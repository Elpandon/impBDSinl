SELECT 
    d1.IDCustomer,
    d2.Number AS Celular,
    d3.Number AS Trabajo,
    d4.Number AS Casa
    FROM DirectorioTelefonico d1
    LEFT JOIN DirectorioTelefonico d2 ON d1.IDCustomer = d2.IDCustomer AND d2.TypePhone = 'Celular'
    LEFT JOIN DirectorioTelefonico d3 ON d1.IDCustomer = d3.IDCustomer AND d3.TypePhone = 'Trabajo'
    LEFT JOIN DirectorioTelefonico d4 ON d1.IDCustomer = d4.IDCustomer AND d4.TypePhone = 'Casa'
    GROUP BY d1.IDCustomer;
mysql> SELECT 
    ->     d1.IDCustomer,
    ->     d2.Number AS Celular,
    ->     d3.Number AS Trabajo,
    ->     d4.Number AS Casa
    ->     FROM DirectorioTelefonico d1
    ->     LEFT JOIN DirectorioTelefonico d2 ON d1.IDCustomer = d2.IDCustomer AND d2.TypePhone = 'Celular'
    ->     LEFT JOIN DirectorioTelefonico d3 ON d1.IDCustomer = d3.IDCustomer AND d3.TypePhone = 'Trabajo'
    ->     LEFT JOIN DirectorioTelefonico d4 ON d1.IDCustomer = d4.IDCustomer AND d4.TypePhone = 'Casa'
    ->     GROUP BY d1.IDCustomer;
+------------+--------------+--------------+--------------+
| IDCustomer | Celular      | Trabajo      | Casa         |
+------------+--------------+--------------+--------------+
|       1001 | 333-897-5421 | 333-897-6542 | 333-698-9874 |
|       2002 | 333-963-6544 | 333-812-9856 | NULL         |
|       3003 | 333-987-6541 | NULL         | NULL         |
+------------+--------------+--------------+--------------+
3 rows in set (0.01 sec)

mysql> SELECT * FROM EtapasDesarrollo;
+------------+-------+-------------------+
| Desarrollo | Etapa | FechaFinalizacion |
+------------+-------+-------------------+
| RestAPI    | 1     | 0000-00-00        |
| RestAPI    | 2     | 0000-00-00        |
| RestAPI    | 3     | 0000-00-00        |
| Web        | 1     | 0000-00-00        |
| Web        | 2     | 0000-00-00        |
| Web        | 3     | NULL              |
| App        | 1     | 0000-00-00        |
| App        | 2     | NULL              |
+------------+-------+-------------------+
8 rows in set (0.00 sec)
mysql> SELECT Desarrollo FROM EtapasDesarrollo WHERE FechaFinalizacion IS NULL;
+------------+
| Desarrollo |
+------------+
| Web        |
| App        |
+------------+
2 rows in set (0.00 sec)


mysql>  SELECT * FROM Candidatos;
+--------------+-------------+
| IdCandidatos | Descripcion |
+--------------+-------------+
|         1001 | Geólogo     |
|         1001 | Astrónomo   |
|         1001 | Bioquímico  |
|         1001 | Técnico     |
|         2002 | Cirujano    |
|         2002 | Mecánico    |
|         2002 | Geólogo     |
|         3003 | Geólogo     |
|         3003 | Astrónomo   |
|         4004 | Ingeniero   |
+--------------+-------------+
10 rows in set (0.00 sec)
mysql> SELECT IdCandidatos
    ->     FROM Candidatos 
    ->     WHERE Descripcion IN ('Geologo', 'Astronomo', 'Tecnico')
    ->     GROUP BY IdCandidatos
    ->     HAVING COUNT(DISTINCT Descripcion) = 3;
+--------------+
| IdCandidatos |
| IdCandidatos |
+--------------+
|         1001 |
+--------------+
1 row in set (0.00 sec)