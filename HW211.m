clc
clear all

k = 1;
d = 1;
eps = 1;
T = 4;

x_exit = [5 0];
xf_0 = [1; 2]; %follower start
xl_0 = [2; 2]; %leader start
N = 10; %number of time steps

u_matrix = zeros(1, 2*(N+1));
xf_matrix = zeros(1, 2*(N+1)); %matrix for all positions for follower
xl_matrix = zeros(1, 2*(N+1)); %matrix for all positions for leader
xf_matrix(1:2) = xf_0;
xl_matrix(1:2) = xl_0;
x = [u_matrix xf_matrix, xl_matrix]';

h = T/N; %length of time step

Aeq = zeros((N+1)*6, 4)';
Aeq(:,2*(N+1)+1)=[1;0;0;0];
Aeq(:,2*(N+1)+2)=[0;1;0;0];
Aeq(:,4*(N+1)+1)=[0;0;1;0];
Aeq(:,4*(N+1)+2)=[0;0;0;1];
Beq=[xf_0; xl_0];


FUN = @(x)opt_min211(x,x_exit,N,h);
NONLCON = @(x)nonl211(x,N,h,k,d,eps);
X = fmincon(FUN,x,[],[],Aeq,Beq,[],[],NONLCON);

X
mini = @(x)opt_min211(X,x_exit,N,h)
mini

follower = zeros(N+1,2);
leader = zeros(N+1,2);
for i=1:(N+1)
    follower(i,:) = [X(2*(N+1)+1+2*(i-1)) X(2*(N+1)+2+2*(i-1))];
    leader(i,:) = [X(4*(N+1)+1+2*(i-1)) X(4*(N+1)+2+2*(i-1))];
end    
follower
leader

plot(follower(:,1),follower(:,2), '-*',leader(:,1),leader(:,2), '-o')
grid on
    
