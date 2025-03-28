#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <stdbool.h>
#include "AES.h"

#define ERROR_FILE_OPEN -3
#define ENCRYPT false
#define DECRYPT true
#define CHUNK_SIZE 64
#define WORD 32

void file_crypter(bool method, char* path_file, char* output_file_path, char* key)
{
    uint8_t* key_b = malloc(strlen(key) * sizeof(uint8_t));
    int Nk = strlen(key) / (WORD / 8);
    int i;
    for(i = 0; i < strlen(key); i++)
    {
        key_b[i] = (uint8_t)key[i];
    }

    FILE* input_file  = fopen(path_file, "rb");
    FILE* output_file = fopen(output_file_path, "wb");

    if(!input_file){
        printf("Wrong path of input file!\n");
        printf("%s", path_file);
        getchar();
        exit(1);
    }
    if(!output_file){
        printf("Wrong path of output file!\n");
        printf("%s", output_file_path);
        getchar();
        exit(1);
    }

    uint8_t* round_keys;
    int Nr;

    switch(Nk)
    {
        case 4: Nr = 10; break;
        case 6: Nr = 12; break;
        case 8: Nr = 14; break;
        default: break;
    }

    round_keys = (uint8_t*)malloc( ((Nr + 1) * (N_B * 4)) * sizeof(uint8_t) );
    KeyExpansion(key_b, round_keys, Nk, Nr);

    int chunk_size = (method == ENCRYPT) ? CHUNK_SIZE : CHUNK_SIZE + (N_B * 4);
    while(!feof(input_file))
    {
        uint8_t* chunk_buff = NULL;
        uint8_t* output_buff = NULL;
        chunk_buff = (uint8_t*)calloc(chunk_size,sizeof(uint8_t));
        uint64_t n_items = fread(chunk_buff, sizeof(uint8_t), chunk_size, input_file);
        uint64_t output_length, L;

        if(method == ENCRYPT)
        {
            output_length = n_items + (N_B * 4);
            while(output_length % (N_B * 4)) output_length++;
            output_buff = (uint8_t*)calloc(output_length,sizeof(uint8_t));
            L = AES_cipher(chunk_buff, output_buff, round_keys, n_items, Nk);
        }
        if(method == DECRYPT)
        {
            output_length = n_items - (N_B * 4);
            output_buff = (uint8_t*)calloc(output_length,sizeof(uint8_t));
            L = AES_decrypter(chunk_buff, output_buff, round_keys, n_items, Nk);
        }
        fwrite(output_buff, sizeof(uint8_t), L , output_file);
        free(chunk_buff);
        free(output_buff);
        chunk_buff = NULL;
        output_buff = NULL;
    }
    fclose(input_file);
    fclose(output_file);
    free(key_b);
    free(round_keys);
}

int main(int argc, char* argv[])
{
    if(argc == 5)
    {
        bool method;
        int key_length = strlen(argv[4]);

        if(key_length != 16 && key_length != 24 && key_length != 32)
        {
            printf("Wrong length of key!\n");
            getchar();
            exit(1);
        }

        if(!strcmp(argv[1],"--encrypt"))
        {
            method = ENCRYPT;
        }
        else if(!strcmp(argv[1],"--decrypt"))
        {
            method = DECRYPT;
        }
        else{
            printf("Such parameter of this program is not exist!\n");
            getchar();
            exit(1);
        }
        clock_t start, end;
        double time_of_crypter;
        start = clock();
        file_crypter(method, argv[2], argv[3], argv[4]);
        end = clock();
        time_of_crypter =  (double)(end - start) / CLOCKS_PER_SEC;
        printf("File operation time is: %f s\n", time_of_crypter);
    }
    else{
        printf("Please enter method, paths and key!\n");
    }
    return 0;
}
