#include <iostream>
#include"SHA_256.h"

using namespace std;

int main()
{
    //char* message = "1111111111111111111111111111111111111111111111111111111111111111";
    //char* message = "hello world";
    char* message = (char*)"The quick brown fox jumps over the lazy dog";
    unsigned char* message_hash = SHA_256((unsigned char*)message);
    printf("SHA-256 hash: %s\n", message_hash);
    delete message_hash;
    return 0;
}

