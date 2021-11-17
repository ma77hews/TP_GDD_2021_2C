CREATE PROCEDURE Creacion_Tablas_BI AS

	CREATE TABLE [GD2C2021].[SQLI].BI_Dimension_Camion
	(
		idCamion		INT IDENTITY,
		patente			char(7),
		numero_chasis	NVARCHAR(255),
		numero_motor	NVARCHAR(255),
		fecha_alta		SMALLDATETIME
	)

	ALTER TABLE [GD2C2021].[SQLI].BI_Dimension_Camion ADD PRIMARY KEY(idCamion)

/*	CREATE TABLE [GD2C2021].[SQLI].BI_Dimension_Viaje
	(
		idViaje			INT IDENTITY,
		fecha_inicio	DATETIME2(7),
		fecha_fin		DATETIME2(7),
		litros_consu	CHAR(8)
	)

	ALTER TABLE [GD2C2021].[SQLI].BI_Dimension_Viaje ADD PRIMARY KEY(idViaje)
*/
	
	CREATE TABLE [GD2C2021].[SQLI].BI_Dimension_Marca
	(
		idMarca		INT IDENTITY,
		nombre		CHAR(20)
	)

	ALTER TABLE [GD2C2021].[SQLI].BI_Dimension_Marca ADD PRIMARY KEY(idMarca)

	CREATE TABLE [GD2C2021].[SQLI].BI_Dimension_Paquete
	(
		idPaquete		INT IDENTITY,
		tipo			NVARCHAR(255),
		alto_max		DECIMAL(18,2),
		largo_max		DECIMAL(18,2),
		ancho_max		DECIMAL(18,2),
		peso_max		DECIMAL(18,2),
		cantidad		INT,
		precio_base		DECIMAL(18,2),
		precio_final	DECIMAL(18,2)
	)

	ALTER TABLE [GD2C2021].[SQLI].BI_Dimension_Paquete	ADD PRIMARY KEY(idPaquete)
	ALTER TABLE [GD2C2021].[SQLI].BI_Dimension_Paquete	ADD FOREIGN KEY(tipo)		REFERENCES [GD2C2021].[SQLI].Tipo_paquete(t_pack_id)	ON DELETE NO ACTION ON UPDATE NO ACTION ;

	CREATE TABLE [GD2C2021].[SQLI].BI_Dimension_Modelo
	(
		idModelo			INT IDENTITY,
		velocidad_max		INT,
		capacidad_tanque	INT,
		capacidad_carga		INT
	)

	ALTER TABLE [GD2C2021].[SQLI].BI_Dimension_Modelo ADD PRIMARY KEY(idModelo)

	CREATE TABLE [GD2C2021].[SQLI].BI_Dimension_Taller
	(
		idTaller		INT IDENTITY,
		direccion		NVARCHAR(255),
		telefono		DECIMAL(18,0),
		mail			NVARCHAR(255),
		nombre			NVARCHAR(255),
		ciudad			NVARCHAR(255)
	)

	ALTER TABLE [GD2C2021].[SQLI].BI_Dimension_Taller ADD PRIMARY KEY(idTaller)

	CREATE TABLE [GD2C2021].[SQLI].BI_Dimension_Tipo_Tarea
	(
		idTipo		INT,
		tipo_tarea	NVARCHAR(255)
	)

	ALTER TABLE [GD2C2021].[SQLI].BI_Dimension_Tipo_Tarea ADD PRIMARY KEY(idTipo)

	CREATE TABLE [GD2C2021].[SQLI].BI_Dimension_Recorrido
	(
		idRecorrido		INT,
		ciudad_origen	NVARCHAR(255),
		ciudad_destino	NVARCHAR(255),
		km				INT,
		precio			DECIMAL(18,2)
	)

	ALTER TABLE [GD2C2021].[SQLI].BI_Dimension_Recorrido ADD PRIMARY KEY(idRecorrido)

	CREATE TABLE [GD2C2021].[SQLI].BI_Dimension_Chofer
	(
		legajoChofer		INT NOT NULL,
		nombre				NVARCHAR(255),
		apellido			NVARCHAR(255),
		dni					DECIMAL(18,0),
		costo_x_hora		INT,
		direccion			NVARCHAR(255),
		telefono			INT,
		mail				NVARCHAR(255),
		fecha_nacimiento	SMALLDATETIME,
		edad				NVARCHAR(20)
	)

	ALTER TABLE [GD2C2021].[SQLI].BI_Dimension_Chofer ADD PRIMARY KEY(legajoChofer)

	CREATE TABLE [GD2C2021].[SQLI].BI_Dimension_Mecanico
	(
		legajoMecanico		INT NOT NULL,
		nombre				NVARCHAR(255),
		apellido			NVARCHAR(255),
		dni					DECIMAL(18,0),
		costo_x_hora		INT,
		direccion			NVARCHAR(255),
		telefono			INT,
		mail				NVARCHAR(255),
		fecha_nacimiento	SMALLDATETIME,
		edad				NVARCHAR(255)
	)

	ALTER TABLE [GD2C2021].[SQLI].BI_Dimension_Mecanico ADD PRIMARY KEY(legajoMecanico)

	CREATE TABLE [GD2C2021].[SQLI].BI_Dimension_Tiempo
	(
		idTiempo		INT IDENTITY,
		anio			INT,
		cuatrimestre	INT
	)

	ALTER TABLE [GD2C2021].[SQLI].BI_Dimension_Tiempo ADD PRIMARY KEY(idTiempo)

	CREATE TABLE [GD2C2021].[SQLI].BI_Dimension_Herramienta
	(
		idHerramienta	INT,
		detalle			CHAR(50),
		codigo			NVARCHAR(100),
		precio			DECIMAL(18,2)
	)

	ALTER TABLE [GD2C2021].[SQLI].BI_Dimension_Herramienta ADD PRIMARY KEY(idHerramienta)

	CREATE TABLE [GD2C2021].[SQLI].BI_Dimension_ODT
	(
		idODT				INT IDENTITY,
		camion				INT,
		estado				NVARCHAR(255),
		fecha_generacion	NVARCHAR(255)
	)

	ALTER TABLE [GD2C2021].[SQLI].BI_Dimension_ODT	ADD PRIMARY KEY(idODT)
	ALTER TABLE [GD2C2021].[SQLI].BI_Dimension_ODT	ADD FOREIGN KEY(camion)		REFERENCES [GD2C2021].[SQLI].BI_Dimension_Camion(idCamion)	ON DELETE NO ACTION ON UPDATE NO ACTION ;

	CREATE TABLE [GD2C2021].[SQLI].BI_Hechos_Viajes
	(
		tiempo				INT NOT NULL,
		legajo_chofer		INT NOT NULL,
		camion				INT NOT NULL,
		combo_paquete		INT NOT NULL, --Un int que distigue univocamente cada uno de las combinaciones de paquetes
		recorrido_realizado	INT NOT NULL,
		precio_recorrido	INT,
		lts_consumidos		INT,
		duracion_viaje		INT,
		costo_viaje			INT
	)

	ALTER TABLE [GD2C2021].[SQLI].BI_Hechos_Viajes	ADD PRIMARY KEY CLUSTERED(tiempo, legajo_chofer, camion, recorrido_realizado, combo_paquete)
	ALTER TABLE [GD2C2021].[SQLI].BI_Hechos_Viajes	ADD FOREIGN KEY(tiempo)						REFERENCES [GD2C2021].[SQLI].BI_Dimension_Tiempo(idTiempo)			ON DELETE NO ACTION ON UPDATE NO ACTION ;
	ALTER TABLE [GD2C2021].[SQLI].BI_Hechos_Viajes	ADD FOREIGN KEY(camion)						REFERENCES [GD2C2021].[SQLI].BI_Dimension_Camion(idCamion)			ON DELETE NO ACTION ON UPDATE NO ACTION ;
	ALTER TABLE [GD2C2021].[SQLI].BI_Hechos_Viajes	ADD FOREIGN KEY(recorrido_realizado)		REFERENCES [GD2C2021].[SQLI].BI_Dimension_Recorrido(idRecorrido)	ON DELETE NO ACTION ON UPDATE NO ACTION ;
	ALTER TABLE [GD2C2021].[SQLI].BI_Hechos_Viajes	ADD FOREIGN KEY(legajo_chofer)				REFERENCES [GD2C2021].[SQLI].BI_Dimension_Chofer(legajoChofer)		ON DELETE NO ACTION ON UPDATE NO ACTION ;
	ALTER TABLE [GD2C2021].[SQLI].BI_Hechos_Viajes	ADD FOREIGN KEY(combo_paquete)				REFERENCES [GD2C2021].[SQLI].BI_Dimension_Paquete(idPaquete)		ON DELETE NO ACTION ON UPDATE NO ACTION ;

	CREATE TABLE [GD2C2021].[SQLI].BI_Hechos_Reparaciones
	(
		idTiempo		INT NOT NULL,
		idCamion		INT NOT NULL,
		idODT			INT NOT NULL,
		idMarca			INT NOT NULL,
		idModelo		INT NOT NULL,
		idTaller		INT NOT NULL,
		idTipoTarea		INT NOT NULL,
		idMecanico		INT NOT NULL,
		idHerramienta	INT NOT NULL
	)

	ALTER TABLE [GD2C2021].[SQLI].BI_Hechos_Reparaciones ADD PRIMARY KEY CLUSTERED
	(idTiempo, idCamion, idMarca, idModelo, idODT, idTaller, idTipoTarea, idMecanico,
	idHerramienta)
GO

-------------------------------- procedures para realizar las migraciones de las tablas --------------------------------
CREATE PROCEDURE Insercion_Dimension_Camion AS
BEGIN
	INSERT INTO	[GD2C2021].[SQLI].BI_Dimension_Camion (idCamion,patente, nro_chasis, nro_motor, fecha_alta)
	SELECT		cami_id, cami_patente, cami_nro_chasis, cami_nro_motor, cami_fecha_alta
	FROM		[GD2C2021].[SQLI].Camion
END
GO

/*CREATE PROCEDURE Insercion_Dimension_Viaje AS
BEGIN
	INSERT INTO [GD2C2021].[SQLI].BI_Dimension_Viaje(idViaje,fecha_inicio, fecha_fin, litros_consu)
	SELECT		viaje_id, viaje_fecha_ini,viaje_fecha_fin,viaje_lts_cons
	FROM		[GD2C2021].[SQLI].Viaje
END
GO*/

CREATE PROCEDURE Insercion_Dimension_Paquete AS
BEGIN
	INSERT INTO [GD2C2021].[SQLI].BI_Dimension_Paquete(idPaquete,tipo, alto_max,largo_max,
	ancho_max, peso_max, cantidad, precio_base, precio_final)
	SELECT		pack_id, t_pack_descripcion, t_pack_alto_max, t_pack_largo_max, t_pack_ancho_max, t_pack_peso_maximo, pack_cantidad, t_pack_precio, sum(pack_cantidad * t_pack_precio)
	FROM		[GD2C2021].[SQLI].Paquete
	JOIN		[GD2C2021].[SQLI].Tipo_Paquete on tipo_pack_id = pack_tipo
END
GO

CREATE PROCEDURE Insercion_Dimension_Herramienta AS
BEGIN
	INSERT INTO [GD2C2021].[SQLI].BI_Dimension_Herramienta(idHerramienta,detalle, codigo, precio)
	SELECT		herra_id, herra_detalle,herra_code, herra_precio
	FROM		[GD2C2021].[SQLI].Herramientas
END
GO

CREATE PROCEDURE Insercion_Dimension_ODT AS
BEGIN
	INSERT INTO [GD2C2021].[SQLI].BI_Dimension_ODT(idODT, camion, estado, fecha_generacion)
	SELECT		odt_id, idCamion, odt_estado, odt_fecha_generado
	FROM		[GD2C2021].[SQLI].Orden_De_Trabajo
	JOIN		[GD2C2021].[SQLI].BI_Dimension_Camion on odt_camion = idCamion
END
GO

CREATE PROCEDURE Insercion_Dimension_Marca AS
BEGIN
	INSERT INTO [GD2C2021].[SQLI].BI_Dimension_Marca(idMarca,nombre)
	SELECT		marca_id, marca_nombre
	FROM		[GD2C2021].[SQLI].Marca
END
GO

CREATE PROCEDURE Insercion_Dimension_Modelo AS
BEGIN
	INSERT INTO [GD2C2021].[SQLI].BI_Dimension_Modelo(idModelo, velocidad_max, capacidad_tanque, capacidad_carga)
	SELECT		modelo_id, modelo_vel_max,modelo_cap_tanque, modelo_cap_carga
	FROM		[GD2C2021].[SQLI].Modelo
	END
GO

CREATE PROCEDURE Insercion_Dimension_Taller AS
BEGIN
	INSERT INTO [GD2C2021].[SQLI].BI_Dimension_Taller(idTaller, direccion, telefono, mail, nombre, ciudad)
	SELECT		taller_id, taller_direccion,taller_telefono,taller_mail,taller_nombre,ciu.ciudad_nombre
	FROM		[GD2C2021].[SQLI].Taller
	JOIN		[GD2C2021].[SQLI].Ciudad ciu on ciu.ciudad_id = taller_ciudad
END
GO

CREATE PROCEDURE Insercion_Dimension_Tipo_Tarea AS
BEGIN
	INSERT INTO [GD2C2021].[SQLI].BI_Dimension_Tipo_Tarea(idTipo, tipo_tarea)
	SELECT		tipo_id, tipo_tarea
	FROM		[GD2C2021].[SQLI].Tipo_Tarea
END
GO

CREATE PROCEDURE Insercion_Dimension_Recorrido AS
BEGIN
	INSERT INTO [GD2C2021].[SQLI].BI_Dimension_Recorrido(idRecorrido, ciudad_origen, ciudad_destino, km, precio)
	SELECT		reco_id, ori.ciudad_nombre,desti.ciudad_nombre,reco_km, reco_precio
	FROM		[GD2C2021].[SQLI].Recorrido
	JOIN		[GD2C2021].[SQLI].Ciudad ori on ori.ciudad_id = reco_ciudad_origen
	JOIN		[GD2C2021].[SQLI].Ciudad desti on desti.ciudad_id = reco_ciudad_destino
END
GO

CREATE PROCEDURE Insercion_Dimension_Chofer AS
BEGIN
	INSERT INTO [GD2C2021].[SQLI].BI_Dimension_Chofer(legajoChofer, nombre, apellido, dni, costo_x_hora, direccion, telefono, mail, fecha_nacimiento, edad)
	SELECT		chofer_id, chofer_nombre,chofer_apellido,chofer_dni,chofer_direccion,chofer_telefono,chofer_mail,chofer_fecha_nac,chofer_costo_hora, case
		when (2021 - year(chofer_fecha_nac)) between 18 and 30		then '18-30 anios'
		when (2021 - year(chofer_fecha_nac)) between 31 and 50		then '31-50 anios'
		else	'> 50 anios'
		end
	FROM		[GD2C2021].[SQLI].Chofer
END
GO

CREATE PROCEDURE Insercion_Dimension_Mecanico AS
BEGIN
	INSERT INTO [GD2C2021].[SQLI].BI_Dimension_Mecanico(legajoMecanico, nombre, apellido, dni, costo_x_hora, direccion,	telefono, mail, fecha_nacimiento, edad)
	SELECT		meca_nro_legajo, meca_nombre, meca_apellido,meca_dni,meca_direccion,meca_telefono,meca_cost_hora,meca_mail,meca_fecha_nac, case
		when (2021 - year(meca_fecha_nac)) between 18 and 30		then '18-30 anios'
		when (2021 - year(meca_fecha_nac)) between 31 and 50		then '31-50 anios'
		else		'> 50 anios'
		end
	FROM		[GD2C2021].[SQLI].Mecanico
END
GO


CREATE PROCEDURE Insercion_Dimension_Tiempo AS
BEGIN
	INSERT INTO [GD2C2021].[SQLI].BI_Dimension_Tiempo(anio, cuatrimestre)
	(	(SELECT year(viaje_fecha_ini), case
				when month(viaje_fecha_ini) = 1 or month(viaje_fecha_ini) = 2 or month(viaje_fecha_ini) = 3 or month(viaje_fecha_ini) = 4
					then 1
				when month(viaje_fecha_ini) = 5 or month(viaje_fecha_ini) = 6 or month(viaje_fecha_ini) = 7 or month(viaje_fecha_ini) = 8
					then 2
				else 3 
				end
			FROM [GD2C2021].[SQLI].Viaje)
		UNION
		(
			SELECT year(viaje_fecha_fin), case
				when month(viaje_fecha_fin) = 1 or month(viaje_fecha_fin) = 2 or month(viaje_fecha_fin) = 3 or month(viaje_fecha_fin) = 4
					then 1
				when month(viaje_fecha_fin) = 5 or month(viaje_fecha_fin) = 6 or month(viaje_fecha_fin) = 7 or month(viaje_fecha_fin) = 8
					then 2
				else 3 
				end
			FROM [GD2C2021].[SQLI].Viaje
		)
		UNION
		(
			SELECT year(tarea_fecha_inicio), case
				when month(tarea_fecha_inicio) = 1 or month(tarea_fecha_inicio) = 2 or month(tarea_fecha_inicio) = 3 or month(tarea_fecha_inicio) = 4
					then 1
				when month(tarea_fecha_inicio) = 5 or month(tarea_fecha_inicio) = 6 or month(tarea_fecha_inicio) = 7 or month(tarea_fecha_inicio) = 8
					then 2
				else 3 
				end
			FROM [GD2C2021].[SQLI].Tarea_Por_ODT
		)
		UNION
		(
			SELECT year(tarea_fecha_fin), case
				when month(tarea_fecha_fin) = 1 or month(tarea_fecha_fin) = 2 or month(tarea_fecha_fin) = 3 or month(tarea_fecha_fin) = 4
					then 1
				when month(tarea_fecha_fin) = 5 or month(tarea_fecha_fin) = 6 or month(tarea_fecha_fin) = 7 or month(tarea_fecha_fin) = 8
					then 2
				else 3 
				end
			FROM [GD2C2021].[SQLI].Tarea_Por_ODT
		)
	)
END
GO

CREATE PROCEDURE Insercion_Hechos_Viajes AS
BEGIN
	INSERT INTO [GD2C2021].[SQLI].BI_Hechos_Viajes(tiempo, legajo_chofer, camion, combo_paquete, recorrido_realizado, precio_recorrido, lts_consumidos, duracion_viaje, costo_viaje)
	SELECT DISTINCT [GD2C2021].[SQLI].buscarIdDelTiempoSegun(viaje_fecha_ini), viaje_chofer, viaje_camion, pack_id, viaje_recorrido, rec.precio, 
	viaje_lts_cons, DATEDIFF(DAY, viaje_fecha_ini, viaje_fecha_fin), 
	DATEDIFF(DAY, viaje_fecha_ini, viaje_fecha_fin) * ch.costo_x_hora * 8

	FROM [GD2C2021].[SQLI].Viaje
	JOIN [GD2C2021].[SQLI].Paquete on pack_viaje = viaje_id
	JOIN [GD2C2021].[SQLI].BI_Dimension_Chofer ch on ch.legajoChofer = viaje_chofer
	JOIN [GD2C2021].[SQLI].BI_Dimension_Recorrido rec on rec.idRecorrido = viaje_recorrido
END
GO

CREATE FUNCTION buscarIdDelTiempoSegun(@fecha DATETIME(2)) 
RETURNS INT
AS
BEGIN
	DECLARE @pk INT, @cuatri INT, @mes INT

	SET @mes = month(@fecha)
	
	IF(@mes >= 1 AND @mes <= 4)
		BEGIN
			SET @cuatri = 1
		END
	ELSE IF(@mes > 4 AND @mes <= 8)
		BEGIN
			SET @cuatri = 2
		END
	ELSE
		BEGIN
			SET @cuatri = 3
		END	

	SET @pk =	(
					SELECT idTiempo FROM [GD2C2021].[SQLI].BI_Dimension_Tiempo
					WHERE anio = year(@fecha) AND cuatrimestre = @cuatri
				)
END
GO

CREATE PROCEDURE Insercion_Hechos_Reparaciones AS
BEGIN
	/*INSERT INTO [GD2C2021].[SQLI].BI_Hechos_Reparaciones(idTiempo, idCamion, idODT, idMarca, idModelo, idTaller, idTipoTarea, idMecanico, idHerramienta)
	SELECT
	FROM*/
END
GO

-----------------------------------Vistas------------------------------------------------------------------------------
CREATE VIEW [GD2C2021].[SQLI].MAX_TIEMPO_FDS_DE_CADA_CAMION_X_CUATRI AS
BEGIN
		
END
GO

CREATE VIEW [GD2C2021].[SQLI].COSTO_MANTENIMIENTO_X_CAMION_X_TALLER_X_CUATRI AS
BEGIN

END
GO


CREATE VIEW [GD2C2021].[SQLI].DESVIO_PROM_DE_CADA_TAREA_X_TALLER AS
BEGIN

END
GO

CREATE VIEW [GD2C2021].[SQLI].TOP_5_TAREAS_REALIZADAS_X_MODELO AS
BEGIN

END
GO

CREATE VIEW [GD2C2021].[SQLI].TOP_10_HERRAM_MAS_USADAS_X_TALLER AS
BEGIN

END
GO

CREATE VIEW [GD2C2021].[SQLI].FACTURACION_TOTAL_POR_RECORRIDO_POR_CUATRI AS
BEGIN

END
GO

CREATE VIEW [GD2C2021].[SQLI].COSTO_PROM_X_RANGO_ETARIO_CHOFERES AS
BEGIN

END
GO

CREATE VIEW [GD2C2021].[SQLI].GANANCIA_X_CAMION AS
BEGIN

END
GO

-------------------------------- procedure migracion ----------------------------------------------------------------
CREATE PROCEDURE BI_Migracion AS
	
	EXEC Insercion_Dimension_Camion
	EXEC Insercion_Dimension_Marca
	EXEC Insercion_Dimension_Modelo
	EXEC Insercion_Dimension_Taller
	EXEC Insercion_Dimension_Tipo_Tarea
	EXEC Insercion_Dimension_Recorrido
	EXEC Insercion_Dimension_Chofer
	EXEC Insercion_Dimension_Mecanico
	EXEC Insercion_Dimension_Tiempo
	EXEC Insercion_Dimension_Herramienta
	EXEC Insercion_Dimension_Paquete
	EXEC Insercion_Dimension_Viaje
	EXEC Insercion_Dimension_ODT
	EXEC Insercion_Hechos_Reparaciones
	EXEC Insercion_Hechos_Viajes
GO

-------------------------------- procedures para reseteos de tablas -------------------------------------------------
CREATE PROCEDURE BI_Reseteo_Tablas AS

	IF (OBJECT_ID('GD2C2021.SQLI.BI_Dimension_Camion')IS NOT NULL)					DROP TABLE [GD2C2021].[SQLI].BI_Dimension_Camion
	IF (OBJECT_ID('GD2C2021.SQLI.BI_Dimension_Marca')IS NOT NULL)					DROP TABLE [GD2C2021].[SQLI].BI_Dimension_Marca
	IF (OBJECT_ID('GD2C2021.SQLI.BI_Dimension_Modelo')IS NOT NULL)					DROP TABLE [GD2C2021].[SQLI].BI_Dimension_Modelo
	IF (OBJECT_ID('GD2C2021.SQLI.BI_Dimension_Taller')IS NOT NULL)					DROP TABLE [GD2C2021].[SQLI].BI_Dimension_Taller
	IF (OBJECT_ID('GD2C2021.SQLI.BI_Dimension_Tipo_Tarea')IS NOT NULL)				DROP TABLE [GD2C2021].[SQLI].BI_Dimension_Tipo_Tarea
	IF (OBJECT_ID('GD2C2021.SQLI.BI_Dimension_Recorrido')IS NOT NULL)				DROP TABLE [GD2C2021].[SQLI].BI_Dimension_Recorrido
	IF (OBJECT_ID('GD2C2021.SQLI.BI_Dimension_Chofer')IS NOT NULL)					DROP TABLE [GD2C2021].[SQLI].BI_Dimension_Chofer
	IF (OBJECT_ID('GD2C2021.SQLI.BI_Dimension_Mecanico')IS NOT NULL)				DROP TABLE [GD2C2021].[SQLI].BI_Dimension_Mecanico
	IF (OBJECT_ID('GD2C2021.SQLI.BI_Dimension_Paquete')IS NOT NULL)					DROP TABLE [GD2C2021].[SQLI].BI_Dimension_Paquete
	IF (OBJECT_ID('GD2C2021.SQLI.BI_Dimension_Herramienta')IS NOT NULL)				DROP TABLE [GD2C2021].[SQLI].BI_Dimension_Herramienta
	IF (OBJECT_ID('GD2C2021.SQLI.BI_Dimension_Viaje')IS NOT NULL)					DROP TABLE [GD2C2021].[SQLI].BI_Dimension_Viaje
	IF (OBJECT_ID('GD2C2021.SQLI.BI_Dimension_Tiempo')IS NOT NULL)					DROP TABLE [GD2C2021].[SQLI].BI_Dimension_Tiempo
	IF (OBJECT_ID('GD2C2021.SQLI.BI_Dimension_ODT')IS NOT NULL)						DROP TABLE [GD2C2021].[SQLI].BI_Dimension_ODT
	IF (OBJECT_ID('GD2C2021.SQLI.BI_Hechos_Viajes')IS NOT NULL)						DROP TABLE [GD2C2021].[SQLI].BI_Hechos_Viajes
	IF (OBJECT_ID('GD2C2021.SQLI.BI_Hechos_Reparaciones')IS NOT NULL)				DROP TABLE [GD2C2021].[SQLI].BI_Hechos_Reparaciones
GO

CREATE PROCEDURE BI_Reseteo_Procedures AS

	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Creacion_Tablas_BI' AND type = 'p')						DROP PROCEDURE dbo.Creacion_Tablas_BI
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Dimension_Camion' AND type = 'p')				DROP PROCEDURE dbo.Insercion_Dimension_Camion
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Dimension_Marca' AND type = 'p')				DROP PROCEDURE dbo.Insercion_Dimension_Marca
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Dimension_Modelo' AND type = 'p')				DROP PROCEDURE dbo.Insercion_Dimension_Modelo
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Dimension_Taller' AND type = 'p')				DROP PROCEDURE dbo.Insercion_Dimension_Taller
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Dimension_Tipo_Tara' AND type = 'p')			DROP PROCEDURE dbo.Insercion_Dimension_Tipo_Tarea
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Dimension_Recorrido' AND type = 'p')			DROP PROCEDURE dbo.Insercion_Dimension_Recorrido
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Dimension_Chofer' AND type = 'p')				DROP PROCEDURE dbo.Insercion_Dimension_Chofer
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Dimension_Mecanico' AND type = 'p')			DROP PROCEDURE dbo.Insercion_Dimension_Mecanico
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Dimension_Tiempo' AND type = 'p')				DROP PROCEDURE dbo.Insercion_Dimension_Tiempo
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Dimension_Viaje' AND type = 'p')				DROP PROCEDURE dbo.Insercion_Dimension_Viaje
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Dimension_Herramienta' AND type = 'p')		DROP PROCEDURE dbo.Insercion_Dimension_Herramienta
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Dimension_Paquete' AND type = 'p')			DROP PROCEDURE dbo.Insercion_Dimension_Paquete
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Dimension_ODT' AND type = 'p')				DROP PROCEDURE dbo.Insercion_Dimension_ODT
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Hechos_Reparaciones' AND type = 'p')			DROP PROCEDURE dbo.Insercion_Hechos_Reparaciones
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Hechos_Viajes' AND type = 'p')				DROP PROCEDURE dbo.Insercion_Hechos_Viajes
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'BI_Migracion' AND type = 'p')							DROP PROCEDURE dbo.BI_Migracion
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'BI_Vistas' AND type = 'p')								DROP PROCEDURE dbo.BI_Vistas
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'BI_Reseteo_Tablas' AND type = 'p')						DROP PROCEDURE dbo.BI_Reseteo_Tablas
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'BI_Reseteo_Procedures' AND type = 'p')					DROP PROCEDURE dbo.BI_Reseteo_Procedures
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'BI_Reseteo' AND type = 'p')								DROP PROCEDURE dbo.BI_Reseteo
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'BI_Play' AND type = 'p')								DROP PROCEDURE dbo.BI_Play
GO

CREATE PROCEDURE BI_Reseteo_Vistas AS
BEGIN
	IF EXISTS(select * FROM sys.views where name = 'MAX_TIEMPO_FDS_DE_CADA_CAMION_X_CUATRI')			DROP VIEW [GD2C2021].[SQLI].MAX_TIEMPO_FDS_DE_CADA_CAMION_X_CUATRI
	IF EXISTS(select * FROM sys.views where name = 'COSTO_MANTENIMIENTO_X_CAMION_X_TALLER_X_CUATRI')	DROP VIEW [GD2C2021].[SQLI].COSTO_MANTENIMIENTO_X_CAMION_X_TALLER_X_CUATRI
	IF EXISTS(select * FROM sys.views where name = 'DESVIO_PROM_DE_CADA_TAREA_X_TALLER')				DROP VIEW [GD2C2021].[SQLI].DESVIO_PROM_DE_CADA_TAREA_X_TALLER
	IF EXISTS(select * FROM sys.views where name = 'TOP_5_TAREAS_REALIZADAS_X_MODELO')					DROP VIEW [GD2C2021].[SQLI].TOP_5_TAREAS_REALIZADAS_X_MODELO
	IF EXISTS(select * FROM sys.views where name = 'TOP_10_HERRAM_MAS_USADAS_X_TALLER')					DROP VIEW [GD2C2021].[SQLI].TOP_10_HERRAM_MAS_USADAS_X_TALLER
	IF EXISTS(select * FROM sys.views where name = 'FACTURACION_TOTAL_POR_RECORRIDO_POR_CUATRI')		DROP VIEW [GD2C2021].[SQLI].FACTURACION_TOTAL_POR_RECORRIDO_POR_CUATRI
	IF EXISTS(select * FROM sys.views where name = 'COSTO_PROM_X_RANGO_ETARIO_CHOFERES')				DROP VIEW [GD2C2021].[SQLI].COSTO_PROM_X_RANGO_ETARIO_CHOFERES
	IF EXISTS(select * FROM sys.views where name = 'GANANCIA_X_CAMION')									DROP VIEW [GD2C2021].[SQLI].GANANCIA_X_CAMION
END
GO

CREATE PROCEDURE BI_Reseteo AS
BEGIN
	EXEC BI_Reseteo_Tablas
	EXEC BI_Reseteo_Procedures
	EXEC BI_Reseteo_Vistas
END
GO

----------------------------------------------Procedure principal------------------------------------------
CREATE PROCEDURE BI_Play AS
BEGIN
	IF EXISTS (SELECT * FROM   sys.schemas WHERE  NAME = 'SQLI')
		BEGIN
			EXEC BI_Reseteo
			DROP SCHEMA SQLI
		END
	ELSE
		BEGIN
			EXEC ('use [GD2C2021]')
			EXEC ('create schema SQLI')
			EXEC Creacion_Tablas_BI
			EXEC BI_Migracion
		END
END
GO

---------------------------------Ejecuta esto----------------------------------------------------------------
EXEC BI_Play