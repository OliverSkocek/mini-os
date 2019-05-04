/*
service module for VGA display support. implements a text buffer to allow scrolling.


*/
#include <sys.h>

#define VGA_ADDRESS 0xB8000
#define CHAR_PER_LINE 80
#define NUM_OF_LINES 25
#define BUFFER_SIZE 256
#define WHITE_ON_BLACK 0x0F

unsigned short TEXT_BUFFER[BUFFER_SIZE][CHAR_PER_LINE];
unsigned char TOP_POS, ;
unsigned char CURSOR[2];


void cls(void){
    memset()
}


void use_arrow_keys(int key){
    if(key==0){                                         /*left*/
        if (CURSOR[0]==0){
            if(CURSOR[1]>0){
                CURSOR[0] = CHAR_PER_LINE - 1;
                CURSOR[1] = CURSOR[1]-1;
            }
        }
        else{
            CURSOR[0] = CURSOR[0]-1;
        }
    }
    else if(key==1){                                    /*up*/
        if (CURSOR[1]>0){
            CURSOR[1] = CURSOR[1]-1;
        }
    }
    else if(key==2){                                    /*down*/
        if (CURSOR[1]<NUM_OF_LINES-1){
            CURSOR[1] = CURSOR[1]+1;
        }
    }
    else if(key==3){                                    /*right*/
        if ((CURSOR[0]==CHAR_PER_LINE - 1)&&(CURSOR[1]<NUM_OF_LINES-1)){
            CURSOR[0] = 0;
            CURSOR[1] = CURSOR[1]+1;
        }
    }
    readjust();
}

void readjust(void){
    if(CURSOR[1]<TOP_POS){
        TOP_POS = CURSOR[1];
    } else if (CURSOR[1]>=TOP_POS + NUM_OF_LINES){
        TOP_POS = CURSOR[1] - NUM_OF_LINES + 1;
    }
    memcpy(((short*)TEXT_BUFFER) + CHAR_PER_LINE*(TOP_POS-NUM_OF_LINES+1), (char*)VGA_ADDRESS, 4000);
    get_cursor();
    set_cursor();
}


void putch(unsigned char c)
{
    if(c==0x08)
    {

    }

}
