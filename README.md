# Jenkins Master Server

[![](https://img.shields.io/docker/pulls/cnservices/jenkins-master.svg)](https://hub.docker.com/r/cnservices/jenkins-master/)
[![](hhttps://img.shields.io/docker/build/cnservices/jenkins-master)](https://hub.docker.com/r/cnservices/jenkins-master/)
[![](https://img.shields.io/docker/automated/cnservices/jenkins-master)](https://hub.docker.com/r/cnservices/jenkins-master/)
[![](https://img.shields.io/docker/stars/cnservices/jenkins-master)](https://hub.docker.com/r/cnservices/jenkins-master/)
[![](https://img.shields.io/github/license/cn-cicd/jenkins-master)](https://github.com/cn-cicd/jenkins-master)
[![](https://img.shields.io/github/issues/cn-cicd/jenkins-master)](https://github.com/cn-cicd/jenkins-master)
[![](https://img.shields.io/github/issues-closed/cn-cicd/jenkins-master)](https://github.com/cn-cicd/jenkins-master)
[![](https://img.shields.io/github/languages/code-size/cn-cicd/jenkins-master)](https://github.com/cn-cicd/jenkins-master)
[![](https://img.shields.io/github/repo-size/cn-cicd/jenkins-master)](https://github.com/cn-cicd/jenkins-master)

This is the Jenkins master node. There are no executors in this node, so you need to attach one or more slaves to run the jobs.

## Start Master Jenkins ##

Create a folder to store Jenkins data files, so the container can be reseted without losing information.  
   
    mkdir ~/jenkins_data
    chmod 777 ~/jenkins_data
    
Run the container  
    
    docker run -d --name jenkins --restart=always -p 8080:8080 -p 50000:50000 -v ~/jenkins_data:/var/jenkins_home cnservices/jenkins-master 

## Adding jobs by default ##

In order to have Jenkins jobs automatically configured when you run the container, follow these steps:  

1. Inside the jobs folder (jenkins-master/jobs) add a new folder named with the name of the new job.  
2. Inside the folder created in the previous step, add a new file named config.xml. That file should contain all the configuration of new job.

## Security

This distribution of Jenkins enables password security with the following credentials:  

    Username: admin  
    Password: admin  

Only logged in users can manage Jenkins and is disable the anonymous access.

PLEASE CHANGE THIS SECURITY SETTINGS AFTER DEPLOYING YOUR INSTANCE
