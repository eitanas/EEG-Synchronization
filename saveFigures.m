function saveFigures(name)

figs = get(0,'Children');
figs = flipud(figs);

for i=1:length(figs)
    saveas(figs(i),[name, num2str(i)],'tif')
    %saveas(figs(i),['fig',num2str(i)],'pdf')
end

end