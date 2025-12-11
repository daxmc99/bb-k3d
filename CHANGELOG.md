# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.1]

### Added

- Added neuvector to default hosts

## [0.2.0]

### Added

- Registry proxy support for reducing neccesary config
- NGINX proxy configuration for cluster ingress

### Changed

- Docker for Mac compatibility adjustments

### Removed

- Legacy deployment scripts

## [0.1.3] - 2025-10-21

### Removed

- Keycloak references from configuration

## [0.1.2]

### Added

- Template support for dev environment and etchosts configuration

### Fixed

- TLS SAN issues in cluster configuration

### Changed

- Removed path prefix handling from configurations

## [0.1.1]

### Added

- Chart publishing configuration
- Automated releaser setup

### Changed

- Chart naming improvements

## [0.1.0] - Initial Release

### Added

- Initial Helm chart structure for K3D cluster management
- Bootstrap configuration generation for Flux and MetalLB
- K3D configuration file generation (k3d.yaml)
- MetalLB configuration with hostAliases integration
- Big Bang integration support
- Flux2 dependency (version 2.15.0)
- README with deployment instructions and examples
- Support for registry credentials configuration
- Host aliases management for load balancer IPs

[Unreleased]: https://github.com/rjferguson21/bb-k3d/compare/v0.1.3...HEAD
[0.1.3]: https://github.com/rjferguson21/bb-k3d/compare/v0.1.2...v0.1.3
[0.1.2]: https://github.com/rjferguson21/bb-k3d/compare/v0.1.1...v0.1.2
[0.1.1]: https://github.com/rjferguson21/bb-k3d/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/rjferguson21/bb-k3d/releases/tag/v0.1.0
