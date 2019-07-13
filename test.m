n = 10; % number of nodes (APs)
d = 2; % dimension, tested only for 2
scale = 50; % considering a scale*scale m.sq. area
n_del = 0:5:20; % #of missing entries in EDM 
m_error = 1:1:3; % distance measurement error
errorType = 'Meters'; % distance measurement error can be either in 'Meter', or in 'Percentage' (percentage of original distance) 
n_config = 100; % # of test runs 
algorithm = 'Alternating Descent'; % algorithm used to complete the EDM. Can be either 'Alternating Descent' or 'Rank Alteration'


% GetRecoveryError returns mean distance recovery error for the EDM
% completion algorithm
[DELTA] = GetRecoveryError(n,d,scale,...
    n_del,m_error,n_config,algorithm,errorType);


% Plot #of missing entries in EDM  vs distance recovery error for different
% distance measurement errors
plot(n_del,DELTA,'LineWidth', 1);
ylabel('Recovery Error (R)', 'fontsize', 16);
xlabel('# of  Missing Distances (M)', 'fontsize', 16);
set(gca,'xtick',n_del);
leg = string.empty(0,numel(m_error));
for i_err = 1:numel(m_error)
    leg(i_err) = strcat('measurement error = ', num2str(m_error(i_err)));
end
legend(leg, 'Location','NorthWest', 'fontsize', 14);
grid('on');
title(['Number of nodes = ',num2str(n)], 'fontsize', 16);