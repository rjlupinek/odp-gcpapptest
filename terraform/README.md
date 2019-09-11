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


### Variables

The following variables need to be set either by setting proper environment variables or editing the variables.tf file:

| Variable      |  Type  |  Description  |
|---          |---        |---  | 
| region |     | string     |  Region to configure resources    |
| cloudsql_tier | string    |  Instance type for the Cloud SQL deployment    |
| project_id | string    | The project ID your application will deploy     |
| notification_email | string     | Email address that will receive      |
| cloudsql_db_name | string    |  Cloud SQL database instance name    |
| cloudsql_username | string    |  postgresql database username     |
| cloudsql_password  |  string |   postgresql database password |

#### Setting environment variables

With Terraform you can set / override any Terraform variables using the TF_VAR_<variable name> format.

* NOTE: Setting the environment variables is the suggested method to configure your project when deploying from a CI pipeline.

* Example settings the project variables :
  ```export TF_VAR_region="us-east1"
  export TF_VAR_cloudsql_tier="db-f1-micro"
  export TF_VAR_project_id="super-awesome-project-of-greatness-01"
  export TF_VAR_notification_email="my.team.gsa.gov"
  export TF_VAR_cloudsql_db_name="pypostgresql"
  export TF_VAR_cloudsql_username="postgres"
  export TF_VAR_cloudsql_password="fGw23!4324fDswrf*&"
  ```


### Remote State 

### init, plan, run

## Modules  <a name="s5"></a>


### Variables


### Outputs


## Individual .tf Files <a name="s6"></a>




