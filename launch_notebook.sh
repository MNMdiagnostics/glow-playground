source .venv/bin/activate

export SPARK_HOME=`find_spark_home.py`

export PYSPARK_DRIVER_PYTHON=jupyter
export PYSPARK_DRIVER_PYTHON_OPTS=notebook

pyspark \
    --packages io.projectglow:glow-spark3_2.12:1.0.1,io.delta:delta-core_2.12:1.0.0 \
    --conf "spark.sql.extensions=io.delta.sql.DeltaSparkSessionExtension" \
    --conf "spark.sql.catalog.spark_catalog=org.apache.spark.sql.delta.catalog.DeltaCatalog" \
    --conf spark.hadoop.io.compression.codecs=io.projectglow.sql.util.BGZFCodec 


