-module(lab8_sol).

% this attribute exports all functions; meant for devel work, but
% we use in this project to avoid having the add our functions to
% an export list.
-compile(export_all).

% Use this function to grab some test data: Shapes = lab6:shapes_data().
shapes_data() ->
  [ { square, 2 }, { circle, 1 }, { square, 1 },
    { square, 3 }, { circle, 2 }, { square, 4 }
  ].

% Use this function to grab some test data: Grades = lab6:grades_data().
grades_data() ->
  [ {bill, 82.0}, {sue, 95}, { john, 85},
    { joe, 73 }, { mary, 65}, { tom, 55}
  ].


%% Exercise 2

perimeter({square, Side}) ->
  4 * Side;
perimeter({circle, Radius}) ->
  2 * 3.14159 * Radius.

guard_perimeter({Type, L}) when Type =:= square ->
  4 * L;
guard_perimeter({Type, L}) when Type =:= circle ->
  2 * 3.14159 * L.

if_perimeter({Type, L}) ->
  if Type =:= square -> 4 * L;
      Type =:= circle -> 2 * 3.14159 * L
  end.

case_perimeter(Shape) ->
  case Shape of
    {square, Side} -> 4 * Side;
    {circle, Radius} -> 2 * 3.14159 * Radius
  end.

letter_grade(Points) when Points > 90 -> 
  'A';
letter_grade(Points) when Points =< 90, Points > 80 -> 
  'B';
letter_grade(Points) when Points =< 80, Points > 70 -> 
  'C';
letter_grade(Points) when Points =< 70, Points > 60 -> 
  'D';
letter_grade(Points) when Points =< 60 -> 
  'F'.

if_letter_grade(Points) ->
  if Points > 90 -> 'A';
      Points =< 90, Points > 80 -> 'B';
      Points =< 80, Points > 70 -> 'C';
      Points =< 70, Points > 60 -> 'D';
      Points =< 60 -> 'F'
  end.

%% Exercise 3.

