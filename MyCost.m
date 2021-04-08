function [z, sol]=MyCost(p,model)

    global NFE;
    if isempty(NFE)
        NFE=0;
    end
    
    NFE=NFE+1;
    Ls=model.Ls;
    y=model.y;
    x=model.x;
    N=model.N;
    PL=model.PL;
    R=zeros(1,2*N);
    xh=zeros(1,2*N);
    yh=zeros(1,2*N);
    
    R=[.2*Ls/p(1) .2*Ls/p(2) .2*Ls/p(3) .2*Ls/p(4) .2*Ls/p(5)];
       
    
    c=zeros(1,2*N);
    %for i=1:N
    %    c(i)=a0(i)+a1(i)*p(i)+a2(i)*p(i)^2;
    %end
    
    % Vectorized version of the previous loop
%    delh=.125*Ls*[sin(0.5*p(1))...
%                  sin(p(1)+0.5*p(2))...
%                  sin(p(1)+p(2)+.5*p(3))...
%                  sin(p(1)+p(2)+p(3)+.5*p(4))...
%                  sin(p(1)+p(2)+p(3)+p(4)+.5*p(5))...
%                  sin(p(1)+p(2)+p(3)+p(4)+p(5)+.5*p(6))...
%                  sin(p(1)+p(2)+p(3)+p(4)+p(5)+p(6)+.5*p(7))...
%                  sin(p(1)+p(2)+p(3)+p(4)+p(5)+p(6)+p(7)+.5*p(8))]
%                  
%    yh=[delh(1)...
%        delh(1)+delh(2)...
%        delh(1)+delh(2)+delh(3)...
%        delh(1)+delh(2)+delh(3)+delh(4)... 
%        delh(1)+delh(2)+delh(3)+delh(4)+delh(5)... 
%        delh(1)+delh(2)+delh(3)+delh(4)+delh(5)+delh(6)... 
%        delh(1)+delh(2)+delh(3)+delh(4)+delh(5)+delh(6)+delh(7)...
%        delh(1)+delh(2)+delh(3)+delh(4)+delh(5)+delh(6)+delh(7)+delh(8)]
    yh(1)=  R(1)*(1-cos(.5*p(1)));
    yh(2)=  R(1)*(1-cos(p(1)));
    yh(3)=  R(1)...
          -(R(1)-R(2))*cos(p(1))...
                -R(2)*cos(p(1)+.5*p(2));
    yh(4)=  R(1)...
          -(R(1)-R(2))*cos(p(1))...
                 -R(2)*cos(p(1)+p(2));
    yh(5)=  R(1)...
          -(R(1)-R(2))*cos(p(1))...
          -(R(2)-R(3))*cos(p(1)+p(2))...
                 -R(3)*cos(p(1)+p(2)+.5*p(3));
    yh(6)=  R(1)...
          -(R(1)-R(2))*cos(p(1))...
          -(R(2)-R(3))*cos(p(1)+p(2))...
                 -R(3)*cos(p(1)+p(2)+p(3));
    yh(7)=  R(1)...
          -(R(1)-R(2))*cos(p(1))...
          -(R(2)-R(3))*cos(p(1)+p(2))...
          -(R(3)-R(4))*cos(p(1)+p(2)+p(3))...
                 -R(4)*cos(p(1)+p(2)+p(3)+.5*p(4));
    yh(8)=  R(1)...
          -(R(1)-R(2))*cos(p(1))...
          -(R(2)-R(3))*cos(p(1)+p(2))...
          -(R(3)-R(4))*cos(p(1)+p(2)+p(3))...
                 -R(4)*cos(p(1)+p(2)+p(3)+p(4));
    yh(9)=  R(1)...
          -(R(1)-R(2))*cos(p(1))...
          -(R(2)-R(3))*cos(p(1)+p(2))...
          -(R(3)-R(4))*cos(p(1)+p(2)+p(3))...
          -(R(4)-R(5))*cos(p(1)+p(2)+p(3)+p(4))...
                - R(5)*cos(p(1)+p(2)+p(3)+p(4)+.5*p(5));
    yh(10)=  R(1)...
          -(R(1)-R(2))*cos(p(1))...
          -(R(2)-R(3))*cos(p(1)+p(2))...
          -(R(3)-R(4))*cos(p(1)+p(2)+p(3))...
          -(R(4)-R(5))*cos(p(1)+p(2)+p(3)+p(4))...
                - R(5)*cos(p(1)+p(2)+p(3)+p(4)+p(5));
    
          
    xh(1)=  R(1)*sin(.5*p(1));
    xh(2)=  R(1)*sin(p(1));
    xh(3)= (R(1)-R(2))*sin(p(1))...
               + R(2)*sin(p(1)+.5*p(2));
    xh(4)= (R(1)-R(2))*sin(p(1))...
               + R(2)*sin(p(1)+p(2));
    xh(5)= (R(1)-R(2))*sin(p(1))...
          +(R(2)-R(3))*sin(p(1)+p(2))...
               + R(3)*sin(p(1)+p(2)+.5*p(3));
    xh(6)= (R(1)-R(2))*sin(p(1))...
          +(R(2)-R(3))*sin(p(1)+p(2))...
               + R(3)*sin(p(1)+p(2)+p(3));      
    xh(7)= (R(1)-R(2))*sin(p(1))...
          +(R(2)-R(3))*sin(p(1)+p(2))...
          +(R(3)-R(4))*sin(p(1)+p(2)+p(3))...
                + R(4)*sin(p(1)+p(2)+p(3)+.5*p(4));
    xh(8)= (R(1)-R(2))*sin(p(1))...
          +(R(2)-R(3))*sin(p(1)+p(2))...
          +(R(3)-R(4))*sin(p(1)+p(2)+p(3))...
                + R(4)*sin(p(1)+p(2)+p(3)+p(4));      
    xh(9)= (R(1)-R(2))*sin(p(1))...
          +(R(2)-R(3))*sin(p(1)+p(2))...
          +(R(3)-R(4))*sin(p(1)+p(2)+p(3))...
          +(R(4)-R(5))*sin(p(1)+p(2)+p(3)+p(4))...
                + R(5)*sin(p(1)+p(2)+p(3)+p(4)+.5*p(5));
    xh(10)= (R(1)-R(2))*sin(p(1))...
          +(R(2)-R(3))*sin(p(1)+p(2))...
          +(R(3)-R(4))*sin(p(1)+p(2)+p(3))...
          +(R(4)-R(5))*sin(p(1)+p(2)+p(3)+p(4))...
                + R(5)*sin(p(1)+p(2)+p(3)+p(4)+p(5));      
        
    c=sqrt((xh-x).^2+(yh-y).^2);
    
    v=abs(sum(p)/PL-1);
    
    beta=100;
    
    z=sum(c)*(1+beta*v);
    
        
    sol.p=p;
    sol.pTotal=sum(p);
    sol.c=c;
    sol.cTotal=sum(c);
    sol.v=v;
    sol.z=z;
    sol.x=x;
    sol.y=y;
    sol.xh=xh;
    sol.yh=yh;
    sol.R=R;

end