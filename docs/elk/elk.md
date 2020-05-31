## Prerequisites

Before you begin with this guide, ensure you have the following available to you:
- A Kubernetes 1.10+ cluster with role-based access control (RBAC) enabled
- The kubectl command-line tool installed on your local machine, configured to connect to your cluster. You can read more about installing kubectl in the [official documentation](https://kubernetes.io/docs/tasks/tools/install-kubectl/). 

### Step 1 — Creating a Namespace
Before we roll out an Elasticsearch cluster, we’ll first create a Namespace into which we’ll install all of our logging instrumentation.

Using kubectl create with the -f filename flag:

``kubectl create -f ./k8s/elk-node/ns.yaml``

### Step 2 — Creating the Elasticsearch single node
Now that we’ve created a Namespace to house our logging stack, we can begin rolling out its various components.
We’ll first begin by deploying a single-node Elasticsearch cluster.

Create the service using kubectl:

``kubectl create -f ./k8s/elk-node/elastic.yaml``

### Step 3 — Creating the Kibana Deployment and Service
To launch Kibana on Kubernetes, we’ll create a Service called kibana, and a Deployment consisting of one Pod replica.
You can scale the number of replicas depending on your production needs.


You can roll out the Service and Deployment using kubectl:

``kubectl create -f ./k8s/elk-node/kibana.yaml``

### Step 4 — Creating the Fluentd DaemonSet
In this guide, we’ll set up Fluentd as a DaemonSet, which is a Kubernetes workload type that runs a copy of a given Pod on each Node in the Kubernetes cluster.
Using this DaemonSet controller, we’ll roll out a Fluentd logging agent Pod on every node in our cluster.
To learn more about this logging architecture, consult [“Using a node logging agent”](https://kubernetes.io/docs/concepts/cluster-administration/logging/#using-a-node-logging-agent) from the official Kubernetes docs.

![](./img/logging-with-node-agent.png)

Now, roll out the DaemonSet using kubectl:

``kubectl create -f ./k8s/elk-node/fluentd.yaml``

### Step 5 — Creating frontend service via nginx

``kubectl create -f ./k8s/elk-node/nginx.yaml``

### Step 6 — 
