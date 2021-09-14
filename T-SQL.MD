#**T-SQL - PL-SQ**

*objetos*|*que hace*
----------|------------
**vista**[link](#vistas)|crea el equivalente a una tabla virtual que represetna los datos de una o mas tablas de una forma alternativa.
**Funciones**|Crea una función definida por el usuario, que es una rutina guardada de Transact-SQL que devuelve un valor
**procedures**|equivalente a cualquier procedimiento de cualquier lenguaje.
**triggers**|solamente existen en los motores de bases de datos, es una clase especial de procedimiento almacenado que se eecuta automaticamente.

<hr>

##vistas##
es un poco mas rapida que un select.
la base de toda la programcion web del siglo XXI son vistas.
solo es una estructura de acceso, no tiene datos (quedan guardadas pero de forma dinamica (queda guardado el select y cuando la consultas éste se ejecuta))
  * _que es?)_ es la persistencia de un select, la creacion de la vista va a estar conformada por una sentencia select (no tiene casi ningun limitante).
  * _cuando se usa?_
    * cuando queremos acceder a una informacion constantemente.
    * cuando queremos ocultar informacion.
###Operaciones###
* _insert_
* _delete_
* _update_
* _select_

###Sintaxis###
`CREATE VIEW[<database_name>.][<owner>.]nombre[(column_name)]
as
select_statement`
**no puede incluir ese select**
* incluir una clausula ODRER BY a menos que tambien haya una clausura TOP en la lista de seleccion de la instruccion SELECT
* incluir la palabra clave INTO
* hacer referencia a una tabla temporal o a una variable del tipo tabla(tabla temporal)

#### INTO ####
crea una tabla nueva en base a un select pero esta tabla nueva solo existe en memoria, cuando cierres el programa desaparece
` select * into TA1 from producto where stoc_deposito = '0001'`

##vistas materializadas##
las vistas materializadas guardan los datos en el momento en el que la ejecutas, cuando l aconsultas de nuevo va a tener los datos que tenia cuando la creaste
es equivalente a una vista con la diferencia que al ekjecutar el select se realiza la captura de los datos existentes a ese momento.
* _que es_ es una vista pero deja de ser virtual, ademas de los accesos tenes los datos, esa abstraccion se materializo. cuando ejecuto va, hace un select into y mete dentro de la vista los datos de ese momento. aka **snapshot**

para que se updatee esta tabla podemos hacer un refresh cada cierto tiempo, estos refresh son idependientes o sea que podes hacer que para cada tabla el tiempo sea uno u otro.
###Sintaxis###
`CREATE MATERIALIZED VIEW nombre AS <select_statement>`

<hr>

##Funcion##
bloque de codigo que resuelve una problematica

_condicionantes_
* las funciones definidas por el usuario no se pueden iutilizar para realizar un conjunto de acciones que modifican el estado global de la base de datos.
* deben retornar un valor.
* las funciones definidas por el usuario, se pueden llamar desde una consulta.
* las funciones definidas por el usuario se modifican utilizando `ALTER FUNCION` y se eliminan mediante `DROP FUNCTION`.

###Funciones Escalares###
`CREATE FUNCTION [owner_name.] nombre ([@parameter_name [as] tipo_dato [= default][..n]]) BEGIN function_body `

###Funciones de valores de tabla en linea###
`CREATE FUNCTION [owner_name.] nombre ([@parameter_name [as] tipo_dato [= default][..n]])RETURNS TABLE [AS] RETURN[(][)] BEGIN function_body `

###Funciones de valores de tabla de multiples instrucciones###
`CREATE FUNCTION [owner_name.] nombre ([@parameter_name [as] tipo_dato [= default][..n]])RETURNS @return_variable table(column_degfinition) [AS] RETURN[(][)] BEGIN function_body `

<hr>
##Procedures##
la diferencia principal es que un procedimiento no retorna valores
otra diferencia es que puede modificar el estado de los datos

###Sintaxis###
`CREATE PROC[EDURE] nombre [@parameter tipo_dato][=default][OUTPUT][..n] AS  sql_Statement[..n] GO`
