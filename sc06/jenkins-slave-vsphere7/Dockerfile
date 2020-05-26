FROM jenkins/jnlp-slave 
MAINTAINER Charles Saroka 

# Set the enviornment variable for SC_CLI_DOWNLOAD_IP either manually or via a pipeline for the build proces to download the vSphere 7 Kubernetes CLI tools from the Supervisor Cluster API. Additionally, uncomment the RUN statement that uses curl to download from 
# the SC_CLI_DOWNLOAD_IP". Otherwise, manually download the vSphere 7 Kubernetes CLI tools from the Supervisor Cluster API and place in the same directory as the Dockerfile. For the local file transfer option, uncomment the statement "COPY vsphere-plugin.zip /tmp" and comment out 
# RUN statement that uses curl to download from the SC_CLI_DOWNLOAD_IP". 

# ENV SC_CLI_DOWNLOAD_IP="192.168.161.1"
# ENV SC_CLUS_VIP="192.168.161.1"
# SC_USER_NAME="administrator@vsphere.local"
# SC_USER_PASS="vmware"

USER root
WORKDIR /
RUN apt-get update && apt-get install -y \ 
  curl \
  tar \
  gzip \
  ca-certificates \
  git \
  apt-utils \
  expect \
&& rm -rf /var/lib/apt/lists/*

RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 \
 && chmod 700 get_helm.sh \
 && ./get_helm.sh

# RUN curl https://$SC_CLI_DOWNLOAD_IP/wcp/plugin/linux-amd64/vsphere-plugin.zip --output /tmp/vsphere-plugin.zip -k
COPY vsphere-plugin.zip /tmp
RUN unzip /tmp/vsphere-plugin.zip -d /tmp/vsphere-plugin \
 && cp /tmp/vsphere-plugin/bin/kubectl* /usr/local/bin/ \
 && chmod +x /tmp/vsphere-plugin/bin/kubectl* 

# The autologinsc script enables the ability auto-login to Supervisor Cluster such as with a CI/CD pipeline; requires variables SC_CLUS_VIP, SC_USER_NAME, and SC_USER_PASS. ENV variables can be set by pipeline or manually above. For local transfer, download 
# script to the same directory as the Dockerfile, uncomment the following COPY and RUN statements, and comment out the RUN wget statement with public URL. Do the reverse to pull from the public repository.

COPY autologinsc.sh /usr/local/bin/autologinsc
RUN chmod +x /usr/local/bin/autologinsc
# RUN wget -O /usr/local/bin/autologinsc https://raw.githubusercontent.com/ModernAppsNinja/v7k8s-tc-templates/master/sc06/autologinsc.sh \
# && chmod +x /usr/local/bin/autologinsc
 
RUN apt-get clean

USER jenkins
