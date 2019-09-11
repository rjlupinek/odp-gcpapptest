# Circle CI 

## Overview <a name="s1"></a>

This CI Pipeline is 

## Table of Contents <a name="s2"></a>

* [Overview](#s1)
* [Table of Conents](#s2)
* [Environment Variables](#s3)
* [Jobs](#s4)
* [Work Flows](#s5)


## Environment Variables <a name="s3"></a>

* Note: For variables with `<BRANCH>` suffix replace this with the GitHub repo branch you wish to tie to your GCP Project ID.  
* Note: For variables with `<BRANCH>` suffix, you will need to configure these variables for each branch. 
* Note: All variables are of the type `string`.

| Variable    |  Description    | 
|---        |---              | 
| `GOOGLE_PROJECT_ID_<BRANCH>` | Project you will be deploying your app into when pushing changes to your branch set in the suffix `<BRANCH>` | 
| `GCLOUD_SERVICE_KEY_<BRANCH>`  |  Complete contents of the access key for your deployment's `terraform@<PROJECT_ID>` service account for the Project ID you set in the `GOOGLE_PROJECT_ID_<BRANCH>` variable   | 
| `NOTIFICATION_EMAIL` | Email that you wish to receive monitoring alerts | 
| `CLOUDSQL_DB` | Postgres Database Instance Name  | 
| `CLOUDSQL_USERNAME` | Username for basic CloudSQL authentication | 
| `CLOUDSQL_PASSWORD` | Password for basic CloudSQL authentication |  
| `DEFAULT_FIREWALL_RULE` | Default IPV4 network block you wish to allow traffic in CIDR notation |

## Jobs <a name="s4"></a>

### gcp_setup

This job will install the Google SDK when needed an authenticate to Google using the GCLOUD_SERVICE_KEY_<BRANCH> variable.

### init_terraform_state

This job configures the storage bucket, if needed, that will house the Terraform state.

### plan_terraform

This job runs the terraform init and plan commands.

### apply_terraform

This job runs the terraform init and apply commands.

### deploy-pypostgresql

This job will create the required database and deploy your postgresql application.
This job does not promote the deployed application.

### test-pypostgresql

This job is a placeholder for any tests you would want to perform prior to promoting your code.

### owaspzap-pypostgresql

This job runs the an OWASPZAP test against the recently deployed version, not the running promoted version, of your application.

### promote-pypostgresql

This job will promote your application to production and clean up prior versions.

## Work Flows  <a name="s5"></a>

There is currently only 1 workflow in place.  

### build_and_deploy

The `build_and_deploy` workflow is used to deploy infrastructure, deploy the application, test, and promote the application to the project for the dev, test, and master branches and their designated projects.