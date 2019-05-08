#include <VGA_driver.h>
#include <keyboard_driver.h>
#include <sys.h>

#define CHAR_PER_LINE 80
#define NUM_OF_LINES 25

static unsigned char buffer[NUM_OF_LINES*CHAR_PER_LINE];
static unsigned char cursor[2];
static unsigned char screen_pos;
static char *STDIN;
static char *STDOUT;

void init(void)
void putch(char c);
void print(char* str);
void cls(void);


void init(void){
/*
    TODO init IDT

*/
    clear_screen();
    cursor = {0,1};
    set_cursor(cursor[0], cursor[0]);
    memset(&buffer, ' ', CHAR_PER_LINE*NUM_OF_LINES);
    print("Willkommen bei SilviOS!\n");
}


void putch(char c){


}