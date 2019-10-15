IMAGE=barambani/servant-poc-api
BUILDER_IMAGE=barambani/servant-poc-api-build
DEPENDENCIES_IMAGE=barambani/servant-poc-api-deps

.PHONY: build
build:
	stack test

.PHONY: publish-local
publish-local:
	docker pull ${DEPENDENCIES_IMAGE}:latest || true
	docker build --target dependencies --cache-from ${DEPENDENCIES_IMAGE}:latest -t ${DEPENDENCIES_IMAGE}:latest .
	docker build --target builder --cache-from ${DEPENDENCIES_IMAGE}:latest --cache-from ${BUILDER_IMAGE}:latest -t ${BUILDER_IMAGE}:latest .
	docker build --target service --cache-from ${DEPENDENCIES_IMAGE}:latest --cache-from ${BUILDER_IMAGE}:latest --cache-from ${IMAGE}:latest -t ${IMAGE}:latest .

.PHONY: publish-local-admin
publish-local-admin:
	docker pull ${DEPENDENCIES_IMAGE}:latest || true
	docker build --target dependencies --cache-from ${DEPENDENCIES_IMAGE}:latest -t ${DEPENDENCIES_IMAGE}:latest .
	docker build --target builder --cache-from ${DEPENDENCIES_IMAGE}:latest --cache-from ${BUILDER_IMAGE}:latest -t ${BUILDER_IMAGE}:latest .
	docker build --target service --cache-from ${DEPENDENCIES_IMAGE}:latest --cache-from ${BUILDER_IMAGE}:latest --cache-from ${IMAGE}:latest -t ${IMAGE}:latest .
	docker push ${DEPENDENCIES_IMAGE}:latest
