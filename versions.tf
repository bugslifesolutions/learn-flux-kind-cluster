terraform {
  required_version = ">=1.7.5"

  required_providers {
    flux = {
      source = "fluxcd/flux"
      version = ">=1.2.3"
    }
    kind = {
      source  = "tehcyx/kind"
      version = ">=0.4.0"
    }
    github = {
      source  = "integrations/github"
      version = ">=6.1.0"
    }
  }
}