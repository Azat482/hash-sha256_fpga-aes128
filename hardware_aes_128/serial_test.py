import serial
import numpy as np

print('start')

test_arr = np.array([48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 57, 57], dtype=np.uint8)



ser_w = serial.Serial('COM4', 19200, stopbits=serial.STOPBITS_TWO)
ser_w.write(test_arr)
ser_w.close()

ser_r = serial.Serial('COM4', 19200, stopbits=serial.STOPBITS_TWO)
data = ser_r.read(12)  
print(  np.array( [chr(d) for d in data], dtype=np.uint8 ) )