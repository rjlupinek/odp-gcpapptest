#Configure monitoring notification channel for email.

resource "google_monitoring_notification_channel" "email" {
  display_name = "Test Notification Channel"
  type = "email"
  labels = {
    email_address = "${var.notification_email}"
  }
}


resource "google_logging_metric" "create_service_account" {
  name = "metric-create-service-account"
  filter = "logName:\"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity\" AND protoPayload.methodName:\"google.iam.admin.v1.CreateServiceAccount\""
  metric_descriptor {
    metric_kind = "DELTA"
    value_type = "INT64"
  }
}

resource "google_logging_metric" "iam_policy_change" {
  name = "metric-iam-policy-change"
  filter = "logName:\"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity\" AND protoPayload.methodName:\"SetIamPolicy\""
  metric_descriptor {
    metric_kind = "DELTA"
    value_type = "INT64"
  }
}

#resource "google_logging_metric" "create_service_account" {
#  name = "my-(custom)/metric"
#  filter = "logName:\"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity" AND methodName: "google.iam.admin.v1.CreateServiceAccount\""
#  metric_descriptor {
#    metric_kind = "DELTA"
#    value_type = "INT64"
#  }
#}

# Monitoring For Max Connections
resource "google_monitoring_alert_policy" "alert_policy_connections"{
  display_name = "Connection limit test - App Engine - pypostgresql"
  combiner= "OR"
  conditions {
      display_name = "GAE Application - Connections for ${var.project_id}, pypostgresql"
      condition_threshold {
        aggregations {
          alignment_period = "60s"
          per_series_aligner = "ALIGN_MEAN"
        }
        comparison = "COMPARISON_GT"
        duration = "60s"
        filter = "metric.type=\"appengine.googleapis.com/flex/connections/current\" resource.type=\"gae_app\" resource.label.\"project_id\"=\"${var.project_id}\" resource.label.\"module_id\"=\"pypostgresql\""
        threshold_value = 200
        trigger {
          count = 1
        }
      }
  }
  documentation {
    content = "# Warning!!!\n\nError message:\n\nThis is just a simple test to validate alerting policy configuration.\nThis alert policy is configured via Terraform."
    mime_type = "text/markdown"
  }

  notification_channels = [
    "${google_monitoring_notification_channel.email.name}",
  ]
}


# Monitoring for number of running instances
resource "google_monitoring_alert_policy" "alert_policy_instance_count"{
  display_name = "Instance count max exceeded - App Engine - pypostgresql"
  combiner= "OR"
  conditions {
      display_name = "instance count exceeded"
      condition_threshold {
        aggregations {
          alignment_period = "60s"
          per_series_aligner = "ALIGN_COUNT"
        }
        comparison = "COMPARISON_GT"
        duration = "60s"
        filter = "metric.type=\"appengine.googleapis.com/system/instance_count\" resource.type=\"gae_app\" resource.label.\"module_id\"=\"pypostgresql\""
        threshold_value = 2
        trigger {
          count = 1
        }
      }
  }
  documentation {
    content = "# Warning\n\n## Error message:\n\nInstance count max for pypostgresql has been exceeded.\nThis alert policy is configured via Terraform."
    mime_type = "text/markdown"
  }
}


# Monitoring For Changes in Project Ownership
resource "google_monitoring_alert_policy" "policy_owner"{
  display_name = "Project Ownership assignments changes"
  combiner= "OR"
  conditions {
      display_name = "policy_owner"
      condition_threshold {
        aggregations {
          alignment_period = "60s"
          per_series_aligner = "ALIGN_COUNT"
        }
        comparison = "COMPARISON_GT"
        duration = "60s"
        filter = "metric.type=\"logging.googleapis.com/user/Project-Ownership-Assignments-Changes\" resource.type=\"global\" resource.label.\"project_id\"=\"${var.project_id}\""
        threshold_value = 1
        trigger {
          count = 1
        }
      }
  }
  documentation {
    content = "# Warning\n\n## Error message:\n\nThe project ownership has changed.\nThis alert policy is configured via Terraform."
    mime_type = "text/markdown"
  }
}


# Service account creation

resource "google_monitoring_alert_policy" "create_service_account"{
  display_name = "Service account creation"
  combiner= "OR"
  conditions {
      display_name = "create_service_account"
      condition_threshold {
        aggregations {
          alignment_period = "60s"
          per_series_aligner = "ALIGN_COUNT"
        }
        comparison = "COMPARISON_GT"
        duration = "60s"
        filter = "metric.type=\"logging.googleapis.com/user/${google_logging_metric.create_service_account.name}\""
        threshold_value = 1
        trigger {
          count = 1
        }
      }
  }
  documentation {
    content = "# Warning\n\n## Error message:\n\nThe project ownership has changed.\nThis alert policy is configured via Terraform."
    mime_type = "text/markdown"
  }
}


#IAM Policy Changes

resource "google_monitoring_alert_policy" "iam_policy_change"{
  display_name = "IAM Policy changes"
  combiner= "OR"
  conditions {
      display_name = "iam_policy_change"
      condition_threshold {
        aggregations {
          alignment_period = "60s"
          per_series_aligner = "ALIGN_COUNT"
        }
        comparison = "COMPARISON_GT"
        duration = "60s"
        filter = "metric.type=\"logging.googleapis.com/user/${google_logging_metric.iam_policy_change.name}\""
        threshold_value = 1
        trigger {
          count = 1
        }
      }
  }
  documentation {
    content = "# Warning\n\n## Error message:\n\nThe project ownership has changed.\nThis alert policy is configured via Terraform."
    mime_type = "text/markdown"
  }
}
