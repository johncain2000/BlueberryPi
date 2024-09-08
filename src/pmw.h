#ifndef PMW_H
#define PMW_H

#include <avr/io.h>
#include <util/delay.h>

void calculate_pulse_width(uint8_t degrees);
void rotate(uint8_t degrees);

#endif