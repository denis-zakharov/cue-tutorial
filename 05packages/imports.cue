// Under https://pkg.go.dev/cuelang.org/go/pkg
import (
	"encoding/json"
	"math"
    "list"
	s "strings"
)

data: json.Marshal({ a: math.Sqrt(7) })

avg: list.Avg([1,2,3,4])

camel: s.ToCamel("StatefulSet")