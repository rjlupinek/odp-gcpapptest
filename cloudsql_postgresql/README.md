cloud_postgresql 
==========

This project is a slightly enhanced sample Python Flask project pulled from the Google Cloud Platform Python samples. 

[Source project](https://github.com/GoogleCloudPlatform/python-docs-samples/tree/master/appengine/flexible/cloudsql_postgresql)

The major change was to allow for Stackdriver Logging to be built in.  This is required for the overall sample project to be a success.

The purpose of this project is as follows:

* Illustrate reading and writing to Cloud SQL Database
* Illustrate logging using the Stackdriver Client Libraries
* Illustrate configuration required to get your application launched using App Engine.
 

Project contents
----------

| File   |  Description    |
|---        |---              |
| app.yaml   |   Example App Engine yaml file.  This is JUST and example.  The real app.yml is completely written using CircleCi in the .circleci folder in the parent directory  |
| create_tables.py |  Script that creates the required tables.  Requires  |
| main_test.py |  Create tables and launches a client test against localhost  |
| main.py     |  The main application file.  It is a simple Flask / SQLAlchemy application that reads/writes to a database. |


Setup
----------

Project setup is not required.  All changes are handled through Environment Variables configured via Circle CI.
See Project contents if you wish to understand the files that make up this project.


Reference documentation
----------

#### Source project
[Source project](https://github.com/GoogleCloudPlatform/python-docs-samples/tree/master/appengine/flexible/cloudsql_postgresql)

#### Stackdriver Logging client libraries ( Logging for your application ) 
https://cloud.google.com/logging/docs/reference/libraries 