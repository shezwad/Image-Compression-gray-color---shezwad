m = 50;

DECODE1 = HUFFDECODE(text1,CODEBOOK1,Prob1);
DECODE2 = HUFFDECODE(text2,CODEBOOK2,Prob2);
DECODE3 = HUFFDECODE(text3,CODEBOOK3,Prob3);

DECODE4 = HUFFDECODE(text4,CODEBOOK4,Prob4);
DECODE5 = HUFFDECODE(text5,CODEBOOK5,Prob5);
DECODE6 = HUFFDECODE(text6,CODEBOOK6,Prob6);

I_Run_out1 = Inv_Run_length(DECODE1);
I_Run_out2 = Inv_Run_length(DECODE2);
I_Run_out3 = Inv_Run_length(DECODE3);

I_DC_mat1 = Inv_DC_extraction(DECODE4,first1);
I_DC_mat2 = Inv_DC_extraction(DECODE5,first2);
I_DC_mat3 = Inv_DC_extraction(DECODE6,first3);

I_Zig_out1 = Inv_zigzag(I_Run_out1,I_DC_mat1,L1,W1);
I_Zig_out2 = Inv_zigzag(I_Run_out2,I_DC_mat2,L1,W1);
I_Zig_out3 = Inv_zigzag(I_Run_out3,I_DC_mat3,L1,W1);

I_Quantization1 = Inv_quant(I_Zig_out1,m,1);
I_Quantization2 = Inv_quant(I_Zig_out2,m,2);
I_Quantization3 = Inv_quant(I_Zig_out3,m,2);

I_DCT_coef1 = Inv_DCT(I_Quantization1);
I_DCT_coef2 = Inv_DCT(I_Quantization2);
I_DCT_coef3 = Inv_DCT(I_Quantization3);

Comp_img1 = Inv_padding(I_DCT_coef1,L0,W0);
Comp_img2 = Inv_padding(I_DCT_coef2,L0,W0);
Comp_img3 = Inv_padding(I_DCT_coef3,L0,W0);

test_img = cat(3,Comp_img1,Comp_img2,Comp_img3);
combined_RGB = ycbcr2rgb(test_img);

figure; montage({Lu, Cr, Cb,Comp_img1,Comp_img2,Comp_img3});
figure;montage({I,combined_RGB});

%% Rough CR 
XX1 = length(A1)+length(A2)+length(A3)+length(A4)+length(A5)+length(A6);

XX2 = 2*(length(CODEBOOK1)+length(CODEBOOK2)+length(CODEBOOK3)+length(CODEBOOK4)+length(CODEBOOK5)+length(CODEBOOK6));
XX3 = length(L0)+length(W0)+length(L1)+length(W1)+length(first1)+length(first2)+length(first3)+3;
XX4 = length(Prob1)+length(Prob2)+length(Prob3)+length(Prob4)+length(Prob5)+length(Prob6);

XX_f = XX1 + 8*(XX2)*18 + 8*(XX3 + XX4);

CR = (L0*W0*8*3)/XX_f ;