from sqlmodel import Session, create_engine, select

from core.settings import settings
from models.user import User, UserCreate, create_user

engine = create_engine(settings.SQLALCHEMY_DATABASE_URI)

def init_db(session: Session):
    user = session.exec(
        select(User).where(User.email == settings.FIRST_SUPERUSER)
    ).first()

    if not user:
        create_user(
            session=session,
            user_create=UserCreate(
                username=settings.FIRST_SUPERUSER_USERNAME,
                email=settings.FIRST_SUPERUSER_EMAIL,
                password=settings.FIRST_SUPERUSER_PASSWORD,
                is_superuser=True,
            )
        )