import jenkins.*;
import jenkins.model.*;
import jenkins.plugins.git.*;
import org.jenkinsci.plugins.workflow.cps.global.*;
import org.jenkinsci.plugins.workflow.libs.*;

// Get Jenkins instance
def instance = Jenkins.getInstance();

// Configure Global Pipeline Libraries
GitSCMSource gitSource = new GitSCMSource("https://github.com/cn-cicd/jenkins-pipeline-library.git");
SCMSourceRetriever scmRetriever = new SCMSourceRetriever(gitSource);
List<LibraryConfiguration> libraries = []
LibraryConfiguration libraryConfig = new LibraryConfiguration("jenkins-pipeline-library", scmRetriever);
libraryConfig.setDefaultVersion("master");
libraryConfig.setImplicit(false);
libraryConfig.setAllowVersionOverride(true);
libraries.add(libraryConfig);
GlobalLibraries globalLibraries = GlobalLibraries.get();
globalLibraries.setLibraries(libraries);
instance.save();