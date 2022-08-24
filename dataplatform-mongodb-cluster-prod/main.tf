provider "aws" {
  region  = "us-east-2"
  profile = "dataplatform-prod"
}
locals {
  device_name        = "/dev/sdf"
  ansible_host_group = ["db-mongodb"]
  volume_size        = 2000
  replica_count      = var.replica_count < 1 ? 1 : var.replica_count
}

data "aws_key_pair" "mongodbkeypair" {
  key_name = "mongodbkeypair"
}


################################################
# CREATE 3 EC2 instance for mongoDB Cluster
################################################


resource "aws_instance" "db_instance" {
  count = 3

  ami                         = var.ec2_ami_id
  instance_type               = var.ec2_instance_type
  associate_public_ip_address = false

  key_name = data.aws_key_pair.mongodbkeypair.key_name
  
  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = local.volume_size
  }

  # Assign subnet and security group for the instance
  subnet_id              = var.private_subnet_ids[count.index]
  vpc_security_group_ids = ["${aws_security_group.instances.id}"]
  tags = {
    Name = "source-domain-dev-${count.index}"
  }
 
}
################################################
# CREATE 3 EC2 Cloudwatch  for mongoDB Cluster
################################################

# resource "null_resource" "copy_installation_files" {
#   depends_on = [
#     aws_instance.db_instance
#   ]

#   # for_each = { for instance_type in aws_instance.db_instance : instance_type.new_key => instance_type }

#   for_each = { for idx, val in aws_instance.db_instance : idx => val }

#   provisioner "file" {
#     source      = "${path.module}/mongodb-org-4.4.repo"
#     destination = "/tmp/mongodb-org-4.4.repo"

#     connection {
#       type        = "ssh"
#       user        = "centos"
#       host        = each.value.private_ip
#       agent       = false
#       private_key = file("mongodbkeypair.pem")
#     }
#   }

#   provisioner "file" {
#     source      = "${path.module}/install_mongo.sh"
#     destination = "/tmp/install_mongo.sh"

#     connection {
#       type        = "ssh"
#       user        = "centos"
#       host        = each.value.private_ip
#       agent       = false
#       private_key = file("mongodbkeypair.pem")
#     }
#   }
# }

# resource "null_resource" "install_mongo" {
#   depends_on = [
#     null_resource.copy_installation_files
#   ]

#   for_each = { for idx, val in aws_instance.db_instance : idx => val }

#   provisioner "remote-exec" {
#     connection {
#       type        = "ssh"
#       user        = "centos"
#       host        = each.value.private_ip
#       agent       = false
#       private_key = file("mongodbkeypair.pem")
#     }

#     inline = [
      
#       "chmod +x /tmp/install_mongo.sh",
#       "sudo /tmp/install_mongo.sh",
#     ]
#   }
#}

# resource "null_resource" "replicaset_initialization" {
#   depends_on = [aws_instance.db_instance]
#   provisioner "local-exec" {
#     command = "/bin/bash ./modules/mongo-cluster/provisioning/create-inventory.sh ${aws_instance.db_instance[0].private_ip} ${aws_instance.db_instance[1].private_ip} ${aws_instance.db_instance[2].private_ip}"
#   }  
# }

