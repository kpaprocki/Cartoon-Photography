clear
clc

pic = double(imread('portrait.jpg'))/255;

% Set bilateral filter parameters.
w     = 5;       % bilateral filter half-width
sigma = [3 0.1]; % bilateral filter standard deviations

bflt = bfilter2(pic,w,sigma);

% Apply bilateral filter for a "cartoon" effect.
cartoon = cartoon(pic);

imshow(bflt);
figure;
imshow(cartoon);

% Try the filter again
bflt2 = bfilter2(bflt,w,sigma);

figure;
imshow(bflt2);