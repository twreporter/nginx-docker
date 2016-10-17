# Set the base image to Ubuntu
FROM ubuntu:14.04

# Install Nginx

# Update the repository
RUN echo "deb http://ppa.launchpad.net/nginx/stable/ubuntu trusty main" > /etc/apt/sources.list.d/nginx-stable-trusty.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C300EE8C
RUN apt-get update

# Install necessary tools
RUN apt-get install -y nano wget dialog net-tools

# Download and Install Nginx
RUN apt-get install -y nginx  

# Remove the default Nginx configuration file
RUN rm -v /etc/nginx/nginx.conf

# Remove the cache metadata
RUN rm -v -f /data/nginx/data

RUN mkdir -p /data/nginx/data

# Copy a configuration file from the current directory
ADD nginx.conf /etc/nginx/

# Append "daemon off;" to the configuration file
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

RUN nginx -v 

# Expose ports
EXPOSE 80

# Set the default command to execute when creating a new container
CMD service nginx start
