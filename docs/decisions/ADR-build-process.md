# Architecture Decision Record

# Decide the Artifact Storage

## Status

Proposed

## Context

The containerization of the application needs a build/tag process and push to the artifact registry. The following two
options were available:
 - Google Cloud Build
 - Custom Script

## Decision

Based on the initial and only requirement of simplicity the custom script is selected. The script is using docker to 
build & push the container in the container registry through a terraform null_resource provisioner. 

## Consequences

Using provisioners in terraform is not considered a best practise. However, comparing the terraform code complexity of 
setting up the full cloud build process with the inline script it is worth taking the risk.