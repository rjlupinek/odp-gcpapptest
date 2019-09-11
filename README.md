# ODP GCP App Engine Template


## Overview

This repository contains an Google Cloud App Engine project template.
The goal of this project is to provide an application team with a template project based on the secure reference architecture developed by the GSA ODP team.

## Status

This project is in it's first release.  This project is expected to change and is provided as is without any SLA, and is available for teams to immediately fork and use as it meets their needs.

## Project Contents


| Folder    |  Description    |
|---        |---              |
| .circleci   |   Directory housing the CircleCi CI code  |
| cloudsql_postgresql  |  Sample Python Flask application that we deploy to GCP App Engine to illustrate  |
| terraform     |  Terraform code that configures all of the GCP resources that are owned by the Application Team, after running gcp_setup scripts, to successfully deploy their application.  |


## Project Setup 

This template project provides you with all of the resources required to get a sample App Engine application up and running.
The project is setup in a way to be easily modified while still providing you with security best practices.

For detail on project setup please refer to the [Getting Started Guide](GettingStarted.md).


## Technologies used  


### Google App Engine
App Engine is a simple way to deploy applications that will automatically scale
up and down according to load, collect logs, etc.  https://cloud.google.com/appengine/

### Google Cloud SQL
Cloud SQL is an easy way to provision and manage databases.  We are using PostgreSQL
for our infrastructure, but you can use MySQL if you like.  Our configuration sets the
production database to be HA, with staging/dev non-HA.

### Google Stackdriver Logging

Google Stackdriver Logging provides teams with the ability to log, aggregate logs, and
export logs to external log platforms.

We employ the Stackdriver Logging Client Library for Python to illustrate how to
write logs within your application to Google Stackdriver.  https://cloud.google.com/logging/docs/reference/libraries

### Google Stackdriver Monitoring

Stackdriver Monitoring provides with the ability to monitor and report on predefined 
events and metrics or custom logging metrics.

We use Stackdriver Monitoring meeting certain CIS benchmarks, and we deploy the configuration
using Terraform.

### Terraform
Terraform orchestrates the project setup, creating databases, storage,
secrets, etc.  https://www.terraform.io/

### Circle CI
Terraform and the Google Cloud SDK are invoked on commit by Circle CI, which
automates all of the terraform, code deployment, testing and scanning tasks
for each environment.  https://circleci.com/

### OWASP ZAP
ZAP is a proxy that can be used to scan an app for common security vulnerabilities.
https://www.owasp.org/index.php/OWASP_Zed_Attack_Proxy_Project


## Example Applications

### Python / Cloud SQL Postgresql 

This application records the visitor's IP address and stores it in a Postgresql.
It also writes logs of each visit to Stackdriver Logging. 

[Python / Cloud SQL Postgresql Example](cloudsql_postgresql/README.md)
