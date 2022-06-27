export REPO_NAME = html_to_image_lambda

usage:       ## Show this help
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

zip:
	zip -r function.zip .

delete-zip:
	rm ./function.zip

create-function:
	roleArn=$$(aws iam get-role --role-name std-role | jq -r '.Role.Arn'); \
	aws lambda create-function --function-name $$REPO_NAME \
		--zip-file fileb://function.zip --handler handler.handler --runtime nodejs16.x \
		--role arn:aws:iam::655770903917:role/std-role

delete-function:
	aws lambda delete-function --function-name $$REPO_NAME

update-function:
	aws lambda update-function-code --function-name $$REPO_NAME \
		--zip-file fileb://function.zip

setup:
	make zip; make update-function; make delete-zip;

test:
	aws lambda invoke --function-name $$REPO_NAME --payload fileb://payload.json response.json

.PHONY: usage zip create-function delete-function update-function
