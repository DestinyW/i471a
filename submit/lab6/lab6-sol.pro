%f(1, 2, z) = f(_, _, X).
%head(a, tail(z, B), Y) = head(_, tail(X, _), _).
%cons(a, cons(b, cons(c, z))) = cons(_, cons(_, cons(_, X))).

%the proper lists are [a, b]. and [a | [b]].

%[1, 2, 3, 4] = [_, _ | X].
%[1, 2, 3, 4] = [_ | [_ | [X | [_]]]].
%[[1, 2], 3, 4] = [X | _].