************************************************************************
file with basedata            : cm142_.bas
initial value random generator: 1580661546
************************************************************************
projects                      :  1
jobs (incl. supersource/sink ):  18
horizon                       :  95
RESOURCES
  - renewable                 :  2   R
  - nonrenewable              :  2   N
  - doubly constrained        :  0   D
************************************************************************
PROJECT INFORMATION:
pronr.  #jobs rel.date duedate tardcost  MPM-Time
    1     16      0       37       11       37
************************************************************************
PRECEDENCE RELATIONS:
jobnr.    #modes  #successors   successors
   1        1          3           2   3   4
   2        1          3           6  10  11
   3        1          3           6   7  14
   4        1          2           5  10
   5        1          3          11  14  16
   6        1          2           8   9
   7        1          1           9
   8        1          1          12
   9        1          3          12  13  15
  10        1          3          12  14  15
  11        1          1          15
  12        1          2          16  17
  13        1          2          16  17
  14        1          1          17
  15        1          1          18
  16        1          1          18
  17        1          1          18
  18        1          0        
************************************************************************
REQUESTS/DURATIONS:
jobnr. mode duration  R 1  R 2  N 1  N 2
------------------------------------------------------------------------
  1      1     0       0    0    0    0
  2      1     9       0    7    6    6
  3      1    10       0    8    6    5
  4      1     7      10    0    2    3
  5      1     7       0    3    3    6
  6      1     6       4    0    5    1
  7      1    10       9    0    1    8
  8      1     5       0    1    9    5
  9      1     3       0    7    9    6
 10      1     3       3    0    4    4
 11      1     3       0    8    3    8
 12      1    10       0    7    9    4
 13      1     1       5    0    3    4
 14      1     8       0    3    8    4
 15      1     7       2    0   10    4
 16      1     4       0    5    2    2
 17      1     2       8    0    2    7
 18      1     0       0    0    0    0
************************************************************************
RESOURCEAVAILABILITIES:
  R 1  R 2  N 1  N 2
   13   13   82   77
************************************************************************
