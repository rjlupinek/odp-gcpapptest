

resource "google_app_engine_firewall_rule" "rule1000" {
  project = "${var.project_id}"
  priority = 1000
  description = "Terraform -  Allow GSA internal access."
  action = "ALLOW"
  source_range = "35.235.0.0/16	"
}

resource "google_app_engine_firewall_rule" "rule1100" {
  project = "${var.project_id}"
  priority = 1100
  description = "Terraform -  Allow GCP IAP Proxy access."  
  action = "ALLOW"
  source_range = "130.211.0.0/22"
}

resource "google_app_engine_firewall_rule" "rule1200" {
  project = "${var.project_id}"
  priority = 4000
  description = "Terraform -  Deny anything not explicitly allowed."
  action = "DENY"
  source_range = "*"
}