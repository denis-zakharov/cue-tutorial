package kube

service: updater: {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		name: "updater"
		labels: {
			app:       "updater"
			component: "infra"
			domain:    "prod"
		}
	}
	spec: {
		ports: [{
			port:       8080
			targetPort: 8080
			protocol:   "TCP"
			name:       "client"
		}]
		selector: {
			app:    "updater"
			domain: "prod"
		}
	}
}
deployment: updater: {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: name: "updater"
	spec: {
		replicas: 1
		template: {
			metadata: labels: {
				app:       "updater" // TODO: fix updater
				component: "infra"
				domain:    "prod"
			}
			spec: {
				volumes: [{
					name: "secret-updater"
					secret: secretName: "updater-secrets"
				}]
				containers: [{
					name:  "updater"
					image: "gcr.io/myproj/updater:v0.1.0"
					volumeMounts: [{
						mountPath: "/etc/certs"
						name:      "secret-updater"
					}]

					ports: [{
						containerPort: 8080
					}]
					args: [
						"-key=/etc/certs/updater.pem",
					]
				}]
			}
		}
	}
}
