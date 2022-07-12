function [xi,yi,zi,ct,zc, bn_x, bn_y] = blockmean(xi,yi,x,y,z,dx,dy) ; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION
% Program to average the data (z) within specified blocks.
%
% INPUT
% x x-location of irregularly-spaced data
% y y-location of irregularly-spaced data
% z Value of the variable z at the locations x,y
% dx Spacing of bin in x direction -- optional
% dy """" y ""
%
% OUTPUT
% xi Regular grid in x direction
% yi """ y "
% zi Block averaged variable z
% ct Number of observations within each bin
%
% EXAMPLE 
% [x,y,zi] = blockmean(x,y,z,dx,dy) ;
% To average the variable sst every 50 m in the horizontal and 1 m in the
% vertical, given the matrix of x-locations (R) and y-locations (z):
% [ri,zi,vari,ct] = blockmean(R,z,sst,50,1) ;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Eliminate NaN points
ii = isnan(z) | isnan(x) | isnan(y) ;
x(ii) = [] ; y(ii) = [] ; z(ii) = [] ; 

% If grid not given, create it
% Default spacing is the bigger of: avg spacing, or the spacing determined by
% set number of points
if nargin < 7
    n = 75 ; % Set number of values in grid
    dx = max([range(x)./n mean(diff(unique(x)))]) ; % Choose the larger spacing
    dy = max([range(y)./n mean(diff(unique(y)))]) ; %
end
%xi = -10:dx:40; % The bins are a bit larger that the % data range
%yi = -20:dy:50; 

% Find index to bins
[n_x,bn_x] = histc(x,xi) ; % xi=bin edges, n_x is the number of observations in each bin, and bn_x indexes the bin that each datapoint goes into
[n_y,bn_y] = histc(y,yi) ; % Same, for y

ii = find(bn_x == 0 | bn_y == 0) ; % can't have zero indicies
bn_x(ii) = [] ; bn_y(ii) = [] ; z(ii) = [] ; 

% Count number of obs in each bin
ct = sparse(bn_y,bn_x,1,length(yi),length(xi)) ; 
% Sum values of z in each bin
sm = sparse(bn_y,bn_x,z,length(yi),length(xi)) ;

% Average of z = sum/count. It will be NaN if the bin is empty.
zi = full(sm./ct) ;

% Compute centered values
zc = z - zi(sub2ind(size(zi),bn_y,bn_x));
