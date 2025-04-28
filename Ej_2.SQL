 SELECT * FROM Compras1;
+----------+
| carrito1 |
+----------+
| azucar   |
| pan      |
| jugo     |
| refresco |
| harina   |
+----------+
5 rows in set (0.00 sec)
mysql> SELECT * FROM Compras2;
+-------------+
| carrito2    |
+-------------+
| azucar      |
| pan         |
| mantequilla |
| queso       |
| manzana     |
+-------------+
5 rows in set (0.00 sec)
mysql> SELECT * FROM Compras1 LEFT OUTER JOIN Compras2 ON carrito1 = carrito2 union SELECT * FROM Compras1 RIGHT OUTER JOIN Compras2
ON carrito1 = carrito2;
+----------+-------------+
| carrito1 | carrito2    |
+----------+-------------+
| azucar   | azucar      |
| pan      | pan         |
| jugo     | NULL        |
| refresco | NULL        |
| harina   | NULL        |
| NULL     | mantequilla |
| NULL     | queso       |
| NULL     | manzana     |
+----------+-------------+
8 rows in set (0.00 sec)






mysql> Select * FROM Predicados;
+-----------+---------+---------+-------+
| IDcliente | IDorden | Destino | Costo |
+-----------+---------+---------+-------+
|      1001 |       1 | JAL     | $987  |
|      1001 |       2 | CDMX    | $400  |
|      1001 |       3 | CDMX    | $545  |
|      1001 |       4 | CDMX    | $321  |
|      2002 |       5 | MTY     | $324  |
|      3003 |       6 | JAL     | $931  |
|      4004 |       7 | JAL     | $876  |
|      5005 |       8 | CDMX    | $567  |
+-----------+---------+---------+-------+
8 rows in set (0.00 sec)
mysql> Select * FROM Predicados where IDcliente=1001 AND Destino='CDMX';
+-----------+---------+---------+-------+
| IDcliente | IDorden | Destino | Costo |
+-----------+---------+---------+-------+
|      1001 |       2 | CDMX    | $400  |
|      1001 |       3 | CDMX    | $545  |
|      1001 |       4 | CDMX    | $321  |
+-----------+---------+---------+-------+
3 rows in set (0.00 sec)


