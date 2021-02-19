function I_Zig_out = Inv_zigzag(I_Run_out,I_DC_mat,L1,W1)

temp1 = L1/8;
temp2 = W1/8;
B = reshape(I_Run_out, 63, []);
B = B';
B_1 = cat(2, zeros(size(B,1),1), B);
temp = length(B_1);

for k = 1:1:temp
    B_1(k,1) = I_DC_mat(k);
end
% FF = {};
% [temp1, temp2] = size(MB);
for i = 1:1:temp
    T = B_1(i,:);
%     for k = 1:1:length(T)
    
       I_Zig_out{i}  = [T(1,1)  T(1,2)  T(1,6)  T(1,7)  T(1,15) T(1,16) T(1,28) T(1,29);
   	                         T(1,3)  T(1,5)  T(1,8)  T(1,14) T(1,17) T(1,27) T(1,30) T(1,43);
		                     T(1,4)  T(1,9)  T(1,13) T(1,18) T(1,26) T(1,31) T(1,42) T(1,44);
		                     T(1,10) T(1,12) T(1,19) T(1,25) T(1,32) T(1,41) T(1,45) T(1,54);
		                     T(1,11) T(1,20) T(1,24) T(1,33) T(1,40) T(1,46) T(1,53) T(1,55);
 		                     T(1,21) T(1,23) T(1,34) T(1,39) T(1,47) T(1,52) T(1,56) T(1,61);
		                     T(1,22) T(1,35) T(1,38) T(1,48) T(1,51) T(1,57) T(1,60) T(1,62);
		                     T(1,36) T(1,37) T(1,49) T(1,50) T(1,58) T(1,59) T(1,63) T(1,64)];

%     end
end
I_Zig_out = reshape(I_Zig_out,temp2,temp1);
I_Zig_out = I_Zig_out';
end
    
    