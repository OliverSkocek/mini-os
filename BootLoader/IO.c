
struct IDT_entry{
	unsigned short int offset_lowerbits;            /* lower bits of 32 bit address of interrupt routine*/
	unsigned short int selector;                    /* GDT selector */
	unsigned char zero;                             /* set to zero*/
	unsigned char type_attr;                        /* */
	unsigned short int offset_higherbits;           /* higher bits of 32 bit address of interrupt routine */
};

struct GDT_entry{
	unsigned long limit;                             /* 20 bit */
	unsigned long base;                              /* 32 bit */
	unsigned char access_byte;                      /*  8 bit */
	unsigned char flags;                            /*  8 bit */
};

struct GDT_Descriptor{
    unsigned int size;
    unsigned long address;

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
    GDT_entry_binary[0] = (0xFFFFUL & GDT_entry_instance.limit);
    GDT_entry_binary[0] = GDT_entry_binary[0] | ((0x0000FFFFUL & GDT_entry_instance.base)<<16);

    GDT_entry_binary[1] = ((0x00FF0000UL & GDT_entry_instance.base)>>16);
    GDT_entry_binary[1] = GDT_entry_binary[1] | (((long)GDT_entry_instance.access_byte)<<8);
    GDT_entry_binary[1] = GDT_entry_binary[1] | (0xF0000UL & GDT_entry_instance.limit);
    GDT_entry_binary[1] = GDT_entry_binary[1] | (((long)GDT_entry_instance.flags)<<20);
    GDT_entry_binary[1] = GDT_entry_binary[1] | ((0xFF000000UL & GDT_entry_instance.base));
    return GDT_entry_binary;
    }
}

void load_GDT(struct GDT_entry[] GDT_instance)
{



struct GDT_Descriptor;

GDT_Descriptor.size = sizeof(GDT_entry);
GDT_Descriptor.address = GDT_entry;


}