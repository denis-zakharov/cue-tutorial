// CUE knows how to resolve the following:
x: 200
x: y + 100 // (2) 100+100=200 // valid cycle
y: x - 100 // (1) 200-100=100

// If a cycle is not broken, CUE will just report it.
//a: b + 100
//b: a - 100