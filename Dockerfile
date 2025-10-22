FROM rancher/k3s:v1.31.5-k3s1

# copy from dist/bootstrap.yaml to /var/lib/rancher/k3s/server/manifests/bootstrap.yaml
COPY dist/bootstrap.yaml /var/lib/rancher/k3s/server/manifests/bootstrap.yaml
