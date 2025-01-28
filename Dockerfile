FROM python:3.9

# Set the working directory inside the container
WORKDIR /app/backend

# Copy requirements first for better caching during rebuilds
COPY requirements.txt /app/backend

# Update and install system dependencies
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install mysqlclient
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire application into the container
COPY . /app/backend

# Expose port 8000 for the Django app
EXPOSE 8000

# Run migrations and start the Django app
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
