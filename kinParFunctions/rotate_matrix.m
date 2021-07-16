%function that calculates rotation of matrix
%name: rotate_matrix

%inputs:
%row of vector
%column of vector
%degrees to rotate

%outputs
%row of vector
%column of vector

function[rot_row,rot_col] = rotate_matrix(row,col,angleindegrees)

%nargin - says if synthase of function is not correct
if nargin~=3;
    disp('usage(row,column,angle in degrees)');
    return;
end
      %transform degrees in radians
    angleinradians = angleindegrees*pi/180;
    
    
    %Rotate matrix
    rot_row = row*cos(angleinradians)-col*sin(angleinradians);
    rot_col = row*sin(angleinradians)+col*cos(angleinradians);
