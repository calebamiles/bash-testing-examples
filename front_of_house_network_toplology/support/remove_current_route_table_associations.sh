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

bosh1_subnet_route_table_id=$(get_aws_route_table_id $bosh1_subnet_id)
bosh2_subnet_route_table_id=$(get_aws_route_table_id $bosh2_subnet_id)
bosh3_subnet_route_table_id=$(get_aws_route_table_id $bosh3_subnet_id)

cf1_subnet_route_table_id=$(get_aws_route_table_id $cf1_subnet_id)
cf2_subnet_route_table_id=$(get_aws_route_table_id $cf2_subnet_id)

diego1_subnet_route_table_id=$(get_aws_route_table_id $diego1_subnet_id)
diego2_subnet_route_table_id=$(get_aws_route_table_id $diego2_subnet_id)
diego3_subnet_route_table_id=$(get_aws_route_table_id $diego3_subnet_id)

services1_subnet_route_table_id=$(get_aws_route_table_id $services1_subnet_id)
services2_subnet_route_table_id=$(get_aws_route_table_id $services2_subnet_id)

logsearch1_subnet_route_table_id=$(get_aws_route_table_id $logsearch1_subnet_id)
logsearch2_subnet_route_table_id=$(get_aws_route_table_id $logsearch2_subnet_id)


### Add warning for potentailly destructive operation and confirm

aws ec2 disassociate-route-table --dry-run --association-id $bosh1_subnet_route_table_id
aws ec2 disassociate-route-table --dry-run --association-id $bosh2_subnet_route_table_id
aws ec2 disassociate-route-table --dry-run --association-id $bosh3_subnet_route_table_id

aws ec2 disassociate-route-table --dry-run --association-id $cf1_subnet_route_table_id
aws ec2 disassociate-route-table --dry-run --association-id $cf2_subnet_route_table_id

aws ec2 disassociate-route-table --dry-run --association-id $diego1_subnet_route_table_id
aws ec2 disassociate-route-table --dry-run --association-id $diego2_subnet_route_table_id
aws ec2 disassociate-route-table --dry-run --association-id $diego3_subnet_route_table_id

aws ec2 disassociate-route-table --dry-run --association-id $services1_subnet_route_table_id
aws ec2 disassociate-route-table --dry-run --association-id $services2_subnet_route_table_id

aws ec2 disassociate-route-table --dry-run  --association-id $logsearch1_subnet_route_table_id
aws ec2 disassociate-route-table --dry-run  --association-id $logsearch2_subnet_route_table_id