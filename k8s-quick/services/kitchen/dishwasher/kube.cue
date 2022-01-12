package kube

deployment: dishwasher: spec: {
	replicas: 5
	template: spec: {
		volumes: [{
			name: "dishwasher-disk"
			gcePersistentDisk: {
				pdName: "dishwasher-disk"
				fsType: "ext4"
			}
		}, {
			name: "secret-dishwasher"
			secret: secretName: "dishwasher-secrets"
		}, {
			name: "secret-ssh-key"
			secret: secretName: "dishwasher-secrets"
		}]
		containers: [{
			image: "gcr.io/myproj/dishwasher:v0.2.13"
			volumeMounts: [{
				name:      "dishwasher-disk"
				mountPath: "/logs"
			}, {
				mountPath: "/sslcerts"
				name:      "secret-dishwasher"
				readOnly:  true
			}, {
				mountPath: "/etc/certs"
				name:      "secret-ssh-key"
				readOnly:  true
			}]
			args: [
				"-env=prod",
				"-ssh-tunnel-key=/etc/certs/tunnel-private.pem",
				"-logdir=/logs",
				"-event-server=events:7788",
			]
		}]
	}
}
