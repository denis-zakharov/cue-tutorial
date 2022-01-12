package kube

deployment: pastrychef: spec: template: spec: {
	volumes: [{
		name: "pastrychef-disk"
		gcePersistentDisk: {
			pdName: "pastrychef-disk"
			fsType: "ext4"
		}
	}, {
		name: "secret-ssh-key"
		secret: secretName: "secrets"
	}]
	containers: [{
		image: "gcr.io/myproj/pastrychef:v0.1.15"
		volumeMounts: [{
			name:      "pastrychef-disk"
			mountPath: "/logs"
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
			"-reconnect-delay=1m",
			"-etcd=etcd:2379",
			"-recovery-overlap=10000",
		]
	}]
}
