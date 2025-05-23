from sqlmodel import SQLModel, Session, create_engine
import os
from typing import Generator

# In production, use environment variables for this
DATABASE_URL = os.getenv("DATABASE_URL", "sqlite:///./lifted_ai.db")

# Create SQLAlchemy engine
connect_args = {"check_same_thread": False} if DATABASE_URL.startswith("sqlite") else {}
engine = create_engine(DATABASE_URL, echo=True, connect_args=connect_args)

def create_db_and_tables():
    """Create database tables from SQLModel models"""
    SQLModel.metadata.create_all(engine)

def get_session() -> Generator[Session, None, None]:
    """Dependency for getting a database session"""
    with Session(engine) as session:
        yield session
