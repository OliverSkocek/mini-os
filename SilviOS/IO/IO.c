#define IDT_NUM 0xFF

struct IDT_entry{
	unsigned short int offset_lowerbits;            /* lower bits of 32 bit address of interrupt routine*/
	unsigned short int selector;                    /* GDT selector */
	unsigned char zero;                             /* set to zero*/
	unsigned char type_attr;                        /* */
	unsigned short int offset_higherbits;           /* higher bits of 32 bit address of interrupt routine */
} __attribute__((packed));

struct IDT_entry IDT[IDT_NUM];

void initialize_interrupt(void)
{
    unsigned long keyboard_address;
    unsigned long IDT_address;
    unsigned long IDT_ptr[2];


}

void memcpy(void* source, void* destination, )