resource "kubectl_manifest" "dashboard" {
  yaml_body = file("manfifests/kubernetes-dashboard.yaml")
}