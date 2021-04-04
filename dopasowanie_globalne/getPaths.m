function [temp] = getPaths(paths)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% init: paths = zeros(m, n, 3);
% 1 -vertical, 2 -horizontal, 3 -diagonal
%

m=size(paths, 1);
n=size(paths, 2);
i = 4;
paths(:,:,i) = zeros(m, n);
paths(m,n,i) = 1;
branches = zeros(m, n); %values of branches: 100 - vert, 010 - horiz, 001 - diag, 110 - v+h 
count = 0;
c=0;
for j = m:-1:1
    for k = n:-1:1
        if paths(j, k , i)==1
            
            if paths(j, k , 1)==1
                paths(j-1, k, i) = 1;
                c = c+100;
            end
            if paths(j, k , 2)==1
                paths(j, k-1, i) = 1;
                c = c+10;
            end
            if paths(j, k , 3)==1
                paths(j-1, k-1, i) = 1;
                c = c+1;
            end
            
            if c>1
                count = count+1;
                branches(j,k) = c;
            end
            
            c=0;
        end
    end
end

if count == 0
    temp = paths(:,:, 4);
else
    i=1;
    temp = zeros(m,n, count*2);
    temp(m, n, :) = 1;
    branch = false;
    
    
    while 1
        
        if branches(m, n)>1
            branch = true;
        end
        
        if paths(m-1, n-1, 4) ==1
            temp(m-1, n-1, i) = 1;
            m = m-1;
            n = n-1;
            if branch
                paths(m, n, 4)=0;
            end
        elseif paths(m-1, n, 4) ==1
            temp(m-1, n, i) = 1;
            m = m-1;
            if branch
                paths(m, n, 4)=0;
            end
        elseif paths(m, n-1, 4) ==1
            temp(m, n-1, i) = 1;
            n = n-1;
            if branch
                paths(m, n, 4)=0;
            end
        end
        
        if (m==1 && n==1)
            if (i<size(temp,3))
                i = i+1;
                m=size(paths, 1);
                n=size(paths, 2);
            elseif i==size(temp,3)
                break;
            end
        end
        
        branch = false;
        
    end
    
end

end

