## Creating the Deployment

Follow these steps to create a Kubernetes Deployment for an Nginx web server with 3 replicas.

### Step 1: Create a Deployment YAML file

Create a file called `nginx-deployment.yaml` with the following content:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 3  # Number of pods to run
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:latest  # Nginx container image
        ports:
        - containerPort: 80  # Expose port 80
```

### Step 2: Apply the Deployment

To create the Deployment in your Kubernetes cluster, apply the `nginx-deployment.yaml` file:

```bash
kubectl apply -f nginx-deployment.yaml
```

This will create the Deployment and launch 3 replicas of the Nginx pod.

## Managing the Deployment

### Scaling the Deployment

You can easily scale the number of pods in your Deployment by updating the `replicas` field in the Deployment YAML or by using the `kubectl scale` command.

For example, to scale the Deployment to 5 replicas:

```bash
kubectl scale deployment nginx-deployment --replicas=5
```

### Updating the Deployment

You can update your Deployment to use a new container image version. For example, to update the Nginx container to version `1.19.0`:

```bash
kubectl set image deployment/nginx-deployment nginx=nginx:1.19.0
```

This will trigger a **rolling update** to gradually replace the old pods with the new version.

### Rollback the Deployment

If something goes wrong after an update, you can easily rollback to a previous version of the Deployment:

```bash
kubectl rollout undo deployment/nginx-deployment
```

This will restore the Deployment to the previous state.

## Verifying the Deployment

To verify the status of your Deployment:

```bash
kubectl get deployments
```

To view the running pods:

```bash
kubectl get pods
```

This will show you the pods managed by your Deployment. You should see the specified number of replicas (3 or 5, depending on scaling).

### Checking the Rollout Status

To check the progress of a rollout (e.g., after an update):

```bash
kubectl rollout status deployment/nginx-deployment
```

## Accessing the Nginx Application

If you want to expose the Nginx web server outside the Kubernetes cluster, you can create a **Service**.

### Create a Service YAML file

Create a file called `nginx-service.yaml` with the following content:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  selector:
    app: nginx  # Matches the pods with the "app: nginx" label
  ports:
    - protocol: TCP
      port: 80  # Port to expose
      targetPort: 80  # Port on the container
  type: LoadBalancer  # Exposes the service outside the cluster (for cloud environments)
```

### Apply the Service

To expose your Nginx Deployment via a service, apply the `nginx-service.yaml` file:

```bash
kubectl apply -f nginx-service.yaml
```

After applying the service, you can check the external IP (if using a cloud provider) or the internal service URL:

```bash
kubectl get services
```

## Additional Resources

- [Kubernetes Deployments Documentation](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
- [Kubernetes Scaling Applications](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/)
- [Kubernetes Rollbacks](https://kubernetes.io/docs/tutorials/kubernetes-basics/update-object/)
```

---

This README provides all the necessary information to create, manage, and scale a simple Nginx Deployment in Kubernetes!
