

function datanew = solveAngle (data)

[row,col]=size(data);
datanew = data;

for n=1:row
    
    H = data(n,5);  % leaf base height
    r = data(n,10); % horizontal distance from leaf tip to stem
    h = data(n,11); % vertical height from leaf tip to ground
    
    T = sqrt(r*r+(h-H)*(h-H)); %
    L = data(n,6); % leaf length
    n
    if(L-T>1)
        y=inline('2*L*sin(theta/2)-T*theta','theta','L','T');
        [theta,yt] = fzero(y,[0.001,3.1416],[],L,T);
    else
        theta=0;
    end
    datanew(n,8) = theta;

end

end

