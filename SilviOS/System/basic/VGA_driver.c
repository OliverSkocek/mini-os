/*SilviOS VGA display driver.*/

#include <io.h>

#define VGA_ADDRESS 0xB8000
#define CHAR_PER_LINE 80
#define NUM_OF_LINES 25
#define WHITE_ON_BLACK 0x0F
#define CONTROL_PORT_VGA 0x3D4
#define DATA_PORT_VGA 0x3D5

void clear_screen(void);
void set_cursor(char,char);
char[] get_cursor(void);
void put_char(char);

void set_cursor(char X, char Y){
    unsigned short offset;
    X = X - (X/80)*80;
    Y = Y - (Y/25)*25;
    offset = Y*80 + X;
    write_port(CONTROL_PORT_VGA, 14);               /* tells VGA controller that high bits are coming*/
    write_port(DATA_PORT_VGA, offset >> 8);
    write_port(CONTROL_PORT_VGA, 15);               /* tells VGA controller that low bits are coming*/
    write_port(DATA_PORT_VGA, (char) offset);
}


char[] get_cursor(void){
    char[2] cursor;
    write_port(CONTROL_PORT_VGA, 14);               /* tells VGA controller that high bits are coming*/
    unsigned short offset = read_port(DATA_PORT_VGA) << 8;
    write_port(CONTROL_PORT_VGA, 15);               /* tells VGA controller that low bits are coming*/
    offset += read_port(DATA_PORT_VGA);
    cursor[1] = offset/80;
    cursor[0] = offset - cursor[1]*80;
    return cursor;
}


void put_char(char c){
    unsigned short *screen = VGA_ADDRESS;
    char[] cursor;
    unsigned short offset;
    cursor = get_cursor();
    offset = cursor[1]*80 + cursor[0];
    *(screen + offset) = ((WHITE_ON_BLACK << 8)|((char)c));
    offset += 1;
    offset = offset - (offset/(CHAR_PER_LINE*NUM_OF_LINES))*(CHAR_PER_LINE*NUM_OF_LINE);
    cursor[1] = offset/80;
    cursor[0] = offset - cursor[1]*80;
    set_cursor(cursor[0],cursor[1]);
}


void clear_screen(void){
    unsigned short *screen = VGA_ADDRESS;
    for(short i=0; i<CHAR_PER_LINE*NUM_OF_LINES; i++){
        *(screen + i) = put_char(' ');
    }
}
