import pyodbc

# Connect to SQL Server
conn = pyodbc.connect(
    "Driver={SQL Server};"
    "Server=YOUR_SERVER_NAME;"
    "Database=YOUR_DATABASE_NAME;"
    "Trusted_Connection=yes;"
)

cursor = conn.cursor()

# Fetch the image data
cursor.execute("select image_data from photos where id = 1")
row = cursor.fetchone()

if row:
    image_data = row[0]
    with open("retrieved_image.jpg", "wb") as f:
        f.write(image_data)
    print("Image saved as retrieved_image.jpg")
else:
    print("No image found with that ID.")

cursor.close()
conn.close()
