"""

write_register(registeraddress: int, value: Union[int, float], number_of_decimals: int = 0, functioncode: int = 16, signed: bool = False) → None[source]

Write an integer to one 16-bit register in the slave, possibly scaling it.

The slave register can hold integer values in the range 0 to 65535 (“Unsigned INT16”).

Args:

registeraddress: The slave register address.
value (int or float): The value to store in the slave register (might be scaled before sending).
number_of_decimals: The number of decimals for content conversion.
functioncode: Modbus function code. Can be 6 or 16.
signed: Whether the data should be interpreted as unsigned or signed.

read_registers(registeraddress: int, number_of_registers: int, functioncode: int = 3) → List[int][source]

Read integers from 16-bit registers in the slave.

The slave registers can hold integer values in the range 0 to 65535 (“Unsigned INT16”).

Args:

registeraddress: The slave register start address.
number_of_registers: The number of registers to read, max 125 registers.
functioncode: Modbus function code. Can be 3 or 4.

"""


import minimalmodbus

modbus = minimalmodbus.Instrument("/dev/ttyACM0",17, mode=minimalmodbus.MODE_ASCII)

try:
    modbus.write_register(10, 90105, functioncode=6)
except Exception as error:
    print(f"Modbus Exception Code: {error}")

a = modbus.read_registers(10,1,3)
for item in a:
    print(hex(item))
#try:
#    mb.write_register(13, 115665, functioncode=6);
#except ValueError or IOError as e:
#    print(f"Modbus exception: {e}")
#else:
#    print(mb.read_registers(13,1,3))

