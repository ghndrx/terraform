resource "aws_efs_file_system" "efs" {
    creation_token  = "efs-asg-west-east"
    encrypted       = true
    performance_mode = "generalPurpose"
    throughput_mode = "bursting"
}



resource "aws_efs_mount_target" "us_west_subnet_1" {
    file_system_id  = aws_efs_file_system.efs.id
    subnet_id       = var.us_west_subnet_1_id
    depends_on      = [var.us_west_subnet_1_id]
}

resource "aws_efs_mount_target" "us_west_subnet_2" {
    file_system_id  = aws_efs_file_system.efs.id
    subnet_id       = var.us_west_subnet_2_id
    depends_on      = [var.us_west_subnet_2_id]
}

resource "aws_efs_mount_target" "us_west_subnet_3" {
    file_system_id  = aws_efs_file_system.efs.id
    subnet_id       = var.us_west_subnet_3_id
    depends_on      = [var.us_west_subnet_3_id]
}

data "template_file" "mount_script" {
  template = <<EOF
#!/bin/bash
yum install -y amazon-efs-utils
mkdir -p /mnt/efs
echo "${aws_efs_file_system.efs.dns_name}:/ /mnt/efs efs defaults,_netdev 0 0" >> /etc/fstab
mount -a -t efs,nfs4 defaults
EOF
}

provider "aws" {
  region = "us-east-1"
  
  
}

resource "aws_efs_mount_target" "us_east_subnet_1" {
    file_system_id  = aws_efs_file_system.efs.id
    subnet_id       = var.us_east_subnet_1_id
    depends_on      = [var.us_east_subnet_1_id]
}

resource "aws_efs_mount_target" "us_east_subnet_2" {
    file_system_id  = aws_efs_file_system.efs.id
    subnet_id       = var.us_east_subnet_2_id
    depends_on      = [var.us_east_subnet_2_id]
}

resource "aws_efs_mount_target" "us_east_subnet_3" {
    file_system_id  = aws_efs_file_system.efs.id
    subnet_id       = var.us_east_subnet_3_id
    depends_on      = [var.us_east_subnet_3_id]
}