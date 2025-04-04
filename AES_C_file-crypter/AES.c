#include "AES.h"

uint8_t Sbox[256] = {
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
        };

uint8_t InvSbox[256] = {
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
        };

//multiplication of bytes in finite filed GF(256)
uint8_t gmul_bytes(uint8_t a, uint8_t b) {
    uint8_t p = 0;
    uint8_t counter;
    uint8_t hi_bit_set;
    for (counter = 0; counter < 8; counter++) {
            if (b & 1)
                    p ^= a;
            hi_bit_set = (a & 0x80);
            a <<= 1;
            if (hi_bit_set)
                    a ^= 0x1b; /* x^8 + x^4 + x^3 + x + 1 */
            b >>= 1;
    }
    return p;
}

void SubWord(uint8_t word[N_B])
{
    int i;
    for(i = 0; i < N_B; i++)
    {
        word[i] = Sbox[word[i]];
    }
}

void RotWord(uint8_t word[N_B])
{
    uint8_t a0 = word[0];
    uint8_t a1 = word[1];
    uint8_t a2 = word[2];
    uint8_t a3 = word[3];

    word[0] = a1;
    word[1] = a2;
    word[2] = a3;
    word[3] = a0;
}

//this function returned power of 0x02, 0x02 ^ (i - 1)
uint8_t Rcon(int n)
{
    uint8_t x = 0x01;
    n = n - 1;
    int i;
    for(i = 0; i < n; i++)
    {
        x = gmul_bytes(x, 0x02);
    }
    return x;
}

void KeyExpansion(uint8_t* key, uint8_t* round_keys, int Nk, int Nr)
{
    int num_keys = Nk * 4; //number bytes of key
    uint8_t temp[4];
    int  i;
    for(i = 0; i < num_keys; i++)
    {
        round_keys[i] = key[i];
    }

    for(i = Nk; i < N_B * (Nr + 1); i++)
    {
        int t;
        for(t = 0; t < N_B; t++)
        {
            temp[t] = round_keys[(i * N_B - N_B) + t]; //this expression as temp = w[i - 1], if use 32bit words
        }
        if(i % Nk == 0)
        {
            RotWord(temp);
            SubWord(temp);
            temp[0] = temp[0] ^ Rcon(i / Nk);
        }
        else if( (Nk > 6) && (i % Nk == 4) )
        {
            SubWord(temp);
        }
        for(t = 0; t < N_B; t++)
        {
            round_keys[(i * N_B) + t] = round_keys[(i * N_B - (N_B * Nk)) + t] ^ temp[t]; //this expression as w[i] = w[i - Nk] ^ temp
        }
    }
    return;
}

void SubBytes(uint8_t state[][N_B])
{
    int rows = 4;
    int columns = N_B;

    int i, j;
    for(i = 0; i < rows; i++)
    {
        for(j = 0; j < columns; j++)
        {
            state[i][j] = Sbox[state[i][j]];
        }
    }
    return;
}

void InvSubBytes(uint8_t state[][N_B])
{
    int rows = 4;
    int columns = N_B;

    int i, j;
    for(i = 0; i < rows; i++)
    {
        for(j = 0; j < columns; j++)
        {
            state[i][j] = InvSbox[state[i][j]];
        }
    }
    return;
}

void ShiftRows(uint8_t state[][N_B])
{
    int rows = 4;
    int columns = N_B;

    int row;
    for(row = 0; row < rows; row++)
    {
        uint8_t* buff_left = (uint8_t*)malloc(row * sizeof(uint8_t));

        int buff_i;
        for(buff_i = 0; buff_i < row; buff_i++)
        {
            buff_left[buff_i] = state[row][buff_i];
        }

        int left_new;
        int right_i;
        for(left_new = 0, right_i = row ; right_i < columns; right_i++, left_new++)
        {
            state[row][left_new] = state[row][right_i];
        }

        int right_new;
        int left_i;
        for(right_new = left_new, left_i = 0; right_new < columns; right_new++, left_i++)
        {
            state[row][right_new] = buff_left[left_i];
        }

        free(buff_left);
    }
    return;
}

void InvShiftRows(uint8_t state[][N_B])
{
    int rows = 4;
    int columns = N_B;

    int row;
    for(row = 0; row < rows; row++)
    {
        uint8_t* buff_left = (uint8_t*)malloc(columns - row * sizeof(uint8_t));

        int buff_i;
        for(buff_i = 0; buff_i < columns - row; buff_i++)
        {
            buff_left[buff_i] = state[row][buff_i];
        }

        int left_new;
        int right_i;
        for(left_new = 0, right_i = buff_i ; right_i < columns; right_i++, left_new++)
        {
            state[row][left_new] = state[row][right_i];
        }

        int right_new;
        int left_i;
        for(right_new = left_new, left_i = 0; right_new < columns; right_new++, left_i++)
        {
            state[row][right_new] = buff_left[left_i];
        }

        free(buff_left);
    }
    return;
}

void MixColumns(uint8_t state[][N_B])
{
    int columns = N_B;
    int S_0, S_1, S_2, S_3;
    int i;
    for(i = 0; i < columns; i++)
    {
        S_0 = state[0][i];
        S_1 = state[1][i];
        S_2 = state[2][i];
        S_3 = state[3][i];

        state[0][i] = gmul_bytes(0x02, S_0) ^ gmul_bytes(0x03, S_1) ^ S_2 ^ S_3;
        state[1][i] = S_0 ^ gmul_bytes(0x02, S_1) ^ gmul_bytes(0x03, S_2) ^ S_3;
        state[2][i] = S_0 ^ S_1 ^ gmul_bytes(0x02, S_2) ^ gmul_bytes(0x03, S_3);
        state[3][i] = gmul_bytes(0x03, S_0) ^ S_1 ^ S_2 ^ gmul_bytes(0x02, S_3);
    }
    return;
}

void InvMixColumns(uint8_t state[][N_B])
{
    int columns = N_B;
    int S_0, S_1, S_2, S_3;
    int i;
    for(i = 0; i < columns; i++)
    {
        S_0 = state[0][i];
        S_1 = state[1][i];
        S_2 = state[2][i];
        S_3 = state[3][i];

        state[0][i] = gmul_bytes(0x0e,S_0) ^ gmul_bytes(0x0b,S_1) ^ gmul_bytes(0x0d,S_2) ^ gmul_bytes(0x09,S_3);
        state[1][i] = gmul_bytes(0x09,S_0) ^ gmul_bytes(0x0e,S_1) ^ gmul_bytes(0x0b,S_2) ^ gmul_bytes(0x0d,S_3);
        state[2][i] = gmul_bytes(0x0d,S_0) ^ gmul_bytes(0x09,S_1) ^ gmul_bytes(0x0e,S_2) ^ gmul_bytes(0x0b,S_3);
        state[3][i] = gmul_bytes(0x0b,S_0) ^ gmul_bytes(0x0d,S_1) ^ gmul_bytes(0x09,S_2) ^ gmul_bytes(0x0e,S_3);
    }
    return;
}

uint8_t* GetRoundKey(uint8_t* key_array, int N, int X0)
{
    uint8_t* round_key_n = (uint8_t*)malloc((4 * N_B) * sizeof(uint8_t));
    int rows = 4;
    int columns = N_B;
    int keys_index = X0;
    int round_key_i;
    for(round_key_i = 0; round_key_i < (columns * rows) && keys_index < N; round_key_i++, keys_index++)
    {
        round_key_n[round_key_i] = key_array[keys_index];
    }
    return round_key_n;
}

void AddRoundKey(uint8_t state[][N_B], uint8_t round_key[16])
{   int rows = 4;
    int columns = N_B;
    int column;
    int key_index;
    for(column = 0, key_index = 0; column < columns; column++)
    {
        int row;
        for(row = 0; row < rows; row++, key_index++)
        {
            state[row][column] ^= round_key[key_index];
        }
    }
    free(round_key);
    return;
}

void AddInputToState(uint8_t* input, uint8_t state[][N_B], int rows, int columns)
{
    //copy input to state array
    int column;
    int input_index = 0;
    for(column = 0; column < columns; column++)
    {
        int row;
        for(row = 0; row < rows; row++, input_index++)
        {
            state[row][column] = input[input_index];
        }
    }
    return;
}

void AES_block_cipher(uint8_t* input, uint8_t output[][N_B], uint8_t* round_keys, int Nk, int Nr)
{
    int rows = 4;
    int columns = N_B;
    int N_keys = (Nr + 1) * (4 * N_B); //(Nr + 1) * 16
    uint8_t state[rows][columns];

    AddInputToState(input, state, rows, columns);
    AddRoundKey(state, GetRoundKey(round_keys, N_keys, 0));
    int round;
    for(round = 1; round < Nr; round++)
    {
        SubBytes(state);
        ShiftRows(state);
        MixColumns(state);
        AddRoundKey(state, GetRoundKey(round_keys, N_keys, round * (N_B * 4)));
    }

    SubBytes(state);
    ShiftRows(state);
    AddRoundKey(state, GetRoundKey(round_keys, N_keys, Nr * (N_B * 4)));

    //copy to output
    int i, j;
    for(i = 0; i < 4; i++)
    {
        for(j = 0; j < N_B; j++)
        {
            output[j][i] = state[j][i];
        }
    }
    return;
}

void AES_block_decrypter(uint8_t* input, uint8_t output[][N_B], uint8_t* round_keys, int Nk, int Nr)
{
    int rows = 4;
    int columns = N_B;
    int N_keys = (Nr + 1) * (4 * N_B); //(Nr + 1) * 16
    uint8_t state[rows][columns];

    AddInputToState(input, state, rows, columns);
    AddRoundKey(state, GetRoundKey(round_keys, N_keys, Nr * (N_B * 4)) );

    int round;
    for(round = Nr - 1; round > 0; round--)
    {
        InvShiftRows(state);
        InvSubBytes(state);
        AddRoundKey(state, GetRoundKey(round_keys, N_keys, round * (N_B * 4)) );
        InvMixColumns(state);
    }

    InvShiftRows(state);
    InvSubBytes(state);
    AddRoundKey(state, GetRoundKey(round_keys, N_keys, 0));

    //copy to output
    int i, j;
    for(i = 0; i < 4; i++)
    {
        for(j = 0; j < N_B; j++)
        {
            output[j][i] = state[j][i];
        }
    }

    return;
}

uint64_t AES_cipher(uint8_t* input, uint8_t* output, uint8_t* round_keys, uint64_t input_length, int key_length)
{
    uint8_t* blocks;
    int Nk = key_length;
    int Nr;
    uint64_t i, j;

    switch(Nk)
    {
        case 4: Nr = 10; break;
        case 6: Nr = 12; break;
        case 8: Nr = 14; break;
        default: break;
    }

    uint64_t blocks_length = input_length + (N_B * 4);
    while(blocks_length % (N_B * 4) != 0) blocks_length++; //padding length
    blocks = (uint8_t*)malloc(blocks_length * sizeof(uint8_t));

    blocks[0] = (uint8_t)(blocks_length - (N_B * 4) - input_length);
    for(i = 1; i < (N_B * 4); i++) blocks[i] = 0x00;
    for(i = (N_B * 4), j = 0; j < input_length; j++, i++) blocks[i] = input[j];
    while(i < blocks_length)
    {
        blocks[i] =0x00;
        i++;
    }

    uint8_t input_block[N_B * 4];
    uint8_t output_block[N_B][4];
    uint64_t blocks_index = 0;
    uint64_t output_index = 0;
    int rows = N_B;
    int columns = 4;
    int row, column;
    while(blocks_index < blocks_length)
    {
        for(i = 0; i < (N_B * 4) ; i++, blocks_index++)
        {
            input_block[i] = blocks[blocks_index];
        }
        AES_block_cipher(input_block, output_block, round_keys, Nk, Nr);
        for(column = 0; column < columns; column++)
        {
            for(row = 0; row < rows; row++, output_index++)
            {
                output[output_index] = output_block[row][column];
            }
        }
    }
    free(blocks);
    return blocks_length;
}


uint64_t AES_decrypter(uint8_t* input, uint8_t* output, uint8_t* round_keys, uint64_t input_length, int key_length)
{
    uint8_t* blocks;
    int Nk = key_length;
    int Nr;
    int rows = N_B;
    int columns = 4;
    uint64_t i, j;

    switch(Nk)
    {
        case 4: Nr = 10; break;
        case 6: Nr = 12; break;
        case 8: Nr = 14; break;
        default: break;
    }

    uint8_t additional_block[4][N_B];
    uint8_t first_ciph_block[4 * N_B];
    for(i = 0; i < columns * rows; i++)
    {
        first_ciph_block[i] = input[i];
    }
    AES_block_decrypter(first_ciph_block, additional_block, round_keys, Nk, Nr);
    uint8_t additional_bytes = additional_block[0][0];

    uint64_t blocks_length = input_length - (4 * N_B);
    blocks = (uint8_t*)malloc(blocks_length * sizeof(uint8_t));
    for(i = 0, j = (4 * N_B); i < blocks_length; i++, j++) blocks[i] = input[j];

    uint64_t output_legth = blocks_length - additional_bytes;
    uint8_t input_block[N_B * 4];
    uint8_t output_block[N_B][4];
    uint64_t blocks_index = 0;
    uint64_t output_index = 0;
    int row, column;

    while(blocks_index < blocks_length)
    {
        for(i = 0; i < (N_B * 4) ; i++, blocks_index++)
        {
            input_block[i] = blocks[blocks_index];
        }
        AES_block_decrypter(input_block, output_block, round_keys, Nk, Nr);
        for(column = 0; column < columns; column++)
        {
            for(row = 0; row < rows && output_index < output_legth; row++, output_index++)
            {
                output[output_index] = output_block[row][column];
            }
        }
    }
    free(blocks);
    return output_legth;
}
