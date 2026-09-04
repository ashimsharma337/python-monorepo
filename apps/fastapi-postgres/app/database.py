import os
from psycopg2.pool import ThreadedConnectionPool
from dotenv import load_dotenv

load_dotenv()

pool = ThreadedConnectionPool(
    minconn=int(os.getenv("DB_MIN_CONNECTIONS", 2)),
    maxconn=int(os.getenv("DB_MAX_CONNECTIONS", 5)),
    host=os.getenv("DB_HOST"),
    port=os.getenv("DB_PORT"),
    database=os.getenv("DB_NAME"),
    user=os.getenv("DB_USER"),
    password=os.getenv("DB_PASSWORD"),
    sslmode=os.getenv("DB_SSL_MODE", 'disable')
)

def get_connection():
    return pool.getconn()

def release_connection(connection):
    pool.putconn(connection)
