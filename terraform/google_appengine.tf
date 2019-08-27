
resource "google_app_engine_firewall_rule" "rule1000" {
  project = "${var.project_id}"
  priority = 1000
  description = "GSA Public range."
  action = "ALLOW"
  source_range = "159.142.0.0/16	"
}

resource "google_app_engine_firewall_rule" "rule1200" {
  project = "${var.project_id}"
  priority = 20000
  description = "Terraform -  Deny anything not explicitly allowed."
  action = "DENY"
  source_range = "0.0.0.0/0"
}
