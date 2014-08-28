#!/bin/bash

function_definition_path="$(realpath $(dirname $0))/../support/aws_response_handling_functions"
source $function_definition_path

function_test_asset_path="$(realpath $(dirname $0))/test_assets"
source $function_test_asset_path

function get_fake_aws_subnets {
  echo $FAKE_AWS_EC2_DESCRIBE_SUBNETS
}


extract_subnet_id get_fake_aws_subnets bosh1

