% [xfit,yfit]=RobustFit2D(x,y,nx,avg_fun)
%
% Compute empirical fit curve from bivariate data
%
% Inputs:
%   x = predictor variable (horizontal axis)
%   y = variable to be predicted (vertical axis)
%   nx = number of bins in x direction
% Optional Input: 
%   avg_fun = handle of function to use for
%             bin averaging. The default is
%             median averaging, i.e. avg_fun = @median
%
% Outputs:
%   xfit = bin centers for x bins
%   yfit = average value of y in each x bin
%
function [xfit,yfit]=RobustFit2D(x,y,nx,avg_fun)

if(nargin<4)
    avg_fun=@median;
end

nx=nx+2;

xmin=min(x); xmax=max(x);
xedge=linspace(xmin,xmax,nx+1); 
xfit=0.5*(xedge(1:nx)+xedge(2:nx+1));
xnrm=(x-xmin)/(xmax-xmin);
ibinx=round((nx-1)*xnrm)+1;

% lump first and last bins into neighboring bins
ibinx(ibinx==1)=2; ibinx(ibinx==nx)=nx-1; ibinx=ibinx-1;
xfit=[0.5*(xfit(1)+xfit(2)),xfit(3:nx-2),0.5*(xfit(nx-1)+xfit(nx))];

I=ones(size(x));

yfit=accumarray(ibinx(:),y(:),[nx-2,1],avg_fun)';


