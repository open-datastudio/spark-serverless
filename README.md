# Spark Serverless

Spark server provides Apache Spark 3.0 (and future version) in serverless configuration.

 - Easy to use
 - Open source
 - Optimized Spark configuration for Kubernetes
 - Secure tunneling between driver and executors/Kubernetes API server over HTTPS. So Spark client mode application can run anywhere.


## How to use (staroid)

Currently, it supports [staroid](https://staroid.com) cloud platform. Contribution for other cloud platform support is welcome!

  1. Download requires binaries and files
     - Download spark-serverless CLI

       clone this repository to get spark-serverless CLI

       ```
       git clone https://github.com/open-datastudio/spark-serverless
       ```
     
     - Download `starctl`
       
       Spark-serverless CLI requires `starctl`. 
       Download `starctl` from the [release page](https://github.com/staroids/starctl/releases).

       ```
       curl -o starctl -L https://github.com/staroids/starctl/releases/download/v0.0.1/starctl-darwin-amd64
       chmod +x starctl
       ```

     - Download `kubectl`
       
       Spark-serverless CLI requires `kubectl`. Download `kubectl` if you don't have it already.

       ```
       curl -o kubectl -s -L https://storage.googleapis.com/kubernetes-release/release/v1.16.3/bin/linux/amd64/kubectl
       chmod +x kubectl
       ```

  2. Create Kubernetes cluster

     You need to do this only once, unless you remove the cluster.

     - sign in [staroid](https://staroid.com)
     - Kubernetes -> New Kubernetes cluster

  3. Configure
     - Set environment variables

       | Environment variables | description |
       | --------------------- | ------------|
       | STAROID_ACCESS_TOKEN | staroid access token. Get from https://staroid.com/settings/accesstokens |
       | STARCTL | Path to the `starctl` executable | 
       | KUBECTL | Path to the `kubectl` executable |

       e.g. 

       ```
       export STAROID_ACCESS_TOKEN=xacr5b7nopx0a0dc2cr6q1x0820gbe71vzb
       export STARCTL=/home/download/starctl
       export KUBECTL=/usr/bin/kubectl
       ```

  4. Start spark-serverless

     ```
     bin/ske_start.sh \
       -o GITHUB/<your github id signup on staroid> \
       -c <cluster name from "Create Kubernetes cluster" step> \
       -a <your spark serverless instance name>
     ```

     for example,

     ```
     bin/ske_start.sh \
       -o GITHUB/staroids \
       -c "dev-cluster" \
       -a "spark1"
     ```

     Note that instance name allows `[a-z0-9-]*` pattern.

     It may take few seconds to minutes to start. Once started, it creates secure tunnel to Kubernetes API server and you can access it through `http://localhost:8001`.

  5. Generate Spark configuration

     Generate `spark-defaults.conf` and place it in your spark installation directory.

     ```
     bin/ske_spark_conf.sh \
       -o GITHUB/<your github id signup on staroid> \
       -c <cluster name from "Create Kubernetes cluster" step> \
       -a <your spark serverless instance name>
     ```

     e.g.

     ```
     bin/ske_spark_conf.sh \
       -o GITHUB/staroids \
       -c "dev-cluster" \
       -a "spark1" > $SPARK_HOME/conf/spark-defaults.conf
     ```

  6. Use it!

     You can 

## How it works

[Spark on Kubernetes](http://spark.apache.org/docs/latest/running-on-kubernetes.html) both provides Spark client mode and Cluster mode. That means if your spark application have access to Kubernetes API server, your application can create driver and executors itself.

Therefore, this project more focuses on providing Kubernetes API endpoint to the Spark application, 
with optimized Spark configuration for the Kubernetes and each cloud platform providers.


```

+---------------------+                             +------------------+
| +-----------------+ |                             |                  |
| | Optimized Spark | |                             |                  |
| | Configuration   | |                             |    Kubernetes    |
| +-----------------+ |                             |                  |
|          |          |                             |                  |
| Your application    | ----- <Secure Tunnel> ----- |    - driver      |
|  - spark-shell      |                             |    - executors   |
|  - spark-submit     |                             |                  |
|  - etc              |                             |                  |
|                     |                             |                  |
+---------------------+                             +------------------+

```



### Spark client mode

In client mode, Spark driver can run on the client side. For example

 - Run spark-shell from laptop
 - Create Spark context in Notebook and interact with it (example)

Client mode require driver run in client side while executors are running in Kubernetes cluster.

Spark serverless provides a secure tunnel between Spark driver and executors, driver and Kubernetes API server to enable it.


## Cloud platform support

Currently, spark-serverless project runs executors on [staroid](https://staroid.com), the cloud platform for open-source projects. So you'll need an staroid account to try it. (You can get $50 free credits on signup)

Contribution for other cloud platform support is welcome!


## Contribution

spark-serverless is an open-source project, as part of [Open data studio](https://open-datastudio.io/) project. Please feel free to create [issues](https://github.com/open-datastudio/spark-serverless/issues) and [pull requests](https://github.com/open-datastudio/spark-serverless/pulls) on this repository.
