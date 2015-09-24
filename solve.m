function [x, N, W, L, Q, R] = solve(A, b)

[Q, R] = ggs(A, [], []);

[m, n] = size(Q);
[Qn, Rn] = ggs(eye(m), Q, R);
L = Qn(:, n+1:end);


[W, Rw] = ggs(A', [], []);

[r, col] = size(W);
[Qw, Rw] = ggs(eye(r), W, Rw);
N = Qw(:, col+1:end);

c = Q*b';

pivotColumns = [];
for rC = 1:size(R, 2)
    for rR = rC:size(R, 1)
        if abs(R(rR,rC)) > sqrt(eps)
            pivotColumns = [pivotColumns rC];
            break;
        end
    end
end
i = n;
while i > 0
    if ismember(i,pivotColumns)
        x(i) = c(i);
        for j = i+1:n
            x(i) = x(i) - x(j)*R(i, j);
        end
        x(i) = x(i)/R(i, i);
        i = i-1;
    end
end

% i = n
% while i > 0
%     curNumVariables = sum(arrayfun(@(x) abs(x) > sqrt(eps), R(n,:)));
%     expectedNumVariables = n-i+1;
%     diff = curNumVariables - expectedNumVariables;
%     i = i - diff;
%     x(i) = b(i);
%     for j = i+1:n
%         x(i) = x(i) - x(j)*R(i, j);
%     end
%     x(i) = x(i)/R(i, i);
%     i = i-1;
% end

end