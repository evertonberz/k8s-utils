# k8s-utils

## k8s-scale.sh example:

```
evertonberz@tromso:~ $ k8s-scale.sh -h
k8s-scale v0.1
Usage: /usr/local/bin/k8s-scale.sh [-c|--csvfile <arg>] [-h|--help] <command> [<namespaces-1>] ... [<namespaces-n>] ...
        <command>: descale or rescale
        <namespaces>: namespace1 namespace2 namespaceN
        -c, --csvfile: Replicas csvfile to rescale deployments (no default)
        -h, --help: Prints help

evertonberz@tromso:~ $ k8s-scale.sh descale default
Get deployment/statefulset replicas on namespace default ...
Descaling default - Deployment - production-the-deployment ...
deployment.apps/production-the-deployment scaled
Descaling default - Deployment - staging-the-deployment ...
deployment.apps/staging-the-deployment scaled
All resources have been scaled to zero.
Previous replica values are stored in /tmp/replicas-9LUC67.csv
In case you need to rescale, use: k8s-scale.sh --csvfile /tmp/replicas-9LUC67.csv rescale

evertonberz@tromso:~ $ k get pods
NAME                                         READY   STATUS        RESTARTS   AGE
production-the-deployment-7b47fd5bdb-mmwp5   1/1     Terminating   0          21s
production-the-deployment-7b47fd5bdb-rhdvg   1/1     Terminating   0          21s
staging-the-deployment-d75675d48-vdbbk       1/1     Terminating   0          21s

evertonberz@tromso:~ $ k8s-scale.sh --csvfile /tmp/replicas-9LUC67.csv rescale
Rescaling default - Deployment - production-the-deployment ...
deployment.apps/production-the-deployment scaled
Rescaling default - Deployment - staging-the-deployment ...
deployment.apps/staging-the-deployment scaled

evertonberz@tromso:~ $ k get pods
NAME                                         READY   STATUS              RESTARTS   AGE
production-the-deployment-7b47fd5bdb-hjhjd   0/1     ContainerCreating   0          2s
production-the-deployment-7b47fd5bdb-v8qhv   0/1     ContainerCreating   0          2s
staging-the-deployment-d75675d48-m57w4       0/1     ContainerCreating   0          2s
```

