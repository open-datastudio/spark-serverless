:::: section column
::: col 60%
Spark Serverless provides instant access to the Spark cluster from anywhere without thinking about infrastructure and maintenance.

Python REPL running on your laptop, favorite python IDE, online notebook environment like Colab, virtually any python environments are supported.
:::

::: col 30%
@[youtube](https://www.youtube.com/watch?v=J43qKJnp_N8&feature=youtu.be)

See [Getting started](http://open-datastudio.io/computing/spark/from_python_environment.html) to learn more.
:::
::::

:::: section column

### Apache Spark with Serverless experience

::: col 40%
#### Super easy
Just a few lines of code to get a Spark cluster from your python environment. No cluster installation, maintenance required.
:::

::: col 60%

![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGNiYAAAAAkAAxkR2eQAAAAASUVORK5CYII= =1x60)

```python
import ods
spark = ods.spark("my_work1", worker_num=5).session()
df = spark.read.load("...")
```

See [Getting started](http://open-datastudio.io/computing/spark/from_python_environment.html) to learn more.
:::

::: col 100%
#### Don't change. Keep your tools
You don't have to change your favorite tools. Run your pyspark code anywhere from you laptop to server, from shell to IDE. Keep your data pipeline unchanged. Spark Serverless provides spark executors remotely, no matter where your application runs.
:::

::: col 100%
#### As many as you want
Each spark application can have their own set of executors. No more waiting for a busy Spark cluster to finish other applications job.
:::

::: col 100%
#### Multi-cloud
Select which regions you want to use. AWS us-west2, GCP us-west1, and so on. We're continuously adding cloud regions to meet your needs. Run your jobs close to the data!

:::

::: col 100%
#### Pay as you go
There's no control plane cost or upfront cost. Pay only Spark executors instance that runs your job.
:::

::::

:::: section column

### Production ready

::: col 30%
#### Spark 3.x
Enjoy latest Spark release. When you need, you can customize Spark container image.
:::

::: col 30%
#### Spark UI
You can access Spark UI, by simply click spark-ui link on Staroid management console. No complex proxy setup requiried.
:::

::: col 30%
#### Delta lake
Simply give `deta=True` parameter when you initialize Spark session.
Delta lake will be automatically configured.
:::

