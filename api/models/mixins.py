from uuid import uuid4, UUID
from datetime import datetime
from typing import Optional

from pydantic import BaseModel
from sqlmodel import Column, DateTime, Field

class BaseMixin(BaseModel):
    id: Optional[str] = Field(
        default_factory=lambda: str(uuid4()),
        primary_key=True,
    )

    created_at: Optional[datetime] = Field(
        sa_column=Column(
            DateTime,
            default=datetime.utcnow,
            nullable=False,
        )
    )

    updated_at: Optional[datetime] = Field(
        sa_column=Column(
            DateTime,
            default=datetime.utcnow,
            onupdate=datetime.utcnow,
        )
    )

    def get_uuid(self):
        return UUID(self.id)