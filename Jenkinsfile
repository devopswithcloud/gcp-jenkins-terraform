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
            steps {
                echo "Planning stage"
                // sh 
                // """
                //     terraform plan -out=tfplan
                // """
            }

        }

        // Applying actual infra
        stage ('apply') {
            steps {
                echo "Applying stage"
                // sh """
                //     terraform apply -auto-approve tfplan
                // """
            }

        }

        // Destroy the infra
        stage ('destroy') { 
            steps {
                echo "Destroying stage"
                // sh """
                //     terraform destroy -auto-approve
                // """
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
