# Getting Started Guide

## Overview 

This guide will provide you with the steps required to get your project up and running.

The workflow required to accomplish this is outlined below:

* [Key Concepts](#s1)
* [GCP Project Setup](#s2)
* [Github](#s3)
* [Terraform - Infrastructure as Code](#s3.1)
* [CircleCI  Setup / Deployment](#s3.2)
* [Post Deployment Configuration](#s4)   

## Key Concepts <a name="s1"></a>

### Branching and GCP Project

A core concept of deploying an AppEngine application using this template is that for each environment or branch that you wish to deploy, you will need a separate GCP Project.

* GCP Appengine projects will be provisioned, built, deployed, tested and promoted using CirclCi.
* Within CircleCI, GCP Projects are linked to repository branches by assigning branch specific environment variables that contain the Project ID
   * Example for dev branch: `GOOGLE_PROJECT_ID_dev=<MY_DEV_GCP_PROJECT>`
   * Example for master branch: `GOOGLE_PROJECT_ID_master=<MY_DEV_GCP_PROJECT>`
      * Note: The `_master` in `GOOGLE_PROJECT_ID_master` is used to identify which branch you are configuring.
* Linking GCP Project ID to a specific branch enables you to safely deploy your application by following your team's push and PR processes.

## GCP Project Setup <a name="s2"></a>

Initial GCP project setup requires interfacing with the GSA ICE team as they will need to complete the initial project and user setup.

[GSA ICE group](https://www.gsa.gov/about-us/organization/office-of-the-chief-information-officer/office-of-corporate-it-services)

### Service Now Tickets

The application team will be responsible submitting a service now ticket for the following configurations:

* Pilot project request
   * Request a pilot project when you are first setting up your project in GCP and need to work through permissions and API requirements.
   * Specific team members will receive project ownership privileges. 
   * This service request will generate ticket that is sent to the ICE / GCAP team.
   * Three separate GCP Projects will be created with the same groups and permissions applied.
* Dev, Test, Prod projects request
   * Request these projects to be setup when you are ready to deploy your application in production.
   * This service request will generate ticket that is sent to the ICE / GCAP team. 
   * Three separate GCP Projects will be created with the same groups and permissions applied.
   * Your team will not receive project ownership privileges.
   * Specific team members will receive the priveleges required to deploy this template application into App Engine.
   * Additional privilege changes must be provided in separate service requests.

 

## Github <a name="s3"></a>

This section will walk you through the process of setting up your own fork of this project with the required 

### Fork this project

Creating a fork of this project is required to enable your team to customize and deploy the template application within your GCP project.

* How to fork a Github project: [HowTo]( https://help.github.com/en/articles/fork-a-repo )

###  GitHub Dependency Scanning

GitHub provides it's users with built in dependency scanning.
 
To enable dependecy scanning click your GitHub repo's gear icon to enter settings and enable these three options:

   <img src="doc_img/dependency_scan.PNG" width="50%">

            
## Terraform - Infrastructure as Code <a name="s3.1"></a>

We use Terraform to provision the GCP resources required to .  Terraform init, plan, and apply are all triggered from the CircleCI portion of this project.

### Configure your project 

For details on customizing and configuring your Terraform project see the below README file: 

[Terraform README.md]( terraform/README.md)

## CircleCI  Setup / Deployment <a name="s3.2"></a>

In this section we describe the process required to configure CircleCI.

### CircleCI Geting Started

#### Login to Circle CI

* You will want to login to [CircleCI](https://circleci.com/dashboard) using a GitHub account that has access to the repo you forked in the section [Github](#s3).
  * This will enable you to add the GitHub repo you added in the steps outlined in the section [Github](#s3).

#### Add GitHub project to CircleCI
 
   Once you are logged into CircleCI with your Github account you should see all of 


### Setup Environment Variables and Secrets

For environment variables and secrets we store them all as CircleCI environment variables.
The next few sections will describe the data and variables require to successfully configure this project.
 
#### Required data for variables

1. For each GCP project, create and download the `terraform@<PROJECT_ID>` service account's access key.
   * From GCP Console select IAM & Admin service.
   * Select Service Accounts

      <img src="doc_img/service_account.PNG" width="25%">

   * Select the `terraform@<PROJECT_ID>` service account, click the three dots besides the account name and finally `Create key`.

      <img src="doc_img/create_key.PNG" width="10%">

   * Accept the defaults creating an Access key file in JSON format.

      <img src="doc_img/defaults_key.PNG" width="50%">

   * Download and open the JSON file as you will the contents to populate the `GCLOUD_SERVICE_KEY_<BRANCH>` described in the next section with the complete contents of this file.

#### Variable List

Below is the list of variables required to successfully deploy your project.

* Note: For variable with `<BRANCH>` suffix replace this with the GitHub repo branch you wish to tie to your GCP Project ID.   
* Note: All variables are of the type `string`.

| Variable    |  Description    | 
|---        |---              | 
| `GOOGLE_PROJECT_ID_<BRANCH>` | Project you will be deploying your app into when pushing changes to your branch set in the suffix `<BRANCH>` | 
| `GCLOUD_SERVICE_KEY_<BRANCH>`  |  Complete contents of the access key for your deployment's `terraform@<PROJECT_ID>` service account for the Project ID you set in the `GOOGLE_PROJECT_ID_<BRANCH>` variable   | 
| `NOTIFICATION_EMAIL` | Email that you wish to receive monitoring alerts | 
| `CLOUDSQL_DB` | Postgres Database Instance Name  | 
| `CLOUDSQL_USERNAME` | Username for basic CloudSQL authentication | 
| `CLOUDSQL_PASSWORD` | Password for basic CloudSQL authentication |  

#### How to configure CircleCI Environment variables

* To configure environment variables you must first access your project's then select Environement Variables under Build Settings.
 
   <img src="doc_img/env_var_1.PNG" width="25%">

* You will then need to click the Add Variable button to add the environment variables you require for your project.

   <img src="doc_img/env_var_2.PNG" width="25%">


### Deploy from Circle


## Post Deployment Configuration <a name="s4"></a>

## Google Web Vunerability Scanner

NEEDS CONTENT


## IAP - Authentication for your Application

NEEDS CONTENT

## Open firewall rules

NEEDS CONTENT

