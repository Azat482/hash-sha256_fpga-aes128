import numpy as np
import serial

N_B = 4

class SerialAES():
    
    "implementation of AES with sequential encryption and decryption of data"
    "software data is divided into blocks and calculated in turn"

    def __init__(self, Nk, key = None):
        self.key = key

    def set_key(self, key):
        self.key = key
        
    def show_out_mess(self, output_message):
        out_message_hex = []
        for s in range(len(output_message)):
            out_message_hex.append( '{:x}'.format(output_message[s]) )
        print(out_message_hex)

    def AES_cipher(self, input):
        ser_aes = serial.Serial('COM4', 115200, stopbits = serial.STOPBITS_TWO)
        mode = np.array( [np.uint8(0) for i in range(16)] , dtype=np.uint8)
        
        blocks_length = len(input) + (N_B * 4) #adding additional block[4x4] to write the number padding bytes in begining 
        while blocks_length % (N_B * 4) != 0: blocks_length += 1
        
        n_block = np.zeros(16, dtype = np.uint8)
        bytes_length = (blocks_length + 48).to_bytes(4, 'big')
        n_block[12] = bytes_length[0]
        n_block[13] = bytes_length[1]
        n_block[14] = bytes_length[2]
        n_block[15] = bytes_length[3]
        #print(blocks_length)
        #print(n_block)
        #print(bytes_length)
        
        ser_aes.write(mode)
        ser_aes.write(self.key)
        ser_aes.write(n_block)
        
        blocks = np.zeros(blocks_length, dtype=np.uint8)
        blocks[0] = np.uint8(blocks_length - len(input) - (N_B * 4))
        b_j = (N_B * 4)
        for i in range(len(input)):
            blocks[b_j] = np.uint8(input[i])
            b_j += 1
        
        output = np.zeros(blocks_length, dtype=np.uint8)
        input_block = np.zeros(N_B * 4, dtype=np.uint8)
        block_index = 0
        output_index = 0
        while block_index < blocks_length:
            for i in range(N_B * 4):
                input_block[i] = blocks[block_index]
                block_index += 1
            #output_block = self.AES_block_cipher(input_block, self.round_keys)
            ser_aes.write(input_block)
            output_block = ser_aes.read(16)
            
            self.show_out_mess(output_block)
            
            for i in range(16):
                output[output_index] = output_block[i]
                output_index += 1
        ser_aes.close()
        return output

    def AES_decrypter(self, input):
        ser_aes = serial.Serial('COM4', 115200, stopbits = serial.STOPBITS_TWO)
        mode = np.array( [np.uint8(255) for i in range(16)] , dtype=np.uint8)
        
        ser_aes.write(mode)
        ser_aes.write(self.key)
        
        blocks_length = len(input) - (N_B * 4)
        bytes_length = ( ((blocks_length + (N_B * 4)) + 48 )).to_bytes(4, 'big')
        n_block = np.zeros(16, dtype=np.uint8)
        n_block[12] = bytes_length[0]
        n_block[13] = bytes_length[1]
        n_block[14] = bytes_length[2]
        n_block[15] =  bytes_length[3]
        #print(blocks_length)
        #print(n_block)
        ser_aes.write(n_block)
        
        ser_aes.write( np.array([np.uint8(i) for i in input[:16]], dtype=np.uint8 ) )
        len_add_bytes = ser_aes.read(16)
        len_add_bytes = len_add_bytes[0]

        blocks = np.zeros(blocks_length, dtype=np.uint8)
        in_j = (N_B * 4)
        for i in range(blocks_length): 
            blocks[i] = np.uint8(input[in_j])
            in_j += 1

        output_length = blocks_length - len_add_bytes
        output = np.zeros(output_length, dtype=np.uint8)
        input_block = np.zeros(N_B * 4, dtype=np.uint8)
        block_index = 0
        output_index = 0
        rows = N_B
        columns = 4
        while block_index < blocks_length:
            for i in range(N_B * 4):
                input_block[i] = blocks[block_index]
                block_index += 1
            #output_block = self.AES_block_decrypter(input_block, self.round_keys)
            ser_aes.write(input_block)
            output_block = ser_aes.read(16)
            self.show_out_mess(output_block)
            i = 0
            while i < 16 and output_index < output_length:
                output[output_index] = output_block[i]
                output_index += 1
                i +=1
        ser_aes.close()
        return output
    
