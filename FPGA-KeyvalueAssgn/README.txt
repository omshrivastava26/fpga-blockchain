The file create_bram.v contains working code for the search and transact operations on the block ram entries.
It has been tested using the test bench file - create_bram_tb.v

Update: The create_bram.v file now contains working code for insert operation on block ram.
It has been tested using the create_bram_tb.v - testbench file.

1. The incoming packet must have the format:

for refer:
command-code 1 byte
key 4 bytes
trailing zero 1 byte (00000000) used for detection purposes.

for transfer:
command-code 1 byte
key-debit 4 bytes
key-credit 4 bytes
transfer amnt
trailing zero 1 byte