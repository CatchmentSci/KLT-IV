function [dataOut] = normalVector(dataIn, start1, end1) % Out is normal and then tangental velocities

if nargin < 3 % Run a demo
    start1 = [0 3]; % really low pixel numbers (bottom left)
    end1 = [2 0]; % really high pixel coordinate numbers (top right)
    dataIn = [0.1 2.99; 1 2]';
end

% Join all of the input data into one single array    
dataIn = horzcat([start1(1), start1(2)]',dataIn, [end1(1), end1(2)]');
   
extracted_easting (1,1) = start1(1);
extracted_northing (1,1) = start1(2);
extracted_easting(2,1) = end1(1);
extracted_northing (2,1) = end1(2);

part1 = diff(extracted_northing);
total_distance_northing = abs(part1);

part1 = diff(extracted_easting);
total_distance_easting = abs(part1);

% First, calculate the straight line distance between the 1st and last
% measurements. This is neccesary to compare the actual distance with the
% corrected distance at the end
% Calculate the angle a
%hypotenuse1 = total_distance_easting/total_distance_northing;
hypotenuse1 = sqrt(total_distance_easting.^2 + total_distance_northing.^2);
a1_angle = atand(hypotenuse1);
clear part1 

% Calculate the remaining angle b
total_profile_b_angle = 180 - a1_angle - 90;

% Calculate the length of the cross section survey
%part1 = sind (total_profile_b_angle);
%cross_section_length = total_distance_northing/part1;
%clear part1 a_angle b_angle length_data

% Assign the cells as zero due to the future points being relative to the
% first
a_angle (1,1) = 0;
b_angle (1,1) = 0;
x (1,1) = 0;
c_angle (1,1) = 0;
c (1,1) = 0;

% Calculate & change the relative points into absolute values
relative_easting = dataIn(1,:) - dataIn(1,1);
relative_northing = dataIn(2,:) - dataIn(2,1);

z = 2;
maxI = size (relative_easting) + 1;

while z < maxI (1,2)
    
    % Calculate the unknown angles of the outside triangle
    part1a = relative_northing (1,z) / relative_easting (1,z);

    a_angle (1,z) = atand(part1a);
    a_angle_abs(1,z) = abs(a_angle(1,z));
    b_angle (1,z) = 180 - 90 - a_angle (1,z);

    % Calculate the distance between the first measurement and the current one
    part1 = sind(a_angle_abs(1,z));
    x (1,z) = relative_northing(1,z)/part1;
    
    % Calculate the remaining neccesary angles of the internal triangle
    
    h = 90-a1_angle;
    normal_length(1,z) = relative_easting (1,z)./sind(a1_angle);
    c(1,z) = normal_length(1,z);
    tangental_length(1,z) = sqrt(c(1,z).^2 - relative_easting(1,z).^2);
    d (1,z) = tangental_length(1,z);
   
    % c (or ans in the demo) is the straight line distance for each survey point along transect
    % line i.e. survey points pulled into the transect line
    
    z = z + 1;

end

%dataOut = [c];%; dataIn(3,:)]';
%[~, rank1] = sort(dataOut(:,1)); % Check to see if c increases with each measurement
%dataOut = dataOut(rank1,:); % Rank the measurements by distance from the origin
dataOut = [x(3)-x(2)];% d(3)-d(2)];
clear a_angle_abs b_angle c_angle_abs d d_angle_abs x x_angle
clear a_angle c_angle d_angle extracted_easting extracted_northing max part1 part2 relative_easting relative_northing total_distance_easting total_distance_northing total_profile_b_angle z 


%xIn = [dataIn(1,1),dataIn(1,4);1,1]';
%%[b] = regress(yIn,xIn);
%aCoefficient = b(2,1); % Pull out the a coefficient in log
%bCoefficient = b(1,1); % Pull out the b coefficient in log
%Ypred = bCoefficient.*xIn(:,1)+aCoefficient;

%xInMove = [dataIn(1,3), dataIn(1,2)]';
%outer = bCoefficient.*xInMove(:,1)+aCoefficient;

