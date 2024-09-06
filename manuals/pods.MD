

### Create a file named  pod.yml
```
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  - name: nginx
    image: nginx:1.14.2
    ports:
    - containerPort: 80

```

### Run the following command to create a pod in your kubernetes cluster

```
kubectl apply -f pod.yml 

```
![Create nginx pod](../images/create-simple-pod.jpg)

### To view the pod , Run the following command  in your kubernetes cluster

```
kubectl get pods

```

![get pod](../images/get-pods.jpg)

### To view the pod with the node details, Run the following command  in your kubernetes cluster

```
kubectl get pods -o wide

```

![get pod with node detail](../images/get-pods-with-node-detail.jpg)

