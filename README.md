# Remarkable SDK Containers

Podman/Docker container images that package the [reMarkable cross-compilation SDKs](https://developer.remarkable.com/documentation/sdk), so you can build software for reMarkable devices without installing the SDK on your host system.

> **Disclaimer:** This project is not affiliated with reMarkable AS. Provided as-is with no guarantees or warranties.

---

## Supported Devices

reMarkable uses internal codenames for each device. This project uses those codenames as image tags.

| Device | Codename | Current OS Version |
|---|---|---|
| reMarkable Paper Pro Move | `chiappa` | 3.26.0.68 |
| reMarkable Paper Pro | `ferrari` | 3.26.0.68 |
| reMarkable 2 | `rm2` | 3.26.0.68 |
| reMarkable 1 | `rm1` | 3.26.0.68 |

---

## Prerequisites

- [Podman](https://podman.io/) or Docker
- `make`

---

## Building

Build the image for your target device. The default target builds for the reMarkable Paper Pro (ferrari).

```bash
# reMarkable Paper Pro (default)
make

# reMarkable Paper Pro Move
make build-remarkable-paper-pro-move-container

# reMarkable 2
make build-remarkable-two-container

# reMarkable 1
make build-remarkable-one-container

# All devices
make all
```

---

## Using

Run the container and mount your project directory into `/home/remarkable/dev`:

```bash
podman run -it \
    -v /path/to/your/project:/home/remarkable/dev:z \
    docker.io/eli-xciv/remarkable-sdk:3.26.0.68-ferrari
```

> **Podman users:** Always include `:z` or `:Z` on volume mounts for SELinux compatibility.

This drops you into a `bash` shell in your project directory with the reMarkable cross-compiler on `$PATH`. Use the `$CC` environment variable to invoke it:

```bash
$CC helloworld.c -o helloworld
```

The resulting binary is compiled for the target ARM architecture and ready to transfer to your reMarkable device.

---

## How It Works

The `Dockerfile` uses a Fedora 40 base image and:
1. Installs the Yocto build dependencies
2. Downloads the official reMarkable toolchain script from Google Cloud Storage
3. Installs the SDK into `/home/remarkable/sdk`
4. Sources the SDK environment in `.bashrc` so the cross-compiler is available on every shell start

SDK scripts and OS versions are defined per-device in the `Makefile` and sourced from:
`https://storage.googleapis.com/remarkable-codex-toolchain`
