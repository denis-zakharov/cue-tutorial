// all fields are optional
#a: {
    foo?: int
    bar?: string
    baz?: string
    fiz?: string
}
b: #a & {
    foo:  3 // exported, not optional
    //bar: 0 // error, not optional and should be a string
    bar: "bar" // exported, not optional
    baz?: 2  // baz?: _|_ - an optional field results to an error hence unexported
    fiz?: "FIZ" // unexported as optional
}