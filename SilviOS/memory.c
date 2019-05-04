struct GDT_entry{
	unsigned long limit;                             /* 20 bit */
	unsigned long base;                              /* 32 bit */
	unsigned char access_byte;                       /*  8 bit */
	unsigned char flags;                             /*  8 bit */
};


unsigned long* encode_GDT_entry(struct GDT_entry GDT_entry_instance)
{
unsigned long GDT_entry_binary[2] ={0, 0};

if (GDT_entry_instance.limit > 0xFFFFFUL)
    {
    return GDT_entry_binary;
    }
else
    {
    GDT_entry_binary[0] = (0x0000FFFFUL & GDT_entry_instance.limit)| ((0x0000FFFFUL & GDT_entry_instance.base)<<16);

    GDT_entry_binary[1] = ((0x00FF0000UL & GDT_entry_instance.base)>>16)| (((long)GDT_entry_instance.access_byte)<<8)
                          |(0x000F0000UL & GDT_entry_instance.limit)|(((long)GDT_entry_instance.flags)<<20)
                          |(0xFF000000UL & GDT_entry_instance.base);
    return GDT_entry_binary;
    }
}


void load_GDT(char* target, struct GDT_entry[] GDT_instance)
{
char* GDT_entry_binary;
unsigned short GDT_Descriptor[3];
unsigned long *address = GDT_Descriptor + 1;

GDT_Descriptor[0] = (unsigned short)(sizeof(GDT_instance)/sizeof(GDT_instance[0]))-1;
*address = (unsigned long)target;

for (i=0;i<=GDT_Descriptor[0];i++)
    {
    GDT_entry_binary = (char*)encode_GDT_entry(GDT_instance[i]);
    for (j=0;j<=8;j++)
        {
        *(target+j+i*8) = GDT_entry_instance[j];
        }
    }





}

void memset(unsigned char* destination, unsigned char value, unsigned int length)
{
    for(int n=0; n<length; destination[n++]=value)
    ;
}

void memcpy(unsigned char* source, unsigned char* destination, unsigned int length)
{
    for(int n=0; n<length; destination[n++]=source[n])
    ;
}

int strlen(const char* string)
{
    for(int count=0;string[count]!=0;count++)
    ;
    return count;
}
