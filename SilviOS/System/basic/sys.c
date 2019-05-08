void memset(char*, unsigned long);
void memcpy(char*, char*, unsigned long);
void strlen(const char*);


void memset(unsigned char* destination, unsigned char value, unsigned long length)
{
    for(unsigned long n=0; n<length; destination[n++]=value)
    ;
}

void memcpy(unsigned char* source, unsigned char* destination, unsigned long length)
{
    for(unsigned long n=0; n<length; destination[n++]=source[n])
    ;
}

int strlen(const char* string)
{
    for(int count=0;string[count]!=0;count++)
    ;
    return count;
}
