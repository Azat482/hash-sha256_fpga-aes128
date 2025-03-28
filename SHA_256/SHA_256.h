#include<math.h>
#include<stdio.h>
#include<stdint.h>
#include<string.h>
#include<cstdlib>

#define little_endian 0
#define big_endian    1

void binary_form_32bit(uint32_t* value, unsigned int n);
void binary_form_8bit(uint8_t* value, unsigned int n);
bool endian();
uint32_t bit_rotate(uint32_t value, int S);
int align_lenght(int length);
uint8_t* pre_processing(uint8_t* message, unsigned int message_length);
unsigned char* SHA_256(unsigned char* input);
