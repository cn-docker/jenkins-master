FROM jenkins/jenkins:lts-alpine
MAINTAINER Julian Nonino <noninojulian@outlook.com>

# Install View Plugins
RUN /usr/local/bin/install-plugins.sh radiatorviewplugin:1.29 nested-view:1.14 dashboard-view:2.9.11
# Install Job Config Plugins
RUN /usr/local/bin/install-plugins.sh job-dsl:1.63 jobConfigHistory:2.16 workflow-step-api:2.11 workflow-job:2.12.1 workflow-aggregator:2.5 postbuild-task:1.8
# Install SCM Plugins
RUN /usr/local/bin/install-plugins.sh git:3.3.0 clone-workspace-scm:0.6 multiple-scms:0.6 ws-cleanup:0.33
# Install Static Anlysis Plugins
RUN /usr/local/bin/install-plugins.sh checkstyle:3.48 pmd:3.48 findbugs:4.70 tasks:4.51
# Install Build Plugins
RUN /usr/local/bin/install-plugins.sh maven:2.15.1 gradle:1.27 purge-build-queue-plugin:1.0 build-timeout:1.18 rebuild:1.25 global-build-stats:1.4 build-metrics:1.3
# Install Test Plugins
RUN /usr/local/bin/install-plugins.sh jacoco:2.2.1 cobertura:1.10 test-results-analyzer:0.3.4 test-stability:2.2
# Install Misc Plugins
RUN /usr/local/bin/install-plugins.sh nomad:0.4 disk-usage:0.28 timestamper:1.8.8 greenballs:1.15 ci-game:1.26 emotional-jenkins-plugin:1.2

# Copy default jobs, please check README.md to know how to add your own jobs
COPY jobs /usr/share/jenkins/ref/jobs

# Configure some stuff by default
COPY custom.groovy /usr/share/jenkins/ref/init.groovy.d/

# Change owner of keys and disable initial wizard
RUN echo lts > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state && \
    echo lts > /usr/share/jenkins/ref/jenkins.install.InstallUtil.lastExecVersion