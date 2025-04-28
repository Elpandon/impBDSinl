
mysql> SELECT * FROM Desa;
+----------+----------+
| Producto | Cantidad |
+----------+----------+
| Lápiz    |        3 |
| Borrador |        4 |
| Cuaderno |        2 |
+----------+----------+
3 rows in set (0.00 sec)


mysql> SELECT 'Lápiz' AS Producto, 1 AS Cantidad UNION ALL
    ->      SELECT 'Lápiz', 1 UNION ALL
    ->      SELECT 'Lápiz', 1 UNION ALL
    ->      SELECT 'Borrador', 1 UNION ALL
    ->      SELECT 'Borrador', 1 UNION ALL
    ->      SELECT 'Borrador', 1 UNION ALL
    ->      SELECT 'Borrador', 1 UNION ALL
    ->      SELECT 'Cuaderno', 1 UNION ALL
    ->      SELECT 'Cuaderno', 1;
+----------+----------+
| Producto | Cantidad |
+----------+----------+
| Lápiz    |        1 |
| Lápiz    |        1 |
| Lápiz    |        1 |
| Borrador |        1 |
| Borrador |        1 |
| Borrador |        1 |
| Borrador |        1 |
| Cuaderno |        1 |
| Cuaderno |        1 |
+----------+----------+
9 rows in set (0.00 sec)

mysql> SELECT * FROM asientos;
+-------------+
| num_asiento |
+-------------+
|           7 |
|          13 |
|          14 |
|          15 |
|          27 |
|          28 |
|          29 |
|          30 |
|          31 |
|          32 |
|          33 |
|          34 |
|          35 |
|          52 |
|          53 |
|          54 |
+-------------+
16 rows in set (0.00 sec)

mysql> WITH asientos_ext AS (
    ->   SELECT 0 AS num_asiento
    ->   UNION ALL
    ->   SELECT num_asiento FROM asientos
    -> )
    -> SELECT 
    ->     a.num_asiento + 1 AS espacio_inicio,
    ->     (SELECT MIN(b.num_asiento) - 1 
    ->      FROM asientos_ext b 
    ->      WHERE b.num_asiento > a.num_asiento) AS espacio_final
    -> FROM asientos_ext a
    -> WHERE EXISTS (
    ->     SELECT 1 FROM asientos_ext b 
    ->     WHERE b.num_asiento > a.num_asiento AND b.num_asiento > a.num_asiento + 1
    -> )
    -> AND (SELECT MIN(b.num_asiento) - 1 
    ->      FROM asientos_ext b 
    ->      WHERE b.num_asiento > a.num_asiento) >= a.num_asiento + 1
    -> ORDER BY espacio_inicio;
+----------------+---------------+
| espacio_inicio | espacio_final |
+----------------+---------------+
|              1 |             6 |
|              8 |            12 |
|             16 |            26 |
|             36 |            51 |
+----------------+---------------+
4 rows in set (0.00 sec)


mysql> WITH asientos_ext AS (
    ->     SELECT 0 AS num_asiento
    ->     UNION ALL
    ->     SELECT num_asiento FROM asientos
    -> )
    -> SELECT SUM(espacio_final - espacio_inicio + 1) AS disponibles
    -> FROM (
    ->     SELECT 
    ->         a.num_asiento + 1 AS espacio_inicio,
    ->         (SELECT MIN(b.num_asiento) - 1 
    ->          FROM asientos_ext b 
    ->          WHERE b.num_asiento > a.num_asiento) AS espacio_final
    ->     FROM asientos_ext a
    ->     WHERE EXISTS (
    ->         SELECT 1 
    ->         FROM asientos_ext b 
    ->         WHERE b.num_asiento > a.num_asiento AND b.num_asiento > a.num_asiento + 1
    ->     )
    -> ) AS espacios
    -> WHERE espacio_final >= espacio_inicio;
+-------------+
| disponibles |
+-------------+
|          38 |
+-------------+
1 row in set (0.00 sec)

mysql> SELECT 
    ->     IF(num_asiento % 2 = 0, 'pares', 'impares') AS tipo,
    ->     COUNT(*) AS total
    -> FROM asientos
    -> GROUP BY tipo;
+---------+-------+
| tipo    | total |
+---------+-------+
| impares |     9 |
| pares   |     7 |
+---------+-------+
2 rows in set (0.00 sec)


mysql> SELECT * FROM Futuro;
+------------+------------+
| Inicio     | Final      |
+------------+------------+
| 2025-01-01 | 2025-01-05 |
| 2025-01-03 | 2025-01-09 |
| 2025-01-10 | 2025-01-11 |
| 2025-01-12 | 2025-01-16 |
| 2025-01-15 | 2025-01-19 |
+------------+------------+
5 rows in set (0.01 sec)


mysql> SELECT MIN(inicio) AS Inicio, MAX(final) AS Final FROM (   SELECT inicio, final,     @grupo := IF(@inicio IS NULL OR inicio >
DATE_ADD(@final, INTERVAL 0 DAY),                  @grupo + 1, @grupo) AS grupo,     @inicio := IF(@inicio IS NULL OR inicio > DATE_A
DD(@final, INTERVAL 0 DAY),                   inicio, @inicio),     @final := IF(@final IS NULL OR inicio > DATE_ADD(@final, INTERVAL
 0 DAY),                  final, IF(final > @final, final, @final)) AS final_update   FROM Futuro   ORDER BY inicio ) AS fusionado GR
OUP BY grupo ORDER BY inicio;
+------------+------------+
| Inicio     | Final      |
+------------+------------+
| 2025-01-01 | 2025-01-09 |
| 2025-01-10 | 2025-01-11 |
| 2025-01-12 | 2025-01-19 |
+------------+------------+
3 rows in set, 3 warnings (0.00 sec)
