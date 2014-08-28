#!/bin/bash
set -e
set -x
set -u

aws_response_handing_functions="$(realpath $(dirname $0))/aws_response_handling_functions"
source $aws_response_handing_functions

outfile="$(realpath $(dirname $0))/terraform.tfvars"

bosh1_subnet_id=$(get_aws_subnet_id $BOSH1_SUBNET_NAME)
bosh2_subnet_id=$(get_aws_subnet_id $BOSH2_SUBNET_NAME)
bosh3_subnet_id=$(get_aws_subnet_id $BOSH3_SUBNET_NAME)

cf1_subnet_id=$(get_aws_subnet_id $CF1_SUBNET_NAME)
cf2_subnet_id=$(get_aws_subnet_id $CF2_SUBNET_NAME)

diego1_subnet_id=$(get_aws_subnet_id $DIEGO1_SUBNET_NAME)
diego2_subnet_id=$(get_aws_subnet_id $DIEGO2_SUBNET_NAME)
diego3_subnet_id=$(get_aws_subnet_id $DIEGO3_SUBNET_NAME)

services1_subnet_id=$(get_aws_subnet_id $SERVICES1_SUBNET_NAME)
services2_subnet_id=$(get_aws_subnet_id $SERVICES2_SUBNET_NAME)

logsearch1_subnet_id=$(get_aws_subnet_id $LOGSEARCH1_SUBNET_NAME)
logsearch2_subnet_id=$(get_aws_subnet_id $LOGSEARCH2_SUBNET_NAME)

vpc_id=$(get_aws_vpc_id_from_subnet $bosh1_subnet_id)
vpc_cidr=$(get_aws_vpc_cidr $vpc_id)

# -----------------------------------------------------------
# save off a variable list for terraform
(
cat <<EOF
access_key = "$AWS_ACCESS_KEY"
secret_key = "$AWS_SECRET_ACCESS_KEY"
vpc = "$vpc_id"
bosh1_subnet = "$bosh1_subnet_id"
bosh2_subnet = "$bosh2_subnet_id"
bosh3_subnet = "$bosh3_subnet_id"
cf1_subnet = "$cf1_subnet_id"
cf2_subnet = "$cf2_subnet_id"
diego1_subnet = "$diego1_subnet_id"
diego2_subnet = "$diego2_subnet_id"
diego3_subnet = "$diego3_subnet_id"
logsearch1_subnet = "$logsearch1_subnet_id"
logsearch2_subnet = "$logsearch2_subnet_id"
services1_subnet = "$services1_subnet_id"
services2_subnet = "$services2_subnet_id"
vpc_cidr = "$vpc_cidr"
internet_gateway = "$(aws ec2 describe-internet-gateways | grep InternetGatewayId | cut -f2 -d ':' | tr -d ', "')"
EOF
) > $outfile
# -----------------------------------------------------------



