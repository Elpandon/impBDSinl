mysql> CREATE TABLE Ordenes (
    ->     Id INT PRIMARY KEY,
    ->     Componente VARCHAR(50),
    ->     DiasParaEntregar INT
    -> );
Query OK, 0 rows affected (0.09 sec)

mysql> INSERT INTO Ordenes (Id, Componente, DiasParaEntregar) VALUES
    -> (1, 'Amanecer', 7),
    -> (2, 'Atardecer', 3),
    -> (3, 'Anochecer', 9);
Query OK, 3 rows affected (0.03 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> CREATE TABLE Manufactura (
    ->     Producto VARCHAR(50),
    ->     Componente VARCHAR(50),
    ->     DiasDeManufactura INT
    -> );
Query OK, 0 rows affected (0.04 sec)

mysql> INSERT INTO Manufactura (Producto, Componente, DiasDeManufactura) VALUES
    -> ('Amanecer', 'Photon Coil', 7),
    -> ('Amanecer', 'Filamento', 2),
    -> ('Amanecer', 'Capacitor', 3),
    -> ('Amanecer', 'Esfera', 1),
    -> ('Atardecer', 'Photon Coil', 7),
    -> ('Atardecer', 'Filamento', 2),
    -> ('Anochecer', 'Capacitor', 3),
    -> ('Anochecer', 'Photon Coil', 1);
Query OK, 8 rows affected (0.01 sec)
Records: 8  Duplicates: 0  Warnings: 0



mysql> SELECT 
    ->     o.Id,
    ->     o.Componente AS Producto,
    ->     MAX(m.DiasDeManufactura) AS DiasParaArmar,
    ->     o.DiasParaEntregar,
    ->     CASE 
    ->         WHEN MAX(m.DiasDeManufactura) = o.DiasParaEntregar THEN 'En tiempo'
    ->         WHEN MAX(m.DiasDeManufactura) < o.DiasParaEntregar THEN 'Atrasado'
    ->         ELSE 'Adelantado'
    ->     END AS Calendario
    -> FROM 
    ->     Ordenes o
    -> JOIN 
    ->     Manufactura m ON o.Componente = m.Producto
    -> GROUP BY 
    ->     o.Id, o.Componente, o.DiasParaEntregar
    -> ORDER BY 
    ->     o.Id;
+----+-----------+---------------+------------------+------------+
| Id | Producto  | DiasParaArmar | DiasParaEntregar | Calendario |
+----+-----------+---------------+------------------+------------+
|  1 | Amanecer  |             7 |                7 | En tiempo  |
|  2 | Atardecer |             7 |                3 | Adelantado |
|  3 | Anochecer |             3 |                9 | Atrasado   |
+----+-----------+---------------+------------------+------------+
3 rows in set (0.00 sec)
