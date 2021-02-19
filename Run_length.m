function [Run_out] = Run_length(Zig_out)
%% this is the runlength code for the AC parts
Run_out = [];
count = 1;
for i = 1:1:length(Zig_out)-1
    if (Zig_out(i) == Zig_out(i+1))
        count = count + 1;
    else
        Run_out = [Run_out,Zig_out(i),count];
        count = 1;
    end
end
Run_out = [Run_out,Zig_out(length(Zig_out)),count];
end

     