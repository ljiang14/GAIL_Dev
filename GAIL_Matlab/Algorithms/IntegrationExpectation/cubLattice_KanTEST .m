%% 1 Function and 2 CVs 
w.func = @(x)[10*x(:,1)-5*x(:,2).^2+1*x(:,3).^3, x(:,1), x(:,2).^2];
w.cv = [8,32/3]; hyperbox= [zeros(1,3);2*ones(1,3)];
q = cubLattice_CLT(w,hyperbox,'uniform',1e-6,0,1,2); 

%% 2 Functions and 0 CVs
f = @(x)[sin(x),cos(x)-sin(1)+1-cos(1)]; hyperbox = [0;1];
q = cubLattice_CLT(f,hyperbox,'uniform',1e-3,1e-2,'transform','C1');

%% 2 Functions and 2 CVs
w.func=@(x)[sin(x),cos(x)-sin(1)+1-cos(1) ,x-1/2,x.^2-1/3]
w.cv = [0,0]; hyperbox= [0;1];
q = cubLattice_CLT(w,hyperbox,'uniform',1e-6,0, 2, 2);

%% 1 Function and 2 CVs 
w.func=@(x)[sin(x), x-1/2,x.^2-1/3]
w.cv = [0,0]; hyperbox= [0;1];
q = cubLattice_CLT(w,hyperbox,'uniform',1e-6,0, 1, 2);

%% 2 Functions and 4 CVs
w.func=@(x)[sin(x),cos(x)-sin(1)+1-cos(1) ,x-1/2,x.^2-1/3, x.^3-0.25, x.^4-0.2]
w.cv = [0,0,0,0]; hyperbox= [0;1];
q = cubLattice_CLT(w,hyperbox,'uniform',1e-6,0, 2, 4);

%% 3 Functions and 2 CVs
w.func=@(x)[sin(x),cos(x)-sin(1)+1-cos(1), cos(x)-sin(1)+1-cos(1), x-1/2,x.^2-1/3]
w.cv = [0,0]; hyperbox= [0;1];
q = cubLattice_CLT(w,hyperbox,'uniform',1e-6,0, 3, 2);

%% Multi-dimensional (Using Keister's equation) 
%initialize the workspace and the display parameters
normsqd = @(t) sum(t.*t,2); %squared l_2 norm of t
f1 = @(normt,a,d) ((2*pi*a^2).^(d/2)) * cos(a*sqrt(normt)) ...
    .* exp((1/2-a^2)*normt);
f = @(t,a,d) f1(normsqd(t),a,d);
abstol = 0; %absolute error tolerance
reltol = 0.01; %relative error tolerance
dvec = 1:2; %vector of dimensions
a = 1 %default value of a
IMCvec = zeros(size(dvec)); %vector of answers
 
w.func=@(t)[f(t(:,1), 1,2),f(t(:,2),1/sqrt(2),2),f(t(:,1),1/sqrt(1.5),2),f(t(:,2),1/sqrt(3),2)]
w.cv = [1.8055,1.8055];
hyperbox= [0 0;1 1];
q = cubLattice_CLT(w,hyperbox,'uniform',1e-6,0, 2, 2); 
