#ifndef BLINK_H
#define BLINK_H

#include <avr/io.h>
#include <util/delay.h>

#define LED_PIN PB3  // Using PB3 (physical pin 2) for the LED
#define LED_PORT PORTB
#define LED_DDR DDRB

void blink(uint8_t times);

#endif // LED_BLINK_H