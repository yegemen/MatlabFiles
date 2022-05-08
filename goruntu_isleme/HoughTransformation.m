% Hafta-13 Canlı Ders 1
% Basit bir görüntünün Hough dönüşümünü resmetme
clear;
f = zeros(101,101); % Yapay görüntü
f(1,1) = 1; f(101,1) = 1; f(1,101) = 1; 
f(101,101) = 1; f(51,51) = 1;
% Points are shown in red for clarity.
frgb = zeros(101,101,3);
frgb(:,:,1) = f;
figure, 
subplot(121), imshow(frgb); title('Yapay görüntü')
[H,thetaV,rhoV] = hough(f);
nr = numel(rhoV); nc = numel(thetaV);
fprintf('Hough matrisinin boyutları =%dx%d',nr,nc);
% Display hough curves in yellow.
Hrgb = zeros(nr,nc,3);
Hrgb(:,:,1) = H; Hrgb(:,:,2) = H;
subplot(122), 
imshow(Hrgb,'XData',thetaV,'YData',rhoV,'Border','loose')
title('Hough eğrileri')
axis on
% Using '\theta' displays the Greek symbol for theta.
xlabel('\theta'); ylabel('\rho');
xticks(-80:20:80)

peaks = houghpeaks(H,6);
x = thetaV(peaks(:,2));
y = rhoV(peaks(:,1));
hold on
plot(round(x), round(y),'LineStyle','none','Linewidth',3,...
    'Marker','s','MarkerSize',8,'color','b')
hold off
% zirvelere karşı gelen hough hücrelerinin doğru parçaları
lines = houghlines(f,thetaV,rhoV,peaks,'FillGap',101);
figure, imshow(f); hold on

for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'Linewidth',3,'Color','y');
end
hold off
%saveas(gcf,[filepath,'HoughCurves-1.png'])

Kenar bağlantıları için Hough dönüşümü kullanma.
clc;clear; 
f = imread('building.tif'); % 'circuit.tif'
bw = edge(f,'canny',[0.04 0.16],1.5);
figure(1),
subplot(121), imshow(f)
title('Orijinal Görüntü')
subplot(122), imshow(bw)
title('İkili Kenar Görüntüsü')

% Hough Döünüşüm matrisini hesaplama.
[H,thetaV,rhoV] = hough(bw,'thetaRes',0.1);

% Houg dönüşümünü ekranda görüntüleme.
figure(2), 
imshow(imadjust(mat2gray(H)),'XData',thetaV,'YData',rhoV,'Border','loose')
title('Hough eğrileri')  
daspect auto
axis on; xlabel('\theta'); ylabel('\rho'); xticks(-80:5:80);

% İkili görüntüdeki en fazla doğrusal olan noktaları hesaplayan houghpeaks
% fonksiyoun çağrılır ve parametre olarak girilen sayı değeri zirve sayısını
% gösteririr.
peaks = houghpeaks(H,8,'Threshold',150);

% Zirveleri veren dönüşümün görüntüsü üzerine bindirerek çizdirme.
x = thetaV(peaks(:,2)); y = rhoV(peaks(:,1));
hold on
plot(round(x), y,'LineStyle','none','Linewidth',3,...
    'Marker','s','MarkerSize',14,'color','b')
hold off
%exportgraphics(gcf,[filepath,'HoughCurves8.png'])

% zirvelere karşı gelen hough hücrelerinin doğru parçaları
lines = houghlines(bw,thetaV,rhoV,peaks,'FillGap',25,'Minlength',55);

figure(3), imshow(f); hold on
max_len = 0;

for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'Linewidth',3,'Color','y');
   
   % Doğruların başlanğıçlarını ve bitişlerini işaretleme
   plot(xy(1,1), xy(1,2),'*','LineWidth',2,'Color','red');
   plot(xy(2,1), xy(2,2),'*','LineWidth',2,'Color','blue');
end
% En uzun doğru parçasını renklendirme
xy_long = [lines(1).point1; lines(1).point2];
line(xy_long(:,1), xy_long(:,2),'LineWidth',3,'Color','cyan');
hold off 
