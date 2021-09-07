# TP_GDD_2021_2C

## __SQL Private Words__


*palabra*|*que hace*
----------|------------
SELECT | selecciona que columnas queres mostrar 
FROM | de que tabla muestro las columnas
JOIN | combino tablas mediante una union
WHERE | condicion a aplicar una vez que tenemos nuestro universo armado
GROUP BY | agrupo los resultados en base a una/s columnas 
HAVING | condicion luego de agrupar el conjunto 
ORDER BY | ordenamiento de los resultados en base a una condicion

<hr>

## SELECT

selecciona las columnas que quiero trabajar

<hr>

## FROM

<hr>

## JOIN 

El objetivo de esto es agrandar mi universo en base al producto cartesiano entre ambas tablas 
usando el **on** es una interseccion -> _para que un resultado sea visible el elemento tiene que estar en ambos conjuntos_

#### Ejemplo

**que pasa si uno clientes con facturas y un cliente no tiene facturas?**
_ no nos devuelve nada porque no cumple la condicion ambas tablas tienen que tener el elemento_

### Tipos

**cuando se usan ?**
por ejemplo tengo que traer a los alumnos y la cantidad de materias aprobadas.
uso un left join porque necesito a **todos** los alumnos si usamos un join solo puede existir el caso en donde algunos alumnos no hayan aprobado ninguna materia, en ese caso se perderia  

* **LEFT** -> _devuelve el join + los valores que esten en la primer tabla_
* **RIGHT** -> lo mismo que el right.

### Uso 
**select** columna/s **from** tabla1 **join** tabla2 on tab1.col1 = tab2.col1

<hr>

## CASE
permite establecer una seleccion multiple dentro de un SELECT
se usa cuando queremos transformar una columna.

_en caso de que el valor cumpla con mas de una condicion sale por el primero en el que tiene true_

### Tipos
* **con valor de columna **
`	CASE columna	WHEN valor1 THEN exp1
			WHEN valor2 THEN exp2
'
* ** con condicion **

#### Ejemplo 
quiero un alumno con su condicion(aprobado, desaprobado, promocionado, recursa)
select nombreAlumno
from alumnos 
case biribirbi 	


## TOP
_no es ansi (estandar internacional) solamente funciona en SQL Server_
nos devuelve solo una determinada cantidad de filas desde el inicio
se usa cuando queremos un ranking ( se combina con un **order by **)
'SELECT TOP col1,col2,coln FROM tabla1 ORDER BY col1'



## SUBCONSULTAS
es la posibilidad de incorporar uno o varios selects dentro ( es como una funcion de orden superior) 

### Donde lo uso ?
Se puede usar en cualquier comando ( select/from/where/group by/having/order by)
**no se usa en el from**

dependiendo del lugar en que se use viene aplicada una condicion a cumplir.
* **en el select ** 
'SELECT col1,(SELECT col5 FROM tabla2 WHERE col3 = tablas1.col1) FROM tabla1)'
para que esto funcione correctamete el **subselect** me tiene que devolver un unico valor ( para esto nos sirve el TOP :wink:)

* **en el WHERE** 
	* 'SELECT col1, col2 FROM tabla1 WHERE col1 = (SELECT col3 FROM tabla2 WHERE col3 = tablas1.col1)' _en este caso tengo que hacer que el sub select devuelva 1 unico valor para que pueda compararse con el valor col1_ 
	*  'SELECT col1, col2 FROM tabla1 WHERE col1 IN (SELECT col3 FROM tabla2 ' _en este_
	* 'SELECT col1, col2 FROM tabla1 WHERE EXISTS (SELECT col3 FROM tabla2 WHERE col3 = col1)' _no lo toma como un conjunto, pregunta si el subselect existe, si retorna no rows -> el subconj no existe _
