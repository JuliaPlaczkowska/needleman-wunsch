function [temp] = getPath(paths)
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

for j = m:-1:1
    for k = n:-1:1
        if paths(j, k , i)==1
            
            if paths(j, k , 1)==1
                paths(j-1, k, i) = 1;
            elseif paths(j, k , 2)==1
                paths(j, k-1, i) = 1;
            elseif paths(j, k , 3)==1
                paths(j-1, k-1, i) = 1;
            end
            
        end
    end
end

    temp = paths(:,:, 4);

end


