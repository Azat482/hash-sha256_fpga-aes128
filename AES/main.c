#include <stdio.h>
#include <stdlib.h>
#include "AES.h"
#include <time.h>

void show_matrix(uint8_t array[4][4])
{
    int i, j;
    for(i = 0; i < 4; i++)
    {
        for(j = 0; j < 4; j++)
        {
            printf("%x", array[i][j]);
            (j + 1) % 4 == 0 ? printf("\n") : printf("\t");
        }
    }
    printf("\n");
}

void show_word(uint8_t word[4])
{
    int i;
    for(i = 0; i < 4; i++)
    {
        printf("%x\t", word[i]);
    }
    printf("\n\n");
}

int main()
{
    uint8_t array[4][4] = {
    {0x19, 0xa0, 0x9a, 0xe9},
    {0x3d, 0xf4, 0xc6, 0xf8},
    {0xe3, 0xe2, 0x8d, 0x48},
    {0xbe, 0x2b, 0x2a, 0x08}
    };

    printf("Before all operations: \n");
    show_matrix(array);

    //test sub_bytes-inv_sub_bytes function
    printf("SubBytes: \n");
    SubBytes(array);
    show_matrix(array);
    printf("InvSubBytes: \n");
    InvSubBytes(array);
    show_matrix(array);

    //test of shift_bytes-inv_sub_bytes
    printf("ShiftRows\n");
    ShiftRows(array);
    show_matrix(array);
    printf("InvShiftRows: \n");
    InvShiftRows(array);
    show_matrix(array);

    //test if multiplication in finite field GF(256)
    printf("Multiplication test of finite field: \n");
    uint8_t gmultest = gmul_bytes(0x57, 0x83);
    printf("0x56 * 0x83: %x\n\n", gmultest);

    //test of MixColumns
    printf("MixColumns: \n");
    MixColumns(array);
    show_matrix(array);
    printf("InvMixColumns: \n");
    InvMixColumns(array);
    show_matrix(array);

    //test of SubWord
    printf("SubWord: \n");
    uint8_t test_word[4] = {0x00, 0x01, 0x02, 0x03};
    SubWord(test_word);
    show_word(test_word);

    //test of RotWord
    printf("RotWord: \n");
    RotWord(test_word);
    show_word(test_word);

    //test of key KeyExpansion
    printf("KeyExpansion: \n");
    uint8_t test_key[16] = {0x2b, 0x7e, 0x15, 0x16, 0x28, 0xae, 0xd2, 0xa6, 0xab, 0xf7, 0x15, 0x88, 0x09, 0xcf, 0x4f, 0x3c};
    uint8_t test_round_keys[176]; // (Nr + 1) * N_B * 4 bytes
    KeyExpansion(test_key, test_round_keys, 4, 10);
    int i;
    for(i = 0; i < (10 + 1) * 4 * 4; i++)
    {
        printf("%2x", test_round_keys[i]);
        if((i + 1) % 4 == 0) printf("\t");
        if((i +1 ) % 16 == 0) printf("\n");
    }
    printf("\n\n");

    //test of block cipher
    for(i = 0; i < 80; i++) {printf("_");} printf("\n");
    printf("AES_block_cipher: \n");
    for(i = 0; i < 80; i++) {printf("_");} printf("\n");
    uint8_t input_data[16] = {0x32, 0x43, 0xf6, 0xa8, 0x88, 0x5a, 0x30, 0x8d, 0x31, 0x31, 0x98, 0xa2, 0xe0, 0x37, 0x07, 0x34};
    printf("input data array: \n");
    for(i = 0; i < 16; i++) printf("%x\t", input_data[i]);
    printf("\n\n");
    uint8_t cipher_data[4][4];

    struct timespec mt1, mt2;
    long int tt;
    clock_gettime(CLOCK_REALTIME, &mt1);
    AES_block_cipher(input_data, cipher_data, test_round_keys, 4, 10);
    for(i = 0; i < 1000000; i++);
    clock_gettime(CLOCK_REALTIME, &mt2);
    tt=1000000000*(mt2.tv_sec - mt1.tv_sec)+(mt2.tv_nsec - mt1.tv_nsec);
    //Выводим результат расчета на экран
    printf ("mt1: %lld, mt2: %lld, Time: %lld ns\n", mt1.tv_nsec, mt2.tv_nsec, tt);

    printf("block cipher_data: \n");
    show_matrix(cipher_data);

    //test of block decrypter
    for(i = 0; i < 80; i++) {printf("_");} printf("\n");
    printf("AES_block_decrypter: \n");
    for(i = 0; i < 80; i++) {printf("_");} printf("\n");
    uint8_t decrypt_data[4][4];
    int j, ci;
    for(i = 0, ci = 0; i < 4; i++)
    {
        for(j = 0; j < 4; j++, ci++)
        {
            input_data[ci] = cipher_data[j][i];
        }
    }
    printf("cipher data: \n");
    for(i = 0; i < 16; i++) printf("%x\t", input_data[i]);
    printf("\n\n");
    AES_block_decrypter(input_data, decrypt_data, test_round_keys, 4, 10);
    printf("block decrypt data: \n");
    show_matrix(decrypt_data);



    //test of AES_cipher-decrypter, part 1
    for(i = 0; i < 80; i++) printf("_");
    printf("\n");
    printf("AES cipher-decrypter test, part 1: \n");
    uint8_t  input_text[16] = {0x32, 0x43, 0xf6, 0xa8, 0x88, 0x5a, 0x30, 0x8d, 0x31, 0x31, 0x98, 0xa2, 0xe0, 0x37, 0x07, 0x34};
    uint64_t input_length = 16;
    uint64_t output_length = input_length;
    while(output_length % 16 != 0) output_length++;
    uint8_t key[16] = {0x2b, 0x7e, 0x15, 0x16, 0x28, 0xae, 0xd2, 0xa6, 0xab, 0xf7, 0x15, 0x88, 0x09, 0xcf, 0x4f, 0x3c};
    int Nk = 4;
    uint8_t* ciphertext = (uint8_t*)malloc(output_length * sizeof(uint8_t));
    printf("INPUT DATA: \n");
    int in;
    for(in = 0; in < input_length; in++)
    {
        printf("%x", input_text[in]);
    }
    printf("\n\n");

    printf("ciphertext: \n");
    uint64_t ciphertext_length = AES_cipher(input_text, ciphertext, key, input_length, Nk);
    uint64_t in_ct;
    for(in_ct = 0; in_ct < ciphertext_length; in_ct++)
    {
        printf("%x", ciphertext[in_ct]);
    }
    printf("\n\n");
    free(ciphertext);

    printf("encrypt text: \n");
    uint8_t* decrypt_text = (uint8_t*)malloc(output_length * sizeof(uint8_t));
    uint64_t decrypt_text_length = AES_decrypter(ciphertext, decrypt_text, key, output_length, Nk);
    int in_dt;
    for(in_dt = 0; in_dt < decrypt_text_length; in_dt++)
    {
        printf("%x", decrypt_text[in_dt]);
    }
    printf("\n\n");

    //main test encrypt-decrypt
    char* text = "This standard specifies the Rijndael algorithm ([3] and [4]), a symmetric block cipher that can process data blocks of 128 bits, using cipher keys with lengths of 128, 192, and 256 bits. Rijndael was designed to handle additional block sizes and key lengths, however they are not adopted in this standard.";
    //char* text = "aaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbcccc";
    uint8_t ckey[16] = {0x2b, 0x7e, 0x15, 0x16, 0x28, 0xae, 0xd2, 0xa6, 0xab, 0xf7, 0x15, 0x88, 0x09, 0xcf, 0x4f, 0x3c};
    uint64_t text_length = strlen(text);
    uint64_t output_text_length = text_length;
    while(output_text_length % 16 != 0) output_text_length++;

    uint8_t* output_text = (uint8_t*)malloc(output_text_length * sizeof(uint8_t));
    uint64_t L = AES_cipher((uint8_t*)text, output_text, ckey, text_length, Nk);

    uint8_t* init_text = (uint8_t*)malloc(output_text_length * sizeof(uint8_t));
    L = AES_decrypter(output_text, init_text, ckey, output_text_length, Nk);

    for(i = 0; i < 100; i++) printf("_");
    printf("\n");
    printf("TEXT: \n");
    for(in = 0; in < text_length; in++) printf("%c",text[in]);
    printf("\n\n");

    for(i = 0; i < 100; i++) printf("_");
    printf("\n");
    printf("CIPHER TEXT: \n");
    for(in_ct = 0; in_ct < output_text_length; in_ct++) printf("%x", output_text[in_ct]);
    printf("\n\n");

    for(i = 0; i < 100; i++) printf("_");
    printf("\n");
    printf("INIT TEXT: \n");
    for(in_dt = 0; in_dt < output_text_length; in_dt++) printf("%c", init_text[in_dt]);
    printf("\n\n");
    return 0;
}
