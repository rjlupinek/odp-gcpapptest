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
* Within CircleCI, GCP Projects are linked to repository branches by assigning branch specific environment variables that contain the Project ID.
   * NOTE: All variables in below examples are case sensitive.
   * Example for dev branch: `GOOGLE_PROJECT_ID_dev=<MY_DEV_GCP_PROJECT>`
   * Example for master branch: `GOOGLE_PROJECT_ID_master=<MY_DEV_GCP_PROJECT>`
      * Note: The `_master` in `GOOGLE_PROJECT_ID_master` is used to identify which branch you are configuring.
* Linking GCP Project ID to a specific branch enables you to safely deploy your application by following your team's push and PR processes.

## GCP Project Setup <a name="s2"></a>

Initial GCP project setup requires interfacing with the GSA ICE team as they will need to complete the initial project and user setup.

[GSA ICE group](https://www.gsa.gov/about-us/organization/office-of-the-chief-information-officer/office-of-corporate-it-services)

### Service Now Tickets

#### Note: ServiceNow ticket links and catalogs are still being developed. We will update links once catalog request are finalized. As of now this process is mannula and needs coordination with ICE team. 

The application team will be responsible submitting a service now ticket for the following configurations:

* Pilot project request
   * Request a pilot project when you are first setting up your project in GCP and need to work through permissions and API requirements.
   * Specific team members will receive project ownership privileges (only in pilot).
   * This service request will generate ticket that is sent to the ICE / GCAP team and necessary approval process.
   *
* Dev, Test, Prod projects request
   * Request these projects to be setup when you are ready to deploy your application in dev, test or production.
   * This service request will generate ticket that is sent to the ICE / GCAP team and necessary approvals. 
   * Three separate GCP Projects (dev, test and prod will be created with the same groups and permissions applied.
   * Your team will not receive project ownership privileges. IAM and roles management is shared responsibility betweeen ICE and application team.
   * Roles and permission needs to be adjusted for group or servive account as needed by submitting service now tickets. We recomment using pilot environment to hash out services, api, roles and permission needed in higher environment.
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
The next few sections will describe the data and variables require to successfully configure this project. We use service account in CircleCi to deploy code. If you do not have project owner access, you will have to submit servivenow request and coordinate with ICE team for creating service account and assign required roles.
 
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

For a details on the environment variables required see the [CircleCI README](.circleci/README.md) for more details.

#### How to configure CircleCI Environment variables

* To configure environment variables you must first access your project's then select Environement Variables under Build Settings.
 
   <img src="doc_img/env_var_1.PNG" width="25%">

* You will then need to click the Add Variable button to add the environment variables you require for your project.

   <img src="doc_img/env_var_2.PNG" width="25%">


### Deploy from Circle

Now that you have your project configured in CircleCi all that you need to do is commit any change and push your changes to either a master, dev, or test branch.

## Post Deployment Configuration <a name="s4"></a>

### Google Cloud Security Scanner

Google Cloud Security Scanner can automatically scan and detect four common vulnerabilities, including cross-site-scripting (XSS), Flash injection, mixed content (HTTP in HTTPS), and outdated/insecure libraries.

* For complete setup instructions please see the following documentation: 

   [Security Scanner with App Engine](https://cloud.google.com/security-scanner/docs/scanning)

### Google Cloud Identity Aware Proxy- Authentication for your Application

Identity Aware Proxy or IAP provides you with an authentication proxy that sits in front of your application.
For internal GSA users this provides a near push button configuration of MFA enabled authentication when authorizing users and groups configured in G Suite.

### Note: OAuth consent scrren needs to be pre-configured to enable IAP.  

* To enable IAP first login to your GCP Console, select your project, Security and the Idendity-Aware Proxy.

* Click the toggle that enables IAP for App Engine.

   <img src="doc_img/iap_enable.PNG" width="30%">

* Select the App Engine service you deployed, the template will be pypostgresql, and click the ADD MEMBER BUTTON

   <img src="doc_img/iap_add1.PNG" width="15%">

* Enter one or multiple groups that you want to enable access to your App Engine service by adding them in the New Members field and selecting the Cloud IAP, IAP-secured Web App User role.

   <img src="doc_img/iap_add2.PNG" width="25%">

* Browsing to your service will now prompt you to login with a Google account.


### App Engine Firewall

App Engine firewall rules are configured using a basic ACL where you either block or allow traffic based on source IP address.
Rules are evaluated in order from lowest priority to highest priority.  
The first rule that is evaluated that contains the source address is triggered regardless of the existance of rules with higher priority values with the same source address.

Default behavior for your deployed application is to allow only IP Addresses source from the GSA public networks.

See following link for details on configuring default Firewall allow rule for this project:

  [Circle CI Variable Configuration](terraform#variables)
  [Terraform Variable Configuration](.circleci#environment-variables-)

See following link for Google's documentation on configuring App Engine firewall rules:

[Controlling Access with Firewall](https://cloud.google.com/appengine/docs/standard/python/creating-firewalls)
