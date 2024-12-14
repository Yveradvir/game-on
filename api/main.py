import routes as r

from core.app import makeapp
from utils.db import init_db

from contextlib import asynccontextmanager

@asynccontextmanager
async def lifespan(app):
    init_db()
    yield

app = makeapp(
    lifespan=lifespan,
    modules=[
        r.user,
    ]
)