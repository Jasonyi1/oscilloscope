import serial

class UartContraller():
    def __init__(self, baudrate, com):
        self.baudrate = baudrate
        self.com = com
        serial = serial.Serial('COM3', baudrate, timeout=0.5)
