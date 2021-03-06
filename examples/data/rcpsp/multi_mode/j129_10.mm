************************************************************************
file with basedata            : md73_.bas
initial value random generator: 920274719
************************************************************************
projects                      :  1
jobs (incl. supersource/sink ):  14
horizon                       :  91
RESOURCES
  - renewable                 :  2   R
  - nonrenewable              :  2   N
  - doubly constrained        :  0   D
************************************************************************
PROJECT INFORMATION:
pronr.  #jobs rel.date duedate tardcost  MPM-Time
    1     12      0       13        6       13
************************************************************************
PRECEDENCE RELATIONS:
jobnr.    #modes  #successors   successors
   1        1          3           2   3   4
   2        3          3           5   7  10
   3        3          2           5   7
   4        3          3           6   7   8
   5        3          3           6  11  13
   6        3          1          12
   7        3          2           9  13
   8        3          2           9  11
   9        3          1          12
  10        3          3          11  12  13
  11        3          1          14
  12        3          1          14
  13        3          1          14
  14        1          0        
************************************************************************
REQUESTS/DURATIONS:
jobnr. mode duration  R 1  R 2  N 1  N 2
------------------------------------------------------------------------
  1      1     0       0    0    0    0
  2      1     2       0    4    0   10
         2     6       7    0    0    9
         3    10       7    0    5    0
  3      1     4       0    4    6    0
         2     4       8    0    7    0
         3     9       5    0    2    0
  4      1     2       0    4    3    0
         2     6       0    3    0    5
         3     9       8    0    0    2
  5      1     4       0    5    4    0
         2     9       5    0    0    6
         3     9       4    0    3    0
  6      1     4       6    0    0    8
         2     8       4    0    4    0
         3     8       5    0    0    7
  7      1     3       5    0    4    0
         2     3       6    0    0    2
         3     3       0    9    0    2
  8      1     1       8    0    5    0
         2     8       4    0    0    9
         3    10       0    6    0    9
  9      1     3       0    5    0    5
         2     3       2    0    6    0
         3     5       0    5    4    0
 10      1     1       0    7    7    0
         2     6       9    0    7    0
         3     6       7    0    0    6
 11      1     4       0    5    8    0
         2     4       0    6    6    0
         3     6       7    0    5    0
 12      1     1       0    8    8    0
         2     2       0    5    7    0
         3     8       2    0    7    0
 13      1     2      10    0    4    0
         2     3       8    0    0    7
         3     8       8    0    3    0
 14      1     0       0    0    0    0
************************************************************************
RESOURCEAVAILABILITIES:
  R 1  R 2  N 1  N 2
   13    5   40   29
************************************************************************
