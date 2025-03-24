function [ contactSequence ] = new_arrayToContactSeq(my_network)
% arrayToContactSeq takes a sequence of matrices and converts this to a
% long format contact sequence.
%
% Inputs:
%       adjArray = an nNodes x nNodes x time-points array encoding a
%           dynamic network
%       isdirected = boolean indicating if the network is directed
%
% Output:
%       contactSequence = nEdges x 3 array of (i,j,t) tuples indicating
%           contact between nodes i,j at time t. If adjArray is weighted,
%           this will be an nEdges x 4 array of (i,j,t,w) including the
%           edge weight w.
%
% Reference: Ann E. Sizemore and Danielle S. Bassett, "Dynamic Graph 
% Metrics: Tutorial, Toolbox, and Tale." Submitted. (2017)
%
% Main function
rows = size(my_network,1);
cols = size(my_network,2);
%times = size(my_network,3);

vals = find(my_network);
contactSequence = zeros(length(vals),3);

t = ceil(vals/(rows*cols));
contactSequence(:,3) = t;

rc = vals - (t-1)*(rows*cols);
j = ceil(rc/cols);
contactSequence(:,1) = j;

i = rc - (j-1)*rows;
contactSequence(:,2) = i;
end

