function [ S ] = new_setOfInfluence( node_i, my_network,  directed, ...
    t_i,t_end,contactTimes, nNodes)
% Determine the set of influence of a node (the set of nodes which can be 
% reached from node i via a time-respecting paths beginning at time t 
% or later).
%
% Inputs:
%       my_network = nNodes x nNodes x nTimes
%       node_i = node of interest
%       contactSequence = nEdges x 3 array of (i,j,t) tuples indicating
%           contact between nodes i,j at time t.
%       directed = 1 if network is directed, 0 if undirected.
%
% Optional Inputs:
%       t_i = time t at which to begin recording connectivity. Default is
%           the time of first contact or min(contactTimes).
%       t_end = tme at which to end calculation. Default is inf.
%       contactTimes = ascending vector of all possible contact times. Ex.
%           1:20. Default assumes all possible times exist in
%           contactSequence.
%       nNodes = number of nodes total in dynamic network. Default assumes 
%           all nodes are present in contactSequence.
%
% Output:
%       S = set of Influence vector for node i
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
if ~exist('t_i','var') || isempty(t_i)
    t_i = min(contactTimes);
end
if ~exist('t_end','var') || isempty(t_end)
    t_end = max(contactTimes);
end



% find nodes which can be reached from nodei
    
% contactSequence(contactSequence(:,3) <t_i,:) = [];
% contactSequence(contactSequence(:,3) >t_end,:) = [];

%my_network_i = my_network(:,:,t_i:t_end);

%try
reachabilityArray = my_makeReachabilityArray(my_network,directed,...
    contactTimes(contactTimes>=t_i & contactTimes<=t_end),nNodes);
%catch
%    disp(strcat('t_i is',num2str(t_i),'and t_end is',num2str(t_end)));
%end


S = find(reachabilityArray(node_i,:,end));




end

