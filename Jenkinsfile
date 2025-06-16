pipeline {
    agent {
        label 'terraform-slave'
    }
    parameters {
        choice(
            name: 'ENVIRONMENT',
            choices: ['na','dev', 'test', 'stage', 'prod']
            description: 'Select Environment'
        )
        choice(
            name: 'ACTION',
            choices: ['validate\nplan\napply\ndestroy']
            description: 'Choose terraform workflow'
        )
    }
    stage {
        stage('init') {
            steps {
                sh """
                    terraform validate 
                """
            }
        }
        stage ('Plan') {
            steps {
                sh """
                    terraform plan 
                """
            }
        }
        stage ('apply') {
            steps {
                sh """
                    terraform apply --auto-approve 
                """
            }
        }
        stage ('destroy') {
            steps {
                sh """
                    terraform destroy --auto-approve 
                """
            }
        }
    }
}