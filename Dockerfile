FROM python:3.8-slim-buster

EXPOSE 5002

RUN adduser -u 5678 --disabled-password --gecos "" appuser

COPY requirements.txt .
RUN python -m pip install --no-cache-dir -r requirements.txt

WORKDIR /app
COPY . /app

RUN chown -R appuser /app
USER appuser

CMD ["gunicorn", "--bind", "0.0.0.0:5002", "--timeout", "600", "--capture-output", "--enable-stdio-inheritance", "app:app"]