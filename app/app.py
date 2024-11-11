from flask import Flask
import mysql.connector
from mysql.connector import Error
import os

app = Flask(__name__)

# Database connection function
def connect_to_db():
    try:
        # Use environment variables for connection details
        connection = mysql.connector.connect(
            host=os.getenv('MYSQL_HOST', 'localhost'),     
            user=os.getenv('MYSQL_USER', 'dbuser'),           
            password=os.getenv('MYSQL_PASSWORD', 'pass123'),       
            database=os.getenv('MYSQL_DB', 'test_db')       
        )

        if connection.is_connected():
            return "Hello, World! Connected to MySQL Database"
    except Error as error:
        return f"Error connecting to MySQL: {error}"
    finally:
        if connection.is_connected():
            connection.close()

# Define the route
@app.route("/")
def hello_world():
    return connect_to_db()

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
