from fastapi import Depends
from typing import Annotated, Type
from sqlmodel import SQLModel, Session, select, func
from math import ceil

class PaginationQueryParams:
    def __init__(self, page: int, limit: int):
        self.page = page
        self.limit = limit

    def paginate(self, model: Type[SQLModel], session: Session):
        total_items = session.exec(select(func.count()).select_from(model)).one()
        total_pages = ceil(total_items / self.limit)
        offset = (self.page - 1) * self.limit

        query = select(model).offset(offset).limit(self.limit)
        results = session.exec(query).all()

        return {
            "page": self.page,
            "limit": self.limit,
            "total_pages": total_pages,
            "total_items": total_items,
            "results": [res.read_only() for res in results],
        }

PaginationDepend = Annotated[PaginationQueryParams, Depends(PaginationQueryParams)]