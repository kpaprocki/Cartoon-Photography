clear
clc

pic = double(imread('portrait.jpg'))/255;

% Set bilateral filter parameters.
w     = 5;       % bilateral filter half-width
sigma = [3 0.1]; % bilateral filter standard deviations

%bflt = bfilter2(pic,w,sigma);

% Apply bilateral filter for a "cartoon" effect.
cartoon = cartoon(pic);

%imshow(bflt);
figure;
imshow(cartoon);

bw = rgb2gray(cartoon);

% bw_cartn = cartoon(bw);

figure;
imshow(bw);


% Try the filter again
%bflt2 = bfilter2(bflt,w,sigma);

%figure;
%imshow(bflt2);

color = zeros(size(bw, 1),size(bw, 2));

for i=1:size(bw, 1)
    for j=1:size(bw, 2)
        if(bw(i, j) > .66)
            color(i, j, 1) = 255;
        elseif(bw(i, j) > .33)
            color(i, j, 2) = 255;
        else
            color(i, j, 3) = 255;
        end
    end
end

figure;
imshow(color);