import jenkins.*;
import jenkins.model.*;

// Get Jenkins instance
def instance = Jenkins.getInstance();

// Remove all executors in master node.
instance.setNumExecutors(0);
instance.save();