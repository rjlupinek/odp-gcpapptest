# Getting Started Guide

## Overview 

This guide will provide you with the steps required to get your project up and running.

The workflow required to accomplish this is outlined below:

* [Key Concepts](#s1)
* [GCP Project Setup](#s2)
* [Github](#s3)
* [CircleCI](#s3.1)
* [Project Setup](#s4)   

## Key Concepts <a name="s1"></a>

### Branching and GCP Project

A core concept of this project is that for each environment or branch that you want to deploy, you will need a separate GCP Project.
If your development lifecycle includes a dev, staging and master branch that want deploy separately you will want to request/create a separate 
GCP Project for of each of these. 

We will refer to this in later configuration examples as your branch.





## GCP Project Setup <a name="s2"></a>

Initial project setup requires interfacing with the GSA ICE team as they will need to complete the initial project and user setup.

[GSA ICE group](https://www.gsa.gov/about-us/organization/office-of-the-chief-information-officer/office-of-corporate-it-services)

The application team will be responisble for providing the 

## Github <a name="s3"></a>

### Fork this project

Creating a fork of this project is required to enable your team to customize and deploy the template application within your GCP project.

* How to fork a project: [HowTo]( https://help.github.com/en/articles/fork-a-repo )

## Enable Dependency Scanning

###  GitHub Dependency Scanning

GitHub provides it's users with built in dependency scanning.

To enable dependecy scanning click your GitHub repo's gear icon to enter settings and enable these three options:

[](../doc_img/gettingstarted/dependency_scan.PNG)




## Circle CI <a name="s3.1"></a>

In this section we describe the process required to configure CircleCI.

### CircleCI Geting Started

* You will want to login to [CircleCI](https://circleci.com/dashboard) using a GitHub account that has access to repo you forked in the section [Github](#s3).
  * This will enable you to add the GitHub repo you added in the steps outlined in the section [Github](#s3).

### Add project

### Configure Encrypted Environment Variables






## Project Setup <a name="s4"></a>



### Add GitHub project to CircleCI.



## Setup Secrets

We have two options for secret setup in this project.

1. Use CircleCI encrypted environment variables
2. Use a combination of CircleCI encrypted environment variables and KMS encrypted secrets.
    * This is the method the demo uses by default.
    * We employ the gcp_setup_secrets.sh script to encrypt a file and store it Cloud Storage Bucket.
    * We use the same gcp_setup_secrets.sh to later download and decrypt the 

## Configure Terraform

There are several variables you will want to configure for 

1. Consider your application load on the database and change the
   parameters in `terraform/google_sql.tf` to size your databases
   properly.  The default `db-f1-micro` db size is probably not sufficient
   for most production systems.
1. Procure three GCP projects and gain access to the [GCP console](https://console.cloud.google.com/)
   on them all.  Unfortunately, as of this writing, the
   [GSA ICE group](https://www.gsa.gov/about-us/organization/office-of-the-chief-information-officer/office-of-corporate-it-services)
   has not yet finalized the process for procuring GCP, so we cannot document
   it fully here, but if you contact them, they should be able to give you
   the latest information on their process.

   For each project, do the following:
   1. Get GSA ICE to enable all of the APIs and roles you need for your GCP
      Project.  They should be able to check this repo out and follow the
      instructions on the [GCP Provisioning page](GCP_Provisioning.md).
   1. Generate a key for the Terraform service account via
      `Console -> IAM & admin -> Service Accounts -> terraform -> Create Key` in GCP.
   1. Save the JSON credentials to `$HOME/master-gcloud-service-key.json` for
      your production GCP Project, `$HOME/staging-gcloud-service-key.json` for
      your staging GCP Project, or `$HOME/dev-gcloud-service-key.json` for
      your dev GCP Project.

      These files should either be stored securely by the administrators
      of the system, or (even better) deleted after circleci has been seeded with
      it's data.
1. You should be sure to set up master and staging branches as protected branches
   that require approval for PRs to land in this repo.  You should also enable
   as many code analysis integrations as are appropriate within the repo to
   enforce code quality and find vulnerabilities.
1. [Enable circleci on this repo](https://circleci.com/docs/2.0/project-build/),
   then [add some environment variables](https://circleci.com/docs/2.0/env-vars/#setting-an-environment-variable-in-a-project) to it:
   * `GCLOUD_SERVICE_KEY_master`:  Set this to the contents of `$HOME/master-gcloud-service-key.json`
   * `GCLOUD_SERVICE_KEY_staging`:  Set this to the contents of `$HOME/staging-gcloud-service-key.json`
   * `GCLOUD_SERVICE_KEY_dev`:  Set this to the contents of `$HOME/dev-gcloud-service-key.json`
   * `GOOGLE_PROJECT_ID_master`: Set this to your production google project ID
   * `GOOGLE_PROJECT_ID_staging`: Set this to your staging google project ID
   * `GOOGLE_PROJECT_ID_dev`: Set this to your dev google project ID
   * `BASICAUTH_PASSWORD`: Set this to a basic auth password to frontend non-SSO apps with.
     If it is not set, then your non-SSO app will be public.
   * `BASICAUTH_USER`: Set this to the basic auth username you want.
1. Watch as circleci deploys the infrastructure.  Watch the terraform job,
   and approve it when it's plan is complete, then wait until it is done.

   The apps will all fail
   because it takes much longer for the databases to be created than the apps,
   and because you will need to get some info from terraform to make the
   oauth2_proxy work.  This is fine.
1. Go to the failed app deploy workflows in circleci and click on `Rerun`.
   Everything should fully deploy this time, though the rails app SSO proxy jobs
   will fail unless you completed the SSO proxy steps too.  This is fine.
1. You can now find all the apps if you go look at `Console -> App Engine -> Versions` and
   then click on the `Service` popup to find the app you'd like to get to
   (rails and dotnet-example, currently).  You will need to authenticate with
   the basic auth credentials you set above.

## Enabling IAP for OAuth Proxying

NEEDS CONTENT

## Enabling Stackdriver logging exports

For each new project, Stackdriver logging exports are enabled by default.
Logging is enabled at the Organization and Folder level for GSA GCP.
The GSA ICE team shall setup your project in the appropriate Folders.
