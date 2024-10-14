# Local Kubernetes Cluster for Experimentation

## Tech Stack
1. For Experiment 1
- [Colima](https://github.com/abiosoft/colima) (with Docker and Docker Compose, see [this article](https://everythingdevops.dev/how-to-run-minikube-on-apple-m1-chip-without-docker-desktop/)
- [Minikube](https://minikube.sigs.k8s.io/docs/)
- [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/)
2. For Experiment 2
- [helm](https://helm.sh/docs/intro/install/#through-package-managers)
- [Fastify](https://www.fastify.io/)
- [Emissary Ingress](https://www.emissary-ingress.io/)


## Experiment 1: Deploy Fastify App
1. Install Colima and Minikube following [this article](https://everythingdevops.dev/how-to-run-minikube-on-apple-m1-chip-without-docker-desktop/)

2. Build the fastify app docker image
```shell
docker build -t fastify-try -f ./Dockerfile .
```

3. Upload docker image to minikube
```shell
minikube image load fastify-try
# Check available images for docker.io/library/fastify-try 
minikube image ls --format table
```

4. Run the fastify app in the minikube cluster and verify it is running
```shell
kubectl run fastify-try-container --image=fastify-try --image-pull-policy=Never --restart=Never
kubectl logs fastify-try-container
```
this should output that the pod is running and the fastify app is listening on port 3000

5. Expose the fastify app to the outside world
```shell
kubectl expose pod fastify-try-container --type=NodePort --port=3000
minikube service fastify-try-container --url
```

6. Browse to the URL and verify that the fastify app is running. It should return a JSON object with the message `{"hello":"world"}`

7. Clean up
```shell
kubectl delete pod fastify-try-container
kubectl delete service fastify-try-container
minikube image ls --format table
minikube image rm <Image ID from fastify-try>
```

## Experiment 2: Use Helm charts to deploy Fastify App





