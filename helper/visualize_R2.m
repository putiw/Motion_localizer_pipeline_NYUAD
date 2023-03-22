function visualize_R2(results,sub,rois)

% Create a single figure and axes
fig = figure('Position', [100, 100, 1200, 600]);
ax = axes;
image_array = gobjects(length(results), 1);
bins = [0 100];
cmap0 = cmaplookup(0:1:100,min(bins),max(bins),[],hot);
for iRoi = 1:length(rois)
    hold(ax, 'on');
    tmp = results.(char(rois{iRoi}));
    %datatoplot = tmp.R2;
    datatoplot = ((tmp.R2 - min(tmp.R2)) / (max(tmp.R2) - min(tmp.R2))) * 100;
    datatoplot(isnan(datatoplot)) = 0;
    
    [rawimg,Lookup,rgbimg] = cvnlookup(sub,1,datatoplot,[min(bins) max(bins)],cmap0,0,[],0,{'roiname',{'Glasser2016'},'roicolor',{'w'},'drawroinames',1,'roiwidth',{1},'fontsize',20});
    
    color = [0.5];
    [r,c,t] = size(rgbimg);
    [i j] = find(all(rgbimg == repmat(color,r,c,3),3));
    
    for ii = 1: length(i)
        rgbimg(i(ii),j(ii),:) = ones(1,3);
    end
    image_handles(iRoi) = imagesc(ax, rgbimg);
end
hold(ax, 'off');
set(image_handles(2:end), 'Visible', 'off');

% Assign the callback function to the figure's KeyPressFcn
set(fig, 'KeyPressFcn', {@key_press_callback_images, image_handles});

% Add a non-interactive UI control to keep focus within the figure
uicontrol('Style', 'text', 'Visible', 'off', 'Enable', 'inactive', 'Position', [0 0 1 1]);
axis image tight;
axis off
hold on
plot(0,0);
colormap(cmap0);
hcb=colorbar('SouthOutside');
hcb.Ticks = [min(bins) range(bins)/2+min(bins) max(bins)];
hcb.TickLabels = num2str(hcb.Ticks(:));
hcb.FontSize = 25
hcb.Label.String = 'R2%'
hcb.TickLength = 0.001;
title(sub)
set(ax, 'YDir', 'reverse');

end