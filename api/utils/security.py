import jwt
import secrets
import typing as t
from datetime import datetime, timedelta, timezone
from fastapi import Depends, HTTPException, Request
from fastapi.security import APIKeyCookie
from core.settings import settings
from models.user import User

access_cookie = APIKeyCookie(name="access", scheme_name="access_cookie")
refresh_cookie = APIKeyCookie(name="refresh", scheme_name="refresh_cookie")

class SecurityJwtToken:
    def __init__(self, token: str):
        self.token = token

    def __str__(self):
        return self.token

    def get_raw(self) -> dict:
        try:
            return jwt.decode(
                self.token, key=settings.SECRET_KEY, algorithms=[settings.ALGORITHM]
            )
        except jwt.ExpiredSignatureError:
            raise HTTPException(401, "Unauthorized: JWT token has expired")
        except jwt.InvalidSignatureError:
            raise HTTPException(400, "Invalid signature")
        except jwt.DecodeError:
            raise HTTPException(400, "Invalid JWT")

    @staticmethod
    def create_token(payload: dict, csrf: str, token_type: str) -> "SecurityJwtToken":
        now = datetime.now(tz=timezone.utc)
        exp = now + (
            timedelta(seconds=settings.ACCESS_TOKEN_LIFE) if token_type == "access" else
            timedelta(seconds=settings.REFRESH_TOKEN_LIFE)
        )
        
        token = jwt.encode(
            payload={
                "payload": payload,
                "iat": now.timestamp(),
                "exp": exp.timestamp(),
                "csrf": csrf,
            },
            headers={
                "alg": settings.ALGORITHM,
                "typ": "JWT",
                "token": token_type
            },
            key=settings.SECRET_KEY
        )
        return SecurityJwtToken(token)

def create_pair(user: User) -> tuple[SecurityJwtToken, SecurityJwtToken]:
    csrf = secrets.token_hex(16)
    access_token = SecurityJwtToken.create_token({"id": user.id}, csrf, "access")
    refresh_token = SecurityJwtToken.create_token({"id": user.id}, csrf, "refresh")
    return access_token, refresh_token

async def authenticated(
    request: Request,
    access: t.Optional[str] = Depends(access_cookie)
):
    if not access:
        raise HTTPException(401, "Unauthorized: Access token is required but not provided")

    raw = SecurityJwtToken(access).get_raw()
    request.state.token = raw

async def need_refresh(
    request: Request,
    refresh: t.Optional[str] = Depends(refresh_cookie)
):
    if not refresh:
        raise HTTPException(401, "Unauthorized: Access token is required but not provided")

    raw = SecurityJwtToken(refresh).get_raw()
    request.state.token = raw