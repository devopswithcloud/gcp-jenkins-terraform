pipeline {
    agent {
        label 'terraform-slave'
    }

    environment {
        GCS_BUCKET = "boanthos-prod-jenkins"
        GOOGLE_APPLICATION_CREDENTIALS = "${WORKSPACE}/sa-key.json"
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
            steps {
                echo "Testing Jenkinsfile for terrform code"
                // sh """
                //     //terraform init --backend-config="bucket=${env.GCS_BUCKET}" --backend-config="prefix=${env.********}"
                // """ 
            }
        }

        // Planning stage
        stage ('plan') {

        }

        // Applying actual infra
        stage ('apply') {

        }

        // Destroy the infra
        stage ('destroy') {

        }
    }
}
