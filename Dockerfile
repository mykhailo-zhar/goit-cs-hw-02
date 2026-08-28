FROM python:3.10

WORKDIR /app

COPY ./project/ /app

RUN apt-get update && \
    apt-get install -y python3-dev libpq-dev build-essential

RUN pip install --no-cache-dir --upgrade -r /app/requirements.txt

ENV PATH="/root/.local/bin:${PATH}"

CMD ["python", "main.py"]
# CMD ["fastapi", "run", "app/main.py", "--port", "80"]