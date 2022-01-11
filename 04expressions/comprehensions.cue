import "strings"

squares: [ for x in #items if x rem 2 == 0 { x*x } ]
#items: [ 1, 2, 3, 4, 5, 6, 7, 8, 9 ]


#a: [ "Barcelona", "Shanghai", "Munich" ]
for k, v in #a {
    "\( strings.ToLower(v) )": {
        pos:     k + 1
        name:    v
        nameLen: len(v)
    }
}