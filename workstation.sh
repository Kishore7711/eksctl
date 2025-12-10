 docker instalation and mount the storage for this
   =================================================
	#!/bin/bash
	growpart /dev/nvme0n1 4
	lvextend -L +30G /dev/mapper/RootVG-varVol
	xfs_growfs /var
	dnf -y install dnf-plugins-core
	dnf-config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
	dnf install docker-ce docker-ec-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
	systemctl start docker
	systemctl enable docker
	usermod -aG docker ec2-user
	
 kubectl for applications managing purpose  & intract with cluster 
  ================================================================
1) Procedure:
   Download the kubectl binary for your cluster’s Kubernetes version from Amazon S3.
   Kubernetes 1.34
	  curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.34.2/2025-11-13/bin/linux/amd64/kubectl
	 
	
2) Apply execute permissions to the binary.
	  chmod +x ./kubectl
	
	
3) Copy the binary to a folder in your PATH. If you have already installed a version of kubectl, then we recommend creating a $HOME/bin/kubectl 
   and ensuring that $HOME/bin comes first in your $PATH.
       mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH	
	   
	   
[ ec2-user@ip-172-31-68-160 ~ ]$ kubectl version --client
Client Version: v1.34.2-eks-ecaa3a6
Kustomize Version: v5.7.1

	
	
	
 eksctl for cluster creation , delation
  ======================================  
    ARCH=amd64
	PLATFORM=$(uname -s)_$ARCH
	curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"
	tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz
	sudo install -m 0755 /tmp/eksctl /usr/local/bin && rm /tmp/eksctl

    eksctl help
  
	
	
 AWS Configuration - aws-cli
  ===========================
  for authontication...
  aws configure