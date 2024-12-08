from uuid import uuid4, UUID
from datetime import datetime, timezone
from typing import Optional

from sqlmodel import SQLModel, Field

class BaseMixin(SQLModel):
    id: str = Field(
        default_factory=lambda: str(uuid4()),
        primary_key=True,
    )

    created_at: Optional[datetime] = Field(
        default_factory=lambda: datetime.now(tz=timezone.utc),
        nullable=False
    )

    updated_at: Optional[datetime] = Field(
        default_factory=lambda: datetime.now(tz=timezone.utc),
        nullable=False
    )

    def get_uuid(self):
        return UUID(self.id)