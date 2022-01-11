// definitions are schema; their values are not exported
msg: "Hello \(#Name)!"

#Name: "world"

// implicitly closed struct
#A: {
    field: int
}

a:   #A & { field: 3 }

//err: #A & { feild: 3 }