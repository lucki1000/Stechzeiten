from time import sleep  #used for sleep function
import sys              #used for system functions
import re               #used for regex 
from mfrc522 import SimpleMFRC522   #used for communication to rfid reader
reader = SimpleMFRC522()

try:
    while True:
        print("Hold a tag near the reader")
        id, readed_text = reader.read() #used the read function to fill the "id" and "readed_text" variables  
        if re.search(r'anwesend\b', readed_text): #using regex to find anwesend in readed_text
            print("ID: %s\nText: %s" % (id,readed_text))
            status_abw = "abwesend" #set new state
            reader.write(status_abw) #write new state
            print("Written")
            sleep(3) #sleep 3 seconds
        else:
            print("ID: %s\nText: %s" % (id,readed_text))
            status_anw = "anwesend" #set new state
            reader.write(status_anw) #write new state
            print("Written")
            sleep(3) #sleep 3 seconds

except KeyboardInterrupt: #cleanup and unuse GPIOs
    GPIO.cleanup()
    raise
