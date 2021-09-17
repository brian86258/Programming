/*
610. Triangle Judgement
For the sample data above, your query should return the follow result:
| x  | y  | z  | triangle |
|----|----|----|----------|
| 13 | 15 | 30 | No       |
| 10 | 20 | 15 | Yes      |

Create table If Not Exists triangle (x int, y int, z int);
insert into triangle (x, y, z) values ('13', '15', '30');
insert into triangle (x, y, z) values ('10', '20', '15');
*/

SELECT x,y,z,
(CASE
WHEN x+y>z AND y+z>x AND x+z>y
THEN 'Yes'
ELSE 'No'
END) AS 'triangle' FROM triangle
