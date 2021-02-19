function I_DC_mat = Inv_DC_extraction(DECODE,first)
I_DC_mat = DECODE + first;
I_DC_mat(1,1) = first; 
end
