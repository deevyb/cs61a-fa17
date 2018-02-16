CREATE TABLE parents AS
  SELECT "abraham" AS parent, "barack" AS child UNION
  SELECT "abraham"          , "clinton"         UNION
  SELECT "delano"           , "herbert"         UNION
  SELECT "fillmore"         , "abraham"         UNION
  SELECT "fillmore"         , "delano"          UNION
  SELECT "fillmore"         , "grover"          UNION
  SELECT "eisenhower"       , "fillmore";

CREATE TABLE dogs AS
  SELECT "abraham" AS name, "long" AS fur, 26 AS height UNION
  SELECT "barack"         , "short"      , 52           UNION
  SELECT "clinton"        , "long"       , 47           UNION
  SELECT "delano"         , "long"       , 46           UNION
  SELECT "eisenhower"     , "short"      , 35           UNION
  SELECT "fillmore"       , "curly"      , 32           UNION
  SELECT "grover"         , "short"      , 28           UNION
  SELECT "herbert"        , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;

-------------------------------------------------------------
-- PLEASE DO NOT CHANGE ANY SQL STATEMENTS ABOVE THIS LINE --
-------------------------------------------------------------

-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT name, size FROM dogs, sizes WHERE height > min AND height <= max;

-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_height AS
  SELECT DISTINCT c.name FROM dogs AS c, parents AS p, dogs AS p2 WHERE c.name = p.child AND p2.name = p.parent ORDER BY p2.height DESC;

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  WITH siblings(first, second) AS (SELECT a.child, b.child FROM parents AS a, parents AS b WHERE a.parent = b.parent AND a.child < b.child)
  SELECT first || " and " || second || " are " || a.size || " siblings" FROM siblings, size_of_dogs AS a, size_of_dogs AS b WHERE a.name = first AND b.name = second AND a.size = b.size;

-- Ways to stack 4 dogs to a height of at least 170, ordered by total height
CREATE TABLE stacks AS
  WITH helper(dog, num_dogs, last_height, total_height) AS (
    SELECT name, 1, height, height FROM dogs UNION
    SELECT dog || ", " || name, num_dogs+1, height, total_height+height FROM helper, dogs WHERE height > last_height AND num_dogs < 4
  )
  SELECT dog, total_height FROM helper WHERE total_height >= 170 ORDER BY total_height;
