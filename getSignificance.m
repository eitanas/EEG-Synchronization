function M = getSignificance(M1,M2)
%this function gets two 6x6xdim matrices, and return thier t-test value per
%matrix element array

M1 = struct2cell(M1);
M2 = struct2cell(M2);
M1 = M1{1};
M2 = M2{1};
s1 = length(M1);
s2 = length(M2);

M = zeros(6);

idx = 1;
ar1 = [];
for i=1:s1
    [~,~,s] = size(M1{i});
    for j=1:s
        curr = M1{i}(:,:,s);
        ar1(:,:,idx) = curr;
        idx = idx + 1;
    end
end

idx = 1;
ar2 = [];
for i=1:s2
    [~,~,s] = size(M2{i});
    for j=1:s
        curr = M2{i}(:,:,s);
        ar2(:,:,idx) = curr;
        idx = idx + 1;
    end
end
[h,p] = ttest2(ar1,ar2,'dim',3);
h
p

M(p<0.05) = 0.0032;
M(p<0.01) = 0.0562;
M(p<0.001) = 1;
M(h==0) = 0;

%colors = repmat( logspace(log10(1),log10(1e-5),5)',1,3 );
imagesc(M)
colormap('gray')
% for i=1:6
%     for j=1:6
%                  
%         currArr1 = ar1(i,j,:);
%         s1 = length(currArr1);
%         currArr1 = reshape(currArr1,1,s1);
%         currArr2 = ar2(i,j,:);
%         s2 = length(currArr2);
%         currArr2 = reshape(currArr2,1,s2);
%         [h,p,ci,stats] = ttest2(currArr1,currArr2 );
%         currArr1
%         h
%         if (h==0)
%             M(i,j) = 0;
%         elseif (1-p<0.001)
%             M(i,j) = 1;
%         elseif(1-p<0.01)
%             M(i,j) = 0.7;
%         elseif (1-p<0.05)
%             M(i,j) = 0.5;
%         end
%     end
% end

end
