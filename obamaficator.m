function [ obamafied ] = obamaficator( image, mask, threshHI, threshMED, threshLO, w, sigma, colors )
%OBAMAFICATOR Creates styalized posters from imput portrait and mask.
%   Does sweet stuffs.

    % ---- Colors ( as hex ) c1 is lightest, c4 darkest
    c11 = colors(1, 1);
    c12 = colors(1, 2);
    c13 = colors(1, 3);

    c21 = colors(2, 1);
    c22 = colors(2, 2);
    c23 = colors(2, 3);

    c31 = colors(3, 1);
    c32 = colors(3, 2);
    c33 = colors(3, 3);

    c41 = colors(4, 1);
    c42 = colors(4, 2);
    c43 = colors(4, 3);

    % input image, perform filters
    pic = double(imread(image))/255;
    bfilt = bfilter2(pic,w,sigma);    
    bw = rgb2gray(bfilt);

    obamafied = zeros(size(bw, 1),size(bw, 2));
    bg_mask = imread(mask);
    
    stitchOn = 1;

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
            % cross tones
            elseif(bw(i, j) > (threshHI-((1-threshHI)/6)))
                if(stitchOn == 1)
                    obamafied(i, j, 1) = c21;
                    obamafied(i, j, 2) = c22;
                    obamafied(i, j, 3) = c23;
                else
                    obamafied(i, j, 1) = c11;
                    obamafied(i, j, 2) = c12;
                    obamafied(i, j, 3) = c13;
                end
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
        if(stitchOn == 1)
            stitchOn = 0;
        else
            stitchOn = 1;
        end
    end
end

