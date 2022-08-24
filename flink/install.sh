
sudo yum update -y
sudo yum install wget -y
sudo yum install java-11-openjdk-devel -y
sudo wget https://dlcdn.apache.org/flink/flink-1.14.5/flink-1.14.5-bin-scala_2.11.tgz --output-file flinkServer.tgz
sudo tar xzf flink-*.tgz
cd flink-*
cd conf
echo 'env.java.home: /usr/lib/java' | sudo tee -a /flink-conf.yaml
echo 'jobmanager.rpc.address: 10.156.46.15' | sudo tee -a /flink-conf.yaml

echo '10.156.45.27' | sudo tee -a /conf/workers
echo '10.156.44.135' | sudo tee -a /conf/workers


