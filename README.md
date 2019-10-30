# Terraform service

This repository is used to generate and deploy a docker image that contains Terraform and its providers.

The Dockerfile will generate an image containing the following:

 * Terraform core in version 0.12.12
 * Terraform latest providers used by terraform files: aws, archive, null, template, random
