function [Comp_img] = Inv_padding_vid(I_DCT_coef,L0,W0)

N = 8;
[temp1, temp2] = size(I_DCT_coef);
for i = 1:1:temp1
    for j = 1:1:temp2
        x1 = (cell2mat(I_DCT_coef(i,j)));
        x2 = mat2cell(x1,N,N);
        I_pad(i,j) = x2;
    end
    xx = cell2mat(I_pad);
    Comp_img = imcrop(xx,[0,0,W0,L0]);
end