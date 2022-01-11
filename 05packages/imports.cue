// Under https://pkg.go.dev/cuelang.org/go/pkg
import (
	"encoding/json"
	"math"
    "list"
)

data: json.Marshal({ a: math.Sqrt(7) })

avg: list.Avg([1,2,3,4])