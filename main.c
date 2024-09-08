#include <avr/io.h>
#include <util/delay.h>

#include "blink.h"

void init() {
	DDRB |= (1 << PB0);
  
	// Set up Timer/Counter0 in Fast PWM mode
    TCCR0A = (1 << COM0A1) | (1 << WGM01) | (1 << WGM00);
    TCCR0B = (1 << CS00); // No prescaling
	  
	// Set initial duty cycle (0-255)
	OCR0A = 25; // 50% duty cycle
}

void setServoPosition(int angle) {
  // Constrain angle to -90 to 90 degrees
  if (angle < -90) angle = -90;
  if (angle > 90) angle = 90;
  
  // Map angle to pulse width
  uint16_t pulseWidth;
  if (angle < 0) {
    pulseWidth = map(angle, -90, 0, SERVO_MIN, SERVO_MID);
  } else {
    pulseWidth = map(angle, 0, 90, SERVO_MID, SERVO_MAX);
  }
  
  // Set PWM compare value
  OCR1A = pulseWidth;
}

int main(void) {
	init();
    // Set LED pin as output
    LED_DDR |= (1 << LED_PIN);
    
    while (1) {
        blink(3);  // Blink 3 times with 500ms delay
        _delay_ms(10000);  // Wait for 1 second before next blink sequence
    }

    return 0;
}