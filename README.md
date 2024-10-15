# k8s-ioh-demo

This repository demonstrates how to use FluxCD to deploy launchpad-charts.

## Features

- **FluxCD**: Automate cluster updates and bootstrap
- **Cilium CNI**: Advanced networking and security
- **Kind/Tilt**: Automated dev environment setup with a web UI

## Requirements

This project uses Nix Flakes to manage and install the necessary dependencies for
setting up and managing the cluster mesh. The `flake.nix` file contains all the
required configurations and package dependencies, making the environment setup
reproducible and straightforward.

Installing Nix with flakes support is beyond the scope of this repo, however I recommend
using the full featured `nix-installer` at <https://github.com/DeterminateSystems/nix-installer>.

Alternatively, you can manually install every separate dependencies mentioned
in the `flake.nix` file, but we can't guarantee it working since package versions
will most likely not match the one used in the Nix environment.

## Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/pinax-network/k8s-ioh-demo.git
cd k8s-ioh-demo
```

### 2. Enter the Nix development environment

```bash
nix develop
```

### 3. Setup the environment variables for bootstrap

Since this demo uses fluxCD to bootstrap the management cluster, you will
need to configure some environment variables before bootstrapping.

To bootstrap Flux, the person running the command must have cluster admin
rights for the target Kubernetes cluster. It is also required that the
person running the command to be the owner of the GitHub repository, or
to have admin rights of a GitHub organization.

If you don't have the required access permission to this repo, you will have to
change the [flux bootstrap script](scripts/flux-bootstrap.sh) to use your
own GitHub Repo instead.

For accessing the GitHub API, the bootstrap command requires a GitHub personal
access token (PAT) with administration permissions.

The GitHub PAT can be exported as an environment variable:

```bash
export GITHUB_TOKEN=<gh-token>
```

Alternatively, you can use `sops` to encrypt a GitHub PAT token
in this repo and point the [flux bootstrap script](scripts/flux-bootstrap.sh)
to it. If the `GITHUB_TOKEN` variable is not set, the bootstrap script
will try to decrypt the secret using sops automatically.

### 4. Bootstrap the cluster

This repository contains a [Tiltfile](https://tilt.dev/) that is used for local
development. To build a local k8s cluster with kind run:

```bash
make setup
```

To bring up a tilt development environment run `tilt up` or:

```bash
make up
```
