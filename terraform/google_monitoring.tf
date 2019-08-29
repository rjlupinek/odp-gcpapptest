resource "google_monitoring_alert_policy" "alert_policy_connections"{
  displayName = "tf-connection-limit-test"
  combiner= "OR"
  conditions {
      displayName = "GAE Application - Connections for i-ise-04302019-playground, pypostgres"
      condition_threshold = {
        aggregations {
          alignment_period = "60s"
          per_series_aligner = "ALIGN_MEAN"
        }
        comparison = "COMPARISON_GT"
        duration = "60s"
        filter = "metric.type=\"appengine.googleapis.com/flex/connections/current\" resource.type=\"gae_app\" resource.label.\"project_id\"=\"i-ise-04302019-playground\" resource.label.\"module_id\"=\"pypostgres\""
        threshold_value = 2
        trigger = {
          count = 1
        }
      }
  }
  documentation = {
    content = "# Warning!!!\n\n## Error message:\n\nThis is just a simple test to validate alerting policy configuration.\nThis alert policy is configured via Terraform."
    mimeType = "text/markdown"
  }
  enabled = true
}