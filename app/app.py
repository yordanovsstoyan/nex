import os
import pymysql

host = os.getenv('DB_HOST', 'localhost')
user = os.getenv('DB_USER', 'admin')
password = os.getenv('DB_PASSWORD', 'password')

connection = None
try:
    # Connect to DB
    connection = pymysql.connect(
        host=host,
        user=user,
        password=password
    )
    print(f"Connection to MySQL database successful! Hello World")

except pymysql.MySQLError as e:
    print(f"Error connecting to MySQL database: {e}")
finally:
    if connection:
        connection.close()
        print("Connection closed.")
