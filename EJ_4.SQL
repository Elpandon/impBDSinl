mysql> SELECT * FROM Flujost;
+-----------------+--------+--------+--------+
| Flujo           | Caso_1 | Caso_2 | Caso_3 |
+-----------------+--------+--------+--------+
| Alta de usuario |      0 |      0 |      0 |
| Baja de usuario |      0 |      1 |      1 |
| Nueva Orden     |      1 |      0 |      0 |
| Elimina Orden   |      0 |      0 |      0 |
+-----------------+--------+--------+--------+
4 rows in set (0.00 sec)

mysql> SELECT Flujo, 
    ->        (Caso_1 + Caso_2 + Caso_3) AS Aprobado
    -> FROM Flujost;
+-----------------+----------+
| Flujo           | Aprobado |
+-----------------+----------+
| Alta de usuario |        0 |
| Baja de usuario |        2 |
| Nueva Orden     |        1 |
| Elimina Orden   |        0 |
+-----------------+----------+
4 rows in set (0.00 sec)

mysql> select * from licencia;
+-------------+----------+
| Id_empleado | Licencia |
+-------------+----------+
|        1001 | Tipo A   |
|        1001 | Tipo B   |
|        1001 | Tipo C   |
|        2002 | Tipo A   |
|        2002 | Tipo B   |
|        2002 | Tipo C   |
|        3003 | Tipo A   |
|        3003 | Tipo D   |
|        4004 | Tipo A   |
|        4004 | Tipo B   |
|        4004 | Tipo D   |
|        5005 | Tipo A   |
|        5005 | Tipo B   |
|        5005 | Tipo D   |
+-------------+----------+
14 rows in set (0.01 sec)

mysql> SELECT B.id_empleado, A.id_empleado, COUNT(*) AS coincidencias FROM licencia B JOIN licencia A  ON B.licencia = A.licencia  AN
D B.id_empleado <> A.id_empleado GROUP BY B.id_empleado, A.id_empleado HAVING COUNT(*) = 3;
+-------------+-------------+---------------+
| id_empleado | id_empleado | coincidencias |
+-------------+-------------+---------------+
|        2002 |        1001 |             3 |
|        1001 |        2002 |             3 |
|        5005 |        4004 |             3 |
|        4004 |        5005 |             3 |
+-------------+-------------+---------------+
4 rows in set (0.00 sec)



mysql> WITH Tabla AS (          SELECT Enteros,                  ROW_NUMBER() OVER (ORDER BY Enteros) AS fila,                 COUNT(
*) OVER () AS total          FROM 3M      )      SELECT AVG(Enteros) AS MEDIANA      FROM Tabla      WHERE fila = CEIL(total / 2.0) O
R fila = FLOOR(total / 2.0 + 1);
+---------+
| MEDIANA |
+---------+
| 14.0000 |
+---------+
1 row in set (0.00 sec)

mysql> SELECT Enteros AS MODA
    -> FROM 3M
    -> GROUP BY Enteros
    -> ORDER BY COUNT(*) DESC
    -> LIMIT 1;
+------+
| MODA |
+------+
|   10 |
+------+
1 row in set (0.03 sec)

ysql> SELECT (MAX(Enteros) - MIN(Enteros)) AS RANGO FROM 3M;
+-------+
| RANGO |
+-------+
|    85 |
+-------+
1 row in set (0.00 sec)
