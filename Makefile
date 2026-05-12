RM_CONTAINER_REGISTRY = docker.io/eli-xciv
RM_CONTAINER_NAME = remarkable-sdk

# RM BASE SDK URL
RM_BASE_SDK_URL = https://storage.googleapis.com/remarkable-codex-toolchain

# Remarkable Paper Pro Vars
RM_FERRARI_OS_VERSION = 3.18.2.3
RM_FERRARI_SDK_SCRIPT_NAME = meta-toolchain-remarkable-4.4.21-ferrari-public-x86_64-toolchain.sh
RM_FERRARI_ENV_SETUP = environment-setup-cortexa53-crypto-remarkable-linux

# Remarkable 2 Vars
RM_RM2_OS_VERSION = 3.15.4.2
RM_RM2_SDK_SCRIPT_NAME = meta-toolchain-remarkable-4.1.112-rm2-public-x86_64-toolchain.sh
# TODO: verify this env setup filename against the actual RM2 SDK output
RM_RM2_ENV_SETUP = environment-setup-cortexa7t2hf-neon-remarkable-linux

# Remarkable 1 Vars
RM_RM1_OS_VERSION = 3.15.4.2
RM_RM1_SDK_SCRIPT_NAME = meta-toolchain-remarkable-4.1.112-rm1-public-x86_64-toolchain.sh
# TODO: verify this env setup filename against the actual RM1 SDK output
RM_RM1_ENV_SETUP = environment-setup-cortexa9hf-neon-remarkable-linux

.DEFAULT_GOAL := build-remarkable-paper-pro-container

build-remarkable-paper-pro-container:
	podman build \
		--build-arg RM_BASE_SDK_URL="$(RM_BASE_SDK_URL)" \
		--build-arg RM_OS_VERSION="$(RM_FERRARI_OS_VERSION)" \
		--build-arg RM_SDK_SCRIPT_NAME="$(RM_FERRARI_SDK_SCRIPT_NAME)" \
		--build-arg RM_ENV_SETUP_FILE="$(RM_FERRARI_ENV_SETUP)" \
		-t $(RM_CONTAINER_REGISTRY)/$(RM_CONTAINER_NAME):$(RM_FERRARI_OS_VERSION)-ferrari \
		.

build-remarkable-two-container:
	podman build \
		--build-arg RM_BASE_SDK_URL="$(RM_BASE_SDK_URL)" \
		--build-arg RM_OS_VERSION="$(RM_RM2_OS_VERSION)" \
		--build-arg RM_SDK_SCRIPT_NAME="$(RM_RM2_SDK_SCRIPT_NAME)" \
		--build-arg RM_ENV_SETUP_FILE="$(RM_RM2_ENV_SETUP)" \
		-t $(RM_CONTAINER_REGISTRY)/$(RM_CONTAINER_NAME):$(RM_RM2_OS_VERSION)-rm2 \
		.

build-remarkable-one-container:
	podman build \
		--build-arg RM_BASE_SDK_URL="$(RM_BASE_SDK_URL)" \
		--build-arg RM_OS_VERSION="$(RM_RM1_OS_VERSION)" \
		--build-arg RM_SDK_SCRIPT_NAME="$(RM_RM1_SDK_SCRIPT_NAME)" \
		--build-arg RM_ENV_SETUP_FILE="$(RM_RM1_ENV_SETUP)" \
		-t $(RM_CONTAINER_REGISTRY)/$(RM_CONTAINER_NAME):$(RM_RM1_OS_VERSION)-rm1 \
		.

all: build-remarkable-paper-pro-container build-remarkable-two-container build-remarkable-one-container
