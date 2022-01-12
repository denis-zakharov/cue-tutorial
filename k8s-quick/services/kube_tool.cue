package kube

objects: [ for v in _objectSets for x in v {x}]

_objectSets: [
	service,
	deployment,
	statefulSet,
	daemonSet,
	configMap,
]
