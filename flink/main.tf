provider "aws" {
  region  = "us-east-2"
  profile = "dataplatform-dev"
}
locals {
  device_name        = "/dev/sdf"
  volume_size        = 20
  replica_count      = var.replica_count < 1 ? 1 : var.replica_count
}
data "aws_key_pair" "mongo-keypair" {
  key_name = "mongo-keypair"
}
################################################
# CREATE  EC2 placement group for flink
################################################

resource "aws_placement_group" "pg_flink" {
  name     = "pg_flink"
  strategy = "partition"
  partition_count = 1
}

resource "aws_instance" "flink_machine" {
  depends_on = [
    aws_placement_group.pg_flink
  ]
  ami                         = var.ec2_ami_id
  instance_type               = var.ec2_instance_type
  associate_public_ip_address = false
  count = 3
  key_name = data.aws_key_pair.mongo-keypair.key_name
  
  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = local.volume_size
  }

  # Assign subnet and security group for the instance
  subnet_id              = var.private_subnet_ids[count.index]
    vpc_security_group_ids = ["${aws_security_group.instances.id}"]

  placement_group = "pg_flink"
  placement_partition_number = 1
  tags = {
    Name = "flink-dev-${count.index}"
  }

}

resource "null_resource" "install_prep" {
  depends_on = [
    aws_instance.flink_machine
  ]

  for_each = { for idx, val in aws_instance.flink_machine : idx => val }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "centos"
      host        = each.value.private_ip
      agent       = false
      private_key = file("mongo-keypair.pem")
    }
    inline = [

      "sudo yum update -y",
      "sudo yum install wget -y",
      "sudo yum install java-11-openjdk-devel -y",
      "sudo wget https://dlcdn.apache.org/flink/flink-1.14.5/flink-1.14.5-bin-scala_2.11.tgz --output-file flinkServer.tgz",
      "sudo tar xzf flink-*.tgz",
      "cd flink-*",
      "cd conf",
      "sudo sed -i '/# taskmanager.memory.flink.size: 1280m/c env.java.home: /usr/lib/java' flink-conf.yaml",
      "sudo sed -i '/jobmanager.rpc.address: localhost/c jobmanager.rpc.address: ${aws_instance.flink_machine[0].private_ip}' flink-conf.yaml",
      "sudo sed -i '/#rest.port: 8081/c rest.port: 8081' flink-conf.yaml",
      "sudo sed -i -e '/localhost/c #localhost' workers",
      "sudo sed -i '1i ${aws_instance.flink_machine[1].private_ip}' workers",
      "sudo sed -i '1i ${aws_instance.flink_machine[2].private_ip}' workers",
      #"cd ./bin",
      #"sudo jobmanager.sh start",
      #"sudo taskmanager.sh start"

        
      

    ]
  }
}
