FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN adduser --disabled-password --gecos "" appuser && chown -R appuser /app
USER appuser

EXPOSE 8005

CMD ["gunicorn", "--bind", "0.0.0.0:8005", "--workers", "1", "--timeout", "30", "app:app"]
