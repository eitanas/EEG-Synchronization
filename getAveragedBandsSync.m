function M = getAveragedBandsSync(in)
%this function gets a 180*180 matrix, and returns a 6*6 matrix, where every
%element in the new matrix is the average of same bands (waves) across all the
%corresponding bands in the original matrix
bands_num = 6;
M = zeros(bands_num);
vals = [];


for idx1=1:bands_num;
    for idx2=1:bands_num;
        
        for i=idx1:bands_num:length(in) - bands_num + idx1
            for j=idx2:bands_num:length(in) -bands_num +idx2
                vals = [vals in(i,j)];
            end
        end
        M(idx1,idx2) = mean(vals);
        vals = [];
        
    end
end
