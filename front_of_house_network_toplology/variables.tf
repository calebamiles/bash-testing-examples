variable "vpc" {
    description = "vpc id"
}

variable "vpc_cidr" {
    description = "CIDR block for the vpc"
}

variable "bosh1_subnet" {
    description = "subnet id for bosh1 subnet"
}

variable "bosh2_subnet" {
    description = "subnet id for bosh2 subnet"
}

variable "bosh3_subnet" {
    description = "subnet id for bosh3 subnet"
}

variable "cf1_subnet" {
    description = "subnet id for cf1 subnet"
}

variable "cf2_subnet" {
    description = "subnet id for cf2 subnet"
}

variable "diego1_subnet" {
    description = "subnet id for diego1 subnet"
}

variable "diego2_subnet" {
    description = "subnet id for diego2 subnet"
}

variable "diego3_subnet" {
    description = "subnet id for diego3 subnet"
}

variable "logsearch1_subnet" {
    description = "subnet id for logsearch_az1 subnet"
}

variable "logsearch2_subnet" {
    description = "subnet id for logsearch_az2 subnet"
}

variable "services1_subnet" {
    description = "subnet id for services1 subnet"
}

variable "services2_subnet" {
    description = "subnet id for services2 subnet"
}

variable "internet_gateway" {
    description = "id for internet gateway"
}

