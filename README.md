# Remarkable-SDK-Containers
This repo house the source files for creating containers for the [Remarkable SDKs](https://developer.remarkable.com/documentation/sdk)

## Disclaimer
- I am not associated with Remarkable AS in any way
- This packaging is provided as is with no guaruntees or warranties

## Inspiration
I wanted to test out some Remarkable development, but did not want to really install the SDK on my system, so I decided to containerize it.

## Background
Remarkable gives their products code names as stated on their [website](https://developer.remarkable.com/links)
- Remarkable Paper Pro -> ferrari
- Remarkable 2 -> rm2
- Remarkable 1 -> rm1

This project uses the Remarkable codename when generating the containers

## Building
### Remarkable Paper Pro
Execute the following
```bash 
make
```

### Remarkable 2
```bash
make build-remarkable-two-container
```
### Remarkable 1
```bash
make build-remarkable-two-container
```

## Using
Once your containers are built, you can run them and mount your development directory into the container using `-v` volume mount option. (If using podman ensure you add the `:z/Z` to the volume mount)

```bash
podman run -it -v /path/to/software:/home/remarkable/dev:z docker.io/eli-xciv/remarkable-sdk:3.15.4.2-ferrari
```

This should give you a `bash` shell within the container. 
The container should also drop you to your softare directory.

You can then compile your software using the remarkable SDK.
```
$CC helloworld.c -o helloworld
```
