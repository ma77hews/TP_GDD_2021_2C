-------------------------------- procedure para la creacion de tablas -------------------------------------------------
CREATE PROCEDURE Creacion_de_Tablas	AS

	CREATE TABLE [GD2C2021].[SQLI].Viaje 
	(
		viaje_id			INT IDENTITY,
		viaje_camion		INT,
		viaje_chofer		INT,
		viaje_recorrido		INT,
		viaje_fechaini		DATETIME2(7),
		viaje_fechafin		DATETIME2(3),
		viaje_itsconsu		char(8)
	);

	CREATE TABLE [GD2C2021].[SQLI].Paquete_Por_Viaje
	(
		ppv_viaje			INT,
		ppv_paquete			INT,
		ppv_cant_paquete	INT,
	);

	CREATE TABLE [GD2C2021].[SQLI].Recorrido 
	(
		reco_id				INT,
		reco_ciudad_origen	INT,
		reco_ciudad_destino	INT,
		reco_km				INT,
		reco_precio			DECIMAL(18,2)
	);

	CREATE TABLE [GD2C2021].[SQLI].Chofer 
	(
		chofer_legajo		INT,
		chofer_nombre		NVARCHAR(255),
		chofer_apellido		NVARCHAR(255),
		chofer_dni			DECIMAL(18,0),
		chofer_direccion	NVARCHAR(255),
		chofer_telefono		INT,
		chofer_mail			NVARCHAR(255),
		chofer_fecha_nac	DATETIME2(3),
		chofer_costo_hora	INT
	);

	CREATE TABLE [GD2C2021].[SQLI].Paquete 
	(
		pack_id				INT,
		pack_alto_max		DECIMAL(18,2),
		pack_ancho_max		DECIMAL(18,2),
		pack_largo_max		DECIMAL(18,2),
		pack_descripcion	NVARCHAR(255),
		pack_precio			DECIMAL(18,2),
		pack_peso_maximo	DECIMAL(18,2),
		pack_cantidad		INT
	);

	CREATE TABLE [GD2C2021].[SQLI].Ciudad 
	(
		ciudad_id			INT,
		ciudad_nombre		NVARCHAR(255)
	);
	
	CREATE TABLE [GD2C2021].[SQLI].Taller 
	(
		taller_id			INT,
		taller_direccion	NVARCHAR(255),
		taller_telefono		DECIMAL(18,0),
		taller_mail			NVARCHAR(255),
		taller_nombre		NVARCHAR(255),
		taller_ciudad		INT
	);

	CREATE TABLE [GD2C2021].[SQLI].Camion 
	(
		cami_id				INT,
		cami_modelo			INT,
		cami_patente		CHAR(7),
		cami_nro_chasis		NVARCHAR(255),
		cami_nro_motor		NVARCHAR(255),
		cami_fecha_alta		SMALLDATETIME
	);
	
	CREATE TABLE [GD2C2021].[SQLI].Modelo 
	(
		modelo_id			INT,
		modelo_vel_max		INT,
		modelo_cap_tanque	INT, --hay que cambiar el nombre en el der ==> Modificado por eze
		modelo_cap_carga	INT -- hay que cambiar el nombre en el der ==> Modif por eze
	);

	CREATE TABLE [GD2C2021].[SQLI].Orden_De_Trabajo 
	(
		odt_id				INT,
		odt_camion			INT,
		odt_estado			NVARCHAR(255),
		odt_fecha_generado	NVARCHAR(255)
	)

	CREATE TABLE [GD2C2021].[SQLI].Tarea_Por_ODT 
	(
		tarea_id			INT,
		odt_id				INT,
		tarea_mecanico		INT,
		tarea_fecha_inicio	DATETIME2(3),
		tarea_fecha_fin		DATETIME2(3),
		tarea_fe_in_plani	DATETIME2(3)-- hay que cambiar el nombre en el der son largos y tengo que poner un tab mas en todas las lineas una paja ==> Modiicado por eze 
	);

	CREATE TABLE [GD2C2021].[SQLI].Tipo_Tarea 
	(
		tipo_id				INT,
		tipo_tarea			NVARCHAR(255)
	)

	CREATE TABLE [GD2C2021].[SQLI].Tareas 
	(
		tarea_codigo		INT,
		tarea_tipo			INT,
		tarea_descripcion	NVARCHAR(255),
		tarea_tiempo_est	INT, -- cambiar el nombre + revisar nombre variable
		tarea_nombre		CHAR(50)
	);

	CREATE TABLE [GD2C2021].[SQLI].Herramientas 
	(
		herra_id			INT,
		herra_detalle		CHAR(50),
		herra_precio		DECIMAL(18,2)
	);

	CREATE TABLE [GD2C2021].[SQLI].Herramienta_Por_Tarea
	(
		tarea_codigo		INT,
		herra_id			INT,
		mxt_cantidad		INT
	);

	CREATE TABLE [GD2C2021].[SQLI].Mecanico 
	(
		meca_nro_legajo		INT,
		meca_nombre			NVARCHAR(255),
		meca_apellido		NVARCHAR(255),
		meca_lugar_trabajo	INT,
		meca_dni			DECIMAL(18,0),
		meca_direccion		NVARCHAR(255),
		meca_telefono		DECIMAL(18,0),
		meca_cost_hora		INT,
		meca_mail			NVARCHAR(255),
		meca_fecha_nac		DATETIME2(3)
	);
GO
-------------------------------Procedure para las PKs y FKs---------------------------------------------------------
CREATE PROCEDURE asignacion_PK_y_FK AS
	ALTER TABLE [GD2C2021].[SQLI].Ciudad			ADD PRIMARY KEY (ciudad_id)

	ALTER TABLE [GD2C2021].[SQLI].Herramientas		ADD PRIMARY KEY (herra_id)

	ALTER TABLE [GD2C2021].[SQLI].Recorrido			ADD PRIMARY KEY (reco_id)
	ALTER TABLE [GD2C2021].[SQLI].Recorrido			ADD FOREIGN KEY (reco_ciudad_destino)	REFERENCES [GD2C2021].[SQLI].Ciudad(ciudad_id) ON DELETE NO ACTION ON UPDATE NO ACTION ;
	ALTER TABLE [GD2C2021].[SQLI].Recorrido			ADD FOREIGN KEY (reco_ciudad_origen)	REFERENCES [GD2C2021].[SQLI].Ciudad(ciudad_id) ON DELETE NO ACTION ON UPDATE NO ACTION ;

	ALTER TABLE [GD2C2021].[SQLI].Chofer			ADD PRIMARY KEY (chofer_legajo)
	
	ALTER TABLE [GD2C2021].[SQLI].Modelo			ADD PRIMARY KEY (modelo_id)

	ALTER TABLE [GD2C2021].[SQLI].Camion			ADD PRIMARY KEY (cami_id)
	ALTER TABLE [GD2C2021].[SQLI].Camion			ADD FOREIGN KEY (cami_modelo)			REFERENCES [GD2C2021].[SQLI].Modelo(modelo_id) ON DELETE NO ACTION ON UPDATE NO ACTION ;
	
	ALTER TABLE [GD2C2021].[SQLI].Paquete			ADD PRIMARY KEY (pack_id)
		
	ALTER TABLE [GD2C2021].[SQLI].Viaje				ADD PRIMARY KEY (viaje_id)
	ALTER TABLE [GD2C2021].[SQLI].Viaje				ADD FOREIGN KEY (viaje_camion)			REFERENCES [GD2C2021].[SQLI].Camion(cami_id) ON DELETE NO ACTION ON UPDATE NO ACTION ;
	ALTER TABLE [GD2C2021].[SQLI].Viaje				ADD FOREIGN KEY (viaje_chofer)			REFERENCES [GD2C2021].[SQLI].Chofer(chofer_legajo) ON DELETE NO ACTION ON UPDATE NO ACTION ;
	ALTER TABLE [GD2C2021].[SQLI].Viaje				ADD FOREIGN KEY (viaje_recorrido)		REFERENCES [GD2C2021].[SQLI].Recorrido(reco_id) ON DELETE NO ACTION ON UPDATE NO ACTION ;
	
	ALTER TABLE [GD2C2021].[SQLI].Paquete_Por_Viaje	ADD FOREIGN KEY (ppv_viaje)				REFERENCES [GD2C2021].[SQLI].Viaje(viaje_id) ON DELETE NO ACTION ON UPDATE NO ACTION ;
	ALTER TABLE [GD2C2021].[SQLI].Paquete_Por_Viaje	ADD FOREIGN KEY (ppv_paquete)			REFERENCES [GD2C2021].[SQLI].Paquete(pack_id) ON DELETE NO ACTION ON UPDATE NO ACTION ;

	ALTER TABLE [GD2C2021].[SQLI].Taller			ADD PRIMARY KEY (taller_id)
	ALTER TABLE [GD2C2021].[SQLI].Taller			ADD FOREIGN KEY (taller_ciudad)			REFERENCES [GD2C2021].[SQLI].Ciudad(ciudad_id) ON DELETE NO ACTION ON UPDATE NO ACTION ;

	ALTER TABLE [GD2C2021].[SQLI].Orden_De_Trabajo	ADD PRIMARY KEY (odt_id)
	ALTER TABLE [GD2C2021].[SQLI].Orden_De_Trabajo	ADD FOREIGN KEY (odt_camion)			REFERENCES [GD2C2021].[SQLI].Camion(cami_id) ON DELETE NO ACTION ON UPDATE NO ACTION ;
	
	ALTER TABLE [GD2C2021].[SQLI].Tipo_Tarea		ADD PRIMARY KEY (tipo_id)

	ALTER TABLE [GD2C2021].[SQLI].Mecanico			ADD PRIMARY KEY (meca_nro_legajo)
	ALTER TABLE [GD2C2021].[SQLI].Mecanico			ADD FOREIGN KEY (meca_lugar_trabajo)	REFERENCES [GD2C2021].[SQLI].Taller(taller_id) ON DELETE NO ACTION ON UPDATE NO ACTION ;

	ALTER TABLE [GD2C2021].[SQLI].Tareas			ADD PRIMARY KEY (tarea_codigo)
	ALTER TABLE [GD2C2021].[SQLI].Tareas			ADD FOREIGN KEY (tarea_tipo)			REFERENCES [GD2C2021].[SQLI].Tipo_Tarea(tipo_id) ON DELETE NO ACTION ON UPDATE NO ACTION ;
	
	ALTER TABLE [GD2C2021].[SQLI].Herramienta_Por_Tarea	ADD FOREIGN KEY (tarea_codigo)		REFERENCES [GD2C2021].[SQLI].Tareas(tarea_codigo) ON DELETE NO ACTION ON UPDATE NO ACTION ;
	ALTER TABLE [GD2C2021].[SQLI].Herramienta_Por_Tarea ADD FOREIGN KEY (herra_id)			REFERENCES [GD2C2021].[SQLI].Herramientas(herra_id) ON DELETE NO ACTION ON UPDATE NO ACTION ;
	
	ALTER TABLE [GD2C2021].[SQLI].Tarea_Por_ODT		ADD FOREIGN KEY (tarea_id)				REFERENCES [GD2C2021].[SQLI].Tareas(tarea_codigo) ON DELETE NO ACTION ON UPDATE NO ACTION ;
	ALTER TABLE [GD2C2021].[SQLI].Tarea_Por_ODT		ADD FOREIGN KEY (odt_id)				REFERENCES [GD2C2021].[SQLI].Orden_De_Trabajo(odt_id) ON DELETE NO ACTION ON UPDATE NO ACTION ;
	ALTER TABLE [GD2C2021].[SQLI].Tarea_Por_ODT		ADD FOREIGN KEY (tarea_mecanico)		REFERENCES [GD2C2021].[SQLI].Mecanico(meca_nro_legajo) ON DELETE NO ACTION ON UPDATE NO ACTION ;
GO