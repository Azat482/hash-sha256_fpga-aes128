#include "SHA_256.h"


void binary_form_8bit(uint8_t* value, unsigned int n)
{
    printf("\n%s%d\n", "array length: ", n);
    for(unsigned int i = 0; i < n; i++)
    {
        for(int bin = 0; bin < 8; bin++)
        {
            char ch = ((value[i] << bin) & 0x80) ? '1' : '0';
            printf("%c", ch);
        }
        printf(" ");
        if((i+1) % 4 == 0) printf("\n");
    }
    printf("\n");
}


void binary_form_32bit(uint32_t* value, unsigned int n)
{
    printf("\n%s%d\n", "array length: ", n);
    for(unsigned int i = 0; i < n; i++)
    {
        for(int bin = 0; bin < 32; bin++)
        {
            char ch = ((value[i] << bin) & 0x80000000) ? '1' : '0';
            printf("%c", ch);
        }
        printf(" ");
        if((i+1) % 2 == 0) printf("\n");
    }
    printf("\n");
}


bool endian()
{
    uint32_t n= 1;
    uint8_t *i = (uint8_t*)(&n);
    if(*i == 1)
    {
        return little_endian;
    }
    else{
        return big_endian;
    }
}


unsigned int align_length(unsigned int length)
{
    length += 9;
    while(length % 64 != 0) length++;
    return length;
}


uint8_t* pre_processing(uint8_t* message, unsigned int message_length)
{
    printf("%s: %s\n", "message", (unsigned char*)message);
    printf("size of message: bytes=%d, bits=%d\n", message_length, message_length * 8);
    unsigned int new_length = align_length(message_length);
    unsigned int middle_length = new_length - 8;
    uint8_t* completed_mess = new uint8_t[new_length];
    unsigned int mess_index;

    //copy message into new array
    for(mess_index = 0; mess_index < message_length; mess_index++)
    {
        completed_mess[mess_index] = message[mess_index];
    }

    binary_form_8bit(completed_mess, message_length);
    //adding 1
    completed_mess[mess_index] = 0b10000000;

    ///adding zero bits
    while(mess_index < middle_length)
    {
        ++mess_index;
        completed_mess[mess_index] = 0b00000000;
    }

    binary_form_8bit(completed_mess, middle_length);
    //adding first length of input message into end array
    uint64_t bit_length = (uint64_t)(message_length * 8);
    if(endian() == big_endian)
    {
        printf("%s%d\n", "big endian, bit length=", bit_length);
        for(unsigned int i = middle_length, j= 0; i < new_length; j++, i++)
        {
            uint8_t byte = (uint8_t)(bit_length >> (j * 8));
            completed_mess[i] = byte;
        }
    }
    else if(endian() == little_endian)
    {
        printf("%s%d\n", "little endian, bit length=", bit_length);
        for(unsigned int i = middle_length, j = 7; i < new_length; j--, i++)
        {
            uint8_t byte = (uint8_t)(bit_length >> (j * 8));
            completed_mess[i] = byte;
        }
    }

    binary_form_8bit(completed_mess, new_length);
    return completed_mess;
}


uint32_t bit_rotate(uint32_t value, int S)
{
    return (value >> S) | (value << (32 - S));
}


unsigned char* SHA_256(unsigned char* input)
{
    //initialization of constant
    uint32_t h0 = 0x6A09E667,
             h1 = 0xBB67AE85,
             h2 = 0x3C6EF372,
             h3 = 0xA54FF53A,
             h4 = 0x510E527F,
             h5 = 0x9B05688C,
             h6 = 0x1F83D9AB,
             h7 = 0x5BE0CD19;
    uint32_t k[64] = {0x428A2F98, 0x71374491, 0xB5C0FBCF, 0xE9B5DBA5, 0x3956C25B, 0x59F111F1, 0x923F82A4, 0xAB1C5ED5,
                      0xD807AA98, 0x12835B01, 0x243185BE, 0x550C7DC3, 0x72BE5D74, 0x80DEB1FE, 0x9BDC06A7, 0xC19BF174,
                      0xE49B69C1, 0xEFBE4786, 0x0FC19DC6, 0x240CA1CC, 0x2DE92C6F, 0x4A7484AA, 0x5CB0A9DC, 0x76F988DA,
                      0x983E5152, 0xA831C66D, 0xB00327C8, 0xBF597FC7, 0xC6E00BF3, 0xD5A79147, 0x06CA6351, 0x14292967,
                      0x27B70A85, 0x2E1B2138, 0x4D2C6DFC, 0x53380D13, 0x650A7354, 0x766A0ABB, 0x81C2C92E, 0x92722C85,
                      0xA2BFE8A1, 0xA81A664B, 0xC24B8B70, 0xC76C51A3, 0xD192E819, 0xD6990624, 0xF40E3585, 0x106AA070,
                      0x19A4C116, 0x1E376C08, 0x2748774C, 0x34B0BCB5, 0x391C0CB3, 0x4ED8AA4A, 0x5B9CCA4F, 0x682E6FF3,
                      0x748F82EE, 0x78A5636F, 0x84C87814, 0x8CC70208, 0x90BEFFFA, 0xA4506CEB, 0xBEF9A3F7, 0xC67178F2};

    //initialization of main variables
    uint8_t* message_8bit = pre_processing((uint8_t*)input, strlen((char*)input));
    unsigned int length = align_length(strlen((char*)input)) / 4;
    int blocks = length / 16;
    uint32_t* message = new uint32_t[length];

    //copy the array 8-bit to new 32-bit array
    for(unsigned int i = 0, i8 = 0; i < length; i++)
    {
        message[i] = 0;
        for(int j = 3; j >=0; j--, i8++)
        {
            message[i] = message[i] | ( (uint32_t)message_8bit[i8] << (8 * j) );
        }
    }
    binary_form_32bit(message,length);

    //main cycle of algorithm
    for(int block = 0; block < blocks; block++)
    {
        uint32_t W[64];

        //array completion with adding 48 words
        for(int Nw = 0, bl_index = 16 * block; Nw < 64; Nw++, bl_index++)
        {
            if(Nw < 16)
            {
                W[Nw] = message[bl_index];
            }
            else
            {
                uint32_t s0 = ( bit_rotate(W[Nw - 15], 7) ^ bit_rotate(W[Nw - 15], 18) ^ (W[Nw - 15] >> 3) );
                uint32_t s1 = ( bit_rotate(W[Nw - 2], 17) ^ bit_rotate(W[Nw - 2], 19) ^ (W[Nw -2] >> 10) );
                W[Nw] = W[Nw - 16] + s0 + W[Nw - 7] + s1;
            }
        }
        binary_form_32bit(W, 64);
        uint32_t a = h0,
                 b = h1,
                 c = h2,
                 d = h3,
                 e = h4,
                 f = h5,
                 g = h6,
                 h = h7;
        for(int index = 0; index < 64; index++)
        {
            uint32_t Z0 = (bit_rotate(a, 2)) ^ (bit_rotate(a, 13)) ^ (bit_rotate(a, 22));
            uint32_t Ma = (a & b) ^ ( a & c) ^ (b & c);
            uint32_t t2 = Z0 + Ma;
            uint32_t Z1 = (bit_rotate(e, 6) ^ (bit_rotate(e, 11)) ^ (bit_rotate(e, 25)));
            uint32_t Ch = (e & f) ^ ((~e) & g);
            uint32_t t1 = h + Z1 + Ch + k[index] + W[index];

            h = g;
            g = f;
            f = e;
            e = d + t1;
            d = c;
            c = b;
            b = a;
            a = t1 + t2;
        }

        h0 += a;
        h1 += b;
        h2 += c;
        h3 += d;
        h4 += e;
        h5 += f;
        h6 += g;
        h7 += h;
    }

    printf("\n\nVariables of h0-h6:\n\n");
    printf("%s%x\n", "h0: ", h0);
    printf("%s%x\n", "h1: ", h1);
    printf("%s%x\n", "h2: ", h2);
    printf("%s%x\n", "h3: ", h3);
    printf("%s%x\n", "h4: ", h4);
    printf("%s%x\n", "h5: ", h5);
    printf("%s%x\n", "h6: ", h6);
    printf("%s%x\n", "h7: ", h7);
    printf("\n\n");

    char SHA256_hash[65];
    SHA256_hash[0] = '\0';
    char h0_str[9];
    char h1_str[9];
    char h2_str[9];
    char h3_str[9];
    char h4_str[9];
    char h5_str[9];
    char h6_str[9];
    char h7_str[9];

    sprintf(h0_str, "%x", h0);
    strcat(SHA256_hash, h0_str);

    sprintf(h1_str, "%x", h1);
    strcat(SHA256_hash, h1_str);

    sprintf(h2_str, "%x", h2);
    strcat(SHA256_hash, h2_str);

    sprintf(h3_str, "%x", h3);
    strcat(SHA256_hash, h3_str);

    sprintf(h4_str, "%x", h4);
    strcat(SHA256_hash, h4_str);

    sprintf(h5_str, "%x", h5);
    strcat(SHA256_hash, h5_str);

    sprintf(h6_str, "%x", h6);
    strcat(SHA256_hash, h6_str);

    sprintf(h7_str, "%x", h7);
    strcat(SHA256_hash, h7_str);

    unsigned char* result = (unsigned char*)malloc(65 * sizeof(unsigned char));
    for(int i = 0; i < 65; i++)
    {
        result[i] = SHA256_hash[i];
    }
    delete message;
    delete message_8bit;
    return result;
}










