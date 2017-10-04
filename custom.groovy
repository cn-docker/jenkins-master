import jenkins.*;
import jenkins.model.*;
import hudson.*;
import hudson.model.*;  
import hudson.security.*
import hudson.security.captcha.CaptchaSupport
import jenkins.plugins.git.*;
import org.jenkinsci.plugins.workflow.cps.global.*;
import org.jenkinsci.plugins.workflow.libs.*;

// Get Jenkins instance
def instance = Jenkins.getInstance();

// Remove all executors in master node.
instance.setNumExecutors(0);

// Configure Global Pipeline Libraries
GitSCMSource gitSource = new GitSCMSource("git@bitbucket.org:jnonino/jenkins-pipeline-library.git");
gitSource.setCredentialsId("git-ssh-key");
SCMSourceRetriever scmRetriever = new SCMSourceRetriever(gitSource);
List<LibraryConfiguration> libraries = []
LibraryConfiguration libraryConfig = new LibraryConfiguration("jenkins-pipeline-library", scmRetriever);
libraryConfig.setDefaultVersion("master");
libraryConfig.setImplicit(false);
libraryConfig.setAllowVersionOverride(true);
libraries.add(libraryConfig);
GlobalLibraries globalLibraries = GlobalLibraries.get();
globalLibraries.setLibraries(libraries);

// Set slave port to fixed number 50000
instance.setSlaveAgentPort(50000)  

// Set security
boolean allowsSignup = true
boolean enableCaptcha = false
CaptchaSupport captchaSupport = null
def hudsonRealm = new HudsonPrivateSecurityRealm(allowsSignup, enableCaptcha, captchaSupport)
hudsonRealm.createAccount("admin","admin")
instance.setSecurityRealm(hudsonRealm)
def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
strategy.setAllowAnonymousRead(true)
instance.setAuthorizationStrategy(strategy)

// Establish unsecured Jenkins
//Jenkins.instance.setAuthorizationStrategy(AuthorizationStrategy.UNSECURED)
// Disable security
//Jenkins.instance.setSecurityRealm(SecurityRealm.NO_AUTHENTICATION)

// Save Instance State
instance.save()
