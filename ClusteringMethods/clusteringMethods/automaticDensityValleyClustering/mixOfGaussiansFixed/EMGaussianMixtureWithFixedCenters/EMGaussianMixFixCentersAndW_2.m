   function [label, model, llh] = EMGaussianMixFixCentersAndW_2(X, mu,fixedW,makeplot)
% Perform EM algorithm for fitting the Gaussian mixture model.
%   X: d x n data matrix
%   init: k (1 x 1) or label (1 x n, 1<=label(i)<=k) or center (d x k)
% Written by Michael Chen (sth4nth@gmail.com).

%%
% %%%%%%%%%%%%% test function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% mu = clusterCenters';
% X = dataThisDataSetRand';
% makeplot = 1;
% 

%%
%%%%%%%%%%%%%%% initialization %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf('EM for Gaussian mixture: running ... \n');
R = initialization(X,mu);
[~,label(1,:)] = max(R,[],2);
R = R(:,unique(label));

tol = 1e-10;%threshold that devines that convergence occured
maxiter = 500;%maximum number of iterations
llh = -inf(1,maxiter);
converged = false;
t = 1;%counter

%%
%%%%%%%%%%%% loop to do maximization and expectation %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

while ~converged && t < maxiter%continue until 500 iterations or converged
    t = t+1;
    
    %%
    %%%%%%%%%%%%%% do maximization %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %do maximization with nothing fixed
    if isempty(mu)
    
    model = maximization(X,R);
    
    end
    
    %do maximazation with fixed centers
    if ~isempty(mu) && isempty(fixedW)

    model = maximization_fixedMu(X, R,mu);
    
    end
    
    %do maximazation with fixed centers and fixed wheights
    if ~isempty(mu) && ~isempty(fixedW)
        
    model = maximization_fixedMuAndW(X, R,mu,fixedW);
        
    end
    
    %%
    %%%%%%%%%%%%%%% do expectation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %do maximization
    if isempty(mu)
    [R, llh(t)] = expectation(X,model);
    end
    
    if ~isempty(mu) && isempty(fixedW)
        
         [R, llh(t)] = expectation(X,model);
   
    end
    
    if ~isempty(mu) && ~isempty(fixedW)
        
    [R, llh(t)] = expectation_FixedMuAndW(X, model,mu,fixedW);
    
    end
   %%
    %%%%%%%%%%%% calcualte log likehood abd check if it converged %%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    [~,label(:)] = max(R,[],2);
    u = unique(label);   % non-empty components
    
    if size(R,2) ~= size(u,2)
        R = R(:,u);   % remove empty components
    else
        
        %determine iof convergence occured
        converged = llh(t)-llh(t-1) < tol*abs(llh(t));
    end

    %%
    %%%%%%%%%%%%%% make plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
if makeplot == 1
    clf
    uniqueLabel = unique(label);
col = jet(length(uniqueLabel));

for n = 1 : length(uniqueLabel)
    
  indThisCluster = find(label == uniqueLabel(n));
  
  
  
  plot(X(1,indThisCluster),X(2,indThisCluster), '.', 'color', col(n,:))
  axis square  
    hold on
    
   
    
end

mu = model.mu;
 plot(mu(1,:),mu(2,:), 'o', 'color', 'red')
  axis square  
    hold on
    
 title(t)
 pause(0.2)
end   
    
end

%output of log likelihood balue
llh = llh(2:t);
if converged
    fprintf('Converged in %d steps.\n',t-1);
else
    fprintf('Not converged in %d steps.\n',maxiter);
end




