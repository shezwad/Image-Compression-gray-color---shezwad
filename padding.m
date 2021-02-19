function [pad_image, L0, W0] = padding(image)
%% This is the function to do padding before splitting in to N x N macroblocks
%%
N = 8; % MB size 
[L0 , W0 ] = size(image);
%% checking length and width whether they can be divide by N
if rem(L0,N) == 0 && rem(W0,N) == 0
    pad_image = image;
elseif rem(L0,N) == 0
    pad = [0,N-rem(W0,N)];
    pad_image = padarray(image,pad,'post'); % padarray will do the padding to image,padsize,padvalue,direction
elseif rem(W0,N) == 0                        % post means Pads after the last array element along each dimension.            
    pad = [N-rem(L0,N),0];
    pad_image = padarray(image,pad,'post'); 
else
    pad = [N-rem(L0,N),N-rem(W0,N)];
    pad_image = padarray(image,pad,'post'); 
end
end
    