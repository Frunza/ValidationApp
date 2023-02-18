# Set base image (host OS)
FROM python:3.9-alpine

# Set the working directory in the container
WORKDIR /work

# Copy the dependencies file to the working directory
COPY requirements.txt .

# Install dependencies
RUN pip install -r requirements.txt

# Copy the conent to the working directory
COPY src/* .

# Command to run on container start
CMD [ "python", "server.py" ]