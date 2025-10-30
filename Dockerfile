FROM alpine:3.19

# Install dependencies
RUN apk add --no-cache \
    bash \
    curl \
    git \
    docker-cli \
    yq \
    openssl

# Install helm
RUN curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Install k3d
RUN curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

# Set working directory
WORKDIR /workspace

# Copy chart files
COPY chart/ ./chart/

# Create dist directory and generate bootstrap.yaml at build time
RUN mkdir -p dist && \
    echo "Generating bootstrap.yaml (flux + metallb + nginx)" && \
    helm template k3d chart > dist/bootstrap.yaml

# Set entrypoint to regenerate k3d config with output volume, create cluster, and export kubeconfig
ENTRYPOINT ["sh", "-c", "\
    echo 'Generating k3d-config with volumeBaseDir=${HOST_VOLUME_PATH:-/output}' && \
    helm template k3d chart \
        --set=k3d.volumeBaseDir=\"${HOST_VOLUME_PATH:-/output}\" \
        --set=registry1.username=\"${REGISTRY1_USERNAME}\" \
        --set=registry1.password=\"${REGISTRY1_PASSWORD}\" \
        --show-only=templates/k3d-config.yaml > dist/k3d.yaml && \
    k3d cluster delete --config dist/k3d.yaml && \
    k3d cluster create --config dist/k3d.yaml && \
    k3d kubeconfig get bb-helm > /output/kubeconfig.yaml && \
    echo 'Kubeconfig written to /output/kubeconfig.yaml'\
"]

# Note: This image expects the Docker socket and output directory to be mounted at runtime:
# docker run -v /var/run/docker.sock:/var/run/docker.sock \
#   -v $(pwd)/output:/output \
#   -e REGISTRY1_USERNAME -e REGISTRY1_PASSWORD \
#   -e HOST_VOLUME_PATH=$(pwd)/output \
#   rjferguson21/bb-k3d
