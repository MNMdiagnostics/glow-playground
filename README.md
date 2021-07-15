

## ENV setup 

```

# Setup ENV

virtualenv -p python3 .venv
source .venv/bin/activate
pip install -r requirements.txt


# Launch notebook

export SPARK_HOME=`find_spark_home.py`

PYSPARK_DRIVER_PYTHON=jupyter PYSPARK_DRIVER_PYTHON_OPTS=notebook pyspark \
    --packages io.projectglow:glow-spark3_2.12:1.0.1,io.delta:delta-core_2.12:1.0.0 \
    --conf "spark.sql.extensions=io.delta.sql.DeltaSparkSessionExtension" \
    --conf "spark.sql.catalog.spark_catalog=org.apache.spark.sql.delta.catalog.DeltaCatalog" \
    --conf spark.hadoop.io.compression.codecs=io.projectglow.sql.util.BGZFCodec 


```
