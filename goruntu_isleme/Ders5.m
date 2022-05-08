%% Görüntü Temsilleri 
% Ders 5
clear; clc; close all
A = uint8(randi([0 255],300,300)); %0-255 arasi 300x300 luk matris olusturur.
imagesc(A)
colormap('summer') 
%sahte renk haritasi ile gosterdik.

I = imread('peppers.png');
% Uc kanalli bir goruntu : R, G, B.
figure('units','normalized','outerposition',[0 0 1 1])
subplot(221),imshow(I);title('Original Image');
R = I(:,:,1); %goruntunun red kanalini aldik, digerleri de ayni sekilde.
G = I(:,:,2);
B = I(:,:,3);
subplot(222), imshow(R);title('Red channel');
subplot(223), imshow(G);title('Green channel');
subplot(224), imshow(B);title('Blue channel');
%uc kanalli goruntu okuyup bunun r,g,b kanallarini da ayri ayri gosterdik.

hsv = rgb2hsv(I); %goruntuyu HVS formatina donusturduk.
% Uc kanalli bir goruntu :H, S, V.
figure('units','normalized','outerposition',[0 0 1 1])
subplot(221),imshow(hsv);title('Original Image');
H = hsv(:,:,1);
S = hsv(:,:,2);
V = hsv(:,:,3);
subplot(222), imshow(H);title('Hue channel');
subplot(223), imshow(S);title('Saturation channel');
subplot(224), imshow(V);title('value channel');

% Bit duzlemleri
I = imread('tire.tif');
I = I(:,:,2);
[m,n] = size(I); %satir ve sutunlari m,n ye kopyaladik.
% bitget returns the bit value at position bit in integer array.
b{1} = double(bitget(I,1)); % 1.bit duzlemi, bitget ile goruntunun 1. bitini aliyoruz
b{2} = double(bitget(I,2)); % 2.bit duzlemi
b{3} = double(bitget(I,3)); % 3.bit duzlemi
b{4} = double(bitget(I,4)); % 4.bit duzlemi
b{5} = double(bitget(I,5)); % 5.bit duzlemi
b{6} = double(bitget(I,6)); % 6.bit duzlemi
b{7} = double(bitget(I,7)); % 7.bit duzlemi
b{8} = double(bitget(I,8)); % 8.bit duzlemi
I_b = cat(8,b{1},b{2},b{3},b{4},b{5},b{6},b{7},b{8}); %8 boyutlu matris olusturduk, her boyutunda bit duzlemleri.
%imshow(b(5)) ile 5. bit deki goruntuye ulasabiliriz.

figure,
imshow(I), title('Original:');

Img = zeros(m,n);
figure('units','normalized','outerposition',[0 0 1 1])
for i=8:-1:1
    subplot(4,2,9-i);
    imshow(b{i}), title(['Bit Plan: ' num2str(i)]);
end

% If you want to add Planes, u can use this:
B{1} = I_b(:,:,1)*(2^0);
B{2} = I_b(:,:,2)*(2^1);
B{3} = I_b(:,:,3)*(2^2);
B{4} = I_b(:,:,4)*(2^3);
B{5} = I_b(:,:,5)*(2^4);
B{6} = I_b(:,:,6)*(2^5);
B{7} = I_b(:,:,7)*(2^6);
B{8} = I_b(:,:,8)*(2^7);
% 
New_Image = zeros(m,n);
figure('units','normalized','outerposition',[0 0 1 1])
for i=8:-1:1
    New_Image = New_Image + B{i};
    subplot(4,2,9-i);
    imshow(New_Image), title(['Bit Plan: ' num2str(i)]);
end

% Matlab'da goruntu okuma, yazma ve sorgulama
imfinfo('cameraman.tif')    % Query the cameraman image that 
                            % is available with matlab. 
                            % imfinfo provides information
%ColorType is gray-scale, width is 256 ... etc.
                    
I1 = imread('cameraman.tif'); 
%Read in the TIF format cameraman image

imwrite(I1,'cameraman.jpg','jpg'); % Write the resulting array I1 to 
                                   % disk as a JPEG image
                                      
imfinfo('cameraman.jpg')    % Query the resulting disk image
                            % Note changes in storage size etc.
                            
% Görüntü gösterimi-1
A = imread('Bubbles_in_space.jpg');   % Read in intensity image

imshow(A);      % First display image using imshow

imagesc(A);     % Next display image using imagesc
axis image;     % Correct aspect ratio of displayed image
axis off;       % turn off the axis labelling
colormap(jet); % display intensity image in gray-scale  

% Görüntü gösterimi-2
B = rand(256).*1000;   % Generate random image array in range 0-1000 

imshow(B);             % Poor contrast results using imshow because data 
                       % exceeds expected range

imagesc(B);             % imagesc automatically scales colourmap to data
axis image; axis off;   % range
colormap(gray); colorbar;

imshow(B,[]);     % But if we specify range of data explicitly then                    
                        % imshow also displays correct image contrast

% Görüntü gösterimi-3
B=imread('cell.tif');    % Read in 8-bit intensity image of cell

C=imread('spine.tif');    % Read in 8-bit intensity image of spine

D=imread('onion.png');    % Read in 8-bit colour image.

subplot(3,1,1); imagesc(B); axis image; % Creates a 3 by 1 mosaic of plots 
axis off; colormap(gray);  % and display 1st image

subplot(3,1,2); imagesc(C); axis image; % Display 2nd image
axis off; colormap(jet);   % Set colourmap to jet (false colour)

subplot(3,1,3); imshow(D); % Display 3rd (colour) image 

% Piksel değerlerine erişim
B=imread('cell.tif');       % Read in 8-bit intensity image of cell

imtool(B);             %Examine grey scale image in interactive viewer

D=imread('onion.png');      % Read in 8-bit colour image.

imtool(D);           %Examine RGB image in interactive viewer

B(25,50)           %Print pixel value at location (25,50)         
B(25,50) = 255;    %Set pixel value at (25,50) to white
imshow(B);         %View resulting changes in image
D(25,50,:)        %Print RGB pixel value at location (25,50)
D(25,50, 1)       %Print only the red value at (25,50)
D(25,50,:) = 255; %Set pixel value to RGB white
imshow(D); %View resulting changes in image

% Görüntü türlerini dönüştürme-1
D = imread('onion.png');      % Read in 8-bit RGB colour image.

Dgray = rgb2gray(D);        % convert it to a grayscale image
Dhsv = rgb2hsv(D);          % convert it to a grayscale image

subplot(2,1,1); imshow(Dgray); axis image;  % display both side by side 
subplot(2,1,2); imshow(Dhsv);  

% Görüntü türlerini dönüştürme-2
D = imread('onion.png');      % Read in 8-bit RGB colour image.

R = D(:,:,1);          % extract red channel   (1st channel)
G = D(:,:,2);          % extract green channel (2nd channel)
B = D(:,:,3);          % extract blue channel  (3rd channel)

subplot(2,2,1); imshow(D); axis image;  % display all in 2x2 plot

subplot(2,2,2); imshow(R); title('red');     % display and label      
subplot(2,2,3); imshow(G); title('green');
subplot(2,2,4); imshow(B); title('blue');

% Çalışma Sorusu -1
I = imread('cell.tif'); 
I(100:120,20:40) = I(100:120,20:40) + 125;
I(50:70,60:80) = I(50:70,60:80) - 125;
imshow(I)

D = imread('onion.png');      % Read in 8-bit RGB colour image.
R = D(:,:,1);          % extract red channel   (1st channel)
G = D(:,:,2);          % extract green channel (2nd channel)
B = D(:,:,3);          % extract blue channel  (3rd channel)

%R(100:120,20:40) = R(100:120,20:40) + 125;
% G(100:120,20:40) = G(100:120,20:40) + 125;
 B(100:120,20:40) = B(100:120,20:40) + 125;

%D(:,:,1) = R;
% D(:,:,2) = G;
 D(:,:,3) = B;  
imagesc(D)




