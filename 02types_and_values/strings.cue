// 21-bit unicode characters
a: "\U0001F60E" // 😎

// multiline strings
b: """
    Hello
    World!
    """

// interpolation \(expression)
c: "You are \( #cost - #budget ) dollars over budget!"

#cost:   102
#budget: 88

// "Raw" Strings
msg1: #"The sequence "\U0001F604" renders as \#U0001F604."#

msg2: ##"""
    A regular expression can conveniently be written as:

        #"\d{3}"#

    This construct works for bytes, strings and their
    multi-line variants.
    """##