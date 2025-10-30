# Docker Image for BB-K3D

This Docker image automates the creation of a k3d cluster with Big Bang configuration.

## Using the Published Image

Pull the latest image from GitHub Container Registry:

```bash
docker pull ghcr.io/rjferguson21/bb-k3d-docker:latest
```

## Build the Image (Optional)

To build locally instead of using the published image:

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
  -e HOST_VOLUME_PATH=$(pwd)/output \
  ghcr.io/rjferguson21/bb-k3d-docker:latest
```

**Note**: The `HOST_VOLUME_PATH` environment variable must be set to the **absolute host path** of the output directory. This is used as `k3d.volumeBaseDir` for mounting volumes into k3d cluster nodes:

- Kubeconfig is written to `output/kubeconfig.yaml` (inside the container at `/output`)
- Cypress directory is mounted from the **host** at `$(pwd)/output/cypress` into cluster pods at `/cypress`
- Registry cache is stored at `$(pwd)/output/reg` on the host

Since k3d creates containers on the host Docker daemon (via the mounted socket), volume paths must reference **host paths**, not container paths.

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
