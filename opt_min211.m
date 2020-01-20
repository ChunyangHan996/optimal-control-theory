function m = opt_min211(x,x_exit,N,h)

sum = 0;

for i = 1:N
    ind = h*norm([x(i*2-1) x(i*2)])^2;
    sum = sum + ind;
end

m = norm([x(4*(N+1)-1); x(4*(N+1))]'-x_exit)^2 + sum;

end
