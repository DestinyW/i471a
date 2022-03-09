%f(1, 2, z) = f(_, _, X).
%head(a, tail(z, B), Y) = head(_, tail(X, _), _).
%cons(a, cons(b, cons(c, z))) = cons(_, cons(_, cons(_, X))).

%the proper lists are [a, b]. and [a | [b]].

%expression for cddr: [1, 2, 3, 4] = [_, _ | X].
%epression for caddr: [1, 2, 3, 4] = [_ | [_ | [X | [_]]]].
%expression for cdar: [[1, 2], 3, 4] = [X | _].

quadratic_roots(A, B, C, Z):-
    Discriminant is sqrt(B*B - 4*A*C),
    Z is (-B + Discriminant) / (2*A).

quadratic_roots(A, B, C, Z):-
    Discriminant is sqrt(B*B - 4*A*C),
    Z is (-B - Discriminant) / (2*A).

quadratic_roots2(A, B, C, Z) :-
    Discriminant is sqrt(B*B - 4*A*C),
    aux_quadratic_roots(A, B, Discriminant, Z).

aux_quadratic_roots(A, B, Discr, Z):-
    Z is (-B + Discr) / (2*A).

aux_quadratic_roots(A, B, Discr, Z):-
    Z is (-B - Discr) / (2*A).

sum_lengths([], 0).
sum_lengths([L|Ls], Z):-
    sum_lengths(Ls, LsZ),
    length(L, X),
    Z is X + LsZ.