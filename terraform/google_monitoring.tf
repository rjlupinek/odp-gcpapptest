resource "google_monitoring_notification_channel" "email" {
  display_name = "Test Notification Channel"
  type = "email"
  labels = {
    email_address = "${var.notification_email}"
  }
}

#Monitoring Connections
resource "google_monitoring_alert_policy" "alert_policy_connections"{
  display_name = "pypostgresql-connection-limit-test"
  combiner= "OR"
  conditions {
      display_name = "GAE Application - Connections for i-ise-04302019-playground, pypostgresql"
      condition_threshold = {
        aggregations {
          alignment_period = "60s"
          per_series_aligner = "ALIGN_MEAN"
        }
        comparison = "COMPARISON_GT"
        duration = "60s"
        filter = "metric.type=\"appengine.googleapis.com/flex/connections/current\" resource.type=\"gae_app\" resource.label.\"project_id\"=\"i-ise-04302019-playground\" resource.label.\"module_id\"=\"pypostgresql\""
        threshold_value = 200
        trigger = {
          count = 1
        }
      }
  }
  documentation = {
    content = "# Warning!!!\n\nError message:\n\nThis is just a simple test to validate alerting policy configuration.\nThis alert policy is configured via Terraform."
    mime_type = "text/markdown"
  }

  notification_channels = [
    "${google_monitoring_notification_channel.email.name}",
  ]
}


resource "google_monitoring_alert_policy" "alert_policy_owner"{
  display_name = "Project Ownership assignments-changes"
  combiner= "OR"
  conditions {
      display_name = "logging/user/Project-Ownership-Assignments-Changes"
      condition_threshold = {
        aggregations {
          alignment_period = "60s"
          per_series_aligner = "ALIGN_RATE"
        }
        comparison = "COMPARISON_GT"
        duration = "60s"
        filter = "metric.type=\"logging.googleapis.com/user/Project-Ownership-Assignments-Changes\" resource.type=\"global\" resource.label.\"project_id\"=\"${var.project_id}\""
        trigger = {
          count = 1
        }
      }
  }
  documentation = {
    content = "# Warning\n\n## Error message:\n\nThe project ownership has changed.\nThis alert policy is configured via Terraform."
    mime_type = "text/markdown"
  }
}


resource "google_monitoring_alert_policy" "alert_policy_instance_count"{
  display_name = "Project Ownership assignments-changes"
  combiner= "OR"
  conditions {
      display_name = "instance count exceeded"
      condition_threshold = {
        aggregations {
          alignment_period = "60s"
          per_series_aligner = "ALIGN_RATE"
        }
        comparison = "COMPARISON_GT"
        duration = "60s"
        filter = "metric.type=\"appengine.googleapis.com/system/instance_count\" resource.type=\"gae_app\" resource.label.\"module_id\"=\"pypostgresql\""
        threshold_value = 2
        trigger = {
          count = 1
        }
      }
  }
  documentation = {
    content = "# Warning\n\n## Error message:\n\nInstance count for pypostgresql has been exceeded.\nThis alert policy is configured via Terraform."
    mime_type = "text/markdown"
  }
}

#Service account modifications