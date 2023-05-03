output app1 {
  description = "Application's endpoint in cloud run. To verify application health run 'curl -H \"Authorization: Bearer $(gcloud auth print-identity-token)\" <endpoint>/health'"
  value = module.app1.endpoint
}

