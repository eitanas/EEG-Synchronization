%%

fr_cell = FOG_group_sixBySix_fr;
[~,s] = size(fr_cell);
fr = [];
idx = 1;
for i=1:s
    curr = fr_cell{i}(:,:);
    fr(:,:,idx) = curr;
    idx = idx + 1;
end

fr_mean = mean(fr,3);
figure;
imagesc(fr_mean);
colormap('jet');
colorbar;
title('EC, normal walking, frequencies');
ax = gca;
ax.XTickLabel = {'\delta', '\theta', '\alpha', '\sigma', '\beta', '\gamma'};
ax.YTickLabel = {'\delta', '\theta', '\alpha', '\sigma', '\beta', '\gamma'};
    