import serial
import numpy as np
import time

def show_out_mess(output_message):
    out_message_hex = []
    for s in range(len(output_message)):
        out_message_hex.append( '{:x}'.format(output_message[s]) )
    print(out_message_hex)


key = np.array([0x2b, 0x7e, 0x15, 0x16, 0x28, 0xae, 0xd2, 0xa6, 0xab, 0xf7, 0x15, 0x88, 0x09, 0xcf, 0x4f, 0x3c], dtype=np.uint8)
input_message = np.array([0x32, 0x43, 0xf6, 0xa8, 0x88, 0x5a, 0x30, 0x8d, 0x31, 0x31, 0x98, 0xa2, 0xe0, 0x37, 0x07, 0x34] , dtype=np.uint8)
mode = np.array( [np.uint8(0) for i in range(16)] , dtype=np.uint8)
n_block = np.array( [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 96], dtype=np.uint8 ) #всего 4 блоков (64 байт)
ser_w = serial.Serial('COM4', 115200, stopbits = serial.STOPBITS_TWO)
ser_w.write(mode)
ser_w.write(key)
ser_w.write(n_block)


#1
ser_w.write(input_message)
output_message = ser_w.read(16)
show_out_mess(output_message=output_message)


#2
ser_w.write(input_message)
output_message = ser_w.read(16)
show_out_mess(output_message=output_message)

#3
input_message = np.array([0x39, 0x25, 0x84, 0x1d, 0x02, 0xdc, 0x09, 0xfb, 0xdc, 0x11, 0x85, 0x97, 0x19, 0x6a, 0x0b, 0x32] , dtype=np.uint8)
ser_w.write(input_message)
output_message = ser_w.read(16)
show_out_mess(output_message=output_message)
#"""


ser_w.close()




#print(len(mode))
#print(len(n_block))
#print(len(key))
#print(len(input_message))
####################################################################################
####################################################################################
####################################################################################
####################################################################################
####################################################################################
####################################################################################
####################################################################################
####################################################################################
#time.sleep(1)

"""key = np.array([0x2b, 0x7e, 0x15, 0x16, 0x28, 0xae, 0xd2, 0xa6, 0xab, 0xf7, 0x15, 0x88, 0x09, 0xcf, 0x4f, 0x3c], dtype=np.uint8)
input_message = np.array([0x39, 0x25, 0x84, 0x1d, 0x02, 0xdc, 0x09, 0xfb, 0xdc, 0x11, 0x85, 0x97, 0x19, 0x6a, 0x0b, 0x32] , dtype=np.uint8)
mode = np.array( [np.uint8(255) for i in range(16)] , dtype=np.uint8)
n_block = np.array( [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 64], dtype=np.uint8 )

ser_w = serial.Serial('COM4', 9600, stopbits = serial.STOPBITS_TWO)
ser_w.write(mode)
ser_w.write(key)
ser_w.write(n_block)
ser_w.write(input_message)

output_message = ser_w.read(16)
ser_w.close()
print('output_message', int.from_bytes(output_message, 'big') )

out_message_hex = []
for s in range(len(output_message)):
    out_message_hex.append( '{:x}'.format(output_message[s]) )
print(out_message_hex)


print(len(mode))
print(len(n_block))
print(len(key))
print(len(input_message))
"""