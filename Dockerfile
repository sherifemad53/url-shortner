FROM python:3.10-slim

COPY ./app .

RUN pip install --no-cache-dir -r requirements.txt

CMD ["python","main.py"]