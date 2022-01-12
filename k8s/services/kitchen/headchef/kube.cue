package kube

deployment: headchef: spec: template: spec: {
	volumes: [{
		name: "headchef-disk"
		gcePersistentDisk: {
			pdName: "headchef-disk"
			fsType: "ext4"
		}
	}, {
		name: "secret-headchef"
		secret: secretName: "headchef-secrets"
	}]
	containers: [{
		image: "gcr.io/myproj/headchef:v0.2.16"
		volumeMounts: [{
			name:      "headchef-disk"
			mountPath: "/logs"
		}, {
			mountPath: "/sslcerts"
			name:      "secret-headchef"
			readOnly:  true
		}]
		args: [
			"-env=prod",
			"-logdir=/logs",
			"-event-server=events:7788",
		]
	}]
}
