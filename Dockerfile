ARG BUILD_IMAGE="registry.fedoraproject.org/fedora:40"

FROM ${BUILD_IMAGE}

ARG RM_BASE_SDK_URL
ARG RM_OS_VERSION
ARG RM_SDK_SCRIPT_NAME
ARG RM_ENV_SETUP_FILE


# Install the required Yocto packages per
# https://docs.yoctoproject.org/ref-manual/system-requirements.html#fedora-packages
RUN dnf install -y \
    bzip2 ccache chrpath cpio cpp curl diffstat diffutils \
    file findutils gawk gcc gcc-c++ git glibc-devel \
    glibc-langpack-en gzip hostname libacl lz4 make \
    patch perl perl-Data-Dumper perl-File-Compare \
    perl-File-Copy perl-FindBin perl-Text-ParseWords \
    perl-Thread-Queue perl-bignum perl-locale \
    python3 python3-GitPython python3-jinja2 \
    python3-pexpect python3-pip rpcgen socat tar \
    texinfo unzip wget which xz zstd

# Add a Remarkable User
RUN useradd -m remarkable

USER remarkable

# Create SDK Directory
WORKDIR /home/remarkable/sdk

# Get SDK from Remarkable
RUN curl ${RM_BASE_SDK_URL}/${RM_OS_VERSION}/${RM_SDK_SCRIPT_NAME} -o ${RM_SDK_SCRIPT_NAME}

# Make SDK install script executable
RUN chmod u+x ${RM_SDK_SCRIPT_NAME}

# Install the SDK into the SDK Dir
RUN ./${RM_SDK_SCRIPT_NAME} -d /home/remarkable/sdk

# Add the env sourcing to the bashrc to ensure load
RUN echo "source /home/remarkable/sdk/${RM_ENV_SETUP_FILE}" >> ~/.bashrc

WORKDIR /home/remarkable/dev

ENTRYPOINT ["/bin/bash"]


