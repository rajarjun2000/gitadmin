pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from the Git repository
                git 'https://github.com/rajarjun2000/gitadmin.git'  // Replace with your repository URL
            }
        }

        
        stage('Run Test') {
            steps {
                // Execute the test.py file
                sh 'python3 test.py'  // Adjust the path to test.py if needed
            }
        }
    }

    post {
        always {
            echo 'Pipeline completed.'
        }
        success {
            echo 'Test passed!'
        }
        failure {
            echo 'Test failed.'
        }
    }
}
