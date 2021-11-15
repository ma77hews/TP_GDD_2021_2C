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
		fecha_nacimiento	SMALLDATETIME
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
		fecha_nacimiento	SMALLDATETIME
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
	idCamion,	idMarca, idModelo, idTaller, idTipoTarea, idRecorrido, 
	idChofer, idMecanico)
GO