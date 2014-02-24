docker-centos-lamp
==================

LAMP with CentOS

Make a LAMP environment using the Docker.

### 1. Please correct the file to suit your environment

 - authorized_keys
 
   Your public key

 - monit.conf
 
   Your IP address to allow
  ```
set httpd port 2812 and
    allow localhost        # allow localhost to connect to the server and
    allow **Your IP address here**
    allow admin:monit      # require user 'admin' with password 'monit'
    allow @monit           # allow users of group 'monit' to connect (rw)
    allow @users readonly  # allow users of group 'users' to connect readonly
```

 - td-agent.conf
 
   Your log server's IP address
  ```
<match http.app.**>
  type forward
  <server>
  host **Your log server's IP address here**
  </server>
  flush_interval 2s
</match>
```

### 2. Build docker image

```sh
  % sudo docker build -t centos-lamp -rm=true .
  % sudo docker images
  REPOSITORY               TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
  centos-lamp              latest              8a8b20fd03c2        23 minutes ago      1.035 GB
```

### 3. Run docker container

```sh
  % sudo docker run -d -t -p 12812:2812 -p 10080:80 -p 10022:22 centos-lamp /usr/bin/monit -I
 9c796ab91f7d79259811b0343978ef1354a57b38e43a64d8bb83b4148aad28a0
  % curl http://localhost:10080/
```
