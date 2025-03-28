import numpy as np

def show_matrix(arr):
    for i in range(4):
        for j in range(4):
            print('{:x}'.format(arr[i][j]), end='')
            if (j+1) % 4 == 0:
                print()
            else: 
                print('\t', end='')

N_B = 4
Sbox =  np.array([
        0x63, 0x7c, 0x77, 0x7b, 0xf2, 0x6b, 0x6f, 0xc5, 0x30, 0x01, 0x67, 0x2b, 0xfe, 0xd7, 0xab, 0x76,
        0xca, 0x82, 0xc9, 0x7d, 0xfa, 0x59, 0x47, 0xf0, 0xad, 0xd4, 0xa2, 0xaf, 0x9c, 0xa4, 0x72, 0xc0,
        0xb7, 0xfd, 0x93, 0x26, 0x36, 0x3f, 0xf7, 0xcc, 0x34, 0xa5, 0xe5, 0xf1, 0x71, 0xd8, 0x31, 0x15,
        0x04, 0xc7, 0x23, 0xc3, 0x18, 0x96, 0x05, 0x9a, 0x07, 0x12, 0x80, 0xe2, 0xeb, 0x27, 0xb2, 0x75,
        0x09, 0x83, 0x2c, 0x1a, 0x1b, 0x6e, 0x5a, 0xa0, 0x52, 0x3b, 0xd6, 0xb3, 0x29, 0xe3, 0x2f, 0x84,
        0x53, 0xd1, 0x00, 0xed, 0x20, 0xfc, 0xb1, 0x5b, 0x6a, 0xcb, 0xbe, 0x39, 0x4a, 0x4c, 0x58, 0xcf,
        0xd0, 0xef, 0xaa, 0xfb, 0x43, 0x4d, 0x33, 0x85, 0x45, 0xf9, 0x02, 0x7f, 0x50, 0x3c, 0x9f, 0xa8,
        0x51, 0xa3, 0x40, 0x8f, 0x92, 0x9d, 0x38, 0xf5, 0xbc, 0xb6, 0xda, 0x21, 0x10, 0xff, 0xf3, 0xd2,
        0xcd, 0x0c, 0x13, 0xec, 0x5f, 0x97, 0x44, 0x17, 0xc4, 0xa7, 0x7e, 0x3d, 0x64, 0x5d, 0x19, 0x73,
        0x60, 0x81, 0x4f, 0xdc, 0x22, 0x2a, 0x90, 0x88, 0x46, 0xee, 0xb8, 0x14, 0xde, 0x5e, 0x0b, 0xdb,
        0xe0, 0x32, 0x3a, 0x0a, 0x49, 0x06, 0x24, 0x5c, 0xc2, 0xd3, 0xac, 0x62, 0x91, 0x95, 0xe4, 0x79,
        0xe7, 0xc8, 0x37, 0x6d, 0x8d, 0xd5, 0x4e, 0xa9, 0x6c, 0x56, 0xf4, 0xea, 0x65, 0x7a, 0xae, 0x08,
        0xba, 0x78, 0x25, 0x2e, 0x1c, 0xa6, 0xb4, 0xc6, 0xe8, 0xdd, 0x74, 0x1f, 0x4b, 0xbd, 0x8b, 0x8a,
        0x70, 0x3e, 0xb5, 0x66, 0x48, 0x03, 0xf6, 0x0e, 0x61, 0x35, 0x57, 0xb9, 0x86, 0xc1, 0x1d, 0x9e,
        0xe1, 0xf8, 0x98, 0x11, 0x69, 0xd9, 0x8e, 0x94, 0x9b, 0x1e, 0x87, 0xe9, 0xce, 0x55, 0x28, 0xdf,
        0x8c, 0xa1, 0x89, 0x0d, 0xbf, 0xe6, 0x42, 0x68, 0x41, 0x99, 0x2d, 0x0f, 0xb0, 0x54, 0xbb, 0x16
        ], dtype=np.uint8)

InvSbox = np.array([
        0x52, 0x09, 0x6a, 0xd5, 0x30, 0x36, 0xa5, 0x38, 0xbf, 0x40, 0xa3, 0x9e, 0x81, 0xf3, 0xd7, 0xfb,
        0x7c, 0xe3, 0x39, 0x82, 0x9b, 0x2f, 0xff, 0x87, 0x34, 0x8e, 0x43, 0x44, 0xc4, 0xde, 0xe9, 0xcb,
        0x54, 0x7b, 0x94, 0x32, 0xa6, 0xc2, 0x23, 0x3d, 0xee, 0x4c, 0x95, 0x0b, 0x42, 0xfa, 0xc3, 0x4e,
        0x08, 0x2e, 0xa1, 0x66, 0x28, 0xd9, 0x24, 0xb2, 0x76, 0x5b, 0xa2, 0x49, 0x6d, 0x8b, 0xd1, 0x25,
        0x72, 0xf8, 0xf6, 0x64, 0x86, 0x68, 0x98, 0x16, 0xd4, 0xa4, 0x5c, 0xcc, 0x5d, 0x65, 0xb6, 0x92,
        0x6c, 0x70, 0x48, 0x50, 0xfd, 0xed, 0xb9, 0xda, 0x5e, 0x15, 0x46, 0x57, 0xa7, 0x8d, 0x9d, 0x84,
        0x90, 0xd8, 0xab, 0x00, 0x8c, 0xbc, 0xd3, 0x0a, 0xf7, 0xe4, 0x58, 0x05, 0xb8, 0xb3, 0x45, 0x06,
        0xd0, 0x2c, 0x1e, 0x8f, 0xca, 0x3f, 0x0f, 0x02, 0xc1, 0xaf, 0xbd, 0x03, 0x01, 0x13, 0x8a, 0x6b,
        0x3a, 0x91, 0x11, 0x41, 0x4f, 0x67, 0xdc, 0xea, 0x97, 0xf2, 0xcf, 0xce, 0xf0, 0xb4, 0xe6, 0x73,
        0x96, 0xac, 0x74, 0x22, 0xe7, 0xad, 0x35, 0x85, 0xe2, 0xf9, 0x37, 0xe8, 0x1c, 0x75, 0xdf, 0x6e,
        0x47, 0xf1, 0x1a, 0x71, 0x1d, 0x29, 0xc5, 0x89, 0x6f, 0xb7, 0x62, 0x0e, 0xaa, 0x18, 0xbe, 0x1b,
        0xfc, 0x56, 0x3e, 0x4b, 0xc6, 0xd2, 0x79, 0x20, 0x9a, 0xdb, 0xc0, 0xfe, 0x78, 0xcd, 0x5a, 0xf4,
        0x1f, 0xdd, 0xa8, 0x33, 0x88, 0x07, 0xc7, 0x31, 0xb1, 0x12, 0x10, 0x59, 0x27, 0x80, 0xec, 0x5f,
        0x60, 0x51, 0x7f, 0xa9, 0x19, 0xb5, 0x4a, 0x0d, 0x2d, 0xe5, 0x7a, 0x9f, 0x93, 0xc9, 0x9c, 0xef,
        0xa0, 0xe0, 0x3b, 0x4d, 0xae, 0x2a, 0xf5, 0xb0, 0xc8, 0xeb, 0xbb, 0x3c, 0x83, 0x53, 0x99, 0x61,
        0x17, 0x2b, 0x04, 0x7e, 0xba, 0x77, 0xd6, 0x26, 0xe1, 0x69, 0x14, 0x63, 0x55, 0x21, 0x0c, 0x7d
        ], dtype=np.uint8)


class BaseAESOperations():

    "This class contains immutable basic operations of the AES algorithm."
    "Designed to work with a basic data block."
    
    def __init__(self, Nk):
        self.Nk = Nk
        try:
            self.Nr = {4:10, 6:12, 8:14}[self.Nk]
        except:
            print('wrong value of Nk')

    #peasant algorithm of multiplication bytes in GF(8) 
    def gmul_bytes(self, a, b):
        p = 0
        for counter in range(8):
            if b & 1:
                p ^= a
            hi_bit_set = (a & 0x80)
            a <<= 1
            if hi_bit_set:
                a ^= 0x1b
            b >>= 1
        return np.uint8(p)            
    
    def SubWord(self, word):
        for i in range(N_B):
            word[i] = Sbox[word[i]]

    def RotWord(self, word):
        a0 = word[0]
        a1 = word[1]
        a2 = word[2]
        a3 = word[3]
        word[0] = a1
        word[1] = a2
        word[2] = a3
        word[3] = a0

    def Rcon(self, n):
        x = 0x01
        n -= 1
        for i in range(n):
            x = self.gmul_bytes(x, 0x02)
        return np.uint8(x)

    def KeyExpansion(self, key):
        round_keys = np.zeros( ((self.Nr + 1) * (N_B * 4)), dtype=np.uint8)
        temp = np.zeros(4, np.uint8)
        num_keys = self.Nk * 4
        for i in range(num_keys):
            round_keys[i] = key[i]
        for i in range(self.Nk, N_B * (self.Nr + 1)):
            for t in range(N_B):
                temp[t] = round_keys[(i * N_B - N_B) + t]
            if(i % self.Nk == 0):
                self.RotWord(temp)
                self.SubWord(temp)
                temp[0] = temp[0] ^ self.Rcon(i // self.Nk)
            elif (self.Nk > 6) and (i % self.Nk == 4):
                self.SubWord(temp)
            for t in range(N_B):
                round_keys[(i * N_B) + t] = round_keys[(i * N_B - (N_B * self.Nk)) + t] ^ temp[t]
        return round_keys
    
    def SubBytes(self, state):
        rows = 4
        columns = N_B
        for i in range(rows):
            for j in range(columns):
                state[i][j] = Sbox[state[i][j]]

    def InvSubBytes(self, state):
        rows = 4
        columns = N_B
        for i in range(rows):
            for j in range(columns):
                state[i][j] = InvSbox[state[i][j]]

    def ShiftRows(self, state):
        rows = 4
        columns = N_B
        for row in range(rows):
            buff_left = np.zeros(row, dtype=np.uint8)
            for buff_i in range(row):
                buff_left[buff_i] = state[row][buff_i]
            left_new = 0
            right_i = row
            while right_i < columns:
                state[row][left_new] = state[row][right_i]
                right_i += 1
                left_new += 1
            right_new = left_new
            left_i = 0
            while right_new < columns:
                state[row][right_new] = buff_left[left_i]
                right_new += 1
                left_i += 1

    def InvShiftRows(self, state):
        rows = 4
        columns = N_B
        for row in range(rows):
            buff_left = np.zeros(columns - row , dtype=np.uint8)
            buff_i = 0
            while buff_i < columns - row:
                buff_left[buff_i] = state[row][buff_i]
                buff_i += 1
            left_new = 0
            right_i = buff_i
            while right_i < columns:
                state[row][left_new] = state[row][right_i]
                left_new += 1
                right_i += 1
            right_new = left_new
            left_i = 0
            while right_new < columns:
                state[row][right_new] = buff_left[left_i]
                right_new += 1
                left_i += 1
    
    def MixColumns(self, state):
        columns = N_B
        gmul_bytes = self.gmul_bytes
        for i in range(columns):
            S_0 = state[0][i]
            S_1 = state[1][i]
            S_2 = state[2][i]
            S_3 = state[3][i]
            state[0][i] = gmul_bytes(0x02, S_0) ^ gmul_bytes(0x03, S_1) ^ S_2 ^ S_3
            state[1][i] = S_0 ^ gmul_bytes(0x02, S_1) ^ gmul_bytes(0x03, S_2) ^ S_3
            state[2][i] = S_0 ^ S_1 ^ gmul_bytes(0x02, S_2) ^ gmul_bytes(0x03, S_3)
            state[3][i] = gmul_bytes(0x03, S_0) ^ S_1 ^ S_2 ^ gmul_bytes(0x02, S_3)

    def InvMixColumns(self, state):
        columns = N_B
        gmul_bytes = self.gmul_bytes
        for i in range(columns):
            S_0 = state[0][i]
            S_1 = state[1][i]
            S_2 = state[2][i]
            S_3 = state[3][i]
            state[0][i] = gmul_bytes(0x0e,S_0) ^ gmul_bytes(0x0b,S_1) ^ gmul_bytes(0x0d,S_2) ^ gmul_bytes(0x09,S_3)
            state[1][i] = gmul_bytes(0x09,S_0) ^ gmul_bytes(0x0e,S_1) ^ gmul_bytes(0x0b,S_2) ^ gmul_bytes(0x0d,S_3)
            state[2][i] = gmul_bytes(0x0d,S_0) ^ gmul_bytes(0x09,S_1) ^ gmul_bytes(0x0e,S_2) ^ gmul_bytes(0x0b,S_3)
            state[3][i] = gmul_bytes(0x0b,S_0) ^ gmul_bytes(0x0d,S_1) ^ gmul_bytes(0x09,S_2) ^ gmul_bytes(0x0e,S_3)

    def GetRoundKey(self, key_array, N, X0):
        round_key_n = np.zeros( (4 * N_B), dtype=np.uint8)
        rows = 4
        columns = N_B
        keys_index = X0
        round_key_i = 0
        while (round_key_i < (columns * rows) and keys_index < N):
            round_key_n[round_key_i] = key_array[keys_index]
            keys_index += 1
            round_key_i += 1
        return round_key_n

    def AddRoundKey(self, state, round_key):
        rows = 4 
        columns = N_B
        column = 0
        key_index = 0
        while column < columns:
            for row in range(rows):
                state[row][column] ^= round_key[key_index]
                key_index += 1
            column += 1

    def AddInputToState(self, input, state):
        rows = 4
        columns = N_B
        input_index = 0
        for column in range(columns):
            for row in range(rows):
                state[row][column] = input[input_index]
                input_index += 1

    def AES_block_cipher(self, input, round_keys):
        rows = 4
        columns = N_B
        N_keys = (self.Nr + 1) * (4 * N_B)
        state = np.zeros((rows, columns), dtype=np.uint8)

        self.AddInputToState(input, state)
        self.AddRoundKey(state, self.GetRoundKey(round_keys, N_keys, 0))
        for round in range(1 , self.Nr):
            self.SubBytes(state)
            self.ShiftRows(state)
            self.MixColumns(state)
            self.AddRoundKey(state, self.GetRoundKey(round_keys, N_keys, round * (N_B * 4)))
        self.SubBytes(state)
        self.ShiftRows(state)
        self.AddRoundKey(state, self.GetRoundKey(round_keys, N_keys, self.Nr * (N_B * 4)))
        return state

    def AES_block_decrypter(self, input, round_keys):
        rows = 4
        columns = N_B
        N_keys = (self.Nr + 1) * (4 * N_B)
        state = np.zeros((rows, columns), dtype=np.uint8)

        self.AddInputToState(input, state)
        self.AddRoundKey(state, self.GetRoundKey(round_keys, N_keys, self.Nr * (N_B * 4)))
        for round in range(self.Nr - 1, 0, -1):
            self.InvShiftRows(state)
            self.InvSubBytes(state)
            self.AddRoundKey(state, self.GetRoundKey(round_keys, N_keys, round * (N_B * 4)))
            self.InvMixColumns(state)
        self.InvShiftRows(state)
        self.InvSubBytes(state)
        self.AddRoundKey(state, self.GetRoundKey(round_keys, N_keys, 0))
        return state
    
    def set_Nk(self, Nk):
        self.Nk = Nk
        self.Nr = {4:10, 6:12, 8:14}[self.Nk]


class SerialAES(BaseAESOperations):

    "implementation of AES with sequential encryption and decryption of data"
    "software data is divided into blocks and calculated in turn"

    def __init__(self, Nk, key = None):
        self.key = key
        self.round_keys = self.KeyExpansion(self.key) if self.key else None
        super().__init__(Nk)

    def set_key(self, key):
        self.key = key
        self.round_keys = self.KeyExpansion(self.key)

    def AES_cipher(self, input):
        blocks_length = len(input) + (N_B * 4) #adding additional block[4x4] to write the number padding bytes in begining 
        while blocks_length % (N_B * 4) != 0: blocks_length += 1
        
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
        rows = N_B
        columns = 4
        while block_index < blocks_length:
            for i in range(N_B * 4):
                input_block[i] = blocks[block_index]
                block_index += 1
            output_block = self.AES_block_cipher(input_block, self.round_keys)
            for column in range(columns):
                for row in range(rows):
                    output[output_index] = output_block[row][column]
                    output_index += 1
        return output

    def AES_decrypter(self, input):
        blocks_length = len(input) - (N_B * 4)
        len_add_bytes = self.AES_block_decrypter(np.array([np.uint8(i) for i in input[:16]], dtype=np.uint8 ), self.round_keys )[0][0]

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
            output_block = self.AES_block_decrypter(input_block, self.round_keys)
            
            for column in range(columns):
                row = 0
                while row < rows and output_index < output_length:
                    output[output_index] = output_block[row][column]
                    output_index += 1
                    row +=1
        return output
    
