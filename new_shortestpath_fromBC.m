function [durationShortestPaths] = new_shortestpath_fromBC(my_network)
% ------------------- Function by Shukti Jan 2023 -------------------------
%% Calculate the shortest path length between all nodes in a dynamic network.
%
% Inputs:
%       my_network = nNodes x nNodes x nTimes
%       contactSequence = nEdges x 3 array of (i,j,t) tuples indicating
%           contact between nodes i,j at time t.
%
% Outputs:
%       durationShortestPath = nNodes x nNodes matrix recording the
%           duration of the shortest path from node i to node j in entry
%           ij.
%
% Reference: Ann E. Sizemore and Danielle S. Bassett, "Dynamic Graph 
% Metrics: Tutorial, Toolbox, and Tale." Submitted. (2017)
%
% Main function:

% betweenness centrality
% First section based on betweenness_bin from the Brain connectivity
% toolbox (Complex network measures of brain connectivity: Uses and 
% interpretations. Rubinov M, Sporns O (2010) NeuroImage 52:1059-69.)

adjArray = my_network;

npoints = size(adjArray,3);
nNodes = size(adjArray,1);
durationShortestPaths = zeros(nNodes);


nPathsDurationt = sum(adjArray,3);
nFastestPathsDurationt = nPathsDurationt;
nFastestPaths = nFastestPathsDurationt;
nFastestPaths(logical(eye(nNodes))) = 1;
durationShortestPaths(nPathsDurationt~=0) = 1;
durationShortestPaths(logical(eye(nNodes))) = 1;

startingInfo = zeros(nNodes,nNodes,npoints);


% Note: we assume time steps are 1:nPoints 

for t = 2:npoints
    
    tArray = zeros(nNodes,nNodes,npoints-t+1);
    
    for p = 1:size(tArray,3)
        
        tArray(:,:,p) = adjArray(:,:,p);
        for j = p+1:p+t-1
            
            tArray(:,:,p) = tArray(:,:,p)*adjArray(:,:,j)+ (tArray(:,:,p)>0);
        end
        
        tArraySlice = tArray(:,:,p);
        startingInfoSlice = startingInfo(:,:,p);
        
        startingInfoSlice(nFastestPaths==0) = tArraySlice(nFastestPaths==0);
        startingInfo(:,:,p) = startingInfoSlice;
        
    end
    
      
    % need to update shortest path matrix
    nPathsDurationt = sum(tArray,3);
    nFastestPathsDurationt(nFastestPaths==0) = ...
        nPathsDurationt(nFastestPaths==0);
    newPathind = nFastestPathsDurationt;
    newPathind(newPathind>0) = 1;
    durationShortestPaths(nFastestPaths==0) = t*newPathind(nFastestPaths==0);
    
    % update fastest paths
    nFastestPaths(nFastestPaths==0) = ...
        nFastestPathsDurationt(nFastestPaths==0);        
    
    
end


disp('part 1: duration shortest paths done'); %----- imp added, update January 2023 ------
% Prepare to find path members

durationShortestPaths(~durationShortestPaths) = inf;
durationShortestPaths(logical(eye(nNodes))) = 0;


end

