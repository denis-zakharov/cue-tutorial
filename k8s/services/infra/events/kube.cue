package kube

service: events: {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		name: "events"
		labels: {
			app:       "events"
			component: "infra"
			domain:    "prod"
		}
	}
	spec: {
		ports: [{
			port:       7788
			targetPort: 7788
			protocol:   "TCP"
			name:       "grpc"
		}]
		selector: {
			app:       "events"
			component: "infra"
			domain:    "prod"
		}
	}
}
deployment: events: {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: name: "events"
	spec: {
		replicas: 2
		template: {
			metadata: {
				labels: {
					// Important: these labels need to match the selector above
					// The api server enforces this constraint.
					app:       "events"
					component: "infra"
					domain:    "prod"
				}
				annotations: {
					"prometheus.io.scrape": "true"
					"prometheus.io.port":   "7080"
				}
			}
			spec: {
				affinity: podAntiAffinity: requiredDuringSchedulingIgnoredDuringExecution: [{
					labelSelector: matchExpressions: [{
						key:      "app"
						operator: "In"
						values: [
							"events",
						]
					}]
					topologyKey: "kubernetes.io/hostname"
				}]
				volumes: [{
					name: "secret-volume"
					secret: secretName: "biz-secrets"
				}]
				containers: [{
					name:  "events"
					image: "gcr.io/myproj/events:v0.1.31"
					ports: [{
						containerPort: 7080
					}, {
						containerPort: 7788
					}]
					args: [
						"-cert=/etc/ssl/server.pem",
						"-key=/etc/ssl/server.key",
						"-grpc=:7788",
					]

					volumeMounts: [{
						mountPath: "/etc/ssl"
						name:      "secret-volume"
					}]
				}]
			}
		}
	}
}
