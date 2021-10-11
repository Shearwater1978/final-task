variable "identifier" {
  type        = string
  default     = "ghost"
}

variable "engine" {
  type        = string
  default     = "mysql"
}

variable "engine_version" {
    type        = string
    default     = "8.0.20"
}

variable "family" {
  type        = string
  default     = "mysql8.0"
}

variable "major_engine_version" {
  type        = string
  default     = "8.0"
}

variable "instance_class" {
  type        = string
  default     = "db.t2.micro"
}

variable "skip_final_snapshot" {
  default     = true
}

variable "auto_minor_version_upgrade" {
  default     = false
}

variable "allocated_storage" {
  default     = 20
}

variable "storage_type" {
  type        = string
  default     = "gp2"
}