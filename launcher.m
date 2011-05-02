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

% ---- Colors ( as hex ) c1 is lightest, c4 darkest
c11 = hex2dec('ff');
c12 = hex2dec('cc');
c13 = hex2dec('99');
    
c21 = hex2dec('99');
c22 = hex2dec('cc');
c23 = hex2dec('ff');
    
c31 = hex2dec('66');
c32 = hex2dec('00');
c33 = hex2dec('00');
    
c41 = hex2dec('00');
c42 = hex2dec('00');
c43 = hex2dec('66');

for i=1:size(bw, 1)
    for j=1:size(bw, 2)
        if(bw(i, j) > .75)
            color(i, j, 1) = c11;
            color(i, j, 2) = c12;
            color(i, j, 3) = c13;
        elseif(bw(i, j) > .50)
            color(i, j, 1) = c21;
            color(i, j, 2) = c22;
            color(i, j, 3) = c23;
        elseif(bw(i, j) > .25)
            color(i, j, 1) = c31;
            color(i, j, 2) = c32;
            color(i, j, 3) = c33;
        else
            color(i, j, 1) = c41;
            color(i, j, 2) = c42;
            color(i, j, 3) = c43;
        end
    end
end

figure;
imshow(color);