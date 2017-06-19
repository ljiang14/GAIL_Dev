function [hmu,mean_out] = meanMC_CLT(varargin)
%MEANMC_CLT Monte Carlo method to estimate the mean of a random variable
%
%   tmu = MEANMC_CLT(Yrand,absTol,relTol,alpha,nSig,inflate) estimates the
%   mean, mu, of a random variable Y to within a specified error tolerance,
%   i.e., | mu - tmu | <= max(absTol,relTol|mu|) with probability at least
%   1-alpha, where abstol is the absolute error tolerance.  The default
%   values are abstol=1e-2 and alpha=1%. Input Yrand is a function handle
%   that accepts a positive integer input n and returns an n x 1 vector of
%   IID instances of the random variable Y.
%
%   Input Arguments
%
%     Yrand --- the function for generating n IID instances of a random
%     variable Y whose mean we want to estimate. Y is often defined as a
%     function of some random variable X with a simple distribution. The
%     input of Yrand should be the number of random variables n, the output
%     of Yrand should be n function values. For example, if Y = X.^2 where X
%     is a standard uniform random variable, then one may define Yrand =
%     @(n) rand(n,1).^2.
%
%     absTol --- the absolute error tolerance, which should be
%     non-negative --- default = 1e-2
%
%     relTol --- the relative error tolerance, which should be
%     non-negative and no greater than 1 --- default = 0
%
%     alpha --- the uncertainty, which should be a small positive
%     percentage --- default = 1%
%
%     nSig --- the number of samples used to compute the sample variance
%     --- default = 1000
%
%     inflate --- the standard deviation inflation factor --- default = 1.2
%
%   Output Arguments
%
%     hmu --- the estimated mean of Y.
%
%     mean_out.ntot --- total sample used.
%
%     mean_out.sig --- the sample standard deviation.
%
%     mean_out.time --- the time elapsed in seconds.
%
%
% >> [mu,out] = meanMC_CLT(@(n) rand(n,1).^2, 0.001)
% mu =
%     0.33***
% out = 
%   meanYOut with properties:
% 
%           mu: 0.33***
%          std: 0.***
%            Y: @(n)rand(n,1).^2
%        alpha: 0.0100
%         nSig: 1000
%      inflate: 1.2000
%         nMax: 100000000
%       absTol: 1.0000e-03
%       relTol: 0
%       solFun: @(mu)mu
%     solBdFun: @(muhat,errbd)[muhat-errbd,muhat+errbd]
%      nSample: ***
%         time: ***
%
%

% This is a heuristic algorithm based on a Central Limit Theorem
% approximation

mean_inp = gail.meanYParam(varargin{:});
mean_out = gail.meanYOut(mean_inp);
tstart = tic; %start the clock
Yval = mean_out.Y(mean_out.nSig); %get samples to estimate variance 
mean_out.std = std(Yval); %calculate the sample standard deviation
sig0up = mean_out.inflate .* mean_out.std; %upper bound on the standard deviation
hmu0 = mean(Yval);
nmu = max(1,ceil((-gail.stdnorminv(mean_out.alpha/2)*sig0up ...
   /max(mean_out.absTol,mean_out.relTol*abs(hmu0))).^2)); 
   %number of samples needed for mean
if nmu > mean_out.nMax %don't exceed sample budget
   warning(['The algorithm wants to use nmu = ' int2str(nmu) ...
      ', which is too big. Using ' int2str(mean_out.nMax) ' instead.']) 
   nmu = mean_out.nMax;
end
hmu = mean(mean_out.Y(nmu)); %estimated mean
mean_out.mu = hmu;
mean_out.nSample = mean_out.nSig+nmu; %total samples required
mean_out.time = toc(tstart); %elapsed time
end

