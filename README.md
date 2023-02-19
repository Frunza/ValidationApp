# ValidationApp
App validates yaml.

# Requirements

- python3
- kubectl

# Initializing the project

Run the following command

```
python3 -m pip install -r requirements.txt
```

# How to run

### Unit tests

Run the unit test for the validation method by running the following command

```
python3 tests/utils_tests.py
```

*tests/correct_yaml_example* was generated with the following command

```
kubectl create deployment validationapp --image=none --dry-run=client -o yaml > tests/correct_yaml_example
```

### Integration tests against running local server

These tests use the same validation files used in the unit tests but run against a running local server.

##### Preparation

Start the server by running the following script

```
sh scripts/server/start_server.sh
```

##### Testing

Run the following scripts with valid and invalid files and check the server responses

```
sh scripts/server/validate_correct_yaml.sh
sh scripts/server/validate_incorrect_yaml.sh
```

### Integration tests against running local server in docker

These tests use the same validation files used in the unit tests but run against a running local server in docker.

##### Preparation

Build the docker image by running the following script

```
sh scripts/docker/build_docker_image.sh
```

Look for your docker image by running the following command (note size differences between images: "python:3.9-alpine" and "python:3.9")

```
docker images | grep "validation_server_app"
```

Run the docker image with the script below. A container is created and that container is run.

```
sh scripts/docker/run_docker_image.sh
```

Make sure that the application container is acutally running with the following command

```
docker ps --filter ancestor="validation_server_app"
```

##### Testing

Run the following scripts with valid and invalid files and check the server responses

```
sh scripts/server/validate_correct_yaml.sh
sh scripts/server/validate_incorrect_yaml.sh
```

##### Cleaning up

Delet the running container with the following script

```
sh scripts/docker/stop_and_remove_docker_container.sh
```

Make sure that the application container was removed successfully by running the following command

```
docker ps --filter ancestor="validation_server_app"
```

### Application in k8s

Running application in k8s.

##### Preparation

The first step is to upload the docker image for k8s usage. Dockerhub can be used for this.

Tag the docker image by running the following script

```
sh scripts/docker/tag_docker_image.sh
```

Assuming you are logged in docker, run the following script to push the docker image to dockerhub

```
sh scripts/docker/push_docker_image.sh
```