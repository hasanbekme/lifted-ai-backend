from sqlmodel import Field, SQLModel
from typing import Optional
from datetime import datetime
from pydantic import EmailStr

class UserBase(SQLModel):
    """Base User model with shared attributes"""
    email: EmailStr
    full_name: str
    is_active: bool = True

class User(UserBase, table=True):
    """User model for database table"""
    id: Optional[int] = Field(default=None, primary_key=True)
    hashed_password: str
    created_at: datetime = Field(default_factory=datetime.utcnow)
    updated_at: datetime = Field(default_factory=datetime.utcnow)

class UserCreate(UserBase):
    """Schema for creating a user"""
    password: str

class UserRead(UserBase):
    """Schema for reading user data"""
    id: int
    created_at: datetime

class UserUpdate(SQLModel):
    """Schema for updating user data"""
    full_name: Optional[str] = None
    email: Optional[EmailStr] = None
    is_active: Optional[bool] = None
