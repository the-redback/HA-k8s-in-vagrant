.PHONY: k8s-up
k8s-up:
	./up.sh

.PHONY: k8s-halt
k8s-halt:
	vagrant halt

.PHONY: k8s-destroy
k8s-destroy:
	vagrant destroy -f

default: k8s-up
