FROM jenkins/jnlp-slave 
MAINTAINER Ravi Jagannathan 

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
  python-pip

RUN pip install pexpect

RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 \
 && chmod 700 get_helm.sh \
 && ./get_helm.sh

# RUN curl https://$SC_CLI_DOWNLOAD_IP/wcp/plugin/linux-amd64/vsphere-plugin.zip --output /tmp/vsphere-plugin.zip -k
COPY vsphere-plugin.zip /tmp
RUN unzip /tmp/vsphere-plugin.zip -d /tmp/vsphere-plugin \
 && cp /tmp/vsphere-plugin/bin/kubectl* /usr/local/bin/ \
 && chmod +x /tmp/vsphere-plugin/bin/kubectl* 
RUN  echo  "KUBECTL-VSPHERE copied"
# The autologinsc script enables the ability auto-login to Supervisor Cluster such as with a CI/CD pipeline; requires variables SC_CLUS_VIP, SC_USER_NAME, and SC_USER_PASS. ENV variables can be set by pipeline or manually above. For local transfer, download 
# script to the same directory as the Dockerfile, uncomment the following COPY and RUN statements, and comment out the RUN wget statement with public URL. Do the reverse to pull from the public repository.
RUN kubectl-vsphere version
 
RUN apt-get clean

USER jenkins
