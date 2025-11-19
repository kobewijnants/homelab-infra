resource "time_sleep" "wait_for_kubernetes" {
  depends_on = [
    module.talos # Ensure this runs only after Talos is done
  ]

  create_duration = "60s" # Give the API server a moment to breathe
}

resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
  version          = "9.1.3"

  depends_on = [
    time_sleep.wait_for_kubernetes
  ]
}