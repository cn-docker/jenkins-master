import jenkins.*;
import jenkins.model.*;
import hudson.*;
import hudson.model.*;  
import hudson.security.*
import hudson.security.captcha.CaptchaSupport
import hudson.security.csrf.DefaultCrumbIssuer;
import jenkins.security.s2m.AdminWhitelistRule

// Get Jenkins instance
def instance = Jenkins.getInstance();

// Disable Remote Access CLI
instance.getDescriptor("jenkins.CLI").get().setEnabled(false);
instance.save();

//Enable CSRF Protection
instance.setCrumbIssuer(new DefaultCrumbIssuer(true));
instance.save();

// Set security
boolean allowsSignup = true;
boolean enableCaptcha = false;
CaptchaSupport captchaSupport = null;
def hudsonRealm = new HudsonPrivateSecurityRealm(allowsSignup, enableCaptcha, captchaSupport);
hudsonRealm.createAccount("admin","admin");
instance.setSecurityRealm(hudsonRealm);
def strategy = new FullControlOnceLoggedInAuthorizationStrategy();
strategy.setAllowAnonymousRead(true);
instance.setAuthorizationStrategy(strategy);
instance.save();

// Enable the access control mechanism
instance.getInjector().getInstance(AdminWhitelistRule.class).setMasterKillSwitch(false);
instance.save();