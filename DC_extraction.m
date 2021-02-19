function [DC_mat,first] = DC_extraction(Quantization)
%% this is code for the extraction of dc parts from the quantized MB 
% temp = length(Quantization);
 DC_mat = [];
% for i = 1:1:temp
%     DC_val = Quantization(1,1,i);
%     DC_mat = [DC_mat DC_val];
% end
% first = DC_mat(1);
% DC_mat = DC_mat-first;
% DC_mat(1) = first;
% end


[temp1, temp2] = size(Quantization);
N = 8;
for i = 1:1:temp1
    for j = 1:1:temp2
        x1 = cell2mat(Quantization(i,j));
        x2 = x1(1,1);
        DC_mat = [DC_mat x2];
    end    
end
first = DC_mat(1);
DC_mat = DC_mat-first;
DC_mat(1) = first;
end