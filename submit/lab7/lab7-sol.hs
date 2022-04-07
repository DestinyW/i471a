-- Exercise 1

-- function which adds two numbers
add n1 n2 = n1 + n2

-- same, but define without using args
plus = (+)

-- function which concats two lists
conc ls1 ls2 = ls1 ++ ls2

-- What happens if the parentheses are omitted on the second-last line above? Why?
-- Answer: it throws an error stating that the function 'conc' is applied too many arguments, thus omitting the parentheses treats each keyword as an argument applied to the first 'conc'

-- Why does the last line result in an error?
-- Answer: lists must be homogeneous, thus you cannot cons a list of type Char with a list of type Num

-- partially apply above functions:

add10 = add 10
plus5 = plus 5
concHello = conc "hello"

-- Exercise 2

first (v, _) = v
second (_, v) = v

fst3 (v, _, _) = v
snd3 (_, v, _) = v

sumFirst2 :: Num a => [a] -> a
sumFirst2 (x1:x2:xs) = x1 + x2

fnFirst2 :: [a] -> (a -> a -> b) -> (a -> a -> b) -> b
fnFirst2 = 
    \(l1:l2:ls) f1 f2 -> if (length (l1:l2:ls)) == 2
        then f1 l1 l2
        else f2 l1 l2

-- Exercise 3

cartesianProduct ls1 ls2 =
  [ (x, y) | x <- ls1, y <- ls2 ]

cartesianProductIf ls1 ls2 predicate =
  [ (x, y) | x <- ls1, y <- ls2, predicate x y ]

oddEvenPairs n = [ (x, y) | x <- [1..n], y <- [1..n], odd x, even y ]