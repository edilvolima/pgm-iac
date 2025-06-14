# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Fixed
- Corrected the `k8s-tools-cluster` role to properly deploy RKE clusters:
  - Modified `tasks/deploy-rke.yml` to execute `rke up` command from the `/vagrant` directory, ensuring correct relative SSH key paths.
  - Uncommented and set `cluster_name: k8s-tools` in `templates/cluster.yml.j2` for clarity.

### Added
- Created this CHANGELOG.md file.
- Added `play_verify_k8s-tools_cluster.yml` playbook for basic post-deployment cluster verification.
