# Sillyfilly-espdumper
silly little thing to dump any memory and flash regions from esp chips  
needs [esp-idf-tools](https://github.com/PrincessPi3/esp-idf-tools)  

just edit the file for your specifications  
### config file format:  
name start(hex) length(hex)  
one per line, no underscores in the hex  
  
example:
```
ROM0 0x40000000 0x4FFFF
Peripherals-1 0x600C0000 0xFFF
````