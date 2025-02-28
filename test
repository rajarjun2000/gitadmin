import os
import time
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

def send_email(subject, body, to_email):
    from_email = 'rajarjun2000.rk@gmail.com'  # Replace with your email
    from_password = 'satwbwlifnfccjep'  # Replace with your email password
    smtp_server = 'smtp.gmail.com'  # Replace with your SMTP server (e.g., smtp.gmail.com)
    smtp_port = 587  # or 465 for SSL
    
    # Create the email
    msg = MIMEMultipart()
    msg['From'] = from_email
    msg['To'] = to_email
    msg['Subject'] = subject
    msg.attach(MIMEText(body, 'plain'))
    
    # Connect to the SMTP server and send email
    try:
        server = smtplib.SMTP(smtp_server, smtp_port)
        server.starttls()  # Use TLS encryption
        server.login(from_email, from_password)
        text = msg.as_string()
        server.sendmail(from_email, to_email, text)
        server.quit()
        print(f"Alert sent to {to_email}")
    except Exception as e:
        print(f"Failed to send email: {e}")

# Function to check if files are stuck for over 30 minutes
def check_files_in_directory(directory_path):
    current_time = time.time()
    stuck_files = []

    # List all files in the directory
    try:
        files = os.listdir(directory_path)
    except FileNotFoundError:
        print(f"Directory not found: {directory_path}")
        return
    
    # Check each file
    for file_name in files:
        file_path = os.path.join(directory_path, file_name)
        
        # Skip if it's not a file
        if not os.path.isfile(file_path):
            continue
        
        # Get the last modified time of the file
        file_modified_time = os.path.getmtime(file_path)
        
        # Calculate time difference
        time_difference = current_time - file_modified_time
        
        # If the file is stuck for over 30 minutes (1800 seconds)
        if time_difference > 1800:
            stuck_files.append(file_path)
    
    if stuck_files:
        # Create the email body with the list of stuck files
        body = "The following files have not been modified in the last 30 minutes:\n\n"
        body += "\n".join(stuck_files)
        
        # Send an email alert with the list of stuck files
        send_email(
            subject="ALERT: Files Stuck in Location",
            body=body,
            to_email="rajarjun2000.rk@gmail.com"  # Replace with recipient's email
        )
        print("Stuck files alert sent.")
    else:
        print("No files are stuck.")

if __name__ == "__main__":
    # Replace with the path to the directory you want to monitor
    directory_path = 'D:\DEVOPS & AWS'

    # Check files in the directory
    check_files_in_directory(directory_path)	



