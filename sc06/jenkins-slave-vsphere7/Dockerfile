FROM jenkins/jnlp-slave 
MAINTAINER Charles Saroka 

# Set the enviornment variable for SC_CLI_DOWNLOAD_IP either manually or via a pipeline for the build proces to download the vSphere 7 Kubernetes CLI tools from the Supervisor Cluster API. Additionally, uncomment the RUN statement that uses curl to download from 
# the SC_CLI_DOWNLOAD_IP". Otherwise, manually download the vSphere 7 Kubernetes CLI tools from the Supervisor Cluster API and place in the same directory as the Dockerfile. For the local file transfer option, uncomment the statement "COPY vsphere-plugin.zip /tmp" and comment out 
# RUN statement that uses curl to download from the SC_CLI_DOWNLOAD_IP". 

# ENV SC_CLI_DOWNLOAD_IP="192.168.161.1"

USER root
WORKDIR /

RUN apt-get update && apt-get install -y \ 
  apt-utils \
  curl \
  tar \
  gzip \
  ca-certificates \
  git \
  expect \
  jq

RUN curl -fsSL -o /tmp/get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 \
 && chmod 700 /tmp/get_helm.sh \
 && ./tmp/get_helm.sh

# RUN curl https://$SC_CLI_DOWNLOAD_IP/wcp/plugin/linux-amd64/vsphere-plugin.zip --output /tmp/vsphere-plugin.zip -k
COPY vsphere-plugin.zip /tmp
RUN unzip /tmp/vsphere-plugin.zip -d /tmp/vsphere-plugin \
 && chmod +x /tmp/vsphere-plugin/bin/kubectl* \
 && mv /tmp/vsphere-plugin/bin/kubectl* /usr/local/bin/

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER jenkins
