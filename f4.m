function val = f4(x)
%A function defined recursively
val = x;
for i = 1:3
    val = 4*val*(1*val^0-val);
end
end