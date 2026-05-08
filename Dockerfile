FROM python:3.11

# No ejecutar como root
RUN adduser -D appuser

WORKDIR /app

# Copiar e instalar dependencias en una sola capa
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .

# Cambiar al usuario no-root
USER appuser

EXPOSE 5000

CMD ["python", "app.py"]