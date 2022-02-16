FROM tiangolo/uvicorn-gunicorn-fastapi:python3.9-slim-2021-10-02

WORKDIR /code

COPY ./requirements.txt /code/requirements.txt

RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

COPY ./app /code/app

#USER www-data

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
