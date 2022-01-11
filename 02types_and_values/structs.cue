a: close({
    field: int
})

// ERROR: can be merged only with allowed fields for a closed struct
b: a & {
    field: 2
    other: 3 //not allowed
}

c: a & {
    field: 2
}