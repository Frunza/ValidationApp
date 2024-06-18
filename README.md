# ValidationApp
App validates yaml.

# Requirements

- python3
- kubectl
- [kind](https://kind.sigs.k8s.io/)

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

Delete the running container with the following script

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

Assuming you are logged in dockerhub, run the following script to push the docker image to dockerhub

```
sh scripts/docker/push_docker_image.sh
```

Create a kind cluster with the following script

```
sh scripts/k8s/create_cluster.sh
```

Add namespacs to the cluster with the following script

```
sh scripts/k8s/apply_namespaces.sh
```

Add the application deployment with the following script

```
sh scripts/k8s/apply_validationapp.sh
```

Add the configmap with the following script
```
sh scripts/k8s/apply_configmap.sh
```

Add the veolume with the following script
```
sh scripts/k8s/apply_volumes.sh
```

To access the deployment outside the cluster an ingress or load balancer can be used. Kind has guides for both. Just for testing the app, port forwarding also works by running the following command

```
kubectl port-forward deployment/validationapp 5555:5555 -n development
```

##### Testing

With port forwarding enabled, the exact same testing routine can be reused. Run the following scripts with valid and invalid files and check the server responses

```
sh scripts/server/validate_correct_yaml.sh
sh scripts/server/validate_incorrect_yaml.sh
```

# Miscellaneous

##### Probes

An easy way to test the effectivness of the probes is to change the port number, delete the deployment with the following command

```
kubectl delete deploy validationapp -n development
```

and apply it again with the following script

```
sh scripts/k8s/apply_validationapp.sh
```

If the liveness probe is changed to fail, you will notice that the restarts count of the pods is continously increasing because the pods are continously restarted due to the liveness fail check.
If the readiness probe is changed to fail, you will notice that the ready status of the pods is 0 because the readiness check is failing.

You can obtain detailed information about the probes of a pod with the following command

```
kubectl describe pods *pod_name* -n development
```

##### Configmap

The applicaton also has a landing page under "/", where some text and the value of the VALIDATIONAPP_TEST environment variable is present.
A configmap can be used to inject that environment variable in the container. Just go throught the preparation section of "Application in k8s" and paste the following in your browser

```
http://localhost:5555/
```

You will notice that the environment variable value from the configmap is displayed.

##### Volumes

The applicaton also has a landing page under "/", where a textfile is also created in the "/tmp" path.
Local volume is used for the container. Just go throught the preparation section of "Application in k8s" and paste the following in your browser

```
http://localhost:5555/
```

To check whether the file was actually created, you can list the content of the path where you expect the file to be. To do so execute the following command

```
kubectl exec *podName- -n development --container validationapp -- ls /tmp
```

The file that the server created should be printed out. If it is not there, you might need to check the other pods as well.

##### Ingress

Since k8s runs in kind, the official guide should be followed at https://kind.sigs.k8s.io/docs/user/ingress/

##### Load balancer

Since k8s runs in kind, the official guide should be followed at https://kind.sigs.k8s.io/docs/user/loadbalancer/

##### Horizontal pod autoscaller

For setting up the horizontal pod autoscaler, it is important to configure requests and limits for the pod containers. You can start a horizontal pod autoscaller with the following command

```
kubectl apply -f k8s/horizontalpodautoscaler.yaml
```

To retrieve information about it run the following command
```
kubectl get hpa -n development
```

Note that the utilization of the target has some unknown information out of the value that in configure in the horizontal pod autoscaller. This happens because a metrics server has to be set up also. For detailed infomration about a full guide on how to set up a metric server consult the official k8s documentation at https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/

##### Cluster autoscaler

There is official documentation about setting up cluster autoscaler for each public cloud provider. For example
- aws: https://docs.aws.amazon.com/eks/latest/userguide/autoscaling.html
- azure: https://learn.microsoft.com/en-us/azure/aks/cluster-autoscaler
- gcd: https://cloud.google.com/kubernetes-engine/docs/concepts/cluster-autoscaler

For on-premise solutions more complex logic has to implemented to scale the cluster and add/remove nodes when necessary.