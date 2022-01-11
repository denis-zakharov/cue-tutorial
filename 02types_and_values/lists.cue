// Lists define arbitrary sequences of CUE values.

#IP: 4 * [ uint8 ]

// open ended lists
#PrivateIP: #IP
#PrivateIP: [10, ...uint8] |
    [192, 168, ...] |
    [172, >=16 & <=32, ...]

myIP: #PrivateIP
myIP: [10, 2, 3, 4]

yourIP: #PrivateIP
//yourIP: [11, 1, 2, 3] // invalid
yourIP: [10, 1, 2, 3] //ok