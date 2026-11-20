from robot.api.deco import keyword, library
import serial
import time


@library 
class FlukeSerialCommand():
    ''' Library for interacting with Fluke ProSim 8
    '''
    #ROBOT_LIBRARY_SCOPE = 'SUITE'
    #ROBOT_LIBRARY_SCOPE = 'GLOBAL'
    

    def __init__(self, portti):
        self._port = serial.Serial(portti, 115200, timeout = 5)
        
        
    @keyword
    def send_command(self, text):
        self._port.reset_input_buffer()
        self._port.write(bytes(text + '\n', 'iso-8859-1'))


    @keyword
    def response_should_be(self, expected_text):
        text = self._port.readline().strip().decode('iso-8859-1')
        if text != expected_text:
            raise AssertionError('Expected: ' + expected_text + ' got: ' + text)
            

    @keyword
    def ignore_response(self):
        self._port.readline()

    @keyword
    def read_coming(self):
        time.sleep(0.5)
        data = self._port.readline()
        return data.decode('iso-8859-1').strip()

