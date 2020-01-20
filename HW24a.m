clc
clear all

k = 1;
d = 1;
eps = 1;
T = 4;

x_exit = [5 0];
xf_0 = [1; 2]; %follower start
xl_0 = [2; 2]; %leader start

q=1

for N=[5 6 7 8]
    u_matrix = zeros(1, 2*(N+1));
    xf_matrix = zeros(1, 2*(N+1)); %matrix for all positions for follower
    xl_matrix = zeros(1, 2*(N+1)); %matrix for all positions for leader
%     for i=1:N+1
%         xf_matrix(2*i-1:2*i) = xf_0;
%         xl_matrix(2*i-1:2*i) = [2; 2];
%     end
%    
%     for i=1:N+1
%         xf = xf_0' + (i-1)/N*(x_exit - xf_0');
%         xf_matrix(2*i-1:2*i) = xf;
%         if i <= N/2+1
%             xl = xl_0' + 2*(i-1)/N*([2 3] - xl_0');
%             xl_matrix(2*i-1:2*i) = xl;
%         else
%             xl = xf_0' + 2*(i-1-N/2)/N*(x_exit - [2 3]);
%             xl_matrix(2*i-1:2*i) = xl;            
%         end
% 	end
    for i=1:N+1
        xf = xf_0' + (i-1)/N*(x_exit - xf_0');
        xl = xl_0' + (i-1)/N*(x_exit - xl_0');
        xf_matrix(2*i-1:2*i) = xf;
        xl_matrix(2*i-1:2*i) = xl;
    end
%     else
%     xf_matrix(1:2) = xf_0;
%     xl_matrix(1:2) = xl_0;
%     xf_matrix(end-1:end) = [0 5];
%     xl_matrix(end-1:end) = [0 5];    
%     
%     end
    x = [u_matrix xf_matrix, xl_matrix]';
    h = T/N; %length of time step
   

    Aeq = zeros((N+1)*6, 6)';
    Aeq(:,2*(N+1)+1)=[1;0;0;0;0;0];
    Aeq(:,2*(N+1)+2)=[0;1;0;0;0;0];
    Aeq(:,4*(N+1)+1)=[0;0;1;0;0;0];
    Aeq(:,4*(N+1)+2)=[0;0;0;1;0;0];
    Aeq(:,4*(N+1)-1)=[0;0;0;0;1;0];
    Aeq(:,4*(N+1))=[0;0;0;0;0;1];
    Beq=[xf_0; xl_0; x_exit'];

    FUN = @(x)opt_min211(x,x_exit,N,h);
    NONLCON = @(x)nonl2114(x,N,h,k,d,eps);
    X = fmincon(FUN,x,[],[],Aeq,Beq,[],[],NONLCON);

    X
    mini = opt_min211(X,x_exit,N,h)

    follower = zeros(N+1,2);
    leader = zeros(N+1,2);
    for i=1:(N+1)
        follower(i,:) = [X(2*(N+1)+1+2*(i-1)) X(2*(N+1)+2+2*(i-1))];
        leader(i,:) = [X(4*(N+1)+1+2*(i-1)) X(4*(N+1)+2+2*(i-1))];
    end    
    follower
    leader

    plot(subplot(2,2,q),follower(:,1),follower(:,2), '-*',leader(:,1),leader(:,2), '-o')
    title(['N=',num2str(N),', min=', num2str(mini)])
    axis([1 6 -1 inf])
    legend('follower','leader')
    grid on
    q=q+1
end