function [R, llh] = expectation_FixedMuAndW(X, model,mu,w)

%%
%%%%%%%%% ger parameters of model %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% mu = model.mu;
Sigma = model.Sigma;
% w = model.weight;

%%
n = size(X,2);
k = size(mu,2);
logRho = zeros(n,k);

%%
for i = 1:k
    logRho(:,i) = loggausspdf(X,mu(:,i),Sigma(:,:,i));
end
logRho = bsxfun(@plus,logRho,log(w));
T = logsumexp(logRho,2);
llh = sum(T)/n; % loglikelihood
logR = bsxfun(@minus,logRho,T);
R = exp(logR);
