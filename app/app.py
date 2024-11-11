import os
import pymysql

# Retrieve database connection details from environment variables
host = os.getenv('MYSQL_HOST', 'localhost')  # Default to 'localhost' if not set
user = os.getenv('MYSQL_USER', 'root')       # Default to 'root' if not set
password = os.getenv('MYSQL_PASSWORD', '')   # Default to empty string if not set
database = os.getenv('MYSQL_DB', 'test')   # Default to 'test' if not set

connection = None
try:
    # Establish a connection to the database
    connection = pymysql.connect(
        host=host,
        user=user,
        password=password,
        database=database
    )

    # If connection is successful
    print(f"Connection to MySQL database '{database}' successful!")

    # You can perform your queries here if needed

except pymysql.MySQLError as e:
    # Handle any errors during connection
    print(f"Error connecting to MySQL database: {e}")
finally:
    # Close the connection if it's open
    if connection:
        connection.close()
        print("Connection closed.")
