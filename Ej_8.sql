mysql> select * from Demanda;
+-------------+------------+--------+
| Id_producto | Fecha      | Precio |
+-------------+------------+--------+
|        1001 | 2025-01-01 |  19.99 |
|        1001 | 2025-04-15 |  59.99 |
|        1001 | 2025-06-08 |  79.99 |
|        2002 | 2025-04-17 |  39.99 |
|        2002 | 2025-05-19 |  59.99 |
+-------------+------------+--------+
5 rows in set (0.00 sec) 

mysql> SELECT Id_producto, Fecha, Precio
    -> FROM Demanda
    -> WHERE (Id_producto, Fecha) IN (
    ->     SELECT Id_producto, MAX(Fecha)
    ->     FROM Demanda
    ->     GROUP BY Id_producto
    -> );
+-------------+------------+--------+
| Id_producto | Fecha      | Precio |
+-------------+------------+--------+
|        1001 | 2025-06-08 |  79.99 |
|        2002 | 2025-05-19 |  59.99 |
+-------------+------------+--------+
2 rows in set (0.00 sec)


mysql> SELECT * FROM Ventas;
+----------+------------+------------+-------+--------+
| Id_orden | Id_cliente | Fecha      | Total | Estado |
+----------+------------+------------+-------+--------+
|        1 |       1001 | 2025-01-01 |   100 | JAL    |
|        2 |       1001 | 2025-01-01 |   150 | JAL    |
|        3 |       1001 | 2025-01-01 |    75 | JAL    |
|        4 |       1001 | 2025-01-02 |   100 | JAL    |
|        5 |       1001 | 2025-01-03 |   100 | JAL    |
|        6 |       2002 | 2025-01-02 |    75 | JAL    |
|        7 |       2002 | 2025-01-02 |   150 | JAL    |
|        8 |       3003 | 2025-01-01 |   100 | CDMX   |
|        9 |       3003 | 2025-01-02 |   100 | CDMX   |
|       10 |       3003 | 2025-01-03 |   100 | CDMX   |
|       11 |       4004 | 2025-01-04 |   100 | CDMX   |
|       12 |       4004 | 2025-01-05 |    50 | CDMX   |
|       13 |       4004 | 2025-01-05 |   100 | CDMX   |
+----------+------------+------------+-------+--------+
13 rows in set (0.01 sec)

mysql> SELECT DISTINCT Estado
    -> FROM (
    ->     SELECT Id_cliente, Estado, 
    ->            EXTRACT(MONTH FROM Fecha) AS Mes,
    ->            AVG(Total) OVER (PARTITION BY Id_cliente, EXTRACT(MONTH FROM Fecha)) AS Total
    ->     FROM Ventas 
    -> ) AS sub
    -> GROUP BY Estado, Id_cliente
    -> HAVING MIN(Total) > 100;
+--------+
| Estado |
+--------+
| JAL    |
+--------+
1 row in set (0.01 sec)

mysql> SELECT * FROM Ocurrencias ;
+---------+----------------------------------+------------+
| Proceso | Mensaje                          | Ocurrencia |
+---------+----------------------------------+------------+
| Web     | Error: No se puede dividir por 0 |          3 |
| RestAPI | Error: Fallo la conversión       |          5 |
| App     | Error: Fallo la conversión       |          7 |
| RestAPI | Error: Error sin identificar     |          9 |
| Web     | Error: Error sin identificar     |          1 |
| App     | Error: Error sin identificar     |         10 |
| Web     | Estado Completado                |          8 |
| RestAPI | Estado Completado                |          6 |
+---------+----------------------------------+------------+
8 rows in set (0.00 sec)


+---------+----------------------------------+------------+
| Proceso | Mensaje                          | Ocurrencia |
+---------+----------------------------------+------------+
| Web     | Error: No se puede dividir por 0 |          3 |
| App     | Error: Fallo la conversión       |          7 |
| App     | Error: Error sin identificar     |         10 |
| Web     | Estado Completado                |          8 |
+---------+----------------------------------+------------+
4 rows in set (0.00 sec)