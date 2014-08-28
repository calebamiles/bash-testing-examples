#!/bin/bash

function_definition_path="$(realpath $(dirname $0))/../support/aws_response_handling_functions"
source $function_definition_path

function_test_asset_path="$(realpath $(dirname $0))/test_assets"
source $function_test_asset_path

function get_fake_aws_vpcs {
  echo $FAKE_AWS_EC2_DESCRIBE_VPCS
}

extract_vpc_cidr get_fake_aws_vpcs vpc-3d24de58
