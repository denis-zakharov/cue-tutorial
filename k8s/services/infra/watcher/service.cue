package kube

service: watcher: {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		name: "watcher"
		labels: {
			app:       "watcher"
			component: "infra"
			domain:    "prod"
		}
	}
	spec: {
		type:           "LoadBalancer"
		loadBalancerIP: "1.2.3.4." // static ip
		ports: [{
			port:       7788
			targetPort: 7788
			protocol:   "TCP"
			name:       "http"
		}]
		selector: app: "watcher"
	}
}