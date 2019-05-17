function cOUT = checkG(c)

if c.fN(end) > 6*9.81
    c.fN(end)
    error('maxG - upward exceeded') 
elseif c.fN < -1*9.81
    error('maxG - downward exceeded')
elseif c.fT(end) > 5*9.81
    error('maxG - forward exceeded')
elseif c.fT(end) < -4*9.81
    error('maxG - backward exceeded')
elseif c.fL(end) < -3*9.81
    error('maxG - left exceeded')
elseif c.fL(end) > 3*9.81
    error('maxG - right exceeded')
else
    %keep going
end
end