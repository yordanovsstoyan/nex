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
        # Try connecting to the DB
        connection = pymysql.connect(
            host=host,
            user=user,
            password=password,
            database=database
        )
        print("Connection to MySQL database successful! Hello World")
        
        time.sleep(5)
        
    except pymysql.MySQLError as e:
        print(f"Error connecting to MySQL database: {e}")
        print("Retrying in 5 seconds...")
        time.sleep(5)
    
    finally:
        if connection:
            connection.close()
            print("Connection closed.")
            
