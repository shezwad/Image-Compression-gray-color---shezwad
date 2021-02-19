function I_Run_out = Inv_Run_length(DECODE)

fr = [];
for i = 2:2:length(DECODE)
   fr = [fr DECODE(i)];
end
sy = [];
for i = 1:2:length(DECODE)
   sy = [sy DECODE(i)];
end
I_Run_out = [];
for i = 1:length(fr)
    m = fr(i);
    q = sy(i);
    for j = 1:m
        I_Run_out = [I_Run_out q];
    end
end