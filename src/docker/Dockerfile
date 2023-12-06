FROM python:3.10

WORKDIR /app
ADD ./requirements.txt /app/

RUN pip install --no-cache-dir -r requirements.txt

COPY streamlit_app.py .
COPY utils.py .

EXPOSE 8501

CMD ["streamlit", "run", "streamlit_app.py"]
