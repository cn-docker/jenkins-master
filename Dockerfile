FROM jenkins/jenkins:lts-alpine
MAINTAINER Julian Nonino <noninojulian@outlook.com>

# Install Pipeline plugins
RUN /usr/local/bin/install-plugins.sh blueocean
# Install View Plugins
RUN /usr/local/bin/install-plugins.sh radiatorviewplugin nested-view dashboard-view
# Install SCM Plugins
RUN /usr/local/bin/install-plugins.sh git git-parameter git-changelog github bitbucket bitbucket-approve bitbucket-build-status-notifier perforce mercurial subversion tfs accurev cvs teamconcert clone-workspace-scm multiple-scms ws-cleanup
# Install Static Anlysis Plugins
RUN /usr/local/bin/install-plugins.sh checkstyle pmd findbugs tasks
# Install Build Plugins
RUN /usr/local/bin/install-plugins.sh ant maven gradle nodejs nant groovy purge-build-queue-plugin build-timeout rebuild global-build-stats build-metrics
# Install Test Plugins
RUN /usr/local/bin/install-plugins.sh jacoco cobertura emma test-results-analyzer test-stability analysis-collector build-failure-analyzer dependency-check-jenkins-plugin nunit ncover 
# Artifact Uploaders Plugins
RUN /usr/local/bin/install-plugins.sh artifactory nexus-artifact-uploader publish-over-ssh publish-over-dropbox 
# Install Cloud Plugins
RUN /usr/local/bin/install-plugins.sh nomad kubernetes amazon-ecs scalable-amazon-ecs azure-vm-agents openstack-cloud mesos
# Install Slaves Plugins
RUN /usr/local/bin/install-plugins.sh swarm ssh-slaves windows-slaves
# Install Authentication Plugins
RUN /usr/local/bin/install-plugins.sh github-oauth gitlab-oauth google-login gravatar kerberos-sso ldap ldapemail
# Install Misc Plugins
RUN /usr/local/bin/install-plugins.sh disk-usage timestamper greenballs ci-game emotional-jenkins-plugin uno-choice logstash splunk-devops performance
# Install Job Config Plugins
RUN /usr/local/bin/install-plugins.sh job-dsl workflow-aggregator jobConfigHistory postbuild-task

# Init scripts
COPY groovy_scripts/*.groovy /usr/share/jenkins/ref/init.groovy.d/

# Copy default jobs, please check README.md to know how to add your own jobs
COPY jobs /usr/share/jenkins/ref/jobs

# Change owner of keys and disable initial wizard
RUN echo lts > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state && \
    echo lts > /usr/share/jenkins/ref/jenkins.install.InstallUtil.lastExecVersion
