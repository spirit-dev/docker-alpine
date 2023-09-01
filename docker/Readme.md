<img src="https://alpinelinux.org/alpinelinux-logo.svg"/>

# Alpine Organization

```shell
images/os/alpine
├── 3.10.x # This is an example
│   ├── assets
│   │   └── alpine-minirootfs-3.10.x-x86_64.tar.gz
│   └── Dockerfile # Specific Dockerfile for this version
├── assets
│   ├── alpine-minirootfs-3.6.5-x86_64.tar.gz
│   ├── alpine-minirootfs-3.7.3-x86_64.tar.gz
│   ├── alpine-minirootfs-3.8.4-x86_64.tar.gz
│   └── alpine-minirootfs-3.9.4-x86_64.tar.gz
├── Dockerfile # Generic Dockerfile for all versions
├── Makefile
├── Readme.md
└── test.yaml # Unit tests
```

# Supported tags

`docker images`

| Image                                               | Tag             | Size   |
| --------------------------------------------------- | --------------- | ------ |
| 142387216362.dkr.ecr.us-west-2.amazonaws.com/alpine | latest (3.14.1) | 17MB   |
| 142387216362.dkr.ecr.us-west-2.amazonaws.com/alpine | 3.14            | 17MB   |
| 142387216362.dkr.ecr.us-west-2.amazonaws.com/alpine | 3.14.1          | 17MB   |
| 142387216362.dkr.ecr.us-west-2.amazonaws.com/alpine | 3.13            | 23.4MB |
| 142387216362.dkr.ecr.us-west-2.amazonaws.com/alpine | 3.13.5          | 23.4MB |
| 142387216362.dkr.ecr.us-west-2.amazonaws.com/alpine | 3.12            | 22.3MB |
| 142387216362.dkr.ecr.us-west-2.amazonaws.com/alpine | 3.12.6          | 22.3MB |
| 142387216362.dkr.ecr.us-west-2.amazonaws.com/alpine | 3.11            | 22.3MB |
| 142387216362.dkr.ecr.us-west-2.amazonaws.com/alpine | 3.11.11         | 22.3MB |
| 142387216362.dkr.ecr.us-west-2.amazonaws.com/alpine | 3.12.0          | 22.3MB |
| 142387216362.dkr.ecr.us-west-2.amazonaws.com/alpine | 3.11.6          | 22.3MB |
| 142387216362.dkr.ecr.us-west-2.amazonaws.com/alpine | 3.10            | 22.8MB |
| 142387216362.dkr.ecr.us-west-2.amazonaws.com/alpine | 3.10.5          | 22.8MB |
| 142387216362.dkr.ecr.us-west-2.amazonaws.com/alpine | 3.9             | 18.2MB |
| 142387216362.dkr.ecr.us-west-2.amazonaws.com/alpine | 3.9.6           | 18.2MB |
| 142387216362.dkr.ecr.us-west-2.amazonaws.com/alpine | 3.8             | 14.8MB |
| 142387216362.dkr.ecr.us-west-2.amazonaws.com/alpine | 3.8.5           | 14.8MB |
| 142387216362.dkr.ecr.us-west-2.amazonaws.com/alpine | 3.7             | 14.4MB |
| 142387216362.dkr.ecr.us-west-2.amazonaws.com/alpine | 3.7.3           | 14.4MB |
| 142387216362.dkr.ecr.us-west-2.amazonaws.com/alpine | 3.6             | 13.9MB |
| 142387216362.dkr.ecr.us-west-2.amazonaws.com/alpine | 3.6.5           | 13.9MB |

# **Local Test**

## **Usage**

### _**Methode 1**_

```shell
make test
```

### _**Methode 2**_

```shell
container-structure-test test --image ssense/alpine:${TAG} --config test.yaml
```

# Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

# Resource

- <https://hub.docker.com/_/alpine>
- <https://github.com/alpinelinux/docker-alpine>
