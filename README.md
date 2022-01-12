# Commands
- eval file.cue: inner representation
- export file.cue: to JSON
- vet: validates CUE and other data files
- bash completion: `source <(cue completion bash)`

```
cue vet langschema.cue langdata.yaml 
languages.1.name: invalid value "dutch" (out of bound =~"^\\p{Lu}"):
    ./langschema.cue:3:8
    ./langdata.yaml:5:12
```

# Types

```
                    _ (top)
     /    /     /      |      \        \     \
  null  bool  string  bytes  number  struct  list
    |     |     |      |     /   \      |      |
    |     |     |      |   int  float   |      |
    \     \     \      /      |    /    /      /
                    _|_ (bottom/error)
```

# Predefined Bounds
```
uint      >=0
uint8     >=0 & <=255
int8      >=-128 & <=127
uint16    >=0 & <=65536
int16     >=-32_768 & <=32_767
rune      >=0 & <=0x10FFFF
uint32    >=0 & <=4_294_967_296
int32     >=-2_147_483_648 & <=2_147_483_647
uint64    >=0 & <=18_446_744_073_709_551_615
int64     >=-9_223_372_036_854_775_808 & <=9_223_372_036_854_775_807
int128    >=-170_141_183_460_469_231_731_687_303_715_884_105_728 &
              <=170_141_183_460_469_231_731_687_303_715_884_105_727
uint128   >=0 & <=340_282_366_920_938_463_463_374_607_431_768_211_455
```

# Kubernetes
Initialize a cue module as a set of one or more packages (similar to go modules).
```sh
cue mod init
```

Initialize a Go module to fetch k8s api definitions later `k8s.io/api/apps/v1`.
```sh
go mod init github.com/denis-zakharov/cue-k8s-tutorial
```

Let us convert the k8s yaml files to cue files.
```sh
cd services/

# -p cue package
# -l cue expression for a single object (for yaml files with many objects)`
#   We can use builtin packages under https://pkg.go.dev/cuelang.org/go/pkg, e.g.
#   strings.ToCamel("StatefulSet") -> "statefulSet"
#   Produce cue objects like `objKind: objName`, e.g. `statefulSet: etcd`
# -f ovewrite files
# -R detect structured data recursively (e.g. yaml in yaml for prometheus rules)
cue import ./... -p kube -l 'strings.ToCamel(kind)' -l metadata.name -f -R
```