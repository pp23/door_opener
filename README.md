# Door Opener

Connects to a SwitchBot (see project switchbot_holder) and triggers it on bluetooth remote control signal.
This is the box enclosure of the door opener circuit. The ciricuit has an Epson rx8010 RTC-I2C-module, a DCF77-receiver
and actually a AHT20-I2C humidity sensor (not working because the I2C connection was wired as a star architecture which
is not usable with I2C, the sensor does not get recognized. It works, if one I2C device is connected one after another).
