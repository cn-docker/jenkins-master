// Remove all executors in master node.
Jenkins.instance.setNumExecutors(0)

// Establish unsecured Jenkins
Jenkins.instance.setAuthorizationStrategy(AuthorizationStrategy.UNSECURED)

// Disable security
Jenkins.instance.setSecurityRealm(SecurityRealm.NO_AUTHENTICATION)