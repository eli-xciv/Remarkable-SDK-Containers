RM_CONTAINER_REGISTRY = docker.io/eli-xciv
RM_CONTAINER_NAME = remarkable-sdk

# RM BASE SDK URL
RM_BASE_SDK_URL = https://storage.googleapis.com/remarkable-codex-toolchain
RM_OS_VERSION = 3.15.4.2

# Remarkable Paper Pro Vars
RM_FERRARI_OS_VERSION = 3.15.4.2
RM_FERRARI_SDK_SCRIPT_NAME = meta-toolchain-remarkable-4.1.112-ferrari-public-x86_64-toolchain.sh

# Remarkable 2 Vars
RM_RM2_OS_VERSION = 3.15.4.2
RM_RM2_SDK_SCRIPT_NAME = meta-toolchain-remarkable-4.1.112-rm2-public-x86_64-toolchain.sh

# Remarkable 1 Vars
RM_RM1_OS_VERSION = 3.15.4.2
RM_RM1_SDK_SCRIPT_NAME = meta-toolchain-remarkable-4.1.112-rm1-public-x86_64-toolchain.sh

.DEFAULT_GOAL := build-remarkable-paper-pro-container

build-remarkable-paper-pro-container:
	podman build \
		--build-arg RM_BASE_SDK_URL="$(RM_BASE_SDK_URL)" \
		--build-arg RM_OS_VERSION="$(RM_OS_VERSION)" \
		--build-arg RM_SDK_SCRIPT_NAME="$(RM_FERRARI_SDK_SCRIPT_NAME)" \
		-t $(RM_CONTAINER_REGISTRY)/$(RM_CONTAINER_NAME):$(RM_OS_VERSION)-ferrari \
    .

build-remarkable-two-container:
	podman build \
		--build-arg RM_BASE_SDK_URL="$(RM_BASE_SDK_URL)" \
		--build-arg RM_OS_VERSION="$(RM_OS_VERSION)" \
		--build-arg RM_SDK_SCRIPT_NAME="$(RM_RM2_SDK_SCRIPT_NAME)" \
		-t $(RM_CONTAINER_REGISTRY)/$(RM_CONTAINER_NAME):$(RM_OS_VERSION)-rm2 \
    .

build-remarkable-one-container:
	podman build \
		--build-arg RM_BASE_SDK_URL="$(RM_BASE_SDK_URL)" \
		--build-arg RM_OS_VERSION="$(RM_OS_VERSION)" \
		--build-arg RM_SDK_SCRIPT_NAME="$(RM_RM2_SDK_SCRIPT_NAME)" \
		-t $(RM_CONTAINER_REGISTRY)/$(RM_CONTAINER_NAME):$(RM_OS_VERSION)-rm1 \
    .

all: build-remarkable-paper-pro-container build-remarkable-two-container	build-remarkable-one-container
