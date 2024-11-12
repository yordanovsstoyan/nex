import os
import pymysql
import time

host = os.getenv('DB_HOST', 'localhost')
user = os.getenv('DB_USER', 'admin')
password = os.getenv('DB_PASSWORD', 'password')
database = os.getenv('DB_NAME', 'mydb')

connection = None
try:
    # Connect to DB
    connection = pymysql.connect(
        host=host,
        user=user,
        password=password,
        database=database
    )
    print(f"Connection to MySQL database successful! Hello World")

except pymysql.MySQLError as e:
    print(f"Error connecting to MySQL database: {e}")
finally:
    if connection:
        connection.close()
        print("Connection closed.")
time.sleep(100000)
