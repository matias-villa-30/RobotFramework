from robot.api.deco import keyword, library
import serial
import time

@library
class ATLibrary():
    '''Library to interact with Pico by AT commands'''

    def __init__(self, portti):
        self._port = serial.Serial(portti, 115200)
    
    @keyword
    def disable_echo(self):
        self._port.write(bytes('ATE1\r\n', 'iso-8859-1'))

    @keyword
    def send_plain_at(self):
        self._port.reset_input_buffer()
        self._port.write(bytes('AT\r\n', 'iso-8859-1'))

    @keyword
    def send_cr(self, text):
        self._port.reset_input_buffer()
        self._port.write(bytes(text + '\r\n', 'iso-8859-1'))
    
    @keyword
    def set_len_timeout(self, num_chars, timeout):
        timeout = int(timeout)
        self._port.reset_input_buffer()
        self._port.write(bytes('ATW' + num_chars + '\r\n', 'iso-8859-1'))
        self._port.write_timeout = timeout

    @keyword
    def ignore_response(self):
        self._port.readline()

    
    @keyword
    def send_command(self, text):
        self._port.reset_input_buffer()
        self._port.write(bytes('AT+SEND=' + text + '\r\n', 'iso-8859-1'))

    @keyword
    def read_coming(self):
        time.sleep(0.7)
        if self._port.in_waiting > 0:
            data = self._port.read(self._port.in_waiting)
            return data.decode('iso-8859-1').strip()
        return ""
