FROM debian:10.7-slim

RUN apt-get update && apt-get -y install cron curl unzip

# Install AWS cli version 2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install

# Copy auto-sync-cron file to the cron.d directory
COPY auto-sync-cron /etc/cron.d/auto-sync-cron

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/auto-sync-cron

# Apply cron job
RUN crontab /etc/cron.d/auto-sync-cron

# Copy auto-sync-cron file to the cron.d directory
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY aws-sync.sh /aws-sync.sh

RUN chmod +x /usr/local/bin/entrypoint.sh
RUN mkdir /dags
# Run the command on container startup
ENTRYPOINT [ "entrypoint.sh" ]