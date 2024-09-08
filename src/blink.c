#include "blink.h"

void blink(uint8_t times) {
    for (uint8_t i = 0; i < times; i++) {
        // Turn LED on
        LED_PORT |= (1 << LED_PIN);
        _delay_ms(500);
        
        // Turn LED off
        LED_PORT &= ~(1 << LED_PIN);
        _delay_ms(500);
    }
}