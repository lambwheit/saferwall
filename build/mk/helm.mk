HELM_VERSION = 3.2.0
HELM_ZIP = helm-v$(HELM_VERSION)-linux-amd64.tar.gz 
HELM_URL = https://get.helm.sh/$(HELM_ZIP)

helm-install:		## Install Helm.
	wget $(HELM_URL)
	tar zxvf $(HELM_ZIP)
	sudo mv linux-amd64/helm /usr/local/bin/helm
	rm -f $(HELM_ZIP)
	helm version

helm-add-repos:	## Add the required Helm Charts repositories.
	helm repo add stable https://kubernetes-charts.storage.googleapis.com/
	helm repo add couchbase https://couchbase-partners.github.io/helm-charts/
	helm repo add elastic https://helm.elastic.co
	helm repo add jetstack https://charts.jetstack.io
	# Update your local Helm chart repository cache.
	helm repo update

helm-create:		## Create a Helm deployment.
	cd $(ROOT_DIR)/deployments \
		&& helm create saferwall \ 
		&& helm ls

helm-release:		## Install Helm release.
	cd  $(ROOT_DIR)/deployments \
		&& helm install saferwall MERCURY

helm-upgrade:		## Upgrade a given release.
	helm upgrade $(RELEASE_NAME) saferwall
