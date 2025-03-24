function [C,C_vec, L_mat,L,BC] = new_temporalSmallWorldness(my_network,...
    directed,nNodes)
% temporalSmallWorldness returns values needed to compute the temporal
% small worldness of a dynamic network. 
%
% Inputs:
%       my_network : full matrix, diagonal 0, binary
%       contactSequence = nEdges x 3 matrix encoding contacts between node
%           i,j at time t by (i,j,t). 
%       directed = 1 if the dynamic network is directed, 0 otherwise.
%
% Optional Inputs:
%       nNodes = number of nodes in the dynamic network. Default is all
%           nodes which appear in contactSequence (have at least one
%           contact).
%
% Outputs:
%       C = temporal correlation of input dynamic network
%       L = efficientcy of dynamic network
%       %----- imp: added L_mat o/p Sep2020
%       L_mat = temporal duration/latency - eqvt to path length
%       C_vec = temp corr of each node
%       BC = betweenness centrality of each node
%
%
%
% Reference: Ann E. Sizemore and Danielle S. Bassett, "Dynamic Graph 
% Metrics: Tutorial, Toolbox, and Tale." Submitted. (2017)
%
% Main function:


if ~exist('nNodes','var') || isempty(nNodes)
    nNodes = size(my_network,1);
end

%--- imp added C_vec Sep20 -----
[C,C_vec] = my_temporalCorrelation(my_network,directed); 

% compute efficiency
%--- imp added BC Sep20 -----
[BC,L_mat,~] = my_betweennessCentrality(my_network,directed);

L_mat(isinf(L_mat)) = 0; %--------------- disconnected nodes Oct20 -------
L = (1/(nNodes*(nNodes-1)))*sum(L_mat(:));



end

