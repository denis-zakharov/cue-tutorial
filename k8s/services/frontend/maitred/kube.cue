package kube

service: maitred: {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		name: "maitred"
		labels: {
			app:       "maitred"
			component: "frontend"
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
			app:    "maitred"
			domain: "prod"
		}
	}
}
deployment: maitred: {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: name: "maitred"
	spec: {
		replicas: 1
		template: {
			metadata: {
				labels: {
					app:       "maitred"
					component: "frontend"
					domain:    "prod"
				}
				annotations: {
					"prometheus.io.scrape": "true"
					"prometheus.io.port":   "7080"
				}
			}
			spec: containers: [{
				name:  "maitred"
				image: "gcr.io/myproj/maitred:v0.0.4"
				ports: [{
					containerPort: 7080
				}]
				args: [
				]
			}]
		}
	}
}
