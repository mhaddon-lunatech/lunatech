

# Airports and Countries Services
### Pre-install Steps:
1. Install latest [minikube](https://github.com/kubernetes/minikube) release on your laptop.
2. Install latest [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) tool on your laptop.
3. Set the memory size for minikube VM to at least 4GB `minikube config set memory 4096`
4. Bring up a minikube cluster.
   4.1. 
    `minikube start --extra-config=kubelet.network-plugin=cni --network-plugin=cni`
    To be able to constrain inter-communication between the two services do as follow:

   4.2. Install calico-etcd  (likely you could use Kubernetes datastore as well)
   ```kubectl apply -f https://docs.projectcalico.org/v3.2/getting-started/kubernetes/installation/hosted/etcd.yaml``

   4.3. Create rbac for etcd
   kubectl apply -f https://docs.projectcalico.org/v3.2/getting-started/kubernetes/installation/rbac.yaml

   4.4. Grab the hosted (etcd) calico manifest
   ```curl https://docs.projectcalico.org/v3.2/getting-started/kubernetes/installation/hosted/calico.yaml -O```

   4.5. Edit the manifest to make "etcd_endpoints" point to the etcd server you just installed. NOTE - this command needs to be adjusted with your etcd endpoint IP address

   ```sed -i -e "s/10\.96\.232\.136/$(kubectl get service -o json --namespace=kube-system calico-etcd | jq  -r .spec.clusterIP)/" calico.yaml```

   4.6. Apply your edited calico.yaml
   ```kubectl apply -f deployment/kube-addons/ ```

5. Enable ingress in minikube `minikube addons enable ingress` 



### Execution Steps:

`git clone https://github.com/shahabshahab2/lunatech.git`

* Start the entire stack by `make`
* Update airports service from v1.0.1 to v1.1.0: `make upgrade-airports`
* Clean the entire stack by `make clean`

## Explanation
* Projects isolated from each other by using 

* Reverse-proxy can be achieved by `ingress nginx`, and kubenetes network. 

* Health-checks is done by Kubernetes and will restart the container if something goes wrong. Each image have it's own heath-check and readiness url ( health/live & /health/ready) 


### Updating airports service to newer version:(Manually)
````kubectl set image deployment airports airports=shahabshahab2/airports:v1.1.0 ````
check status with: 
````kubectl rollout status deployment airports ````


### Cleaning up:

````kubectl delete ns lunatech````
````minikube stop && minikube delete````



# Known Issues

- Since in the minikube ingress is enabled as an addon, the nginx-ingress-controller automatically exposes 80 and 443 ports (and not 8000). 
