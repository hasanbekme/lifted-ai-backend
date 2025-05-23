FROM python:3.9-slim

WORKDIR /code

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    DATA_DIR=/app/data \
    IMAGES_DIR=/app/images

# Install dependencies
COPY ./requirements.txt /code/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# Copy project files
COPY ./app /code/app

# Command to run the application
CMD ["fastapi", "run", "app/main.py", "--port", "80"]