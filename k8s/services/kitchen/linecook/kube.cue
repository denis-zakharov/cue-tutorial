package kube

service: linecook: {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		name: "linecook"
		labels: {
			app:       "linecook"
			component: "kitchen"
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
			app:       "linecook"
			component: "kitchen"
			domain:    "prod"
		}
	}
}
deployment: linecook: {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: name: "linecook"
	spec: {
		replicas: 1
		template: {
			metadata: {
				labels: {
					app:       "linecook"
					component: "kitchen"
					domain:    "prod"
				}
				annotations: "prometheus.io.scrape": "true"
			}
			spec: {
				volumes: [{
					name: "linecook-disk"
					gcePersistentDisk: {
						pdName: "linecook-disk"
						fsType: "ext4"
					}
				}, {
					name: "secret-kitchen"
					secret: secretName: "secrets"
				}]
				containers: [{
					name:  "linecook"
					image: "gcr.io/myproj/linecook:v0.1.42"
					volumeMounts: [{
						name:      "linecook-disk"
						mountPath: "/logs"
					}, {
						mountPath: "/etc/certs"
						name:      "secret-kitchen"
						readOnly:  true
					}]
					ports: [{
						containerPort: 8080
					}]
					args: [
						"-name=linecook",
						"-env=prod",
						"-logdir=/logs",
						"-event-server=events:7788",
						"-etcd",
						"etcd:2379",
						"-reconnect-delay",
						"1h",
						"-recovery-overlap",
						"100000",
					]

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
		}
	}
}
