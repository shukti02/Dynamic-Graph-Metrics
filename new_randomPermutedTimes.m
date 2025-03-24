function [ rand_network ] = new_randomPermutedTimes(my_network)
% randomPermutedTimes returns a randomized dynamic network from the input
% contact sequence by randomly permuting the times of each contact.
%
% Input:
%       NEED TO FIX STILL - Sept 2020
%       contactSequence = nEdges x 3 matrix encoding contacts between node
%           i,j at time t by (i,j,t). 
%
% Output:
%       rand_contactSequence = contact sequence of randomized input data. 
%
%
%
% Reference: Ann E. Sizemore and Danielle S. Bassett, "Dynamic Graph 
% Metrics: Tutorial, Toolbox, and Tale." Submitted. (2017)
%
% Main function:

% ---------- need to make it symmetric Oct 2020---------
res_network = reshape(my_network,[size(my_network,1)*size(my_network,2),...
    size(my_network,3)]);
all_conn = my_network(:);
new_conn = randsample(length(all_conn),length(all_conn));
rand_network = all_conn(new_conn);
rand_network = reshape(rand_network,size(my_network));

%rand_network(:,3) = rand_network(newOrder,3);


end

