from time import sleep  #used for sleep function
import mysql.connector  #used to connect to mysql database
import sys              #used for system functions
import re               #used for regex 
from mfrc522 import SimpleMFRC522   #used for communication to rfid reader
reader = SimpleMFRC522()

mydb = mysql.connector.connect( #connect to mysql
  host="localhost",  #Server who are the databse stored
  user="stechzeit_nutzer", #user who has rights on the database
  password="blabla",  #password for user 
  database="stechzeiten"  #database
)

cursor = mydb.cursor()

def sql_exec():
    sql = f"INSERT INTO stechzeiten (ID, Datum, Uhrzeit, Status) VALUES ('{id_new}', CURRENT_DATE(), CURRENT_TIME(), '{status}')" #sql command
    cursor.execute(sql) #execute sql command
    print("Written to Database")
    mydb.commit()
    sleep(3) #sleep 3 seconds

try:
    while True:
        print("Hold a tag near the reader")
        id, readed_text = reader.read() #used the read function to fill the "id" and "readed_text" variables  
        if id == your_chip_id:
            id_new = "your-name"
        else:
            id_new = "Unknown"
        if re.search(r'gekommen\b', readed_text): #using regex to find gekommen in readed_text
            print("ID: %s\nText: %s" % (id,readed_text))
            print(id_new)
            status = "gegangen" #set new state
            reader.write(status) #write new state
            print("Written")
            sql_exec()
        elif re.search(r'gegangen\b', readed_text):
            print("ID: %s\nText: %s" % (id,readed_text))
            print(id_new)
            status = "gekommen" #set new state
            reader.write(status) #write new state
            print("Written")
            sql_exec()
        else:
            print("No valid Chip, nothing wrote")
            print(id, id_new, readed_text)

except KeyboardInterrupt: #cleanup and unuse GPIOs
    GPIO.cleanup()
    mydb.close() #close the connection to mysql
    raise

finally:
    GPIO.cleanup()

