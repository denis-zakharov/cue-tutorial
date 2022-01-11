// lower, upper or inequality for numbers, strings, bytes and null

#rn: >=3 & <8        // type int | float
#ri: >=3 & <8 & int  // type int
#rf: >=3 & <=8.0     // type float
#rs: >="a" & <"mo"

a: #rn & 3.5
//b: #ri & 3.5 // invalid: not an int
c: #rf & 3
d: #rs & "ma"
//e: #rs & "mu" // invalid: > "mo"

r1: #rn & >=5 & <10 // another bound, an incomplete value
r1: 6.9

// use some predefined bounds (see README.md)
#positive: uint
#byte:     uint8
#word:     int32

pos: #positive & 1
int8bits: #byte & 128
int32bits: #word & 2_000_000_000