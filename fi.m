function fi = fi(t,k)

if k == 1
    fi = 1/2;    
else if mod(k,2) == 0 
    fi = 1/sqrt(2)*sin(k/2*pi*t/2);
    else
        fi = 1/sqrt(2)*cos((k-1)/2*pi*t/2);
    end
end

end
