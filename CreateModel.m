function model=CreateModel()
    global Rc;
    global Ls;
    Rmin=[5*Rc (5/2)*Rc (5/3)*Rc (5/4)*Rc Rc];
    
    pmin=[.0000000001   .2*Ls/Rmin(1) .2*Ls/Rmin(2) .2*Ls/Rmin(3) .2*Ls/Rmin(4)];
          
    pmax=[.2*Ls/Rmin(1) .2*Ls/Rmin(2) .2*Ls/Rmin(3) .2*Ls/Rmin(4) .2*Ls/Rmin(5)];
        
    N=numel(pmin);
    PL=Ls/(2*Rc);
    x=zeros(1,2*N);
    y=zeros(1,2*N);
    
    for i=1:10
      x(i)=(i/10)*Ls-((i/10)*Ls)^5/(40*(Rc*Ls)^2)+((i/10)*Ls)^9/(3456*(Rc*Ls)^4);
      y(i)=((i/10)*Ls)^3/(6*Rc*Ls)-((i/10)*Ls)^7/(336*(Rc*Ls)^3)+((i/10)*Ls)^11/(42240*(Rc*Ls)^5);
    end
    
    model.N=N;
    model.Rc=Rc;
    model.Ls=Ls;
    model.pmin=pmin;
    model.pmax=pmax;
    model.x=x;
    model.y=y;
    model.PL=PL;

end