FROM python:3.10-slim

COPY ./app .

RUN pip install --no-cache-dir -r requirements.txt

CMD ["flask","--app","main.py","run"]

EXPOSE 5000