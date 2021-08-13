#!/bin/bash

if [ "$#" -eq 0 ]; then
  echo "Use: $0 namespace1 namespace2 namespaceN"
  exit 1
fi

csvfile=$(mktemp -t replicas-XXXXXX.csv)
echo "csvfile: $csvfile"
#csvfile="/tmp/replicas.csv"
rm -f $csvfile

for namespace in "$@"
do
  echo "Get deployment/statefulset replicas on namespace $namespace ..."
  kubectl get deployment,statefulset -n $namespace -o jsonpath='{range .items[*]}{@.metadata.namespace},{@.kind},{@.metadata.name},{@.spec.replicas}{"\n"}{end}' >> $csvfile
done

while IFS="," read -r namespace kind resource replicas
do
  echo "Descaling $namespace - $kind - $resource ..."
  kubectl scale -n $namespace --replicas=0 $kind $resource 
done < $csvfile

echo "All resources have been scaled to zero... Press any key to rescale back or ctrl+c to abort..."
read

while IFS="," read -r namespace kind resource replicas
do
  echo "Rescaling $namespace - $kind - $resource ..."
  kubectl scale -n $namespace --replicas=$replicas $kind $resource
done < $csvfile

