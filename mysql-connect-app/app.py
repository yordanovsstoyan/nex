import os
import pymysql
import time

host = os.getenv('DB_HOST', 'localhost')
user = os.getenv('DB_USER', 'admin')
password = os.getenv('DB_PASSWORD', 'password')
database = os.getenv('DB_NAME', 'mydb')

connection = None
while True:
    try:
        # Try to connect to DB periodically
        if connection is None or connection.open == 0:
            connection = pymysql.connect(
                host=host,
                user=user,
                password=password,
                database=database
            )
            print(f"Connection to MySQL database successful! Hello World")

    except pymysql.MySQLError as e:
        print(f"Error connecting to MySQL database: {e}")
    
    time.sleep(10)
