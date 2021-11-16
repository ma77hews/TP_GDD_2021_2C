CREATE PROCEDURE Creacion_Tablas_BI AS

	CREATE TABLE [GD2C2021].[SQLI].BI_Dimension_Camion
	(
		idCamion		INT IDENTITY,
--		modelo			INT,
--		marca			INT,
--		Revisar si en verdad va modelo y marca!
		patente			char(7),
		numero_chasis	NVARCHAR(255),
		numero_motor	NVARCHAR(255),
		fecha_alta		SMALLDATETIME
	)

	ALTER TABLE [GD2C2021].[SQLI].BI_Dimension_Camion ADD PRIMARY KEY(idCamion)

	CREATE TABLE [GD2C2021].[SQLI].BI_Dimension_Marca
	(
		idMarca		INT IDENTITY,
		nombre		CHAR(20)
	)

	ALTER TABLE [GD2C2021].[SQLI].BI_Dimension_Marca ADD PRIMARY KEY(idMarca)

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
		idTipo		INT IDENTITY,
		tipo_tarea	NVARCHAR(255)
	)

	ALTER TABLE [GD2C2021].[SQLI].BI_Dimension_Tipo_Tarea ADD PRIMARY KEY(idTipo)

	CREATE TABLE [GD2C2021].[SQLI].BI_Dimension_Recorrido
	(
		idRecorrido		INT IDENTITY,
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
		idTiempo		INT NOT NULL,
		anio			INT,
		cuatrimestre	INT
	)

	ALTER TABLE [GD2C2021].[SQLI].BI_Dimension_Tiempo ADD PRIMARY KEY(idTiempo)

	CREATE TABLE [GD2C2021].[SQLI].BI_Hechos
	(
		idTiempo	INT NOT NULL,
		idCamion	INT NOT NULL,
		idMarca		INT NOT NULL,
		idModelo	INT NOT NULL,
		idTaller	INT NOT NULL,
		idTipoTarea	INT NOT NULL,
		idRecorrido	INT NOT NULL,
		idChofer	INT NOT NULL,
		idMecanico	INT NOT NULL,
	)

	ALTER TABLE [GD2C2021].[SQLI].BI_Hechos ADD PRIMARY KEY CLUSTERED(idTiempo, 
	idCamion, idMarca, idModelo, idTaller, idTipoTarea, idRecorrido, 
	idChofer, idMecanico)
GO

-------------------------------- procedures para realizar las migraciones de las tablas --------------------------------
CREATE PROCEDURE Insercion_Dimension_Camion AS
BEGIN
	INSERT INTO	[GD2C2021].[SQLI].BI_Dimension_Camion (idCamion,/*modelo, marca,*/ patente, nro_chasis, nro_motor, fecha_alta)
	SELECT		cami_id,/*cami_modelo,cami_marca,*/ cami_patente, cami_nro_chasis, cami_nro_motor, cami_fecha_alta
	FROM		[GD2C2021].[SQLI].Camion
END
GO

CREATE PROCEDURE Insercion_Dimension_Marca AS
BEGIN
	INSERT INTO [GD2C2021].[SQLI].BI_Dimension_Marca(IdMarca,nombre)
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
		else		'> 50 anios'
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


CREATE PROCEDURE Insercion_Hechos AS
BEGIN
	/*INSERT INTO [GD2C2021].[SQLI].BI_Hechos(/*idTiempo*/idCamion, idMarca, idModelo, idTaller, idTipoTarea, idRecorrido, idChofer, idMecanico)
	SELECT	tiem.idTiempo, cami.idCamion, mar.idMarca, mode.idModelo, tall.idTaller, tipo.idTipo, reco.idReco, cho.legajoChofer, meca.legajoMecanico
	FROM [GD2C2021].[SQLI].BI_Dimension_Tiempo tiem
	JOIN [GD2C2021].[SQLI].BI_Dimension_Mecanico meca on meca.legajoMecanico = legajoMecanico
	JOIN [GD2C2021].[SQLI].BI_Dimension_Chofer cho on cho.legajoChofer = legajoChofer
	JOIN [GD2C2021].[SQLI].BI_Dimension_Recorrido reco on reco.idReco = idRecorrido
	JOIN [GD2C2021].[SQLI].BI_Dimension_Tipo_Tarea tipo on tipo.idTipo = idTipo
	JOIN [GD2C2021].[SQLI].BI_Dimension_Taller tall on tall.idTaller = idTaller
	JOIN [GD2C2021].[SQLI].BI_Dimension_Modelo mode on mode.idModelo = idModelo
	JOIN [GD2C2021].[SQLI].BI_Dimension_Marca mar on mar.idMarca = idMarca
	JOIN [GD2C2021].[SQLI].BI_Dimension_Camion cami on cami.idCamion = idCamion*/
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
	EXEC Insercion_Hechos
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
	--IF (OBJECT_ID('GD2C2021.SQLI.BI_Dimension_Tiempo')IS NOT NULL)					DROP TABLE [GD2C2021].[SQLI].BI_Dimension_Tiempo
	IF (OBJECT_ID('GD2C2021.SQLI.BI_Hechos')IS NOT NULL)							DROP TABLE [GD2C2021].[SQLI].BI_Hechos
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
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'BI_Migracion' AND type = 'p')							DROP PROCEDURE dbo.BI_Migracion
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'BI_Reseteo_Tablas' AND type = 'p')						DROP PROCEDURE dbo.BI_Reseteo_Tablas
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'BI_Reseteo_Procedures' AND type = 'p')					DROP PROCEDURE dbo.BI_Reseteo_Procedures
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'BI_Reseteo' AND type = 'p')								DROP PROCEDURE dbo.BI_Reseteo
	--IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Play' AND type = 'p')									DROP PROCEDURE dbo.Play

GO

CREATE PROCEDURE BI_Reseteo AS

	EXEC BI_Reseteo_Tablas
	EXEC BI_Reseteo_Procedures

GO
