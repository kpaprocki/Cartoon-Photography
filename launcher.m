clear
clc

addpath('Bilateral Filtering');
addpath('images');

% Set parameters
IMAGE = 'images/obama.jpg';
MASK = 'images/obama_mask.gif';

% Threshold parameters, HI is high intensity (white)
THRESH_HI  = .68;
THRESH_MED = .48;
THRESH_LO  = .25;

% colors light (1) to dark (4)
% obama colors **SAVE** (used as default)
C1_R = 'fc';
C1_G = 'e4';
C1_B = 'a8';

C2_R = '71';
C2_G = '96';
C2_B = '9f';

C3_R = 'd7';
C3_G = '1a';
C3_B = '21';

C4_R = '00';
C4_G = '32';
C4_B = '4d';

% ---- Colors ( as hex ) c1 is lightest, c4 darkest
c11 = hex2dec(C1_R)/255;
c12 = hex2dec(C1_G)/255;
c13 = hex2dec(C1_B)/255;
    
c21 = hex2dec(C2_R)/255;
c22 = hex2dec(C2_G)/255;
c23 = hex2dec(C2_B)/255;
    
c31 = hex2dec(C3_R)/255;
c32 = hex2dec(C3_G)/255;
c33 = hex2dec(C3_B)/255;
    
c41 = hex2dec(C4_R)/255;
c42 = hex2dec(C4_G)/255;
c43 = hex2dec(C4_B)/255;


% Set bilateral filter parameters.
w     = 5;       % bilateral filter half-width
sigma = [3 0.1]; % bilateral filter standard deviations
 
% ----- GIF support ------
%[imIn, cmap] = imread(IMAGE, 'gif');

%imshow(imIn, cmap);

%for i = 1:256
%    sum = (cmap(i, 1) + cmap(i, 2) + cmap(i, 3))/3;
        % basic thresholding
    %if(sum > THRESH_HI)
    %    thresh(i, 1) = c11;
    %    thresh(i, 2) = c12;
    %    thresh(i, 3) = c13;
    %elseif(sum > THRESH_MED)
    %    thresh(i, 1) = c21;
    %    thresh(i, 2) = c22;
    %    thresh(i, 3) = c23;
    %elseif(sum > THRESH_LO)
    %    thresh(i, 1) = c31;
    %   thresh(i, 2) = c32;
    %    thresh(i, 3) = c33;
    %else
    %    thresh(i, 1) = c41;
    %    thresh(i, 2) = c42;
    %    thresh(i, 3) = c43;
    %    end
%end

%imshow(imIn, thresh);

% ----- JPEG support ------
pic = double(imread(IMAGE))/255;
%cart = bfilter2(pic,w,sigma);
%cartoon = bfilter2(cart,w,sigma);

% Apply bilateral filter for a "cartoon" effect.
%cartoon = cartoon(pic);

%imshow(bflt);
%figure;
%imshow(cartoon);
%imwrite(cartoon, 'step_cartoon.png', 'png');

bw = rgb2gray(pic);

% bw_cartn = cartoon(bw);

%figure;
%imshow(bw);

%imwrite(bw, 'step_bw.png', 'png');

% Try the filter again
%bflt2 = bfilter2(bflt,w,sigma);

%figure;
%imshow(bflt2);

color = zeros(size(bw, 1),size(bw, 2));

bg_mask = imread(MASK);

for i=1:size(bw, 1)
    for j=1:size(bw, 2)
        % background to c2 (left) and c3 (right)
        if(bg_mask(i, j) < 125)
            if(j < (size(bw, 2)/2))
                % set background
                color(i, j, 1) = c21;
                color(i, j, 2) = c22;
                color(i, j, 3) = c23;
                % make border of darkest color
                if(bg_mask(i, j+1) > 125)
                    for k=j:j+10
                        color(i, k, 1) = c41;
                        color(i, k, 2) = c42;
                        color(i, k, 3) = c43;
                    end
                end
                %if((i ~= (size(bw,1)-10)) && (bw(i+1, j) < .9))
                %    for k=i:i+10
                %        color(k, j, 1) = c41;
                %        color(k, j, 2) = c42;
                %        color(k, j, 3) = c43;
                %    end
                %end
            else
                color(i, j, 1) = c31;
                color(i, j, 2) = c32;
                color(i, j, 3) = c33;
            end
        % basic thresholding
        elseif(bw(i, j) > THRESH_HI)
            color(i, j, 1) = c11;
            color(i, j, 2) = c12;
            color(i, j, 3) = c13;
        elseif(bw(i, j) > THRESH_MED)
            color(i, j, 1) = c21;
            color(i, j, 2) = c22;
            color(i, j, 3) = c23;
        elseif(bw(i, j) > THRESH_LO)
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

imwrite(color, 'obama_nofilt.png', 'png');