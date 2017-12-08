import jenkins.*;
import jenkins.model.*;

// Get Jenkins instance
def instance = Jenkins.getInstance();

// Set slave port to fixed number 50000
instance.setSlaveAgentPort(50000)
instance.save();

// Remove deprecated agent protocols
Set<String> agentProtocolsList = ['JNLP4-connect', 'Ping'];
instance.setAgentProtocols(agentProtocolsList);
instance.save();