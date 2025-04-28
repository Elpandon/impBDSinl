mysql> SELECT * FROM Letras;
+-------+-------+-------+
| CasoA | CasoB | CasoC |
+-------+-------+-------+
| A     | B     | C     |
+-------+-------+-------+
1 row in set (0.01 sec)
mysql> SELECT A.CasoA, B.CasoB, C.CasoC
    ->      FROM (SELECT 'A' AS CasoA UNION ALL
    ->            SELECT 'B' UNION ALL
    ->            SELECT 'C') AS A
    ->      CROSS JOIN (SELECT 'A' AS CasoB UNION ALL
    ->                  SELECT 'B' UNION ALL
    ->                  SELECT 'C') AS B
    ->      CROSS JOIN (SELECT 'A' AS CasoC UNION ALL
    ->                  SELECT 'B' UNION ALL
    ->                  SELECT 'C') AS C
    ->      WHERE A.CasoA <> B.CasoB
    ->        AND A.CasoA <> C.CasoC
    ->        AND B.CasoB <> C.CasoC;
+-------+-------+-------+
| CasoA | CasoB | CasoC |
+-------+-------+-------+
| B     | C     | A     |
| C     | B     | A     |
| A     | C     | B     |
| C     | A     | B     |
| A     | B     | C     |
| B     | A     | C     |
+-------+-------+-------+
6 rows in set (0.01 sec)


mysql> Select * from Promedios;
+------------+--------------+
| Desarrollo | Finalizacion |
+------------+--------------+
| RestAPI    | 2024-06-01   |
| RestAPI    | 2024-06-14   |
| RestAPI    | 2024-06-15   |
| Web        | 2024-06-01   |
| Web        | 2024-06-02   |
| Web        | 2024-06-19   |
| App        | 2024-06-01   |
| App        | 2024-06-15   |
| App        | 2024-06-30   |
+------------+--------------+
9 rows in set (0.00 sec)

mysql> SELECT Desarrollo, AVG(DIFERENCIA) AS Promedio
    ->  FROM (
    ->  SELECT  Desarrollo, DATEDIFF(Finalizacion, LAG(Finalizacion) OVER (PARTITION BY Desarrollo ORDER BY Finalizacion)) AS DIFERENCIA
    ->  FROM Promedios
    ->  ) AS A
    ->  GROUP BY Desarrollo;
+------------+----------+
| Desarrollo | Promedio |
+------------+----------+
| App        |  14.5000 |
| RestAPI    |   7.0000 |
| Web        |   9.0000 |
+------------+----------+


mysql> SELECT * FROM Inventario;
+------------+--------+
| fecha      | ajuste |
+------------+--------+
| 2025-01-03 | 100    |
| 2025-01-04 | 75     |
| 2025-01-05 | -150   |
| 2025-01-06 | 50     |
| 2025-01-07 | -70    |
+------------+--------+
5 rows in set (0.00 sec)
mysql> SELECT fecha,  ajuste,  SUM(ajuste) OVER (ORDER BY fecha) AS Inventario FROM Inventario;
+------------+--------+------------+
| fecha      | ajuste | Inventario |
+------------+--------+------------+
| 2025-01-03 | 100    |        100 |
| 2025-01-04 | 75     |        175 |
| 2025-01-05 | -150   |         25 |
| 2025-01-06 | 50     |         75 |
| 2025-01-07 | -70    |          5 |
+------------+--------+------------+
5 rows in set (0.00 sec)