function [ reachabilityArray ] = new_makeReachabilityArray(my_network,...
    directed,contactTimes,nNodes)
% Create an array encoding time-respecting paths between nodes
%
% Inputs:
%       network = nNodes x nNodes x nTimes
%       contactSequence = nEdges x 3 array of (i,j,t) tuples indicating
%           contact between nodes i,j at time t.
%       directed = 1 if network is directed, 0 if undirected.
% Optional Inputs:
%       contactTimes = ascending vector of all possible contact times. Ex.
%           1:20. Default assumes all possible times exist in
%           contactSequence.
%       nNodes = number of nodes total in dynamic network. Default assumes 
%           all nodes are present in contactSequence.
%
% Output:
%       reachabilityArray = nNodes x nNodes x nContactTimes binary array
%           recording if node j can be reached from node i via a 
%           time-respecting path up to that time index.
%       
%
%
% Reference: Ann E. Sizemore and Danielle S. Bassett, "Dynamic Graph 
% Metrics: Tutorial, Toolbox, and Tale." Submitted. (2017)
%
% Main function:

if ~exist('contactTimes','var') || isempty(contactTimes)
    contactTimes = 1:size(my_network,3);
end
if ~exist('nNodes','var') || isempty(nNodes)
    nNodes = size(my_network,1);
end

% Preallocate
reachabilityArray = zeros(nNodes,nNodes,length(contactTimes));


for t = 1:length(contactTimes)
    
    t1 = contactTimes(t);
   
    
    % make binary matrix at this time
    badj = my_reachabilityAtTimeT(my_network,t1,directed,nNodes);
    
    if t == 1
        reachabilityArray(:,:,t) = badj;
    else 
        
    newSlice = reachabilityArray(:,:,(t-1))*badj;
    
    reachabilityArray(:,:,t) = newSlice + badj + ...
        reachabilityArray(:,:,(t-1));
    
    reachabilityArray(reachabilityArray>0) = 1;

    end
    
    
end



end

