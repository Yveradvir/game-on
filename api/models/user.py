from sqlmodel import SQLModel, Field
from models.mixins import BaseMixin

from pydantic import EmailStr

from utils.hashing import get_password_hash

class UserCreate(SQLModel):
    username: str = Field(..., max_length=40)
    password: str = Field(..., min_length=8)
    
    email: EmailStr

    is_active: bool = Field(True)
    is_superuser: bool = Field(default=False)
    is_online: bool = Field(default=True)
    

class User(BaseMixin, SQLModel, table=True):
    username: str = Field(unique=True, max_length=40)
    password: str = Field()
    
    email: str = Field(unique=True, schema_extra={
            'pattern': r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
        })
    
    is_active: bool = Field(True)
    is_superuser: bool = Field(default=False)
    is_online: bool = Field(default=True)

    def read_only(self):
        return super().read_only(exclude={"email"})

def create_user(*, session, user_create: UserCreate):
    user = User.model_validate(user_create, update={
        "password": get_password_hash(user_create.password)
    })

    session.add(user)
    session.commit()

    session.refresh(user)

    return user