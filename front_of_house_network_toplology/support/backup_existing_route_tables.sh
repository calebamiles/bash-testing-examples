#!/bin/bash
set -e
set -x
set -u

aws_response_handing_functions="$(realpath $(dirname $0))/aws_response_handling_functions"
source $aws_response_handing_functions

outfile="$(realpath $(dirname $0))/restore_route_tables-$(date '+%m-%d-%Y-%H_%M_%S').sh"

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

bosh1_subnet_current_route_table=$(get_aws_route_table_id $bosh1_subnet_id)
bosh2_subnet_current_route_table=$(get_aws_route_table_id $bosh2_subnet_id)
bosh3_subnet_current_route_table=$(get_aws_route_table_id $bosh3_subnet_id)

cf1_subnet_current_route_table=$(get_aws_route_table_id $cf1_subnet_id)
cf2_subnet_current_route_table=$(get_aws_route_table_id $cf2_subnet_id)

diego1_subnet_current_route_table=$(get_aws_route_table_id $diego1_subnet_id)
diego2_subnet_current_route_table=$(get_aws_route_table_id $diego2_subnet_id)
diego3_subnet_current_route_table=$(get_aws_route_table_id $diego1_subnet_id)

services1_subnet_current_route_table=$(get_aws_route_table_id $services1_subnet_id)
services2_subnet_current_route_table=$(get_aws_route_table_id $services2_subnet_id)

logsearch1_subnet_current_route_table=$(get_aws_route_table_id $logsearch1_subnet_id)
logsearch2_subnet_current_route_table=$(get_aws_route_table_id $logsearch2_subnet_id)

# -----------------------------------------------------------
# Generate a simple script to restore the route table associations from the current configuration
(
cat <<EOF
#### AUTOMATICALLY GENERATED FILE DO NOT EDIT ####
#### USE THIS TO RESTORE ROUTE TABLE ASSOCIATIONS TO THE STATE THAT EXISTED BEFORE TERRAFORM
#!/bin/bash
set -e
set -x

aws ec2 associate-route-table --dry-run --subnet-id $bosh1_subnet_id  --route-table-id $bosh1_subnet_current_route_table
aws ec2 associate-route-table --dry-run --subnet-id $bosh2_subnet_id  --route-table-id $bosh2_subnet_current_route_table
aws ec2 associate-route-table --dry-run --subnet-id $bosh3_subnet_id  --route-table-id $bosh3_subnet_current_route_table

aws ec2 associate-route-table --dry-run --subnet-id $cf1_subnet_id  --route-table-id $cf1_subnet_current_route_table
aws ec2 associate-route-table --dry-run --subnet-id $cf2_subnet_id  --route-table-id $cf2_subnet_current_route_table

aws ec2 associate-route-table --dry-run --subnet-id $diego1_subnet_id  --route-table-id $diego1_subnet_current_route_table
aws ec2 associate-route-table --dry-run --subnet-id $diego2_subnet_id  --route-table-id $diego2_subnet_current_route_table
aws ec2 associate-route-table --dry-run --subnet-id $diego3_subnet_id  --route-table-id $diego3_subnet_current_route_table

aws ec2 associate-route-table --dry-run --subnet-id $services1_subnet_id  --route-table-id $services1_subnet_current_route_table
aws ec2 associate-route-table --dry-run --subnet-id $services2_subnet_id  --route-table-id $services2_subnet_current_route_table

aws ec2 associate-route-table --dry-run --subnet-id $logsearch1_subnet_id  --route-table-id $logsearch1_subnet_current_route_table
aws ec2 associate-route-table --dry-run --subnet-id $logsearch2_subnet_id  --route-table-id $logsearch2_subnet_current_route_table

exit 0
EOF
) > $outfile

chmod +x $outfile
# -----------------------------------------------------------



