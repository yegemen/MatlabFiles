function fftshow(f,type)
% usage: fftshow(f,type)
%
% Displays the fft matrix F using imshow, where TYPE must be one of
% 'abs' or 'log'. If TYPE = 'abs', then abs(f) is displayed; if
% TYPE = 'log' then log(1+abs(f)) is displayed. If TYPE is omitted, 
% then 'log' is chosen as default.
%
% Example:
% c = imread('cameraman.tif');
% cf = fftshift(fft2(c));
% fftshow(cf, 'abs')
%
if nargin < 2
  type = 'log';
end
if strcmp(type,'log')
    fl = log(1+abs(f));
    %fm = max(fl(:));
    imshow(mat2gray((fl)),[])
elseif strcmp(type,'abs')
    fa = abs(f);
    %fm = max(fa(:));
    imshow(fa,[])
else
    error('TYPE abs veya log girilmeli.')
end
end