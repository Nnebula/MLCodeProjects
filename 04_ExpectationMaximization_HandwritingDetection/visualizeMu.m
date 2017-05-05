function visualizeMu(Mu,fig_num,title_str)
% Visualize a Bernoulli mixture.
% Shows Mu values from a Bernoulli mixture in figure fig_num with title title_str

K = size(Mu,3);

figure(fig_num);
set(gca,'FontSize',15);
clf;
nrows=3;
subplot(nrows,ceil(K/nrows),1);
for k=1:K
  subplot(nrows,ceil(K/nrows),k);
  imagesc(Mu(:,:,k));
  colormap gray;
  axis image;
  axis off;
  title(sprintf('%s: %d',title_str,k));
end
