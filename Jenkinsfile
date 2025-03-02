pipeline {
    agent any
    
    environment {
        // Optional: Define environment variables here if needed
    }
    
    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from the Git repository
                git url: 'https://github.com/rajarjun2000/gitadmin.git', branch: 'master'  // Update if necessary
            }
        }

        stage('Install Dependencies') {
            steps {
                // Install Python dependencies (assuming requirements.txt exists)
                sh 'pip install -r requirements.txt'
            }
        }

        stage('Run Tests') {
            steps {
                // Run the test.py file using Python
                sh 'python test.py'  // Adjust the path to test.py if it's in a subfolder
            }
        }
    }
    
    post {
        always {
            // Optional: Cleanup actions
            echo 'Cleaning up...'
        }

        success {
            echo 'Test executed successfully!'
        }

        failure {
            echo 'Test execution failed.'
        }
    }
}

