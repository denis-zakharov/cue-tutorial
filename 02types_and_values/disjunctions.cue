// disjunctions are union types
#Conn: {
    address:  string
    port:     int
    
    // It is an error for a concrete Conn to define anything else than these two values.
    protocol: "tcp" | "udp"
}

lossy: #Conn & {
    address:  "1.2.3.4"
    port:     8888
    protocol: "udp"
}


// floor defines the specs of a floor in some house.
floor: {
    level:   int  // the level on which this floor resides
    hasExit: bool // is there a door to exit the house?
}

// constraints on the possible values of floor.
floor: {
    level: 0 | 1
    hasExit: true
} | {
    level: -1 | 2 | 3
    hasExit: false
}

floor: level: 1