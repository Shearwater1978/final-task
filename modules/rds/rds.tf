module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 3.0"

  identifier = "demodb"

  engine            = "mysql"
  engine_version    = "5.7.19"
  instance_class    = "db.t2.large"
  allocated_storage = 5

  name     = "demodb"
  username = "user"
  password = "YourPwdShouldBeLongAndSecure!"
  port     = "3306"

  iam_database_authentication_enabled = true

  vpc_security_group_ids = ["sg-12345678"]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  # Enhanced Monitoring - see example for details on how to create the role
  # by yourself, in case you don't want to create it automatically
  create_monitoring_role = false

  tags = {
    Owner       = "user"
    Environment = "dev"
  }

  # DB subnet group
  subnet_ids = ["${element(aws_vpc.aws_subnet.mysql.*.id,count.index)}"]

  # DB parameter group
  family = "mysql5.7"

  # DB option group
  major_engine_version = "5.7"

  # Database Deletion Protection
  deletion_protection = true

  parameters = [
    {
      name = "character_set_client"
      value = "utf8mb4"
    },
    {
      name = "character_set_server"
      value = "utf8mb4"
    }
  ]

  options = [
    {
      option_name = "MARIADB_AUDIT_PLUGIN"

      option_settings = [
        {
          name  = "SERVER_AUDIT_EVENTS"
          value = "CONNECT"
        },
        {
          name  = "SERVER_AUDIT_FILE_ROTATIONS"
          value = "37"
        },
      ]
    },
  ]
}

# module "db" {
#     source  = "terraform-aws-modules/rds/aws"
#     version = "~> 3.0"

#     # Disable creation of RDS instance(s)
#     create_db_instance = false

#     # Disable creation of option group - provide an option group or default AWS default
#     create_db_option_group = false

#     # Disable creation of parameter group - provide a parameter group or default to AWS default
#     create_db_parameter_group = false

#     # Disable creation of subnet group - provide a subnet group
#     create_db_subnet_group = false

#     # Enable creation of monitoring IAM role
#     create_monitoring_role = true

#     identifier                  = "${var.identifier}"
#     allocated_storage           = "${var.allocated_storage}"
#     engine                      = "${var.engine}"
#     engine_version              = "${var.engine_version}"
#     major_engine_version        = "${var.major_engine_version}"
#     # family                      = "${var.family}"
#     instance_class              = "${var.instance_class}"
#     auto_minor_version_upgrade  = "${var.auto_minor_version_upgrade}"
#     storage_type                = "${var.storage_type}"
#     skip_final_snapshot         = "${var.skip_final_snapshot}"

# }

# resource "aws_db_option_group" "default" {
#     major_engine_version        = "${var.major_engine_version}"
#     engine_name                      = "${var.engine}"
# }

# resource "asw_db_paramater_group" "default" {
#     family                      = "${var.family}"
# }

# resource "aws_db_instance" "default" {
#     identifier                  = "${var.identifier}"
        
#     allocated_storage           = "${var.allocated_storage}"
#     engine                      = "${var.engine}"
#     engine_version              = "${var.engine_version}"
    
#     instance_class              = "${var.instance_class}"
#     auto_minor_version_upgrade  = "${var.auto_minor_version_upgrade}"
#     storage_type                = "${var.storage_type}"
#     skip_final_snapshot         = "${var.skip_final_snapshot}"

# }