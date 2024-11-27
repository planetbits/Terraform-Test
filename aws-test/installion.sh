#! /bin/bash
sudo apt-get update
sudo apt-get install -y apache2
sudo systemctl start apache2
echo "<h1>Test Page from Terraform</h1>" | sudo tee /var/www/html/index.html