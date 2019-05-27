function [H1, H2] = ComputeRectification(K, R, C)
rx_t=(C./norm(C))';
rz_tilde=[0;0;1];
rz= (rz_tilde- (dot(rz_tilde,rx_t')*rx_t'))./norm(rz_tilde- (dot(rz_tilde,rx_t')*rx_t'));
ry=cross(rz,rx_t');

R_rect=[rx_t; ry'; rz'];

H1=K*R_rect*inv(K);
H2=K*R_rect*R'*inv(K);
end