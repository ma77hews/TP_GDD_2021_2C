CREATE PROCEDURE Creacion_Tablas_BI AS

	CREATE TABLE [GD2C2021].[SQLI].BI_Dimension_Camion
	(
		idCamion		INT NOT NULL,
		patente			NVARCHAR(255),
		numero_chasis	NVARCHAR(255),
		numero_motor	NVARCHAR(255),
		fecha_alta		DATETIME2(3)
	)

	ALTER TABLE [GD2C2021].[SQLI].BI_Dimension_Camion ADD PRIMARY KEY(idCamion)
	
	CREATE TABLE [GD2C2021].[SQLI].BI_Dimension_Marca
	(
		idMarca		INT NOT NULL,
		nombre		CHAR(20)
	)

	ALTER TABLE [GD2C2021].[SQLI].BI_Dimension_Marca ADD PRIMARY KEY(idMarca)
	
	CREATE TABLE [GD2C2021].[SQLI].BI_Dimension_Paquete
	(
		idPaquete		INT NOT NULL,
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
	
	CREATE TABLE [GD2C2021].[SQLI].BI_Dimension_Modelo
	(
		idModelo			INT NOT NULL,
		nombre				NVARCHAR(255),
		velocidad_max		INT,
		capacidad_tanque	INT,
		capacidad_carga		INT
	)

	ALTER TABLE [GD2C2021].[SQLI].BI_Dimension_Modelo ADD PRIMARY KEY(idModelo)

	CREATE TABLE [GD2C2021].[SQLI].BI_Dimension_Taller
	(
		idTaller		INT NOT NULL,
		direccion		NVARCHAR(255),
		telefono		DECIMAL(18,0),
		mail			NVARCHAR(255),
		nombre			NVARCHAR(255),
		ciudad			NVARCHAR(255)
	)

	ALTER TABLE [GD2C2021].[SQLI].BI_Dimension_Taller ADD PRIMARY KEY(idTaller)

	CREATE TABLE [GD2C2021].[SQLI].BI_Dimension_Tarea
	(
		idTarea			INT NOT NULL,
		detalle			NVARCHAR(255),
		tipo			NVARCHAR(255),
		tiempo_estimado	INT
	)

	ALTER TABLE [GD2C2021].[SQLI].BI_Dimension_Tarea ADD PRIMARY KEY(idTarea)

	CREATE TABLE [GD2C2021].[SQLI].BI_Dimension_Recorrido
	(
		idRecorrido		INT NOT NULL,
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
		edad				NVARCHAR(20)
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
		idHerramienta	INT NOT NULL,
		detalle			CHAR(50),
		codigo			NVARCHAR(100),
		precio			DECIMAL(18,2),
		cantidad		INT
	)

	ALTER TABLE [GD2C2021].[SQLI].BI_Dimension_Herramienta ADD PRIMARY KEY(idHerramienta)

	CREATE TABLE [GD2C2021].[SQLI].BI_Dimension_ODT
	(
		idODT				INT NOT NULL,
		estado				NVARCHAR(255),
		fecha_generacion	NVARCHAR(255)
	)

	ALTER TABLE [GD2C2021].[SQLI].BI_Dimension_ODT	ADD PRIMARY KEY(idODT)
	
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
		tiempo			INT NOT NULL,
		camion			INT NOT NULL,
		marca			INT NOT NULL,
		modelo			INT NOT NULL,
		odt				INT NOT NULL,
		taller			INT NOT NULL,
		tarea			INT NOT NULL,
		legajo_mecanico	INT NOT NULL,
		herramienta		INT NOT NULL
	)

	ALTER TABLE [GD2C2021].[SQLI].BI_Hechos_Reparaciones ADD PRIMARY KEY CLUSTERED
	(tiempo, camion, marca, modelo, odt, taller, tarea, legajo_mecanico,
	herramienta)

	ALTER TABLE [GD2C2021].[SQLI].BI_Hechos_Reparaciones	ADD FOREIGN KEY(tiempo)				REFERENCES [GD2C2021].[SQLI].BI_Dimension_Tiempo(idTiempo)					ON DELETE NO ACTION ON UPDATE NO ACTION ;
	ALTER TABLE [GD2C2021].[SQLI].BI_Hechos_Reparaciones	ADD FOREIGN KEY(camion)				REFERENCES [GD2C2021].[SQLI].BI_Dimension_Camion(idCamion)					ON DELETE NO ACTION ON UPDATE NO ACTION ;
	ALTER TABLE [GD2C2021].[SQLI].BI_Hechos_Reparaciones	ADD FOREIGN KEY(marca)				REFERENCES [GD2C2021].[SQLI].BI_Dimension_Marca(idMarca)					ON DELETE NO ACTION ON UPDATE NO ACTION ;
	ALTER TABLE [GD2C2021].[SQLI].BI_Hechos_Reparaciones	ADD FOREIGN KEY(modelo)				REFERENCES [GD2C2021].[SQLI].BI_Dimension_Modelo(idModelo)					ON DELETE NO ACTION ON UPDATE NO ACTION ;
	ALTER TABLE [GD2C2021].[SQLI].BI_Hechos_Reparaciones	ADD FOREIGN KEY(odt)				REFERENCES [GD2C2021].[SQLI].BI_Dimension_ODT(idODT)						ON DELETE NO ACTION ON UPDATE NO ACTION ;
	ALTER TABLE [GD2C2021].[SQLI].BI_Hechos_Reparaciones	ADD FOREIGN KEY(taller)				REFERENCES [GD2C2021].[SQLI].BI_Dimension_Taller(idTaller)					ON DELETE NO ACTION ON UPDATE NO ACTION ;
	ALTER TABLE [GD2C2021].[SQLI].BI_Hechos_Reparaciones	ADD FOREIGN KEY(tarea)				REFERENCES [GD2C2021].[SQLI].BI_Dimension_Tarea(idTarea)					ON DELETE NO ACTION ON UPDATE NO ACTION ;
	ALTER TABLE [GD2C2021].[SQLI].BI_Hechos_Reparaciones	ADD FOREIGN KEY(legajo_mecanico)	REFERENCES [GD2C2021].[SQLI].BI_Dimension_Mecanico(legajoMecanico)			ON DELETE NO ACTION ON UPDATE NO ACTION ;
	ALTER TABLE [GD2C2021].[SQLI].BI_Hechos_Reparaciones	ADD FOREIGN KEY(herramienta)		REFERENCES [GD2C2021].[SQLI].BI_Dimension_Herramienta(idHerramienta)		ON DELETE NO ACTION ON UPDATE NO ACTION ;
GO

-------------------------------- procedures para realizar las migraciones de las tablas --------------------------------
CREATE PROCEDURE Insercion_Dimension_Camion AS
BEGIN
	INSERT INTO	[GD2C2021].[SQLI].BI_Dimension_Camion(idCamion, patente, numero_chasis, numero_motor, fecha_alta)
	SELECT		cami_id, cami_patente, cami_nro_chasis, cami_nro_motor, cami_fecha_alta
	FROM		[GD2C2021].[SQLI].Camion
END
GO

CREATE PROCEDURE Insercion_Dimension_Paquete AS
BEGIN
	INSERT INTO [GD2C2021].[SQLI].BI_Dimension_Paquete(idPaquete, tipo, alto_max, largo_max, ancho_max, peso_max, cantidad, precio_base, precio_final)
	SELECT		pack_id, t_pack_descripcion, t_pack_alto_max, t_pack_largo_max, t_pack_ancho_max, t_pack_peso_maximo, pack_cantidad, t_pack_precio, sum(pack_cantidad * t_pack_precio)
	FROM		[GD2C2021].[SQLI].Paquete
	JOIN		[GD2C2021].[SQLI].Tipo_Paquete on t_pack_id = pack_tipo
	GROUP BY	pack_id, t_pack_descripcion, t_pack_alto_max, t_pack_largo_max, t_pack_ancho_max, t_pack_peso_maximo, pack_cantidad, t_pack_precio
END
GO

CREATE PROCEDURE Insercion_Dimension_Herramienta AS
BEGIN
	INSERT INTO [GD2C2021].[SQLI].BI_Dimension_Herramienta(idHerramienta, detalle, codigo, precio, cantidad)
	SELECT		herra_id, herra_detalle,herra_code, herra_precio, hxt.mxt_cantidad
	FROM		[GD2C2021].[SQLI].Herramientas
	JOIN		[GD2C2021].[SQLI].Herramienta_Por_Tarea hxt on hxt.herra_id = herra_id
END
GO

CREATE PROCEDURE Insercion_Dimension_ODT AS
BEGIN
	INSERT INTO [GD2C2021].[SQLI].BI_Dimension_ODT(idODT, estado, fecha_generacion)
	SELECT		odt_id, odt_estado, odt_fecha_generado
	FROM		[GD2C2021].[SQLI].Orden_De_Trabajo
END
GO

CREATE PROCEDURE Insercion_Dimension_Marca AS
BEGIN
	INSERT INTO [GD2C2021].[SQLI].BI_Dimension_Marca(idMarca, nombre)
	SELECT		marca_id, marca_nombre
	FROM		[GD2C2021].[SQLI].Marca
END
GO

CREATE PROCEDURE Insercion_Dimension_Modelo AS
BEGIN
	INSERT INTO [GD2C2021].[SQLI].BI_Dimension_Modelo(idModelo, nombre, velocidad_max, capacidad_tanque, capacidad_carga)
	SELECT		modelo_id, modelo_detalle, modelo_vel_max, modelo_cap_tanque, modelo_cap_carga
	FROM		[GD2C2021].[SQLI].Modelo
END
GO

CREATE PROCEDURE Insercion_Dimension_Taller AS
BEGIN
	INSERT INTO [GD2C2021].[SQLI].BI_Dimension_Taller(idTaller, direccion, telefono, mail, nombre, ciudad)
	SELECT		taller_id, taller_direccion, taller_telefono, taller_mail, taller_nombre, ciu.ciudad_nombre
	FROM		[GD2C2021].[SQLI].Taller
	JOIN		[GD2C2021].[SQLI].Ciudad ciu on ciu.ciudad_id = taller_ciudad
END
GO

CREATE PROCEDURE Insercion_Dimension_Tarea AS
BEGIN
	INSERT INTO [GD2C2021].[SQLI].BI_Dimension_Tarea(idTarea, detalle, tipo, tiempo_estimado)
	SELECT	tarea_codigo, tarea_descripcion, tipo_tarea, tarea_tiempo_est
	FROM [GD2C2021].[SQLI].Tareas
	JOIN [GD2C2021].[SQLI].Tipo_Tarea on tipo_id = tarea_tipo
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
	SELECT		chofer_nro_legajo, chofer_nombre, chofer_apellido, chofer_dni, chofer_costo_hora, chofer_direccion, chofer_telefono, chofer_mail, chofer_fecha_nac, CASE
		WHEN (2021 - year(chofer_fecha_nac)) between 18 and 30		THEN '18-30 anios'
		WHEN (2021 - year(chofer_fecha_nac)) between 31 and 50		THEN '31-50 anios'
		ELSE	'> 50 anios'
		END
	FROM		[GD2C2021].[SQLI].Chofer
END
GO

CREATE PROCEDURE Insercion_Dimension_Mecanico AS
BEGIN
	INSERT INTO [GD2C2021].[SQLI].BI_Dimension_Mecanico(legajoMecanico, nombre, apellido, dni, costo_x_hora, direccion,	telefono, mail, fecha_nacimiento, edad)
	SELECT		meca_nro_legajo, meca_nombre, meca_apellido,meca_dni,meca_direccion,meca_telefono,meca_cost_hora,meca_mail,meca_fecha_nac, CASE
		WHEN (2021 - year(meca_fecha_nac)) between 18 and 30		THEN '18-30 anios'
		WHEN (2021 - year(meca_fecha_nac)) between 31 and 50		THEN '31-50 anios'
		ELSE		'> 50 anios'
		END
	FROM		[GD2C2021].[SQLI].Mecanico
END
GO

CREATE PROCEDURE Insercion_Dimension_Tiempo AS
BEGIN
	INSERT INTO [GD2C2021].[SQLI].BI_Dimension_Tiempo(anio, cuatrimestre)
	(	(SELECT year(viaje_fecha_ini), CASE
				WHEN month(viaje_fecha_ini) = 1 or month(viaje_fecha_ini) = 2 or month(viaje_fecha_ini) = 3 or month(viaje_fecha_ini) = 4
					THEN 1
				WHEN month(viaje_fecha_ini) = 5 or month(viaje_fecha_ini) = 6 or month(viaje_fecha_ini) = 7 or month(viaje_fecha_ini) = 8
					THEN 2
				ELSE 3 
				END
			FROM [GD2C2021].[SQLI].Viaje)
		UNION
		(
			SELECT year(viaje_fecha_fin), CASE
				WHEN month(viaje_fecha_fin) = 1 or month(viaje_fecha_fin) = 2 or month(viaje_fecha_fin) = 3 or month(viaje_fecha_fin) = 4
					THEN 1
				WHEN month(viaje_fecha_fin) = 5 or month(viaje_fecha_fin) = 6 or month(viaje_fecha_fin) = 7 or month(viaje_fecha_fin) = 8
					THEN 2
				ELSE 3 
				END
			FROM [GD2C2021].[SQLI].Viaje
		)
		UNION
		(
			SELECT year(tarea_fecha_inicio), CASE
				WHEN month(tarea_fecha_inicio) = 1 or month(tarea_fecha_inicio) = 2 or month(tarea_fecha_inicio) = 3 or month(tarea_fecha_inicio) = 4
					THEN 1
				WHEN month(tarea_fecha_inicio) = 5 or month(tarea_fecha_inicio) = 6 or month(tarea_fecha_inicio) = 7 or month(tarea_fecha_inicio) = 8
					THEN 2
				ELSE 3 
				END
			FROM [GD2C2021].[SQLI].Tarea_Por_ODT
		)
		UNION
		(
			SELECT year(tarea_fecha_fin), CASE
				WHEN month(tarea_fecha_fin) = 1 or month(tarea_fecha_fin) = 2 or month(tarea_fecha_fin) = 3 or month(tarea_fecha_fin) = 4
					THEN 1
				WHEN month(tarea_fecha_fin) = 5 or month(tarea_fecha_fin) = 6 or month(tarea_fecha_fin) = 7 or month(tarea_fecha_fin) = 8
					THEN 2
				ELSE 3 
				END
			FROM [GD2C2021].[SQLI].Tarea_Por_ODT
		)
	)
END
GO

CREATE FUNCTION [SQLI].buscarIdDelTiempoSegun(@fecha DATETIME2(3)) 
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
	RETURN @pk
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

CREATE PROCEDURE Insercion_Hechos_Reparaciones AS
BEGIN
	INSERT INTO [GD2C2021].[SQLI].BI_Hechos_Reparaciones(tiempo, camion, marca, modelo, odt, taller, tarea, legajo_mecanico, herramienta)
	SELECT DISTINCT [GD2C2021].[SQLI].buscarIdDelTiempoSegun(txo.tarea_fecha_inicio), odt_camion, mar.marca_id, mode.modelo_id, 
	odt.odt_id, 1 /*ACA IRIA EL TALLER*/, tar.tarea_codigo, mec.meca_nro_legajo, her.herra_id
	FROM [GD2C2021].[SQLI].Orden_De_Trabajo odt
	JOIN [GD2C2021].[SQLI].Tarea_Por_ODT txo on txo.odt_id = odt.odt_id
	JOIN [GD2C2021].[SQLI].Camion cam on cam.cami_id = odt.odt_camion
	JOIN [GD2C2021].[SQLI].Marca mar on mar.marca_id = cam.cami_marca
	JOIN [GD2C2021].[SQLI].Modelo mode on mode.modelo_id = cam.cami_modelo
	JOIN [GD2C2021].[SQLI].Mecanico mec on mec.meca_nro_legajo = txo.tarea_mecanico
--	JOIN [GD2C2021].[SQLI].Taller tal on tal.taller_id = mec.meca_taller 
	JOIN [GD2C2021].[SQLI].Tareas tar on tar.tarea_codigo = txo.tarea_id
	JOIN [GD2C2021].[SQLI].Herramienta_Por_Tarea hpt on hpt.tarea_codigo = tar.tarea_codigo
	JOIN [GD2C2021].[SQLI].Herramientas her on her.herra_id = hpt.herra_id
END
GO
--Nota: en este ultimo, metimos la fecha inicial de la tarea de una OdT porque la fecha de generacion de la OdT la tenemos en formato NVARCHAR(255) (figuraba asi en la tabla maestra)

-----------------------------------Vistas------------------------------------------------------------------------------
CREATE VIEW [GD2C2021].[SQLI].MAX_TIEMPO_FDS_DE_CADA_CAMION_X_CUATRI AS
BEGIN
	SELECT	r.camion, r.cuatrimestre,
	(
		SELECT	MAX(DATEDIFF(DAY, MIN(txo.tarea_fecha_inicio), MAX(txo.tarea_fecha_fin)))
		FROM	[GD2C2021].[SQLI].Tarea_Por_ODT txo
		JOIN	[GD2C2021].[SQLI].Orden_De_Trabajo orden on orden.odt_id = txo.odt_id
		WHERE odt_id = r.odt AND orden.odt_camion = r.camion
	)

	FROM	[GD2C2021].[SQLI].BI_Hechos_Reparaciones r
	JOIN	[GD2C2021].[SQLI].BI_Dimension_Tiempo on r.tiempo = idTiempo
	GROUP BY r.camion, r.cuatrimestre
END
GO

CREATE VIEW [GD2C2021].[SQLI].COSTO_MANTENIMIENTO_X_CAMION_X_TALLER_X_CUATRI AS
BEGIN
	SELECT r.camion, t.cuatrimestre, r.taller,
	((
		SELECT SUM(meca.costo_x_hora * task.tiempo_estimado * 8)
		FROM [GD2C2021].[SQLI].BI_Hechos_Reparaciones r2
		JOIN [GD2C2021].[SQLI].BI_Dimension_Mecanico meca on meca.legajoMecanico = r2.legajo_mecanico
		WHERE r2.tarea = task.idTarea
	)
	+
	(
		SELECT SUM(herra.precio * herra.cantidad)
		FROM [GD2C2021].[SQLI].BI_Dimension_Herramienta herra
		WHERE herra.idHerramienta in	(
											SELECT herramienta
											FROM [GD2C2021].[SQLI].BI_Hechos_Reparaciones
											WHERE tarea = task.idTarea
											GROUP BY herramienta
										)
	))
	FROM [GD2C2021].[SQLI].BI_Hechos_Reparaciones r
	JOIN [GD2C2021].[SQLI].BI_Dimension_Tiempo t on t.idTiempo = r.tiempo
	JOIN [GD2C2021].[SQLI].BI_Dimension_Tarea task on task.idTarea = r.tarea
	GROUP BY r.camion, t.cuatrimestre, r.taller
END
GO


CREATE VIEW [GD2C2021].[SQLI].DESVIO_PROM_DE_CADA_TAREA_X_TALLER AS
BEGIN

END
GO

CREATE VIEW [GD2C2021].[SQLI].TOP_5_TAREAS_REALIZADAS_X_MODELO AS
BEGIN
	SELECT r1.modelo, r1.tarea
	FROM [GD2C2021].[SQLI].BI_Hechos_Reparaciones r1
	WHERE r1.tarea in	(
							SELECT TOP 5 r2.tarea
							FROM [GD2C2021].[SQLI].BI_Hechos_Reparaciones r2
							WHERE r2.modelo = r1.modelo
							GROUP BY r2.tarea
							ORDER BY COUNT(DISTINCT r2.tarea) DESC
						)
	GROUP BY r1.modelo, r1.tarea
END
GO

CREATE VIEW [GD2C2021].[SQLI].TOP_10_HERRAM_MAS_USADAS_X_TALLER AS
BEGIN
	SELECT repa.herramienta, repa.taller
	FROM [GD2C2021].[SQLI].BI_Hechos_Reparaciones repa
	WHERE repa.herramienta in	(
									SELECT TOP 10 r2.herramienta
									FROM [GD2C2021].[SQLI].BI_Hechos_Reparaciones r2
									JOIN [GD2C2021].[SQLI].BI_Hechos_Herramienta h2 on h2.idHerramienta = r2.herramienta
									WHERE r2.taller = repa.taller
									GROUP BY r2.herramienta
									ORDER BY COUNT(DISTINCT r2.herramienta) DESC
								)
	GROUP BY repa.herramienta, repa.taller
END
GO

CREATE VIEW [GD2C2021].[SQLI].FACTURACION_TOTAL_POR_RECORRIDO_POR_CUATRI AS
BEGIN
	SELECT tiem.cuatrimestre, viaje.recorrido_realizado, 
	(
		SELECT SUM(pack.precio_final + reco.precio)
		FROM [GD2C2021].[SQLI].BI_Dimension_Paquete pack
		WHERE pack.idPaquete in	(
									SELECT viaje1.combo_paquete
									FROM [GD2C2021].[SQLI].BI_Hechos_Viajes viaje1
									WHERE viaje1.recorrido_realizado = viaje.recorrido_realizado
									GROUP BY viaje1.combo_paquete
								)	
	)
	FROM [GD2C2021].[SQLI].BI_Hechos_Viajes viaje
	JOIN [GD2C2021].[SQLI].BI_Dimension_Tiempo tiem on tiem.idTiempo = viaje.tiempo
	JOIN [GD2C2021].[SQLI].BI_Dimension_Recorrido reco on reco.idReco = viaje.recorrido_realizado
	GROUP BY tiem.cuatrimestre, viaje.recorrido_realizado
END
GO

CREATE VIEW [GD2C2021].[SQLI].COSTO_PROM_X_RANGO_ETARIO_CHOFERES AS
BEGIN
	SELECT c.edad, (SUM(c.costo_x_hora) / COUNT(DISTINCT c.legajoChofer))
	FROM [GD2C2021].[SQLI].BI_Hechos_Viajes
	JOIN [GD2C2021].[SQLI].BI_Hechos_Chofer c on c.legajoChofer = legajo_chofer
	GROUP BY c.edad
END
GO

CREATE VIEW [GD2C2021].[SQLI].GANANCIA_X_CAMION AS
BEGIN
	SELECT viaje.camion, 
	(
		SELECT SUM(viaje1.precio_recorrido + pack.precio_final)
		FROM [GD2C2021].[SQLI].BI_Hechos_Viajes viaje1
		JOIN [GD2C2021].[SQLI].BI_Dimension_Paquete pack on pack.idPaquete = viaje1.combo_paquete
		WHERE viaje1.camion = viaje.camion AND pack.idPaquete in	(
																		SELECT combo_paquete
																		FROM [GD2C2021].[SQLI].BI_Hechos_Viajes
																		WHERE camion = viaje.camion
																	)
	) --Ingresos
	-
	(
		SELECT (viaje2.duracion_viaje * ch.costo_x_hora * 8) + (viaje2.lts_consumidos * 100)
		FROM [GD2C2021].[SQLI].BI_Hechos_Viajes viaje2
		JOIN [GD2C2021].[SQLI].BI_Hechos_Chofer ch on ch.legajoChofer = viaje2.legajo_chofer
		WHERE ch.legajoChofer in	(
										SELECT legajo_chofer
										FROM [GD2C2021].[SQLI].BI_Hechos_Viajes 
										WHERE camion = viaje.camion
									)
	) --Costo de viaje
	-
	(
		SELECT SUM(meca.costo_x_hora * ta.tiempo_estimado * 8) + SUM(herra.precio * herra.cantidad)
		FROM [GD2C2021].[SQLI].BI_Hechos_Viajes v
		JOIN [GD2C2021].[SQLI].BI_Hechos_Reparaciones r on r.camion = v.camion
		JOIN [GD2C2021].[SQLI].BI_Hechos_Herramienta herra on r.herramienta = herra.idHerramienta
		JOIN [GD2C2021].[SQLI].BI_Hechos_Mecanico meca on meca.legajoMecanico = r.legajo_mecanico
		JOIN [GD2C2021].[SQLI].BI_Hechos_Tarea ta on ta.idTarea = r.tarea
		WHERE r.camion = viaje.camion
	) --Costo de mantenimiento

	FROM [GD2C2021].[SQLI].BI_Hechos_Viajes viaje
	GROUP BY cami.patente
END
GO

-------------------------------- procedure migracion ----------------------------------------------------------------
CREATE PROCEDURE BI_Migracion AS
BEGIN	
	EXEC Insercion_Dimension_Camion
	EXEC Insercion_Dimension_Marca
	EXEC Insercion_Dimension_Modelo
	EXEC Insercion_Dimension_Taller
	EXEC Insercion_Dimension_Tarea
	EXEC Insercion_Dimension_Recorrido
	EXEC Insercion_Dimension_Chofer
	EXEC Insercion_Dimension_Mecanico
	EXEC Insercion_Dimension_Tiempo
	EXEC Insercion_Dimension_Herramienta
	EXEC Insercion_Dimension_Paquete
	EXEC Insercion_Dimension_ODT
	EXEC Insercion_Hechos_Reparaciones
	EXEC Insercion_Hechos_Viajes
END
GO

-------------------------------- procedures para reseteos de tablas -------------------------------------------------
CREATE PROCEDURE BI_Reseteo_Tablas AS
BEGIN
	IF (OBJECT_ID('GD2C2021.SQLI.BI_Dimension_Camion')IS NOT NULL)					DROP TABLE [GD2C2021].[SQLI].BI_Dimension_Camion
	IF (OBJECT_ID('GD2C2021.SQLI.BI_Dimension_Marca')IS NOT NULL)					DROP TABLE [GD2C2021].[SQLI].BI_Dimension_Marca
	IF (OBJECT_ID('GD2C2021.SQLI.BI_Dimension_Modelo')IS NOT NULL)					DROP TABLE [GD2C2021].[SQLI].BI_Dimension_Modelo
	IF (OBJECT_ID('GD2C2021.SQLI.BI_Dimension_Taller')IS NOT NULL)					DROP TABLE [GD2C2021].[SQLI].BI_Dimension_Taller
	IF (OBJECT_ID('GD2C2021.SQLI.BI_Dimension_Tarea')IS NOT NULL)					DROP TABLE [GD2C2021].[SQLI].BI_Dimension_Tarea
	IF (OBJECT_ID('GD2C2021.SQLI.BI_Dimension_Recorrido')IS NOT NULL)				DROP TABLE [GD2C2021].[SQLI].BI_Dimension_Recorrido
	IF (OBJECT_ID('GD2C2021.SQLI.BI_Dimension_Chofer')IS NOT NULL)					DROP TABLE [GD2C2021].[SQLI].BI_Dimension_Chofer
	IF (OBJECT_ID('GD2C2021.SQLI.BI_Dimension_Mecanico')IS NOT NULL)				DROP TABLE [GD2C2021].[SQLI].BI_Dimension_Mecanico
	IF (OBJECT_ID('GD2C2021.SQLI.BI_Dimension_Paquete')IS NOT NULL)					DROP TABLE [GD2C2021].[SQLI].BI_Dimension_Paquete
	IF (OBJECT_ID('GD2C2021.SQLI.BI_Dimension_Herramienta')IS NOT NULL)				DROP TABLE [GD2C2021].[SQLI].BI_Dimension_Herramienta
--	IF (OBJECT_ID('GD2C2021.SQLI.BI_Dimension_Viaje')IS NOT NULL)					DROP TABLE [GD2C2021].[SQLI].BI_Dimension_Viaje
	IF (OBJECT_ID('GD2C2021.SQLI.BI_Dimension_Tiempo')IS NOT NULL)					DROP TABLE [GD2C2021].[SQLI].BI_Dimension_Tiempo
	IF (OBJECT_ID('GD2C2021.SQLI.BI_Dimension_ODT')IS NOT NULL)						DROP TABLE [GD2C2021].[SQLI].BI_Dimension_ODT
	IF (OBJECT_ID('GD2C2021.SQLI.BI_Hechos_Viajes')IS NOT NULL)						DROP TABLE [GD2C2021].[SQLI].BI_Hechos_Viajes
	IF (OBJECT_ID('GD2C2021.SQLI.BI_Hechos_Reparaciones')IS NOT NULL)				DROP TABLE [GD2C2021].[SQLI].BI_Hechos_Reparaciones
END
GO

CREATE PROCEDURE BI_Reseteo_Procedures AS
BEGIN
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Creacion_Tablas_BI' AND type = 'p')						DROP PROCEDURE dbo.Creacion_Tablas_BI
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Dimension_Camion' AND type = 'p')				DROP PROCEDURE dbo.Insercion_Dimension_Camion
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Dimension_Marca' AND type = 'p')				DROP PROCEDURE dbo.Insercion_Dimension_Marca
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Dimension_Modelo' AND type = 'p')				DROP PROCEDURE dbo.Insercion_Dimension_Modelo
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Dimension_Taller' AND type = 'p')				DROP PROCEDURE dbo.Insercion_Dimension_Taller
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Dimension_Tarea' AND type = 'p')				DROP PROCEDURE dbo.Insercion_Dimension_Tarea
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Dimension_Recorrido' AND type = 'p')			DROP PROCEDURE dbo.Insercion_Dimension_Recorrido
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Dimension_Chofer' AND type = 'p')				DROP PROCEDURE dbo.Insercion_Dimension_Chofer
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Dimension_Mecanico' AND type = 'p')			DROP PROCEDURE dbo.Insercion_Dimension_Mecanico
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Dimension_Tiempo' AND type = 'p')				DROP PROCEDURE dbo.Insercion_Dimension_Tiempo
--	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Dimension_Viaje' AND type = 'p')				DROP PROCEDURE dbo.Insercion_Dimension_Viaje
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Dimension_Herramienta' AND type = 'p')		DROP PROCEDURE dbo.Insercion_Dimension_Herramienta
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Dimension_Paquete' AND type = 'p')			DROP PROCEDURE dbo.Insercion_Dimension_Paquete
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Dimension_ODT' AND type = 'p')				DROP PROCEDURE dbo.Insercion_Dimension_ODT
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Hechos_Reparaciones' AND type = 'p')			DROP PROCEDURE dbo.Insercion_Hechos_Reparaciones
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Hechos_Viajes' AND type = 'p')				DROP PROCEDURE dbo.Insercion_Hechos_Viajes
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'BI_Migracion' AND type = 'p')							DROP PROCEDURE dbo.BI_Migracion
--	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'BI_Vistas' AND type = 'p')								DROP PROCEDURE dbo.BI_Vistas
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'BI_Reseteo_Tablas' AND type = 'p')						DROP PROCEDURE dbo.BI_Reseteo_Tablas
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'BI_Reseteo' AND type = 'p')								DROP PROCEDURE dbo.BI_Reseteo
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'BI_Play' AND type = 'p')								DROP PROCEDURE dbo.BI_Play
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'BI_Reseteo_Procedures' AND type = 'p')					DROP PROCEDURE dbo.BI_Reseteo_Procedures
END
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