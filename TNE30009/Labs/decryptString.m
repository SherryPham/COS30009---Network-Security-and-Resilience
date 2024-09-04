function [m] = decryptString(n, d, c) 
% given private key (n, d), decrypt cypher text c into message m 
% Author: Philip Branch
% Code calculates m = mod(c^d, n) . Uses some clever maths 
% to calculate it quickly and to avoid rounding errors

alphaArray = ['ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz:(). '];

plainTextNumeric = [1:length(c)];  %buffer where we store our numeric plain text
for i = 1:length(c)
    s = 1; t = c(i); u = d;
    while (u > 0)
        if (mod(floor(u),2) == 1)
            s = mod(floor(s)*floor(t), n);
        end;
        u = floor(u/2);
        t = floor(mod(t*t, n));
    end;
    plainTextNumeric(i) = s;
end

% Now convert plainTextNumeric to alpha
for i = 1:length(plainTextNumeric)
    if plainTextNumeric(i) > length(alphaArray)
        plainTextAlpha(i) = '.';
    else
       plainTextAlpha(i) = alphaArray(plainTextNumeric(i));   
    end
end
m = plainTextAlpha;
end
