list: [ "Cat", "Mouse", "Dog" ]

a: *list[0] | "None" // Cat
b: *list[5] | "None" // None because out of bounds

n: [null]
v: *(n[0]&string) | "default"

ho: list[1] | *"Jerry"