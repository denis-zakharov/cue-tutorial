package kube

#Component: "kitchen"

deployment: [string]: spec: template: {
	metadata: annotations: "prometheus.io.scrape": "true"
	spec: containers: [{
		ports: [{
			containerPort: 8080
		}]
		livenessProbe: {
			httpGet: {
				path: "/debug/health"
				port: 8080
			}
			initialDelaySeconds: 40
			periodSeconds:       3
		}
	}]
}
