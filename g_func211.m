function [g] = g_func211(k, d, eps, xf, xl)
    beta = xl-xf;
    dist = norm(beta);
    if dist <= d
        g = k*beta;
    elseif dist <= (d+eps)
        g = beta*(3*dist^3 - 14*dist^2 + 20*dist - 8)/dist;
    else
        g = [0 0];
    end
end