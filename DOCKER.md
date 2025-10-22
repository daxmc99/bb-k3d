# Docker Image for BB-K3D

This Docker image automates the creation of a k3d cluster with Big Bang configuration.

## Build the Image

```bash
docker build -t rjferguson21/bb-k3d .
```

## Run the Image

The image requires:

- Docker socket mounted
- Output directory mounted (used for kubeconfig and k3d volumes like cypress)
- Registry credentials as environment variables

```bash
mkdir -p output/cypress
docker run \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $(pwd)/output:/output \
  -e REGISTRY1_USERNAME \
  -e REGISTRY1_PASSWORD \
  rjferguson21/bb-k3d
```

**Note**: The `output` directory is used as `k3d.volumeBaseDir`, which means:

- Kubeconfig is written to `output/kubeconfig.yaml`
- Cypress directory is mounted from `output/cypress` (create it beforehand to avoid warnings)

## What It Does

1. **Build Time**: Generates `bootstrap.yaml` (Flux + MetalLB + nginx)

2. **Runtime**:
   - Generates `k3d.yaml` with `volumeBaseDir=/output`
   - Deletes existing cluster (if any)
   - Creates new k3d cluster
   - Exports kubeconfig to `/output/kubeconfig.yaml`

## Using the Kubeconfig

After running the container, use the generated kubeconfig:

```bash
export KUBECONFIG=$(pwd)/output/kubeconfig.yaml
kubectl get nodes
```
