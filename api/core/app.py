from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from core.settings import settings

def makeapp(lifespan, modules: list) -> FastAPI:
    app = FastAPI(title=settings.PROJECT_NAME, lifespan=lifespan)

    app.add_middleware(
        CORSMiddleware,
        allow_origins=settings.all_cors_origins,
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )

    for module in modules:
        app.include_router(module.router)

    return app