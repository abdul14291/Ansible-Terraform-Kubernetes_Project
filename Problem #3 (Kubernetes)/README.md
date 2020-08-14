## This service has been designed on kubeadm cluster not minikube. This is 3 nodes cluster.
# One Master and two Worker nodes.

    


                        [root@k8s-master ~]# kubectl get all
                        NAME                                     READY   STATUS    RESTARTS   AGE
                        pod/nginx-hello-world-7d7c65496c-n8xkd   1/1     Running   1          8h
                        pod/nginx-hello-world-7d7c65496c-sgv2r   1/1     Running   1          8h

                        NAME                        TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
                        service/kubernetes          ClusterIP   10.96.0.1       <none>        443/TCP        90d
                        service/nginx-hello-world   NodePort    10.98.122.132   <none>        80:30007/TCP   7h14m

                        NAME                                READY   UP-TO-DATE   AVAILABLE   AGE
                        deployment.apps/nginx-hello-world   2/2     2            2           8h

                        NAME                                           DESIRED   CURRENT   READY   AGE
                        replicaset.apps/nginx-hello-world-7d7c65496c   2         2         2       8h

                        NAME                                                   REFERENCE                     TARGETS         MINPODS   MAXPODS   REPLICAS   AGE
                        horizontalpodautoscaler.autoscaling/nginx-deployment   Deployment/nginx-deployment   <unknown>/80%   7         10        7          86d
                        [root@k8s-master ~]#
                        
                        
                        
                        [root@k8s-master ~]# kubectl get pods -o wide
                        NAME                                 READY   STATUS    RESTARTS   AGE   IP             NODE       NOMINATED NODE   READINESS GATES
                        nginx-hello-world-7d7c65496c-n8xkd   1/1     Running   1          8h    10.244.2.158   worker02   <none>           <none>
                        nginx-hello-world-7d7c65496c-sgv2r   1/1     Running   1          8h    10.244.1.183   worker01   <none>           <none>
                        [root@k8s-master ~]#
                        
![image](https://user-images.githubusercontent.com/21194692/88318654-a1443880-cd4d-11ea-9422-72941f75168c.png)


