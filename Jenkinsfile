pipeline {
    agent any
    
    environment {
        // Define environment variables here if needed
        GIT_REPO_URL = 'https://github.com/rajarjun2000/gitadmin.git'
    }
    
    stages {
        stage('Checkout') {
            steps {
                // Clone the repository from GitHub
                git url: "${GIT_REPO_URL}", branch: 'main' // Adjust the branch name if necessary
            }
        }

        stage('Build') {
            steps {
                // Example build step, replace with your build commands
                echo 'Building the project...'
                // Add your build commands, for example:
                // sh 'make build'
                // sh 'npm install && npm run build'
            }
        }

        stage('Test') {
            steps {
                // Example test step, replace with your testing commands
                echo 'Running tests...'
                // Add your test commands, for example:
                // sh 'npm test'
                // sh './run_tests.sh'
            }
        }

        stage('Deploy') {
            steps {
                // Example deploy step, replace with your deploy commands
                echo 'Deploying the project...'
                // Add your deploy commands, for example:
                // sh './deploy.sh'
                // sh 'docker-compose up -d'
            }
        }
    }

    post {
        always {
            // Always run cleanup or notifications
            echo 'Cleaning up...'
        }

        success {
            // Actions to perform on success (optional)
            echo 'Pipeline succeeded!'
        }

        failure {
            // Actions to perform on failure (optional)
            echo 'Pipeline failed.'
        }
    }
}
