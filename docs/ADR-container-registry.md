# Architecture Decision Record

# Decide the Artifact Storage

## Status

Proposed

## Context

Since the decision the Application platform was selected to be the Google Cloud Run, an available docker registry
should be used for storing the application's builds. Some of the available options:
 - Google Container Registry
 - Google Artifact Registry

## Decision

Not many options here to decide since the Cloud Run only supports the Google cloud registry solutions. It is reasonable
to go with Google Artifact Registry since it has no extra code complexity over Google Container Registry and 
ensures future compatibility as the Google Container Registry will be retired in the near future.

## Consequences

Ensures future compatibility