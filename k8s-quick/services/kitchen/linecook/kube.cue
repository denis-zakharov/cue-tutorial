package kube

deployment: linecook: spec: template: spec: {
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
		image: "gcr.io/myproj/linecook:v0.1.42"
		volumeMounts: [{
			name:      "linecook-disk"
			mountPath: "/logs"
		}, {
			mountPath: "/etc/certs"
			name:      "secret-kitchen"
			readOnly:  true
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
	}]
}
