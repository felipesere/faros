#!/bin/bash
aws --version
aws configure set default.region us-west-2
aws configure set default.output json

echo "preparing task definition"
aws ecs describe-task-definition --task-definition applications | ./jq --arg x $CIRCLE_SHA1 ' .taskDefinition
                                                                                              | del(.status)
                                                                                              | del(.taskDefinitionArn)
                                                                                              | del(.revision)
                                                                                              | .containerDefinitions[0].image = ("felipesere/faros:"+$x)' > new-task-definition.json

NEW_REVISION=$(aws ecs register-task-definition --cli-input-json file://new-task-definition.json | ./jq '.taskDefinition.revision')

echo "updating service definition"
aws ecs update-service --cluster alexandria --service lighthouse-2 --task-definition "applications:$NEW_REVISION"


