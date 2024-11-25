resource "kubernetes_namespace" "namespaces" {
  for_each = toset(var.namespaces)
  metadata {
    name = each.key
    labels = {
      name = each.key
    }
    annotations = {
      "created_by" = "terraform"
    }
  }
  depends_on = [module.eks]
}