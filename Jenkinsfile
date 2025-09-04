pipeline {
    agent {
        label 'terraform-slave'
    }

    parameters{
        choice(
            name: 'ENVIRONMENT' ,
            choices: ['dev', 'test', 'stage', 'prod'],
            description: 'Choose the environment to deploy'
        )
        choice(
            name: 'ACTION' ,
            choices: "validate\ninit\nplan\napply\ndestroy",
            description: 'Choose the action to perform'
        )
    }

    environment {
        // bucket name where tfstate file will be stored for all environments
        GCS_BUCKET = "boanthos-prod-jenkins"
        GOOGLE_APPLICATION_CREDENTIALS = "${WORKSPACE}/sa-key.json"
        TFVARS_FILE  = "${params.ENVIRONMENT}.tfvars"
    }

    stages {
        // Definging auth credential setup stage
        stage ('Setup GCE Auth') {
            steps {
                withCredentials([file(credentialsId: 'gcp-service-account-key', variable: 'SA_KEY')]) {
                    // some block
                    sh '''
                        cp  $SA_KEY $GOOGLE_APPLICATION_CREDENTIALS
                    '''
                }
            }
        }

        // Initialize terraform
        stage ('init') {
            // no need of when condition as we want to have this stage irrespective of action chosen
            steps {
                echo "Testing Jenkinsfile for terrform code"
                sh """
                    terraform init --backend-config="bucket=${env.GCS_BUCKET}" --backend-config="prefix=${params.ENVIRONMENT}"
                """ 
            }
        }

        // Planning stage
        stage ('plan') {
            when {
                expression{
                    params.ACTION == 'plan'
                }
            }
            steps {
                echo "Planning  stage"
                sh """
                    terraform plan -var-file=${env.TFVARS_FILE}
                """
            }

        }

        // Applying actual infra
        stage ('apply') {
            when {
                expression{
                    params.ACTION == 'apply'
                }
            }
            steps {
                echo "Applying stage"
                sh """
                    terraform apply -var-file=${env.TFVARS_FILE} --auto-approve 
                """
            }

        }

        // Destroy the infra
        stage ('destroy') { 
            when {
                expression{
                    params.ACTION == 'destroy'
                }
            }
            steps {
                echo "Destroying stage"
                sh """
                    terraform destroy -var-file=${env.TFVARS_FILE} --auto-approve 
                """
            }
        }
    }
    post {
        always {
            echo "Cleaning the workspace"
            cleanWs()
        }
    }
}
