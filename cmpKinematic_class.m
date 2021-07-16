function [outputArg1,outputArg2] = cmpKinematic_class(n_cluster_watershed,radius,angle,color,symbol)
figure,
nexttile,
hold on;
label = n_cluster_watershed;
h = [];
shuffle_label = label(randperm(length(label),length(label)));
for i=1:length(unique(label(~isnan(label))))
    [f,edge] = histcounts(angle(label==i),[-pi/2:0.2:pi/2],'Normalization','probability');
    htmp = plot(edge(1:end-1),f,'Color',color(i,:),'LineWidth',2);
    h = [h htmp];
    [f,edge] = histcounts(angle(shuffle_label==i),[-pi/2:0.2:pi/2],'Normalization','probability');
    plot(edge(1:end-1),f,'Color',color(i,:),'LineWidth',1,'LineStyle','-.');
end
xlabel('angle');ylabel('pdf');
htmp = plot(edge(1:end-1),f,'Color','k','LineWidth',1,'LineStyle','-.','Visible','off');
h = [h htmp];
legend(h,{'HAT','RT','C-turn','slow 2','slow 1','J-turn','shuffle'});
nexttile,hold on,
h = [];
for i=1:length(unique(label(~isnan(label))))
    [f,edge] = histcounts(radius(label==i),[0:5:100],'Normalization','probability');
    htmp = plot(edge(1:end-1),f,'Color',color(i,:),'LineWidth',2);
    h = [h htmp];
    [f,edge] = histcounts(radius(shuffle_label==i),[0:5:100],'Normalization','probability');
    plot(edge(1:end-1),f,'Color',color(i,:),'LineWidth',1,'LineStyle','-.');
end
xlabel('distance');ylabel('pdf');
htmp = plot(edge(1:end-1),f,'Color','k','LineWidth',1,'LineStyle','-.','Visible','off');
h = [h htmp];
legend(h,{'HAT','RT','C-turn','slow 2','slow 1','J-turn','shuffle'});
figure,
gscatter(angle,radius,n_cluster_watershed,color,symbol);
set(gca,'YLim',[0 150]);

end

