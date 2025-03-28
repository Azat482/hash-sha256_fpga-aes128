#include <cstdio>
#include <cstdlib>
#include <cstddef>
#include "SHA_256.h"

using namespace std;

int main(int argc, char* argv[])
{
    if(argc < 2)
    {
        printf("Enter path of file!\n");
        return -1;
    }
    FILE* file = fopen(argv[1], "rb");
    if (file == NULL)
    {
        printf("File does not exist: %s", argv[1]);
        return -1;
    }
    fseek(file, 0, SEEK_END);
    size_t file_size = ftell(file);
    rewind(file);

    uint8_t* file_buffer = (uint8_t*)malloc(file_size * sizeof(uint8_t));
    if(file_buffer == NULL)
    {
        fclose(file);
        printf("Error!\n");
        return -1;
    }

    size_t bytes_read = fread(file_buffer, sizeof(uint8_t), file_size, file);
    if (bytes_read != file_size)
    {
        free(file_buffer);
        fclose(file);
        printf("Error! bytes_read != file_size");
        return -1;
    }

    unsigned char* file_hash = SHA_256((unsigned char*)file_buffer, file_size);

    printf("SHA-256 HASH: %s\n", file_hash);

    free(file_hash);
    free(file_buffer);
    fclose(file);
    return 0;
}
