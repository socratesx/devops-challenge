# Architecture Decision Record

# Decide the Terraform State file location

## Status

Proposed

## Context

The state file needs to be secured in a safe location. This ensures that any secrets stored in it are secured. Two options:
 - local
 - Google Bucket


## Decision

The Google bucket is the obvious choice not only because of security but for convenience too. If running terraform in a
CI/CD pipeline then the local backend is not suitable as the state file would be lost after the pipeline is finished.
Naming for the bucket: 
`{project_id}-statefiles`

## Consequences

Ensures security and CI/CD compatibility.