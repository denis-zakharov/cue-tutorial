package kube

deployment: expiditer: spec: template: spec: {
	volumes: [{
		name: "expiditer-disk"
		gcePersistentDisk: {
			pdName: "expiditer-disk"
			fsType: "ext4"
		}
	}, {
		name: "secret-expiditer"
		secret: secretName: "expiditer-secrets"
	}]
	containers: [{
		image: "gcr.io/myproj/expiditer:v0.5.34"
		volumeMounts: [{
			name:      "expiditer-disk"
			mountPath: "/logs"
		}, {
			mountPath: "/etc/certs"
			name:      "secret-expiditer"
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
