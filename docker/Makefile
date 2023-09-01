TEAM_NAME ?= devops
AWS_REGION ?= us-west-2
AWS_PROFILE ?= ecr-jenkins-central-access
NS ?= 142387216362.dkr.ecr.${AWS_REGION}.amazonaws.com
IMAGE_NAME ?= alpine

GIT_HASH ?= githash
CURRENT_DATE_LABEL = --label="build_date=$(shell date --iso=seconds)" --label="git_hash=${GIT_HASH}"

ALPINE_VERSION ?= 3.9.4
TAG ?= 3.9
LATEST ?= false

MINIROOTFS_URL = http://dl-cdn.alpinelinux.org/alpine/v${TAG}/releases/x86_64/
MINIROOTFS_TGZ = alpine-minirootfs-${ALPINE_VERSION}-x86_64.tar.gz

build: pull-image build-image tag-image see-image
test: test-image
push: login registry push-image

pull-image:
	@docker pull ${NS}/${IMAGE_NAME}:${TAG} || echo "${NS}/${IMAGE_NAME}:${TAG} - Does not exists"
	@docker pull ${NS}/${IMAGE_NAME}:${ALPINE_VERSION} || echo "${NS}/${IMAGE_NAME}:${ALPINE_VERSION} - Does not exists"

ifeq ($(LATEST), true)
	@docker pull ${NS}/${IMAGE_NAME}:latest || echo "${NS}/${IMAGE_NAME}:latest - Does not exists"
endif

build-image:
	@sed -i -e "s/<GIT_HASH>/${GIT_HASH}/g" assets/.profile
	@curl ${MINIROOTFS_URL}${MINIROOTFS_TGZ} --output assets/${MINIROOTFS_TGZ}
	@docker build -t ${NS}/${IMAGE_NAME}:${ALPINE_VERSION} --build-arg alpine_version=${ALPINE_VERSION} ${CURRENT_DATE_LABEL} .
	@rm assets/${MINIROOTFS_TGZ}
	@sed -i -e "s/${GIT_HASH}/<GIT_HASH>/g" assets/.profile

tag-image:
	@docker tag ${NS}/${IMAGE_NAME}:${ALPINE_VERSION} ${NS}/${IMAGE_NAME}:${TAG}

ifeq ($(LATEST), true)
	@docker tag ${NS}/${IMAGE_NAME}:${ALPINE_VERSION} ${NS}/${IMAGE_NAME}:latest
endif

see-image:
	@docker images | grep ${NS}/${IMAGE_NAME}

test-image:
	@container-structure-test test --image ${NS}/${IMAGE_NAME}:${ALPINE_VERSION} --config test.yaml

push-image:
	@docker push ${NS}/${IMAGE_NAME}:${TAG}
	@docker push ${NS}/${IMAGE_NAME}:${ALPINE_VERSION}

ifeq ($(LATEST), true)
	@docker push ${NS}/${IMAGE_NAME}:latest
endif

registry:
	@aws ecr describe-repositories --region ${AWS_REGION} --profile ${AWS_PROFILE} --repository-names ${IMAGE_NAME} || aws ecr create-repository --region ${AWS_REGION} --profile ${AWS_PROFILE} --repository-name ${IMAGE_NAME} --tags Key=app,Value=${IMAGE_NAME} Key=team,Value=${TEAM_NAME} --image-tag-mutability MUTABLE --image-scanning-configuration scanOnPush=true && aws ecr put-lifecycle-policy --region ${AWS_REGION} --profile ${AWS_PROFILE} --repository-name ${IMAGE_NAME} --lifecycle-policy-text '{"rules":[{"rulePriority":1,"description":"Remove untagged images","selection":{"tagStatus":"untagged","countType":"sinceImagePushed","countUnit":"days","countNumber":7},"action":{"type":"expire"}},{"rulePriority":2,"description":"Preserve 50 latest images","selection":{"tagStatus":"any","countType":"imageCountMoreThan","countNumber":50},"action":{"type":"expire"}}]}' && aws ecr set-repository-policy --region ${AWS_REGION} --profile ${AWS_PROFILE} --repository-name ${IMAGE_NAME} --policy-text '{"Version":"2008-10-17","Statement":[{"Sid":"cross-share-access","Effect":"Allow","Principal":{"AWS":["arn:aws:iam::968771061916:root","arn:aws:iam::119428626494:root","arn:aws:iam::897347678622:root","arn:aws:iam::546249166250:root"]},"Action":["ecr:BatchCheckLayerAvailability","ecr:BatchGetImage","ecr:CompleteLayerUpload","ecr:DescribeImages","ecr:DescribeRepositories","ecr:GetDownloadUrlForLayer","ecr:InitiateLayerUpload","ecr:ListImages","ecr:PutImage","ecr:UploadLayerPart"]}]}'

login:
	# @aws ecr get-login-password --region ${AWS_REGION} --profile ${AWS_PROFILE} | docker login --username AWS --password-stdin ${NS}
	docker login registry.local.lan