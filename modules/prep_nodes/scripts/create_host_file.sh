#!/bin/bash

master_name=$1
infra_name=$2
app0_name=$3
app1_name=$4
app2_name=$5

sudo tee /tmp/hosts << EOF
[nodes]
$master_name
$infra_name
$app0_name
$app1_name
$app2_name
EOF
