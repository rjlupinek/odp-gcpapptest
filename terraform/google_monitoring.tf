#Configure monitoring notification channel for email.

resource "google_monitoring_notification_channel" "email" {
  display_name = "Test Notification Channel"
  type = "email"
  labels = {
    email_address = "${var.notification_email}"
  }
}

resource "google_logging_metric" "firewall_change" {
  name = "firewall-change"
  filter = "logName:\"projects/i-ise-04302019-playground/logs/cloudaudit.googleapis.com%2Factivity\" AND protoPayload.methodName:\"google.appengine.v1.Firewall.\""
  metric_descriptor {
    metric_kind = "DELTA"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "firewall_change"{
  display_name = "firewall-change"
  combiner= "OR"
  conditions {
      display_name = "firewall-change"
      condition_threshold {
        aggregations {
          alignment_period = "60s"
          per_series_aligner = "ALIGN_SUM"
        }
        comparison = "COMPARISON_GT"
        duration = "60s"
        filter = "metric.type=\"logging.googleapis.com/user/${google_logging_metric.firewall_change.name}\" AND resource.type=\"gae_app\""
        threshold_value = 0
        trigger {
          count = 1
        }
      }
  }
  documentation {
    content = "# Warning - CIS Alert Triggered\n\n# Error message:\n\nfirewall-change triggered."
    mime_type = "text/markdown"
  }
}


#CIS 2.4 Ensure log metric filter and alerts exists for Project Ownership assignments/changes

resource "google_logging_metric" "cis2_4_project_owner_change" {
  name = "cis2-4-project_owner-change"
  filter = "logName:\"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity\" AND (protoPayload.serviceName=\"cloudresourcemanager.googleapis.com\") AND (ProjectOwnership OR projectOwnerInvitee) OR (protoPayload.serviceData.policyDelta.bindingDeltas.action=\"REMOVE\" AND protoPayload.serviceData.policyDelta.bindingDeltas.role=\"roles/owner\") OR (protoPayload.serviceData.policyDelta.bindingDeltas.action=\"ADD\" AND protoPayload.serviceData.policyDelta.bindingDeltas.role=\"roles/owner\")"
  metric_descriptor {
    metric_kind = "DELTA"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "cis2_4_project_owner_change"{
  display_name = "cis2-4-project_owner-change"
  combiner= "OR"
  conditions {
      display_name = "cis2-4-project_owner-change"
      condition_threshold {
        aggregations {
          alignment_period = "60s"
          per_series_aligner = "ALIGN_SUM"
        }
        comparison = "COMPARISON_GT"
        duration = "60s"
        filter = "metric.type=\"logging.googleapis.com/user/${google_logging_metric.cis2_4_project_owner_change.name}\" AND resource.type=\"project\""
        threshold_value = 0
        trigger {
          count = 1
        }
      }
  }
  documentation {
    content = "# Warning - CIS Alert Triggered\n\n# Error message:\n\nCIS 2.4 Ensure log metric filter and alerts exists for Project Ownership assignments/changes triggered."
    mime_type = "text/markdown"
  }
}


#CIS 2.5 Ensure log metric filter and alerts exists for Audit Configuration 

resource "google_logging_metric" "cis2_5_audit_config_change" {
  name = "cis2-5-audit-config-change"
  filter = "logName:\"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity\" AND protoPayload.methodName=\"SetIamPolicy\" AND protoPayload.serviceData.policyDelta.auditConfigDeltas:*"
  metric_descriptor {
    metric_kind = "DELTA"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "cis2_5_audit_config_change"{
  display_name = "cis2-5-audit-config-change"
  combiner= "OR"
  conditions {
      display_name = "cis2-5-audit-config-change"
      condition_threshold {
        aggregations {
          alignment_period = "60s"
          per_series_aligner = "ALIGN_SUM"
        }
        comparison = "COMPARISON_GT"
        duration = "60s"
        filter = "metric.type=\"logging.googleapis.com/user/${google_logging_metric.cis2_5_audit_config_change.name}\" AND resource.type=\"global\""
        threshold_value = 0
        trigger {
          count = 1
        }
      }
  }
  documentation {
    content = "# Warning - CIS Alert Triggered\n\n# Error message:\n\nCIS 2.5 Ensure log metric filter and alerts exists for Audit Configuration - has triggered."
    mime_type = "text/markdown"
  }
}



#CIS 2.6 Ensure log metric filter and alerts exists for Custom Role changes 

resource "google_logging_metric" "cis2_6_custom_role_change" {
  name = "cis2-6-custom-role-change"
  filter = "logName:\"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity\" AND resource.type=\"iam_role\" AND protoPayload.methodName =  \"google.iam.admin.v1.CreateRole\" OR protoPayload.methodName=\"google.iam.admin.v1.DeleteRole\" OR protoPayload.methodName=\"google.iam.admin.v1.UpdateRole\""
  metric_descriptor {
    metric_kind = "DELTA"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "cis2_6_custom_role_change"{
  display_name = "cis2-6-custom-role-change"
  combiner= "OR"
  conditions {
      display_name = "cis2-6-custom-role-change"
      condition_threshold {
        aggregations {
          alignment_period = "60s"
          per_series_aligner = "ALIGN_SUM"
        }
        comparison = "COMPARISON_GT"
        duration = "60s"
        filter = "metric.type=\"logging.googleapis.com/user/${google_logging_metric.cis2_6_custom_role_change.name}\" AND resource.type=\"iam_role\""
        threshold_value = 0
        trigger {
          count = 1
        }
      }
  }
  documentation {
    content = "# Warning - CIS Alert Triggered\n\n# Error message:\n\nCIS 2.6 Ensure log metric filter and alerts exists for Custom Role changes has triggered."
    mime_type = "text/markdown"
  }
}



#CIS 2.10 - Ensure log metric filter and alerts exists for Cloud Storage IAM permission changes

resource "google_logging_metric" "cis2_10_storage_iam_change" {
  name = "cis2-10-storage-iam-change"
  filter = "logName:\"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity\" AND resource.type=gcs_bucket AND protoPayload.methodName=\"storage.setIamPermissions\""
  metric_descriptor {
    metric_kind = "DELTA"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "cis2_10_storage_iam_change"{
  display_name = "cis2-10-storage-iam-change"
  combiner= "OR"
  conditions {
      display_name = "cis2-10-storage-iam-change"
      condition_threshold {
        aggregations {
          alignment_period = "60s"
          per_series_aligner = "ALIGN_SUM"
        }
        comparison = "COMPARISON_GT"
        duration = "60s"
        filter = "metric.type=\"logging.googleapis.com/user/${google_logging_metric.cis2_10_storage_iam_change.name}\" AND resource.type=\"gcs_bucket\""
        threshold_value = 0
        trigger {
          count = 1
        }
      }
  }
  documentation {
    content = "# Warning - CIS Alert Triggered\n\n# Error message:\n\nCIS 2.10 - Ensure log metric filter and alerts exists for Cloud Storage IAM permission changes - has triggered."
    mime_type = "text/markdown"
  }
}


#CIS 2.11 - Ensure log metric filter and alerts exists for SQL instance configuration changes

resource "google_logging_metric" "cis2_11_sql_instance_change" {
  name = "cis2-11-sql-instance-change"
  filter = "logName:\"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity\" AND protoPayload.methodName=\"cloudsql.instances.update\""
  metric_descriptor {
    metric_kind = "DELTA"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "cis2_11_sql_instance_change"{
  display_name = "cis2-11-sql-instance-change"
  combiner= "OR"
  conditions {
      display_name = "cis2-11-sql-instance-change"
      condition_threshold {
        aggregations {
          alignment_period = "60s"
          per_series_aligner = "ALIGN_SUM"
        }
        comparison = "COMPARISON_GT"
        duration = "60s"
        filter = "metric.type=\"logging.googleapis.com/user/${google_logging_metric.cis2_11_sql_instance_change.name}\" AND resource.type=\"cloudsql_database\""
        threshold_value = 0
        trigger {
          count = 1
        }
      }
  }
  documentation {
    content = "# Warning - CIS Alert Triggered\n\n# Error message:\n\nCIS 2.11 - Ensure log metric filter and alerts exists for SQL instance configuration changes - has triggered."
    mime_type = "text/markdown"
  }
}


 