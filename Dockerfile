FROM ubuntu:16.04

# Install required services
RUN apt-get update && apt-get install -y \
    apache2 \
    php7.0 \
    libapache2-mod-php7.0 \
    openssh-server \
    vsftpd \
    postfix \
    dovecot-pop3d \
    dovecot-imapd \
    john \
    openssl \
    sudo \
    net-tools \
    && rm -rf /var/lib/apt/lists/*

# Configure Apache
RUN a2enmod php7.0
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Configure SSH
RUN mkdir /var/run/sshd
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# Configure FTP
RUN echo 'anonymous_enable=YES' >> /etc/vsftpd.conf
RUN echo 'local_enable=YES' >> /etc/vsftpd.conf
RUN echo 'write_enable=YES' >> /etc/vsftpd.conf

# Configure Postfix (non-interactive)
RUN echo "postfix postfix/mailname string de-ice-s1100" | debconf-set-selections
RUN echo "postfix postfix/main_mailer_type string 'Internet Site'" | debconf-set-selections

# Create vulnerable users
RUN useradd -m -s /bin/bash aadams && echo 'aadams:nostaw' | chpasswd
RUN useradd -m -s /bin/bash bbanter && echo 'bbanter:password' | chpasswd  
RUN useradd -m -s /bin/bash ccoffee && echo 'ccoffee:SecretPassword' | chpasswd
RUN useradd -m -s /bin/bash ddeeds && echo 'ddeeds:p@ssw0rd' | chpasswd
RUN useradd -m -s /bin/bash eeikman && echo 'eeikman:monday' | chpasswd

# Set root password (weak for demo)
RUN echo 'root:edived' | chpasswd

# Grant sudo privileges to aadams (common vulnerability)
RUN echo 'aadams ALL=(ALL) NOPASSWD:/bin/cat /etc/passwd, /bin/cat /etc/shadow' >> /etc/sudoers

# Create salary file
RUN mkdir -p /home/aadams
RUN echo "Name,Department,Salary" > /home/aadams/salary_dec2003.csv
RUN echo "Alice Adams,HR,55000" >> /home/aadams/salary_dec2003.csv
RUN echo "Bob Banter,IT,65000" >> /home/aadams/salary_dec2003.csv
RUN echo "Carol Coffee,Finance,58000" >> /home/aadams/salary_dec2003.csv
RUN echo "Dave Deeds,Marketing,52000" >> /home/aadams/salary_dec2003.csv
RUN echo "Eve Eikman,Legal,72000" >> /home/aadams/salary_dec2003.csv

# Encrypt salary file
RUN openssl enc -aes-256-cbc -salt -in /home/aadams/salary_dec2003.csv -out /home/aadams/salary_dec2003.csv.enc -k "HeadOfSecurity" 2>/dev/null || true
RUN rm -f /home/aadams/salary_dec2003.csv
RUN chown aadams:aadams /home/aadams/salary_dec2003.csv.enc

# Copy startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Expose ports
EXPOSE 21 22 25 80 110 143

# Start services
CMD ["/start.sh"]