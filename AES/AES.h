#include<math.h>
#include<stdio.h>
#include<stdint.h>
#include<string.h>
#include<stdlib.h>
#include<malloc.h>

#define N_B 4


uint8_t gmul_bytes(uint8_t a, uint8_t b);
void SubBytes(uint8_t state[][N_B]);
void InvSubBytes(uint8_t state[][N_B]);
void ShiftRows(uint8_t state[][N_B]);
void InvShiftRows(uint8_t state[][N_B]);
void MixColumns(uint8_t state[][N_B]);
void InvMixColumns(uint8_t state[][N_B]);
void AddRoundKey(uint8_t state[][N_B], uint8_t round_key[16]);
void KeyExpansion(uint8_t* key, uint8_t* round_keys, int Nk, int Nr);
void SubWord(uint8_t word[N_B]);
void RotWord(uint8_t word[N_B]);
uint8_t Rcon(int n);

uint8_t* GetRoundKey(uint8_t* key_array, int N, int X0);
void AddInputToState(uint8_t* input, uint8_t state[][N_B], int rows, int columns);

void AES_block_cipher(uint8_t* input, uint8_t output[][N_B], uint8_t* round_keys, int Nk, int Nr);
void AES_block_decrypter(uint8_t* input, uint8_t output[][N_B], uint8_t* round_keys, int Nk, int Nr);
uint64_t AES_cipher(uint8_t* input, uint8_t* output, uint8_t* key, uint64_t input_length, int key_length);     //main function of encrypting, return length obtained cipher data
uint64_t AES_decrypter(uint8_t* input, uint8_t* output, uint8_t* key, uint64_t input_length, int key_length);  //main function of decrypting, return length obtained initial data, it may be a little different, if initial message not multiple 16 bytes

