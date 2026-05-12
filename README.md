# reMarkable SDK Containers

> Cross-compile for any reMarkable device — no native SDK install required.

Containerized [reMarkable cross-compilation toolchains](https://developer.remarkable.com/documentation/sdk) built on Fedora 40. Mount your project, run `$CC`, get an ARM binary ready for your device.

> **Disclaimer:** Not affiliated with reMarkable AS. Provided as-is with no guarantees or warranties.

---

## Supported Devices

reMarkable uses internal codenames for each product. Images are tagged by codename and OS version.

| Device | Codename | OS Version | Toolchain |
|---|---|---|---|
| reMarkable Paper Pro Move | `chiappa` | 3.26.0.68 | 5.6.75 |
| reMarkable Paper Pro | `ferrari` | 3.26.0.68 | 5.6.75 |
| reMarkable 2 | `rm2` | 3.26.0.68 | 5.6.75 |
| reMarkable 1 | `rm1` | 3.26.0.68 | 5.6.75 |

---

## Quick Start

### 1. Build the image for your device

```bash
# reMarkable Paper Pro — default
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

### 2. Run the container and compile

Mount your project directory and start the shell:

```bash
make build-remarkable-one-container
```

Inside the container, use the `$CC` environment variable to invoke the cross-compiler:

```bash
$CC helloworld.c -o helloworld
```

The output binary is compiled for ARM and ready to copy to your reMarkable device.

> **Podman + SELinux:** Always append `:z` (shared) or `:Z` (private) to volume mounts to avoid permission errors.

---

## Image Tags

Images follow the `<os-version>-<codename>` convention:

| Image Tag | Device |
|---|---|
| `3.26.0.68-chiappa` | reMarkable Paper Pro Move |
| `3.26.0.68-ferrari` | reMarkable Paper Pro |
| `3.26.0.68-rm2` | reMarkable 2 |
| `3.26.0.68-rm1` | reMarkable 1 |

---

## Prerequisites

- [Podman](https://podman.io/) or Docker
- `make`

---

## How It Works

The `Dockerfile` accepts three build arguments — SDK base URL, OS version, and toolchain script name — and performs the following steps:

1. Installs Yocto build dependencies on a Fedora 40 base image
2. Downloads the official reMarkable toolchain installer from Google Cloud Storage
3. Runs the installer into `/home/remarkable/sdk`
4. Sources the SDK environment in `.bashrc` so `$CC`, `$CXX`, and related tools are available in every shell session
5. Sets the working directory to `/home/remarkable/dev`, where your project is mounted

The `Makefile` defines per-device OS versions, toolchain script names, and SDK environment filenames, passing them as `--build-arg` flags at build time.

---

## SDK Source

Toolchain scripts are fetched directly from reMarkable's official distribution:

```
https://storage.googleapis.com/remarkable-codex-toolchain/<os-version>/<script>.sh
```

For the full list of available releases and devices, see the [reMarkable developer links page](https://developer.remarkable.com/links).

---

## Updating SDK Versions

When reMarkable releases a new OS version:

1. Check [developer.remarkable.com/links](https://developer.remarkable.com/links) for the new OS version and toolchain script names
2. Update the version and script name variables for each device in `Makefile`
3. Verify the `RM_*_ENV_SETUP` filename matches what the SDK installer actually generates — check the TODO comments in `Makefile` for RM1, RM2, and chiappa
4. Rebuild and re-tag

---

## Contributing

Pull requests are welcome. The project is intentionally minimal — one `Dockerfile`, one `Makefile`, all devices.
