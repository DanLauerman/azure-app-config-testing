import os
import time
from datetime import datetime

config_value = os.getenv('CONN_STRING')
while config_value != "new-connection-string":
    print(datetime.now().strftime("%m/%d/%Y, %H:%M:%S"))
    print("Config Value: ", config_value)
    time.sleep(30)
    config_value = os.getenv('CONN_STRING')

print("Connection String Updated!")
print(datetime.now().strftime("%m/%d/%Y, %H:%M:%S"))
print("Config Value: ", config_value)