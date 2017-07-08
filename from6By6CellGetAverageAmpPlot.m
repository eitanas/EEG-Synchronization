%%
amp_cell = FOG_group_sixBySix_amp;
[~,s] = size(amp_cell);
amp = [];
idx = 1;
for i=1:s
    curr = amp_cell{i}(:,:);
    amp(:,:,idx) = curr;
    idx = idx + 1;
end

amp_mean = mean(amp,3);
figure;
imagesc(amp_mean);
colormap('jet');
colorbar;
title('FOG, normal walking, amplitudes');
ax = gca;
ax.XTickLabel = {'\delta', '\theta', '\alpha', '\sigma', '\beta', '\gamma'};
ax.YTickLabel = {'\delta', '\theta', '\alpha', '\sigma', '\beta', '\gamma'};