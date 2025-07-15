#!/bin/bash
#set -x

cd /var/www/
# Download Moodle 4.5 (latest stable)
wget https://download.moodle.org/download.php/direct/stable405/moodle-latest-405.tgz
tar zxvf moodle-latest-405.tgz
rm -rf html/ moodle-latest-405.tgz
mv moodle html
mkdir moodledata
chown apache. -R html
chown apache. -R moodledata

# Updated PHP.ini settings for Moodle 4.5
sed -i '/memory_limit = 128M/c\memory_limit = 512M' /etc/php.ini
sed -i '/max_execution_time = 30/c\max_execution_time = 300' /etc/php.ini
sed -i '/max_input_time = 60/c\max_input_time = 300' /etc/php.ini
sed -i '/post_max_size = 8M/c\post_max_size = 100M' /etc/php.ini
sed -i '/upload_max_filesize = 2M/c\upload_max_filesize = 100M' /etc/php.ini
sed -i '/max_input_vars = 1000/c\max_input_vars = 5000' /etc/php.ini

# Enable opcache for better performance
sed -i '/opcache.enable=1/c\opcache.enable=1' /etc/php.d/10-opcache.ini
sed -i '/opcache.memory_consumption=128/c\opcache.memory_consumption=256' /etc/php.d/10-opcache.ini
sed -i '/opcache.max_accelerated_files=4000/c\opcache.max_accelerated_files=8000' /etc/php.d/10-opcache.ini

# Add recommended settings for Moodle 4.5
echo "opcache.revalidate_freq=60" >> /etc/php.d/10-opcache.ini
echo "opcache.use_cwd=1" >> /etc/php.d/10-opcache.ini
echo "opcache.validate_timestamps=1" >> /etc/php.d/10-opcache.ini
echo "opcache.save_comments=1" >> /etc/php.d/10-opcache.ini
echo "opcache.enable_file_override=0" >> /etc/php.d/10-opcache.ini

systemctl start httpd
systemctl enable httpd

echo "Moodle 4.5 installed and Apache started !"
