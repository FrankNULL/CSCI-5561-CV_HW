function[filter_x, filter_y]= getDifferentialFilter()
filter_y=[1,1, 1; 0,0,0; -1,-1,-1]; % filter_y captures the horizontal edges by the y-component of the gradient
filter_x=[1,0,-1;1,0,-1;1,0,-1];% filter_x captures the vertical edges by the x-component of the gradient