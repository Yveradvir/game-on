from fastapi import APIRouter
from fastapi.responses import JSONResponse

from models.user import User

from utils.pagination import PaginationDepend
from utils.db import SessionDepend

router = APIRouter(prefix="/users", tags=["users"])


@router.get("/", response_model=list[User])
async def users__get(
    pagination: PaginationDepend,
    session: SessionDepend
) -> list[User]:
    return JSONResponse(pagination.paginate(User, session), 200)