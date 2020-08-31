# Spark Serverless

Spark server provides Apache Spark in serverless configuration.

This repository is deployed to [staroid](https://staroid.com) cluster using [ods](https://github.com/open-datastudio/ods) python pacakge.

## Quick start

Please visit https://github.com/open-datastudio/ods.

## How it works

[Spark on Kubernetes](http://spark.apache.org/docs/latest/running-on-kubernetes.html) both provides Spark client mode and Cluster mode. That means if your spark application have access to Kubernetes API server, your application can create driver and executors itself.

Therefore, this project more focuses on providing Kubernetes API endpoint to the Spark application, 
with optimized Spark configuration for the Kubernetes and each cloud platform providers.

### Spark client mode application

![](http://open-datastudio.io/_images/spark-serverless-client-mode.png)

### Spark cluster mode application

![](http://open-datastudio.io/_images/spark-serverless-cluster-mode.png)


## Get supported

Don't hesitate to create an [issue](https://github.com/open-datastudio/spark-serverless/issues) and [join our Slack channel](https://join.slack.com/t/opendatastudio/shared_invite/zt-fy2dsmb7-E9_UrBAh4UA47lzN5sUHUA).

For commercial support, please [contact staroid](https://staroid.com/site/contact).