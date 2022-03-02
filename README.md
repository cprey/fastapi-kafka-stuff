# Python One

That one tutorial in python that shows an interaction with Kafka.

## Let's install and run this bad boy

> 🚨 A gotcha is you must specify `imagePullPolicy: Never` or this will not obey the local dockerfile repo.

1. Set up minkube to use a local Docker

    Lets set up *minikube* to use it's local docker image repo. You will need to do this for every shell.

    `eval $(minikube -p minikube docker-env)`

    Now when you type `docker image ls` you will see the contents of minikube's local docker. This allows you to use images from your local system instead of ECR or Dockerhub.

1. install the Helm chart for Kafka
    * helm repo add bitnami https://charts.bitnami.com/bitnami
    * helm install kafka bitnami/kafka

1. run docker build to add image to local minikube docker inventory
    * docker build -t python-one .

1. install the `python-one.yaml` and see what's there
    * `kubectl apply -f python-one.yaml`
    * `kubectl get all`

1. install the `ingress`
    * `kubectl apply -f ingress.yaml`

1. test it out
    * `curl $(minikube ip)/`
    * `curl $(minikube ip)/docs`

1. fire off a call to producer
    * `kubectl exec -it python-one -- python app/producer.py`

1. use a browser to look at changes
    * http://`minikube ip`/state
    * http://`minikube ip`/docs - OpenAPI docs
    * http://`minikube ip`/ - "Classic" Hello, world

1. show logs

    * kubectl logs -f python-one
    * kubectl logs -f kafka-0

## make changes to app and rebuild

1. docker build -t one .

1. kubectl delete -f python-one.yaml

1. kubectl apply -f python-one.yaml

## clean up

1. Building the images is gonna leave a bunch of garbage laying around  - `docker system prune --volumes` cleans it up
