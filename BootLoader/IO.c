
struct IDT_entry{
	unsigned short int offset_lowerbits;            /* lower bits of 32 bit address of interrupt routine*/
	unsigned short int selector;                    /* GDT selector */
	unsigned char zero;                             /* set to zero*/
	unsigned char type_attr;                        /* */
	unsigned short int offset_higherbits;           /* higher bits of 32 bit address of interrupt routine */
};

struct GDT_entry{
	unsigned int limit;                             /* 20 bit */
	unsigned int base;                              /* 32 bit */
	unsigned char access_byte;                      /*  8 bit */
	unsigned char flags;                            /*  8 bit */
};

