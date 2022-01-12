// a template for objects down the file tree structure
package kube

configMap: [ID=_]: {
	metadata: name: ID
	metadata: labels: component: #Component
}

daemonSet: [ID=_]: _spec & {
	apiVersion: "apps/v1"
	kind:       "DaemonSet"
	_name:      ID
}

statefulSet: [ID=_]: _spec & {
	apiVersion: "apps/v1"
	kind:       "StatefulSet"
	_name:      ID
}

deployment: [ID=_]: _spec & {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	_name:      ID
	spec: replicas: *1 | int
}

service: [ID=_]: {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		name: ID
		labels: {
			app:       ID         // by convention
			component: #Component // varies per directory
			domain:    "prod"     // always the same in the given files
		}
	}
	spec: {
		ports: [...{
			port:     int
			protocol: *"TCP" | "UDP"
			name:     string | *"client"
		}]
		selector: metadata.labels
	}
}

#Component: string
_spec: {
	_name: string

	metadata: name: _name
	metadata: labels: component: #Component
	spec: selector: {}
	spec: template: {
		metadata: labels: {
			app:       _name
			component: #Component
			domain:    "prod"
		}
		spec: containers: [{name: _name}]
	}
}

// Define the _export option and set the default to true
// for all ports defined in all containers.
_spec: spec: template: spec: containers: [...{
	resources: limits: {
		cpu:    *"100m" | string
		memory: *"64Mi" | string
	}
	ports: [...{
		_export: *true | false // include the port in the service
	}]
}]

// Add Service object for each deployment, daemonSet of statefulSet
for workload in [deployment, daemonSet, statefulSet] for k, v in workload {
	// service: ID
	service: "\(k)": {
		spec: selector: v.spec.template.metadata.labels // get pod selector labels from objects
		spec: ports: [
			for c in v.spec.template.spec.containers
			for p in c.ports
			if p._export {
				let Port = p.containerPort
				port:       *Port | int
				targetPort: *Port | int
			},
		]
	}
}
