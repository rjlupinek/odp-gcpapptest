#!/bin/bash

#########################
#  Purpose:
#    This script will setup a bucket and encrypted secrets file for you.
#  Requires:
#     * GCP SDK installed 
#       *  gcloud binary
#       *  gsutil binary
#  Example:
#    ./gcp_setup_secrets.sh --project-id=<Your project ID>  --environment=<dev, prod, etc>  --secrets-file=<Secrets .json file>
#########################

set -e

arguments () {
  #This functional makes it possible to set arguments using the --param= format.
  for i in "$@"
  do
  case $i in
      --environment=*) #Environment you are setting up secrets for
      ENVIRONMENT="${i#*=}"
      shift # past argument=value
      ;;
      --project-id=*)  #ID of the project you will be storing your secrets in
      GOOGLE_PROJECT_ID="${i#*=}"
      shift # past argument=value
      ;;
      --secrets-file=*)  #Actual secrets file to encrypt
      SECRETS_IN_FILE="${i#*=}"
      shift # past argument=value
      ;;
      --decrypt=*)  #Actual secrets file to encrypt
      DECRYPT="${i#*=}"
      shift # past argument=value
      ;;
      *)
              # unknown option
      ;;
  esac
  done


}

create_key () {

  #Create keyring and keys for the secrets storage bucket
  
  #Start by creating the key ring
  gcloud kms keyrings create $KEYRING \
       --location=$LOCATION || true
  #Create the key you will be usingto encrypt your secrets
  gcloud kms keys create $KEY \
        --location=$LOCATION \
        --keyring=$KEYRING \
        --purpose=encryption \
        --rotation-period=$KEY_ROTATE \
        --next-rotation-time=+P$KEY_ROTATE || true

}

create_bucket () {
  #Create the secrets bucket
  gsutil mb gs://$SECRETS_BUCKET || true
}

upload_encrypted_secret () {
  
  #Encrypt secrets file
  gcloud kms encrypt \
        --key=$KEY \
        --keyring=$KEYRING \
        --location=$LOCATION \
        --plaintext-file=$SECRETS_IN_FILE \
        --ciphertext-file=$SECRETS_FILE

  #Copy ecrypted secrets file to secrets bucket 
  gsutil cp  $SECRETS_FILE gs://$SECRETS_BUCKET/$SECRETS_FILE 
}

download_encrypted_secret () {

  #Download encrypted secrets file from secrets bucket
  gsutil cp gs://$SECRETS_BUCKET/$SECRETS_FILE $SECRETS_FILE 
  
  #Decrypt secrets file
  gcloud kms decrypt \
        --key=$KEY \
        --keyring=$KEYRING \
        --location=$LOCATION \
        --ciphertext-file=$SECRETS_FILE \
        --plaintext-file=$SECRETS_FILE
}


main () {

  #Call the arguments function
  arguments $@

  usage="This script will encrypt and upload your secrets file to a GCP storage bucket for use in your CI pipeline.\n  Usage to encrypt: \n  ./gcp_setup_secrets.sh --project-id=<Your project ID>  --environment=<dev, prod, etc>  --secrets-file=<Secrets .json file>\n  Usage to decrypt: \n  ./gcp_setup_secrets.sh --decrypt=true"
  #Test command line arguments

  if [ "$DECRYPT" != "true" ]
  then
    if [ $# -eq 0 ] || [ -z "$ENVIRONMENT" ] || [ -z "$GOOGLE_PROJECT_ID" ] || [ -z "$SECRETS_IN_FILE" ]
    then
      echo
      printf "$usage"
      echo
      return
    fi
  fi 

  #Declare variables
  #export ENVIRONMENT="dev"
  #export GOOGLE_PROJECT_ID=i-ise-04302019-playground
  export SECRETS_BUCKET=gcp-vars-$GOOGLE_PROJECT_ID
  export KEYRING=gcp-keyring-$GOOGLE_PROJECT_ID
  export KEY=gcp-secrets-key-$GOOGLE_PROJECT_ID-$ENVIRONMENT
  export KEY_RESOURCE=projects/$GOOGLE_PROJECT_ID/locations/$LOCATION/keyRings/$KEYRING/cryptoKeys/$KEY
  export LOCATION=us
  export KEY_ROTATE="30d"
  export SECRETS_FILE=$ENVIRONMENT-vars.json
  export SECRETS_IN_FILE

  if [ -z "$DECRYPT" ]
  then 
    create_key
    create_bucket
    upload_encrypted_secret
  fi

  if ["$DECRYPT" = "true"]
  then
    download_encrypted_secret
  fi

}


main $@
