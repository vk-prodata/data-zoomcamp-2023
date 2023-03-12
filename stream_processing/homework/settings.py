# import pyspark.sql.types as T

# INPUT_DATA_PATH = '../../resources/rides.csv'
# BOOTSTRAP_SERVERS = 'localhost:9092'

# TOPIC_WINDOWED_VENDOR_ID_COUNT = 'vendor_counts_windowed'

# PRODUCE_TOPIC_RIDES_CSV = CONSUME_TOPIC_RIDES_CSV = 'rides_csv'

# RIDE_SCHEMA = T.StructType(
#     [T.StructField("vendor_id", T.IntegerType()),
#      T.StructField('tpep_pickup_datetime', T.TimestampType()),
#      T.StructField('tpep_dropoff_datetime', T.TimestampType()),
#      T.StructField("passenger_count", T.IntegerType()),
#      T.StructField("trip_distance", T.FloatType()),
#      T.StructField("payment_type", T.IntegerType()),
#      T.StructField("total_amount", T.FloatType()),
#      ])

from confluent_kafka import Producer

def read_ccloud_config(config_file):
    conf = {}
    with open(config_file) as fh:
        for line in fh:
            line = line.strip()
            if len(line) != 0 and line[0] != "#":
                parameter, value = line.strip().split('=', 1)
                conf[parameter] = value.strip()
    return conf




if __name__ == "__main__":
    path = '/Users/kudriavtcevi/Desktop/data-zoomcamp-2023/data-zoomcamp-2023/stream_processing/streams-example/pyspark/config.txt'
    #print(read_ccloud_config(path))

    producer = Producer(read_ccloud_config(path))
    producer.produce("rides", key="key", value="value")