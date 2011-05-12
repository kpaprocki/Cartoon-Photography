function [ obamafied ] = obamaficator( image, mask, threshHI, threshMED, threshLO, w, sigma )
%OBAMAFICATOR Creates styalized posters from imput portrait and mask.
%   Does sweet stuffs.

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

    % input image, perform filters
    pic = double(imread(image))/255;
    bfilt = bfilter2(pic,w,sigma);
    bw = rgb2gray(bfilt);

    obamafied = zeros(size(bw, 1),size(bw, 2));
    bg_mask = imread(mask);

    for i=1:size(bw, 1)
        for j=1:size(bw, 2)
            % background to c2 (left) and c3 (right)
            if(bg_mask(i, j) < 125)
                if(j < (size(bw, 2)/2))
                    % set background
                    obamafied(i, j, 1) = c21;
                    obamafied(i, j, 2) = c22;
                    obamafied(i, j, 3) = c23;
                    % make border of darkest color
                    if(bg_mask(i, j+1) > 125)
                        for k=j:j+10
                            obamafied(i, k, 1) = c41;
                            obamafied(i, k, 2) = c42;
                            obamafied(i, k, 3) = c43;
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
                    obamafied(i, j, 1) = c31;
                    obamafied(i, j, 2) = c32;
                    obamafied(i, j, 3) = c33;
                end
            % basic thresholding
            elseif(bw(i, j) > threshHI)
                obamafied(i, j, 1) = c11;
                obamafied(i, j, 2) = c12;
                obamafied(i, j, 3) = c13;
            elseif(bw(i, j) > threshMED)
                obamafied(i, j, 1) = c21;
                obamafied(i, j, 2) = c22;
                obamafied(i, j, 3) = c23;
            elseif(bw(i, j) > threshLO)
                obamafied(i, j, 1) = c31;
                obamafied(i, j, 2) = c32;
                obamafied(i, j, 3) = c33;
            else
                obamafied(i, j, 1) = c41;
                obamafied(i, j, 2) = c42;
                obamafied(i, j, 3) = c43;
            end
        end
    end
end

