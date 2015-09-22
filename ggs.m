function [Q, R] = ggs(A, Q, R)

if nargin < 3 || isempty(Q) || isempty(R)
    Q = [];
    R = [];
end

[m, n] = size(A);
[r0, n0] = size(R);

if ~isempty(Q) && size(Q, 1) ~= m
    error('A and Q have inconsistent row sizes')
end

if ~isempty(Q) && size(Q, 2) ~= r0
    error('Q and R have inconsistent sizes')
end

% Your code here