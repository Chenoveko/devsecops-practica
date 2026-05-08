FROM python:3.9-alpine

RUN apk update && apk upgrade --no-cache

RUN adduser -D appuser

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir --upgrade pip setuptools wheel && \
    pip install --no-cache-dir -r requirements.txt

COPY app.py .

USER appuser

EXPOSE 5000

CMD ["python", "app.py"]