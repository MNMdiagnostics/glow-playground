

## ENV setup (native)

```

# Setup ENV

virtualenv -p python3 .venv
source .venv/bin/activate
pip install -r requirements.txt


# Launch notebook

export SPARK_HOME=`find_spark_home.py`

export PYSPARK_DRIVER_PYTHON=jupyter
export PYSPARK_DRIVER_PYTHON_OPTS=notebook

pyspark \
    --packages io.projectglow:glow-spark3_2.12:1.0.1,io.delta:delta-core_2.12:1.0.0 \
    --conf "spark.sql.extensions=io.delta.sql.DeltaSparkSessionExtension" \
    --conf "spark.sql.catalog.spark_catalog=org.apache.spark.sql.delta.catalog.DeltaCatalog" \
    --conf spark.hadoop.io.compression.codecs=io.projectglow.sql.util.BGZFCodec 

```

## Example ENV setup in container

With 16G of memory and 16 cores

```
MEM_LIMIT=16G
CORE_LIMIT=16

docker run --rm -p 8888:8888 -ti  \
	-e SPARK_HOME=/usr/local/spark \
	-e PYSPARK_DRIVER_PYTHON=jupyter \
	-e PYSPARK_DRIVER_PYTHON_OPTS=notebook \
	-v /readonly/data/location/:/data:ro \
	-v /readwrite/location/glow:/glow:rw \
	-w /glow \
	mnmdiagnostics/glow-1.0.1_spark-3.1.2:0.1 \
	/bin/bash 

export SPARK_OPTS="--master=local[4] --driver-java-options=-Xms1024M --driver-java-options=-Xmx${MEM_LIMIT} --driver-java-options=-Dlog4j.logLevel=ERROR"

pyspark --packages io.projectglow:glow-spark3_2.12:1.0.1,io.delta:delta-core_2.12:1.0.0 \
        --conf "spark.sql.extensions=io.delta.sql.DeltaSparkSessionExtension" \
        --conf "spark.sql.catalog.spark_catalog=org.apache.spark.sql.delta.catalog.DeltaCatalog" \
        --conf spark.hadoop.io.compression.codecs=io.projectglow.sql.util.BGZFCodec \
	 --driver-memory ${MEM_LIMIT} --executor-cores ${CORE_LIMIT}


```
