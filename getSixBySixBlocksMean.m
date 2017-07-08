function M_mean = getSixBySixBlocksMean(M)
n = length(M);
M_mean = zeros(6);
%{
 i_idx=1;
 j_idx=1;
 for i=1:6:n+1-6
     i_idx
     for j=1:6:n+1-6
         j_idx
         curr = M(i:i+5,j:j+5);
         curr = reshape(curr,1,36);
         M_mean(i_idx,j_idx) = mean(curr);
         j_idx = j_idx + 1;
     end
     i_idx = i_idx + 1;
     j_idx=1;
%}
val = [];
for idx1=1:6
    for idx2=1:6
        
        for i=idx1:6:n
            for j=idx2:6:n
                if (i==j)
                    continue;
                else
                    val = [val M(i,j)];
                end
            end
            M_mean(idx1,idx2) = mean(val);
            val = [];
        end
    end
end