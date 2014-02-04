%GENZ_TEST_FUN  A suite of test functions from Alan Genz and Keister that
%contains seven multidimensional integrands. The test function accepts six
%inputs and give the output of the function values.
%
% The first argument is x, which is the random variable, x should be a
% matrix of size n x d. n is the sample size, d is the dimension.
% The second argument is index, which identifies a test function to use.
% The third argument is the dimension of the integrand.
% The fourth argument is the parameter alpha.
% The fifth argument is the parameter beta.
% The sixth argument is the paramter r.
%
% Sources: 
% TESTPACK, http://people.sc.fsu.edu/~jburkardt/m_src/testpack/testpack.html
% 
function f_val = genz_test_fun (x,index,dim,alpha,beta,r)

switch index
  case 1 % Genz "Oscillatory"
    f_val = cos (2.0 * pi * r + sum (x(:,1:dim).*...
      repmat(alpha(1:dim),size(x,1),1),2));
  case 2; % Genz "Product Peak";
    f_val = 1./prod(repmat(alpha(1:dim),size(x,1),1).^2+...
      (x(:,1:dim)-repmat(beta(1:dim),size(x,1),1)).^2,2);
  case 3 % Genz "Corner Peak"
    f_val = 1./(1+sum(repmat(alpha(1:dim),size(x,1),1).*x(:,1:dim),2))...
      .^(dim+r);
  case 4 % Genz "Gaussian"
    f_val = exp(-sum(repmat(alpha(1:dim),size(x,1),1).^2.*...
      (x(:,1:dim)-repmat(beta(1:dim),size(x,1),1)).^2,2));
  case 5 % Genz "Continuous"
    f_val = exp(-sum(repmat(alpha(1:dim),size(x,1),1).*...
      abs(x(:,1:dim)-repmat(beta(1:dim),size(x,1),1)),2));
  case 6 % Genz "Discontinuous"
    f_val = nan(size(x,1),1);
    for i = 1: size(x,1)
      if ( any ( beta(1:dim) < x(i,1:dim) ))
        f_val(i) = 0;
      else
        f_val(i) = exp(sum(alpha(1:dim).*x(i,1:dim),2));
      end
    end
  case 7 % Keister test function
    f_val = cos(sqrt(sum(norminv(x(:,1:dim)).^2/2,2)))*pi/2;
end
end