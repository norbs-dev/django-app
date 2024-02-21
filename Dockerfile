FROM python:3.11.3-alpine3.18
LABEL mantainer='norbert.98@gmail.com'


# This variable is used to control if Python must
# create bytecode files (.pyc) in the disk. 1 = No, 0 = Yes
ENV PYTHONDONTWRITEBYTECODE 1


# Set if the Python output will display instantly at the console
# or in others output devices without buffer storage.
# Basically the Python outputs will display in real time.
ENV PYTHONUNBUFFERED 1

# Copy the "app" and "scripts" folders into the container
COPY ./app /app
COPY ./scripts /scripts

# Enter in the app folder inside the container
WORKDIR /app

# The 8000 port will be able to external connections for the container.
# This is the that port that will be used by Django
EXPOSE 8000


# Run execute shell commands inside the container to build the image.
# The execution result will be stored in the system image files as a new layer.
# Group all the commands in a single run command will reduce the quantity of layers
# of the image and make it more efficient.
RUN python -m venv /venv && \
  /venv/bin/pip install --upgrade pip && \
  /venv/bin/pip install -r /app/requirements.txt && \
  adduser --disabled-password --no-create-home duser && \
  mkdir -p /data/web/static && \
  mkdir -p /data/web/media && \
  chown -R duser:duser /venv && \
  chown -R duser:duser /data/web/static && \
  chown -R duser:duser /data/web/media && \
  chmod -R 755 /data/web/static && \
  chmod -R 755 /data/web/media && \
  chmod -R +x /scripts

# Add the scripts folder and venv/bin into the conatiner's $PATH
ENV PATH="/scripts:/venv/bin:$PATH"

# Change the user for duser
USER duser

# Execute the scripts/commands.sh file
CMD ["commands.sh"]
