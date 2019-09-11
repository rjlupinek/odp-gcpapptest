# Terraform - Google Cloud App Engine

## Overview <a name="s1"></a>

This Terraform project will configure the following resources to enable deployment of the App Engine template:

* App Engine Firewall - Default rules
* Google Stackdriver monitoring for CIS Rules 2.4, 2.5, 2.6, 2.10, and 2.11
* Google Cloud SQL - postgresql

## Table of Contents <a name="s2"></a>

* [Overview](#s1)
* [Table of Conents](#s2)
* [Project Contents](#s3)
* [Project Setup](#s4)
* [Modules](#s5)
* [Individual .tf Files](#s6)

## Project Contents <a name="s3"></a>

| Folder / File      |  Description  |
|---          |---        |
| google_appengine.tf   |   description |
| google_monitoring.tf   |   description |
| google_sql.tf   |   description |
| outputs.tf   |   description |
| provider.tf   |   Provider and backend configuration  |
| variables.tf   |   Variables file used to set defaults  |

## Project Setup <a name="s4"></a>

### Authenication and privileges

* In order to deploy this project you will need a service account with the following roles applied:

```
	roles/viewer
	roles/iam.securityReviewer
	roles/cloudsql.admin
	roles/cloudsql.viewer
	roles/appengine.appAdmin
	roles/appengine.deployer
	roles/cloudbuild.builds.editor
	roles/cloudbuild.builds.builder
	roles/compute.storageAdmin
	roles/cloudkms.admin
	roles/cloudkms.cryptoKeyDecrypter
	roles/cloudscheduler.admin
	roles/storage.admin
	roles/logging.admin
```

* You will need to download the Access Key JSON file for the service account and save it as a file named ``

### Variables

The following variables need to be set either by setting proper environment variables or editing the variables.tf file:

| Variable      |  Type  |  Description  |
|---          |---        |---  | 
| region |   string     |  Region to configure resources    |
| cloudsql_tier | string    |  Instance type for the Cloud SQL deployment    |
| project_id | string    | The project ID your application will deploy     |
| notification_email | string     | Email address that will receive      |
| cloudsql_db_name | string    |  Cloud SQL database instance name    |
| cloudsql_username | string    |  postgresql database username     |
| cloudsql_password  |  string |   postgresql database password |

### Outputs

| Variable      |  Type  |  Description  |
|---          |---        |---  | 
| google_sql_database_instance.postgres.connection_name |  string     |  Connection name for postgresql instance    |


#### Setting environment variables

With Terraform you can set / override any Terraform variables using the TF_VAR_<variable name> format.

* NOTE: Setting the environment variables is the suggested method to configure your project when deploying from a CI pipeline.

* Example settings the project variables :
  ```
  export TF_VAR_region="us-east1"
  export TF_VAR_cloudsql_tier="db-f1-micro"
  export TF_VAR_project_id="super-awesome-project-of-greatness-01"
  export TF_VAR_notification_email="my.team.gsa.gov"
  export TF_VAR_cloudsql_db_name="pypostgresql"
  export TF_VAR_cloudsql_username="postgres"
  export TF_VAR_cloudsql_password="fGw23!4324fDswrf*&"
  ```


### Remote State 

You will need a Google Storage Bucket to store the remote state.

`gsutil mb gs://gcp-terraform-state-$TF_VAR_project_id || true`

Once you have created a Storage Bucket you can configure it using the `-backend-config` flag or hardcode the bucket name in the `provider.tf` file.

`terraform init -backend-config="bucket=gcp-terraform-state-$TF_VAR_project_id"`

### init, plan, and apply

To init your project you will want to specify the Storage Bucket using the `-backend-config` flag or hardcode the bucket name in the `provider.tf` file.

`terraform init -backend-config="bucket=gcp-terraform-state-$TF_VAR_project_id"`

Run terraform plan

`terraform plan`

Run terraform apply

`terraform apply`


## Modules  <a name="s5"></a>

At this time this Terraform project is not making use of any modules.
However, there are plans to convert the google_monitoring.tf into a module at some point due to it's reusability.

### Variables

NA

### Outputs

NA






