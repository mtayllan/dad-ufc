export AWS_ACCESS_KEY_ID ?= test
export AWS_SECRET_ACCESS_KEY ?= test
export SERVICES = cloudformation,ecs,ecr
export AWS_DEFAULT_REGION = us-east-1
export REPO_NAME = html_to_base64_lambda

usage:       ## Show this help
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

install:     ## Install dependencies
	@which awslocal || pip install awscli-local

create-repo:
	echo "Creating a new ECR repository locally"; \
	awslocal ecr create-repository --repository-name $$REPO_NAME;

delete:      ## remove uploaded resources
	awslocal ecr delete-repository --repository-name repo3 --force; \
	awslocal lambda delete-function --function-name $$REPO_NAME

upload-image:         ## Build, deploy, and invoke the Lambda container image locally
	@make install; \
		repoUri=$$(awslocal ecr describe-repositories --repository-names=$$REPO_NAME |  jq -r '.repositories[0].repositoryUri'); \
		echo "Building the Docker image, pushing it to ECR URL: $$repoUri"; \
		docker build -t "$$repoUri" .; \
		docker push "$$repoUri";

create-function:
	echo "Deploying Lambda function from container image locally"; \
	awslocal lambda create-function --function-name $$REPO_NAME --package-type Image \
		--code ImageUri=$$repoUri --role arn:aws:iam::000000000:role/lambda-r1 \
		--handler handler.handler;

update-function:
	repoUri=$$(awslocal ecr describe-repositories --repository-names=$$REPO_NAME |  jq -r '.repositories[0].repositoryUri'); \
	awslocal lambda update-function-code --function-name $$REPO_NAME \
		--image-uri=$$repoUri;

test-invoke:
	awslocal lambda invoke --function-name $$REPO_NAME --payload fileb://payload.json response.json

test-ci:
	make install && make deploy || true

.PHONY: usage install deploy delete
