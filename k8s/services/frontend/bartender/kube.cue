package kube

service: bartender: {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		name: "bartender"
		labels: {
			component: "frontend"
			app:       "bartender"
			domain:    "prod"
		}
	}
	spec: {
		ports: [{
			port:       7080
			targetPort: 7080
			protocol:   "TCP"
			name:       "client"
		}]
		selector: {
			component: "frontend"
			app:       "bartender"
			domain:    "prod"
		}
	}
}
deployment: bartender: {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: name: "bartender"
	spec: {
		replicas: 1
		template: {
			metadata: {
				labels: {
					component: "frontend"
					app:       "bartender"
					domain:    "prod"
				}
				annotations: {
					"prometheus.io.scrape": "true"
					"prometheus.io.port":   "7080"
				}
			}
			spec: containers: [{
				name:  "bartender"
				image: "gcr.io/myproj/bartender:v0.1.34"
				ports: [{
					containerPort: 7080
				}]
				args: [
				]
			}]
		}
	}
}
