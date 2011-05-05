clear
clc

addpath('Bilateral Filtering');

% Set parameters
IMAGE = 'koala.jpg';

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


% Set bilateral filter parameters.
w     = 5;       % bilateral filter half-width
sigma = [3 0.1]; % bilateral filter standard deviations

pic = double(imread(IMAGE))/255;

%bflt = bfilter2(pic,w,sigma);

% Apply bilateral filter for a "cartoon" effect.
cartoon = cartoon(pic);

%imshow(bflt);
%figure;
%imshow(cartoon);
%imwrite(cartoon, 'step_cartoon.png', 'png');

bw = rgb2gray(cartoon);

% bw_cartn = cartoon(bw);

%figure;
%imshow(bw);

%imwrite(bw, 'step_bw.png', 'png');

% Try the filter again
%bflt2 = bfilter2(bflt,w,sigma);

%figure;
%imshow(bflt2);

color = zeros(size(bw, 1),size(bw, 2));

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

for i=1:size(bw, 1)
    for j=1:size(bw, 2)
        % background to c2 (left) and c3 (right)
        if(bw(i, j) > .9)
            if(j < (size(bw, 2)/2))
                % set background
                color(i, j, 1) = c21;
                color(i, j, 2) = c22;
                color(i, j, 3) = c23;
                % make border of darkest color
                if(bw(i, j+1) < .9)
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

imwrite(color, 'koala_final.png', 'png');