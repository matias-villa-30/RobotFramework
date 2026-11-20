from robot.api.deco import keyword, library
import minimalmodbus

@library
class ModbusASCII():
    '''Library to interact with Modbus ASCII'''

    def __init__(self):
        self.modbus = minimalmodbus.Instrument("/dev/ttyACM0",17, mode=minimalmodbus.MODE_ASCII)

    
    @keyword
    def write_to_registers(self, reg_addr, value, func_code):
        reg_addr = int(reg_addr)
        value = int(value)
        if not (0 <= value <= 65535):
            return f"Error: Value {value} is out of 16-bit range"
        func_code = int(func_code)
        try:
            self.modbus.write_register(reg_addr, value, functioncode=func_code)
            return "Success"
        except Exception as error:
            return f"Modbus Exception Code: {error}"

    @keyword
    def write_negative_values_to_registers(self, reg_addr, value, func_code):
        reg_addr = int(reg_addr)
        value = int(value)
        if not (-32768 <= value <= 0):
            return f"Error: Value {value} is out of 16-bit range"
        func_code = int(func_code)
        try:
            self.modbus.write_register(reg_addr, value, functioncode=func_code, signed=True)
            return "Success"
        except Exception as error:
            return f"Modbus Exception Code: {error}"
    
    @keyword
    def read_from_registers(self, reg_addr, num_of_reg, func_code):
        reg_addr = int(reg_addr)
        num_of_reg = int(num_of_reg)
        func_code = int(func_code)
        try:
            return self.modbus.read_registers(reg_addr, num_of_reg, func_code)
        except Exception as error:
            return f"Modbus Exception Code: {error}"

    @keyword
    def read_negative(self, reg_addr, func_code):
        reg_addr = int(reg_addr)
        func_code = int(func_code)
        try:
            return self.modbus.read_register(
                registeraddress=reg_addr,
                number_of_decimals=0,
                functioncode=func_code,
                signed=True
            )
        except Exception as error:
            return f"Modbus Exception Code: {error}"
