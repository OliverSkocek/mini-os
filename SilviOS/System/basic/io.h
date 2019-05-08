#ifndef INCLUDE_IO_H
#define INCLUDE_IO_H

void write_port(unsigned short port, unsigned char data); /*port is 16 bit, data is 8bit*/
unsigned char read_port(unsigned short port);


#endif
