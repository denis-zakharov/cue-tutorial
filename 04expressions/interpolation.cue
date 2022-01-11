phrase: "You are \( #cost - #budget ) dollars over budget!"

#cost:   102
#budget: 88

sandwich: {
    type:            "Cheese"
    "has\(type)":    true
    hasButter:       true
    // butterAndCheese: hasButter && hasCheese // cannot refer to a generated field hasCheese
}