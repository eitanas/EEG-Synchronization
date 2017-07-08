function M_mean = getElectrodesAverageMatrix(M)

[n,m] = size(M);
 j_idx=1;
 i_idx =1;
 M_mean = zeros(30);
 
 for i=1:6:n+1-6    
     for j=1:6:n+1-6
        
         curr = M(i:i+5,j:j+5);
         curr = reshape(curr,1,36);
         M_mean(i_idx,j_idx) = mean(curr);
         j_idx = j_idx + 1;
     end
     i_idx = i_idx + 1;
     j_idx=1;
     
 end
end