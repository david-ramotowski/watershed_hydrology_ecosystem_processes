% [N,xbin,ybin] = Hist2D(x,y,nx,ny)
%
% Compute 2D histogram of bivariate data
%
% Inputs:
%   x = 1st variable (horizontal axis)
%   y = 2nd variable (vertical axis)
%   nx = number of bins in x direction
%   ny = number of bins in y direction
%
% Outputs:
%   N = ny by nx matrix of point counts
%   xbin = bin centers for x bins
%   ybin = bin centers for y bins
%
function [N,xbin,ybin]=Hist2D(x,y,nx,ny)

% compute range of x data
xmin=min(x); xmax=max(x);
% compute locations of x bin edges
xedge=linspace(xmin,xmax,nx+1); 
% compute locations of x bin centers
xbin=0.5*(xedge(1:nx)+xedge(2:nx+1));
% normalize x data to a range of [0,1]
xnrm=(x-xmin)/(xmax-xmin);

% compute range of y data
ymin=min(y); ymax=max(y);
% compute locations of y bin edges
yedge=linspace(ymin,ymax,ny+1); 
% compute locations of y bin centers
ybin=0.5*(yedge(1:ny)+yedge(2:ny+1));
% normalize y data to a range of [0,1]
ynrm=(y-ymin)/(ymax-ymin);

% compute which bin each x point falls into 
ibinx=round((nx-1)*xnrm)+1;
% compute which bin each y point falls into 
ibiny=round((ny-1)*ynrm)+1;

% compute bin counts
N=accumarray([ibiny,ibinx],ones(length(x),1));
% Note: accumarray takes row and column indices, so
% to get x horizontal and y vertical we must specify
% ibinx as the column index and ibiny as the row index

% Note: because N is a matrix, it is oriented with
% the upper left corner (1,1), as the origin. To plot
% the histogram correctly, we want the origin as the
% lower left corner
N=flipud(N); ybin=fliplr(ybin);

