FROM jenkins/jenkins:lts-alpine
MAINTAINER Julian Nonino <noninojulian@outlook.com>

# Install Pipeline plugins
RUN /usr/local/bin/install-plugins.sh blueocean
# Install View Plugins
RUN /usr/local/bin/install-plugins.sh radiatorviewplugin nested-view dashboard-view
# Install Job Config Plugins
RUN /usr/local/bin/install-plugins.sh job-dsl jobConfigHistory workflow-step-api workflow-job workflow-aggregator postbuild-task
# Install SCM Plugins
RUN /usr/local/bin/install-plugins.sh git clone-workspace-scm multiple-scms ws-cleanup
# Install Static Anlysis Plugins
RUN /usr/local/bin/install-plugins.sh checkstyle pmd findbugs tasks
# Install Build Plugins
RUN /usr/local/bin/install-plugins.sh maven gradle purge-build-queue-plugin build-timeout rebuild global-build-stats build-metrics
# Install Test Plugins
RUN /usr/local/bin/install-plugins.sh jacoco cobertura test-results-analyzer test-stability
# Install Misc Plugins
RUN /usr/local/bin/install-plugins.sh nomad disk-usage timestamper greenballs ci-game emotional-jenkins-plugin

# Copy default jobs, please check README.md to know how to add your own jobs
COPY jobs /usr/share/jenkins/ref/jobs

# Configure some stuff by default
COPY custom.groovy /usr/share/jenkins/ref/init.groovy.d/

# Change owner of keys and disable initial wizard
RUN echo lts > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state && \
    echo lts > /usr/share/jenkins/ref/jenkins.install.InstallUtil.lastExecVersion