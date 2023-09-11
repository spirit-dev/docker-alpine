NS ?= gitlab-registry-internal.spirit-dev.net
NS_REPO ?= infrastructure/docker
IMAGE_NAME ?= alpine
IMAGE_FULLNAME ?= ${NS}/${NS_REPO}/${IMAGE_NAME}

GIT_HASH ?= githash
CURRENT_DATE_LABEL = --label="build_date=$(shell date --iso=seconds)" --label="git_hash=${GIT_HASH}"

ARCHITECTURE ?= aarch64
ALPINE_VERSION ?= 3.9.4
TAG ?= 3.9
LATEST ?= false

MINIROOTFS_URL = http://dl-cdn.alpinelinux.org/alpine/v${TAG}/releases/${ARCHITECTURE}/
MINIROOTFS_TGZ = alpine-minirootfs-${ALPINE_VERSION}-${ARCHITECTURE}.tar.gz

build: pull-image build-image tag-image see-image
test: test-image
push: login push-image

pull-image:
	@docker pull ${IMAGE_FULLNAME}:${TAG} || echo "${IMAGE_FULLNAME}:${TAG} - Does not exists"
	@docker pull ${IMAGE_FULLNAME}:${ALPINE_VERSION} || echo "${IMAGE_FULLNAME}:${ALPINE_VERSION} - Does not exists"

ifeq ($(LATEST), true)
	@docker pull ${IMAGE_FULLNAME}:latest || echo "${IMAGE_FULLNAME}:latest - Does not exists"
endif

build-image:
	@sed -i -e "s/<GIT_HASH>/${GIT_HASH}/g" assets/.profile
	@curl ${MINIROOTFS_URL}${MINIROOTFS_TGZ} --output assets/${MINIROOTFS_TGZ}
	@docker build -t ${IMAGE_FULLNAME}:${ALPINE_VERSION} --build-arg alpine_version=${ALPINE_VERSION} --build-arg architecture=${ARCHITECTURE} ${CURRENT_DATE_LABEL} .
	@rm assets/${MINIROOTFS_TGZ}
	@sed -i -e "s/${GIT_HASH}/<GIT_HASH>/g" assets/.profile

tag-image:
	@docker tag ${IMAGE_FULLNAME}:${ALPINE_VERSION} ${IMAGE_FULLNAME}:${TAG}

ifeq ($(LATEST), true)
	@docker tag ${IMAGE_FULLNAME}:${ALPINE_VERSION} ${IMAGE_FULLNAME}:latest
endif

see-image:
	@docker images | grep ${IMAGE_FULLNAME}

test-image:
	@container-structure-test test --image ${IMAGE_FULLNAME}:${ALPINE_VERSION} --config test.yaml

push-image:
	@docker push ${IMAGE_FULLNAME}:${TAG}
	@docker push ${IMAGE_FULLNAME}:${ALPINE_VERSION}

ifeq ($(LATEST), true)
	@docker push ${IMAGE_FULLNAME}:latest
endif

login:
	@docker login -u $$CI_REGISTRY_USER -p $$CI_REGISTRY_PASSWORD $$CI_REGISTRY