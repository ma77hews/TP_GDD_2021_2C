# TP_GDD_2021_2C

## __SQL Private Words__


*palabra*|*que hace*
----------|------------
SELECT - selecciona que columnas queres mostrar 
FROM - de que tabla muestro las columnas
JOIN - combino tablas mediante una union
WHERE - condicion a aplicar una vez que tenemos nuestro universo armado
GROUP BY - agrupo los resultados en base a una/s columnas 
HAVING - condicion luego de agrupar el conjunto 
ORDER BY - ordenamiento de los resultados en base a una condicion


## SELECT
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
