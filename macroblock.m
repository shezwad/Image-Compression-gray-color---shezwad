function [MB , L1, W1] = macroblock(pad_image)
%% This is the function to do splitting in to N x N macro blocks
%%
N = 8; % MB size
[L1 , W1] = size(pad_image);
%% splitting N x N MB s
%MB = reshape(pad_image,N*ones(1,L1/N),N*ones(1,W1/N)); % returns N x N blocks where the products of N,N,L1*W1/(N*N) is same as pad_image
MB = mat2cell(pad_image,N*ones(1,L1/N),N*ones(1,W1/N));
% [L2 , W2] = size(MB);
% %J = L2*W2;
% %j = 1:1:J;
% for k = 1:1:L2
%     for i = 1:1:W2
%         C(:,:,j) = cell2mat(MB(k,i));
%     end
% end
end