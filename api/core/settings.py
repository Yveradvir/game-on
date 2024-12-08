from secrets import token_urlsafe
from datetime import timedelta
from typing import Annotated

from pydantic import (
    PostgresDsn,
    Field,
    computed_field
)
from pydantic_settings import BaseSettings, SettingsConfigDict
from pydantic_core import MultiHostUrl


class Settings(BaseSettings):
    model_config = SettingsConfigDict(
        env_file="../../.env",
        env_ignore_empty=True,
        extra="ignore",
    )

    SECRET_KEY: str = Field(default_factory=lambda: token_urlsafe(32))

    ACSESS_TOKEN_LIFE: int = timedelta(minutes=40).seconds
    REFRESH_TOKEN_LIFE: int = timedelta(hours=4).seconds

    POSTGRES_SERVER: str
    POSTGRES_PORT: int 
    POSTGRES_USER: str
    POSTGRES_PASSWORD: str
    POSTGRES_DB: str

    @computed_field
    @property
    def SQLALCHEMY_DATABASE_URI(self) -> PostgresDsn:
        return str(MultiHostUrl.build(
            scheme="postgresql+psycopg",
            username=self.POSTGRES_USER,
            password=self.POSTGRES_PASSWORD,
            host=self.POSTGRES_SERVER,
            port=self.POSTGRES_PORT,
            path=self.POSTGRES_DB,
        ))
    
    ALL_CORS_ORIGINS: str

    @computed_field
    @property
    def all_cors_origins(self) -> list[str]:
        return [i.strip() for i in self.ALL_CORS_ORIGINS.split(",")]
    
    PROJECT_NAME: str

    FIRST_SUPERUSER_USERNAME: str
    FIRST_SUPERUSER_EMAIL: str
    FIRST_SUPERUSER_PASSWORD: str

settings = Settings()