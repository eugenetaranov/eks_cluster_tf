resource "kubectl_manifest" "calico" {
  yaml_body = file("manfifests/calico.yaml")
}

resource "kubectl_manifest" "network_policy_ns_default" {
  yaml_body = file("manfifests/network-policy-deny.yaml")
}

resource "kubectl_manifest" "network_policy_ns_staging" {
  yaml_body = file("manfifests/network-policy-deny.yaml")
}