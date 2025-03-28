import sys
import timeit
import py_aes
import numpy as np
from timeit import default_timer as timer

def show_matrix(arr):
    for i in range(4):
        for j in range(4):
            print('{:x}'.format(arr[i][j]), end='')
            if (j+1) % 4 == 0:
                print()
            else: 
                print('\t', end='')

AES = py_aes.BaseAESOperations(4)

print('GF nultiplication test: ')
gmultest = AES.gmul_bytes(0x57, 0x83)
print("0x57 * 0x83  = {0:x}".format(gmultest))
print('\n')

print('KeyExpansion:')
test_key = np.array([0x2b, 0x7e, 0x15, 0x16, 0x28, 0xae, 0xd2, 0xa6, 0xab, 0xf7, 0x15, 0x88, 0x09, 0xcf, 0x4f, 0x3c], dtype=np.uint8)
test_round_keys = AES.KeyExpansion(test_key)
for i in range( (10 + 1) * 4 * 4):
    print('{:2x}'.format(test_round_keys[i]), end='')
    if (i + 1) % 4 == 0: print('\t', end='')
    if (i + 1) % 16 == 0: print()
print('\n\n')

print('AES_block_cipher: ')
input_data = np.array([0x32, 0x43, 0xf6, 0xa8, 0x88, 0x5a, 0x30, 0x8d, 0x31, 0x31, 0x98, 0xa2, 0xe0, 0x37, 0x07, 0x34], dtype=np.uint8)
cipher_output_block = AES.AES_block_cipher(input_data, test_round_keys)
print('Input data:')
for i in input_data:
    print('{:x}'.format(i), end='\t')
print('\n')
print('Block cipher data:')
show_matrix(cipher_output_block)
print('\n\n')

print('AES_block_decrypter:')
input_data = np.zeros(4 * 4, dtype=np.uint8)
ci = 0
for i in range(4):
    for j in range(4):
        input_data[ci] = cipher_output_block[j][i]
        ci += 1
print('cipher data:')
for i in input_data:
    print('{:x}'.format(i), end='\t')
print('\n')
init_data = AES.AES_block_decrypter(input_data, test_round_keys)
print('block decrypt data:')
show_matrix(init_data)
print('\n\n')


for i in range(50): print('+', end='')
print()
print('AES cipher and decrypter test:')
AES = py_aes.SerialAES(4)
text = "This standard specifies the Rijndael algorithm ([3] and [4]), a symmetric block cipher that can process data blocks of 128 bits, using cipher keys with lengths of 128, 192, and 256 bits. Rijndael was designed to handle additional block sizes and key lengths, however they are not adopted in this standard."
test_key = np.array([0x2b, 0x7e, 0x15, 0x16, 0x28, 0xae, 0xd2, 0xa6, 0xab, 0xf7, 0x15, 0x88, 0x09, 0xcf, 0x4f, 0x3c], dtype=np.uint8)

start_timer_of_cipher = timer()
cipher_text = AES.AES_cipher(bytes(text, encoding= 'UTF-8'), test_key)
time_of_cipher = timer() - start_timer_of_cipher

start_timer_of_decrypter  = timer()
init_text = AES.AES_decrypter(cipher_text, test_key)
time_of_decrypter = timer() - start_timer_of_decrypter

print('TEXT:\n', text, end='\n\n')
print('Cipher text:')
for i in cipher_text:
    print('{:x}'.format(i), end='')
print('\n\n')
print('Init text:')
for i in init_text:
    print('{:c}'.format(i), end='')
print('\n\n')
print('time of cipher: ', time_of_cipher)
print('time of decrypter: ', time_of_decrypter)
for i in range(50): print('+', end='')
print()
