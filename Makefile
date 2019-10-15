IMAGE=barambani/servant-poc-api
BUILDER_IMAGE=barambani/servant-poc-api-build
DEPENDENCIES_IMAGE=barambani/servant-poc-api-deps
PORT?=8080

.PHONY: build
build:
	stack test

.PHONY: local-server-run
local-server-run:
	docker pull ${DEPENDENCIES_IMAGE}:latest || true
	docker build --target dependencies --cache-from ${DEPENDENCIES_IMAGE}:latest -t ${DEPENDENCIES_IMAGE}:latest .
	docker build --target builder --cache-from ${DEPENDENCIES_IMAGE}:latest --cache-from ${BUILDER_IMAGE}:latest -t ${BUILDER_IMAGE}:latest .
	docker build --target service --cache-from ${DEPENDENCIES_IMAGE}:latest --cache-from ${BUILDER_IMAGE}:latest --cache-from ${IMAGE}:latest -t ${IMAGE}:latest .
	docker run -e PORT=${PORT} -p ${PORT}:${PORT} ${IMAGE}:latest

.PHONY: publish-cache-as-admin
publish-cache-as-admin:
	docker pull ${DEPENDENCIES_IMAGE}:latest || true
	docker build --target dependencies --cache-from ${DEPENDENCIES_IMAGE}:latest -t ${DEPENDENCIES_IMAGE}:latest .
	docker build --target builder --cache-from ${DEPENDENCIES_IMAGE}:latest --cache-from ${BUILDER_IMAGE}:latest -t ${BUILDER_IMAGE}:latest .
	docker build --target service --cache-from ${DEPENDENCIES_IMAGE}:latest --cache-from ${BUILDER_IMAGE}:latest --cache-from ${IMAGE}:latest -t ${IMAGE}:latest .
	docker push ${DEPENDENCIES_IMAGE}:latest
