provider "flux" {
  kubernetes = {
    host = kind_cluster.this.endpoint
    config_path = "~/.kube/config"
  }
  git = {
    url = "ssh://git@github.com/${var.github_org}/${var.github_repository}.git"
    ssh = {
      username    = "git"
      private_key = tls_private_key.flux.private_key_pem
    }
  }
}

resource "flux_bootstrap_git" "this" {
  depends_on = [github_repository_deploy_key.this]
  path = var.github_repository_flux_path
  kustomization_override = local.kustomization_override
  recurse_submodules = true
}


locals {
  kustomization_override = <<KUST_EOF

apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - gotk-components.yaml
  - gotk-sync.yaml
KUST_EOF
}
