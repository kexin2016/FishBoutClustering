


F1ScoreThis1 = F1All(:,[5,6,7])';
F1ScoreThis2 = F1All(:,[1,2,3])';


figure
subplot(2,2,1)
imagesc(F1ScoreThis1)
axis square
colormap gray
caxis([0 1])

subplot(2,2,2)
imagesc(F1ScoreThis2)

axis square
colormap gray
caxis([0 1])

subplot(2,2,3)
imagesc(F1All(10,[5,6,7,1,2,3])')

axis square
colormap gray
caxis([0 1])

% subplot(2,2,4)
% imagesc(F1ScoreThis2(:,10))
% 
% axis square
% colormap gray
% caxis([0 1])
