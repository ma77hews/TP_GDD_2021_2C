-------------------------------- procedure para la creacion de tablas -------------------------------------------------
CREATE PROCEDURE Creacion_de_Tablas	AS

	CREATE TABLE [GD2C2021].[SQLI].Modelo 
	(
		modelo_id			INT IDENTITY,
		modelo_detalle		NVARCHAR(255),
		modelo_vel_max		INT,
		modelo_cap_tanque	INT, 
		modelo_cap_carga	INT
	)

	CREATE TABLE [GD2C2021].[SQLI].Marca
	(	
		marca_id			INT IDENTITY,
		marca_nombre		NVARCHAR(255)
	)

	CREATE TABLE [GD2C2021].[SQLI].Camion 
	(
		cami_id				INT IDENTITY,
		cami_modelo			INT,
		cami_marca			INT,
		cami_patente		NVARCHAR(255),
		cami_nro_chasis		NVARCHAR(255),
		cami_nro_motor		NVARCHAR(255),
		cami_fecha_alta		DATETIME2(3)
	)

	CREATE TABLE [GD2C2021].[SQLI].Chofer 
	(
		chofer_id			INT IDENTITY,
		chofer_nro_legajo	INT,
		chofer_nombre		NVARCHAR(255),
		chofer_apellido		NVARCHAR(255),
		chofer_dni			DECIMAL(18,0),
		chofer_direccion	NVARCHAR(255),
		chofer_telefono		INT,
		chofer_mail			NVARCHAR(255),
		chofer_fecha_nac	DATETIME2(3),
		chofer_costo_hora	INT
	)

	CREATE TABLE [GD2C2021].[SQLI].Ciudad 
	(
		ciudad_id			INT IDENTITY,
		ciudad_nombre		NVARCHAR(255)
	)

	CREATE TABLE [GD2C2021].[SQLI].Recorrido 
	(
		reco_id				INT IDENTITY,
		reco_ciudad_origen	INT,
		reco_ciudad_destino	INT,
		reco_km				INT,
		reco_precio			DECIMAL(18,2)
	)

	CREATE TABLE [GD2C2021].[SQLI].Viaje 
	(
		viaje_id			INT IDENTITY,
		viaje_camion		INT,
		viaje_chofer		INT,
		viaje_recorrido		INT,
		viaje_fecha_ini		DATETIME2(7),
		viaje_fecha_fin		DATETIME2(3),
		viaje_lts_cons		DECIMAL(18,2)
	)

	CREATE TABLE [GD2C2021].[SQLI].Taller 
	(
		taller_id			INT IDENTITY,
		taller_direccion	NVARCHAR(255),
		taller_telefono		DECIMAL(18,0),
		taller_mail			NVARCHAR(255),
		taller_nombre		NVARCHAR(255),
		taller_ciudad		INT
	)
	
		CREATE TABLE [GD2C2021].[SQLI].Mecanico 
	(
		meca_nro_legajo		INT NOT NULL,
		meca_nombre			NVARCHAR(255),
		meca_apellido		NVARCHAR(255),
		meca_dni			DECIMAL(18,0),
		meca_direccion		NVARCHAR(255),
		meca_telefono		INT,
		meca_cost_hora		INT,
		meca_mail			NVARCHAR(255),
		meca_fecha_nac		DATETIME2(3),
	)

	CREATE TABLE [GD2C2021].[SQLI].Tipo_Tarea 
	(
		tipo_id				INT IDENTITY,
		tipo_tarea			NVARCHAR(255)
	)

	CREATE TABLE [GD2C2021].[SQLI].Herramientas 
	(
		herra_id			INT IDENTITY,
		herra_code			NVARCHAR(100),
		herra_detalle		NVARCHAR(255),
		herra_precio		DECIMAL(18,2)
	)

	CREATE TABLE [GD2C2021].[SQLI].Tipo_Paquete 
	(
		t_pack_id			INT IDENTITY,
		t_pack_alto_max		DECIMAL(18,2),
		t_pack_ancho_max	DECIMAL(18,2),
		t_pack_largo_max	DECIMAL(18,2),
		t_pack_descripcion	nvarchar(255),
		t_pack_precio		DECIMAL(18,2),
		t_pack_peso_maximo	DECIMAL(18,2)
	)

	CREATE TABLE [GD2C2021].[SQLI].Paquete 
	(
		pack_id				INT IDENTITY,
		pack_tipo			INT,
		pack_cantidad		INT,
		pack_viaje			INT
	)

	CREATE TABLE [GD2C2021].[SQLI].Orden_De_Trabajo 
	(
		odt_id				INT IDENTITY,
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
		tarea_fe_in_plani	DATETIME2(3) 
	);	

	CREATE TABLE [GD2C2021].[SQLI].Tareas 
	(
		tarea_codigo		INT IDENTITY,
		tarea_tipo			INT,
		tarea_descripcion	NVARCHAR(255),
		tarea_tiempo_est	INT, -- cambiar el nombre + revisar nombre variable
	);
	

	CREATE TABLE [GD2C2021].[SQLI].Herramienta_Por_Tarea
	(
		tarea_codigo		INT,
		herra_id			INT,
		mxt_cantidad		INT
	);
GO

-------------------------------Procedure para las PKs y FKs---------------------------------------------------------
CREATE PROCEDURE PK_Y_FK AS

	ALTER TABLE [GD2C2021].[SQLI].Modelo				ADD PRIMARY KEY (modelo_id)

	ALTER TABLE [GD2C2021].[SQLI].Marca					ADD PRIMARY KEY (marca_id)

	ALTER TABLE [GD2C2021].[SQLI].Camion				ADD PRIMARY KEY (cami_id)
	ALTER TABLE [GD2C2021].[SQLI].Camion				ADD FOREIGN KEY (cami_modelo)				REFERENCES [GD2C2021].[SQLI].Modelo(modelo_id)			ON DELETE NO ACTION ON UPDATE NO ACTION ;
	ALTER TABLE [GD2C2021].[SQLI].Camion				ADD FOREIGN KEY (cami_marca)				REFERENCES [GD2C2021].[SQLI].Marca(marca_id)			ON DELETE NO ACTION ON UPDATE NO ACTION ;

	ALTER TABLE [GD2C2021].[SQLI].Chofer				ADD PRIMARY KEY (chofer_id)
	
	ALTER TABLE [GD2C2021].[SQLI].Ciudad				ADD PRIMARY KEY (ciudad_id)

	ALTER TABLE [GD2C2021].[SQLI].Recorrido				ADD PRIMARY KEY (reco_id)
	ALTER TABLE [GD2C2021].[SQLI].Recorrido				ADD FOREIGN KEY (reco_ciudad_destino)		REFERENCES [GD2C2021].[SQLI].Ciudad(ciudad_id)			ON DELETE NO ACTION ON UPDATE NO ACTION ;
	ALTER TABLE [GD2C2021].[SQLI].Recorrido				ADD FOREIGN KEY (reco_ciudad_origen)		REFERENCES [GD2C2021].[SQLI].Ciudad(ciudad_id)			ON DELETE NO ACTION ON UPDATE NO ACTION ;

	ALTER TABLE [GD2C2021].[SQLI].Viaje					ADD PRIMARY KEY (viaje_id)
	ALTER TABLE [GD2C2021].[SQLI].Viaje					ADD FOREIGN KEY (viaje_camion)				REFERENCES [GD2C2021].[SQLI].Camion(cami_id)			ON DELETE NO ACTION ON UPDATE NO ACTION ;
	ALTER TABLE [GD2C2021].[SQLI].Viaje					ADD FOREIGN KEY (viaje_chofer)				REFERENCES [GD2C2021].[SQLI].Chofer(chofer_id)			ON DELETE NO ACTION ON UPDATE NO ACTION ;
	ALTER TABLE [GD2C2021].[SQLI].Viaje					ADD FOREIGN KEY (viaje_recorrido)			REFERENCES [GD2C2021].[SQLI].Recorrido(reco_id)			ON DELETE NO ACTION ON UPDATE NO ACTION ;

	ALTER TABLE [GD2C2021].[SQLI].Taller				ADD PRIMARY KEY (taller_id)
	ALTER TABLE [GD2C2021].[SQLI].Taller				ADD FOREIGN KEY (taller_ciudad)				REFERENCES [GD2C2021].[SQLI].Ciudad(ciudad_id)			ON DELETE NO ACTION ON UPDATE NO ACTION ;

	ALTER TABLE [GD2C2021].[SQLI].Mecanico				ADD PRIMARY KEY (meca_nro_legajo)

	ALTER TABLE [GD2C2021].[SQLI].Tipo_Tarea			ADD PRIMARY KEY (tipo_id)

	ALTER TABLE [GD2C2021].[SQLI].Herramientas			ADD PRIMARY KEY (herra_id)

	ALTER TABLE [GD2C2021].[SQLI].Tipo_paquete			ADD PRIMARY KEY (t_pack_id)

	ALTER TABLE [GD2C2021].[SQLI].Paquete				ADD PRIMARY KEY (pack_id)
	ALTER TABLE [GD2C2021].[SQLI].Paquete				ADD FOREIGN KEY (pack_tipo)					REFERENCES [GD2C2021].[SQLI].Tipo_paquete(t_pack_id)	ON DELETE NO ACTION ON UPDATE NO ACTION ;
	ALTER TABLE [GD2C2021].[SQLI].Paquete				ADD FOREIGN KEY (pack_viaje)				REFERENCES [GD2C2021].[SQLI].Viaje(viaje_id)			ON DELETE NO ACTION ON UPDATE NO ACTION ;
		
	ALTER TABLE [GD2C2021].[SQLI].Orden_De_Trabajo		ADD PRIMARY KEY (odt_id)	
	ALTER TABLE [GD2C2021].[SQLI].Orden_De_Trabajo		ADD FOREIGN KEY (odt_camion)				REFERENCES [GD2C2021].[SQLI].Camion(cami_id)			ON DELETE NO ACTION ON UPDATE NO ACTION ;
	
	ALTER TABLE [GD2C2021].[SQLI].Tareas				ADD PRIMARY KEY (tarea_codigo)
	ALTER TABLE [GD2C2021].[SQLI].Tareas				ADD FOREIGN KEY (tarea_tipo)				REFERENCES [GD2C2021].[SQLI].Tipo_Tarea(tipo_id)		ON DELETE NO ACTION ON UPDATE NO ACTION ;
	
	ALTER TABLE [GD2C2021].[SQLI].Herramienta_Por_Tarea	ADD FOREIGN KEY (tarea_codigo)				REFERENCES [GD2C2021].[SQLI].Tareas(tarea_codigo)		ON DELETE NO ACTION ON UPDATE NO ACTION ;
	ALTER TABLE [GD2C2021].[SQLI].Herramienta_Por_Tarea ADD FOREIGN KEY (herra_id)					REFERENCES [GD2C2021].[SQLI].Herramientas(herra_id)		ON DELETE NO ACTION ON UPDATE NO ACTION ;
	
	ALTER TABLE [GD2C2021].[SQLI].Tarea_Por_ODT			ADD FOREIGN KEY (tarea_id)					REFERENCES [GD2C2021].[SQLI].Tareas(tarea_codigo)		ON DELETE NO ACTION ON UPDATE NO ACTION ;
	ALTER TABLE [GD2C2021].[SQLI].Tarea_Por_ODT			ADD FOREIGN KEY (odt_id)					REFERENCES [GD2C2021].[SQLI].Orden_De_Trabajo(odt_id)	ON DELETE NO ACTION ON UPDATE NO ACTION ;
	ALTER TABLE [GD2C2021].[SQLI].Tarea_Por_ODT			ADD FOREIGN KEY (tarea_mecanico)			REFERENCES [GD2C2021].[SQLI].Mecanico(meca_nro_legajo)	ON DELETE NO ACTION ON UPDATE NO ACTION ;
GO

-------------------------------- procedures para realizar las migraciones de las tablas --------------------------------
CREATE PROCEDURE Insercion_Tabla_Modelo AS
	INSERT INTO [GD2C2021].[SQLI].Modelo(modelo_detalle,	modelo_vel_max,modelo_cap_tanque, modelo_cap_carga)
	SELECT		MODELO_CAMION,MODELO_CAPACIDAD_CARGA,MODELO_CAPACIDAD_TANQUE,MODELO_VELOCIDAD_MAX
	FROM		[GD2C2021].[gd_esquema].Maestra AS MASTERTABLE
	where		(MODELO_CAMION is not null) or (MODELO_VELOCIDAD_MAX is not null) or (MODELO_CAPACIDAD_TANQUE is not null) or (MODELO_CAPACIDAD_CARGA is not null)
	group by	MODELO_CAMION, MODELO_VELOCIDAD_MAX, MODELO_CAPACIDAD_TANQUE, MODELO_CAPACIDAD_CARGA
GO

CREATE PROCEDURE Insercion_Tabla_Marca AS
	INSERT INTO [GD2C2021].[SQLI].Marca(marca_nombre)
	SELECT		 MARCA_CAMION_MARCA
	FROM		[GD2C2021].[gd_esquema].Maestra 
	WHERE		MARCA_CAMION_MARCA is not null
	GROUP BY	MARCA_CAMION_MARCA
GO

CREATE PROCEDURE Insercion_Tabla_Camion AS
	INSERT INTO		[GD2C2021].[SQLI].Camion(cami_modelo,cami_marca, cami_patente, cami_nro_chasis, cami_nro_motor, cami_fecha_alta)
	SELECT DISTINCT modelo_id,marca_id,CAMION_PATENTE,CAMION_NRO_CHASIS,CAMION_NRO_MOTOR,CAMION_FECHA_ALTA
	FROM gd_esquema.Maestra 
	JOIN GD2C2021.[SQLI].Modelo on MODELO_CAMION = modelo_detalle and MODELO_CAPACIDAD_TANQUE = modelo_cap_tanque
	JOIN GD2C2021.[SQLI].Marca on MARCA_CAMION_MARCA = marca_nombre
	GROUP BY modelo_id,	marca_id,CAMION_PATENTE,CAMION_NRO_CHASIS,CAMION_NRO_MOTOR,CAMION_FECHA_ALTA
GO

CREATE PROCEDURE Insercion_Tabla_Chofer AS
	
	INSERT INTO			[GD2C2021].[SQLI].Chofer (chofer_nro_legajo,chofer_nombre,chofer_apellido,chofer_dni,chofer_direccion,chofer_telefono,chofer_mail,chofer_fecha_nac,chofer_costo_hora)
	SELECT	DISTINCT	CHOFER_NRO_LEGAJO,CHOFER_NOMBRE,CHOFER_APELLIDO,CHOFER_DNI,CHOFER_DIRECCION,CHOFER_TELEFONO,CHOFER_MAIL,CHOFER_FECHA_NAC,CHOFER_COSTO_HORA
	FROM				[GD2C2021].[gd_esquema].Maestra AS MASTERTABLE
	WHERE				(CHOFER_NRO_LEGAJO is not null) 
GO

CREATE PROCEDURE Insercion_Tabla_Ciudad AS
	INSERT INTO [GD2C2021].[SQLI].Ciudad
	select distinct RECORRIDO_CIUDAD_ORIGEN from [GD2C2021].[gd_esquema].Maestra where RECORRIDO_CIUDAD_ORIGEN is not null 
	union 
	select distinct RECORRIDO_CIUDAD_DESTINO from [GD2C2021].[gd_esquema].Maestra where RECORRIDO_CIUDAD_DESTINO is not null
	union 
	select distinct TALLER_CIUDAD from [GD2C2021].[gd_esquema].Maestra where TALLER_CIUDAD is not null 
GO

CREATE PROCEDURE Insercion_Tabla_Recorrido AS
	INSERT INTO [GD2C2021].[SQLI].Recorrido(reco_ciudad_origen,reco_ciudad_destino,reco_km, reco_precio)
	SELECT DISTINCT c1.ciudad_id,c2.ciudad_id,RECORRIDO_KM,RECORRIDO_PRECIO
	FROM gd_esquema.Maestra
	JOIN [GD2C2021].[SQLI].[Ciudad] c1 ON c1.ciudad_nombre = RECORRIDO_CIUDAD_ORIGEN
	JOIN [GD2C2021].[SQLI].[Ciudad] c2 ON c2.ciudad_nombre = RECORRIDO_CIUDAD_DESTINO
GO

CREATE PROCEDURE Insercion_Tabla_Taller AS
	INSERT INTO [GD2C2021].[SQLI].Taller (taller_direccion,taller_telefono,taller_mail,taller_nombre,taller_ciudad)
	SELECT DISTINCT TALLER_DIRECCION,TALLER_TELEFONO,TALLER_MAIL,TALLER_NOMBRE,ciudad_id 
	FROM gd_esquema.Maestra
	JOIN [GD2C2021].[SQLI].Ciudad on ciudad_nombre = TALLER_CIUDAD
GO

CREATE PROCEDURE Insercion_Tabla_Mecanico AS
	INSERT INTO [GD2C2021].[SQLI].Mecanico(meca_nro_legajo, meca_nombre, meca_apellido,meca_dni,meca_direccion,meca_telefono,meca_cost_hora,meca_mail,meca_fecha_nac)
	SELECT DISTINCT MECANICO_NRO_LEGAJO,MECANICO_NOMBRE,MECANICO_APELLIDO,MECANICO_DNI,MECANICO_DIRECCION,MECANICO_TELEFONO,MECANICO_COSTO_HORA,MECANICO_MAIL,MECANICO_FECHA_NAC
	FROM			[GD2C2021].[gd_esquema].Maestra AS MASTERTABLE
	WHERE			(MECANICO_NRO_LEGAJO is not null)
GO

CREATE PROCEDURE Insercion_Tabla_Tipo_Tarea AS
	INSERT INTO [GD2C2021].[SQLI].Tipo_Tarea(tipo_tarea)
	SELECT	DISTINCT	TIPO_TAREA
	FROM				[GD2C2021].[gd_esquema].Maestra 
	where				TIPO_TAREA is not null
GO

CREATE PROCEDURE Insercion_Tabla_Tipo_Paquete AS
	INSERT INTO [GD2C2021].[SQLI].Tipo_Paquete(t_pack_alto_max,t_pack_ancho_max,t_pack_largo_max,t_pack_descripcion,t_pack_precio,t_pack_peso_maximo)
	SELECT DISTINCT PAQUETE_ALTO_MAX,PAQUETE_ANCHO_MAX,PAQUETE_LARGO_MAX,PAQUETE_DESCRIPCION,PAQUETE_PRECIO,PAQUETE_PESO_MAX
	FROM		gd_esquema.Maestra
	WHERE		PAQUETE_DESCRIPCION is not null
GO

CREATE PROCEDURE Insercion_Tabla_Herramientas AS
	INSERT INTO [GD2C2021].[SQLI].Herramientas(herra_code, herra_detalle, herra_precio)
	SELECT		MATERIAL_COD, MATERIAL_DESCRIPCION, MATERIAL_PRECIO
	FROM		[GD2C2021].[gd_esquema].Maestra
	where		(MATERIAL_COD is not null) or (MATERIAL_DESCRIPCION is not null) and (MATERIAL_PRECIO is not null)
	GROUP BY	MATERIAL_COD, MATERIAL_DESCRIPCION, MATERIAL_PRECIO
GO

CREATE PROCEDURE Insercion_Tabla_Tareas AS
	SET IDENTITY_INSERT [GD2C2021].[SQLI].Tareas ON
	INSERT INTO			[GD2C2021].[SQLI].Tareas(tarea_codigo, tarea_tipo, tarea_descripcion, tarea_tiempo_est)
	SELECT				TAREA_CODIGO, tipo.tipo_id, TAREA_DESCRIPCION, TAREA_TIEMPO_ESTIMADO
	FROM				[GD2C2021].[gd_esquema].Maestra AS MASTERTABLE
	join				[GD2C2021].[SQLI].Tipo_tarea tipo on MASTERTABLE.TIPO_TAREA = tipo.tipo_tarea-- no tengo como joinear contra tipo_tarea
	where				(TAREA_CODIGO is not null) or (tipo.tipo_id is not null) or (TAREA_DESCRIPCION is not null) or (TAREA_TIEMPO_ESTIMADO is not null)
	group by			TAREA_CODIGO, tipo.tipo_id, TAREA_DESCRIPCION, TAREA_TIEMPO_ESTIMADO
	SET IDENTITY_INSERT [GD2C2021].[SQLI].Tareas OFF
GO

CREATE PROCEDURE Insercion_Tabla_Viaje AS
	INSERT INTO		[GD2C2021].[SQLI].Viaje (viaje_camion, viaje_chofer, viaje_recorrido, viaje_fecha_ini, viaje_fecha_fin, viaje_lts_cons)
	SELECT DISTINCT	cam.cami_id, cho.chofer_nro_legajo, rec.reco_id, VIAJE_FECHA_INICIO, VIAJE_FECHA_FIN, VIAJE_CONSUMO_COMBUSTIBLE
	FROM			[GD2C2021].[gd_esquema].Maestra AS MASTERTABLE
	join			[GD2C2021].[SQLI].Camion cam  on MASTERTABLE.CAMION_NRO_CHASIS = cam.cami_nro_chasis
	join			[GD2C2021].[SQLI].Chofer cho  on MASTERTABLE.CHOFER_NRO_LEGAJO = cho.chofer_nro_legajo
	join			[GD2C2021].[SQLI].Recorrido rec on MASTERTABLE.RECORRIDO_PRECIO = rec.reco_precio
	where			(cam.cami_id is not null) or (cho.chofer_nro_legajo is not null) or (rec.reco_id is not null) or (VIAJE_FECHA_INICIO is not null) or (VIAJE_FECHA_FIN is not null) or (VIAJE_CONSUMO_COMBUSTIBLE is not null)
	group by		cam.cami_id, cho.chofer_nro_legajo, rec.reco_id, VIAJE_FECHA_INICIO, VIAJE_FECHA_FIN, VIAJE_CONSUMO_COMBUSTIBLE
GO

CREATE PROCEDURE Insercion_Tabla_Paquete AS
	INSERT INTO			[GD2C2021].[SQLI].Paquete (pack_tipo, pack_cantidad, pack_viaje)
	SELECT	DISTINCT	tip.t_pack_id, PAQUETE_CANTIDAD, v1.viaje_id
	FROM				[GD2C2021].[gd_esquema].Maestra AS MASTERTABLE
	JOIN				[GD2C2021].[SQLI].Tipo_Paquete tip on tip.t_pack_descripcion = MASTERTABLE.PAQUETE_DESCRIPCION
	JOIN				[GD2C2021].[SQLI].Viaje v1 on MASTERTABLE.VIAJE_FECHA_INICIO = v1.viaje_fecha_ini and MASTERTABLE.VIAJE_FECHA_FIN = v1.viaje_fecha_fin
	where				(MASTERTABLE.PAQUETE_DESCRIPCION is not null) or (MASTERTABLE.VIAJE_FECHA_INICIO is not null) or (MASTERTABLE.VIAJE_FECHA_FIN is not null)
	group by			tip.t_pack_id, PAQUETE_CANTIDAD, v1.viaje_id
GO

CREATE PROCEDURE Insercion_Tabla_Orden_De_Trabajo AS
	INSERT INTO [GD2C2021].[SQLI].Orden_De_Trabajo (odt_camion, odt_estado, odt_fecha_generado)
	SELECT		cam.cami_id, ORDEN_TRABAJO_ESTADO, ORDEN_TRABAJO_FECHA
	FROM		[GD2C2021].[gd_esquema].Maestra AS MASTERTABLE
	join		[GD2C2021].[SQLI].Camion cam on MASTERTABLE.CAMION_NRO_CHASIS = cam.cami_nro_chasis AND MASTERTABLE.CAMION_PATENTE = cam.cami_patente
	where		(CAMION_NRO_CHASIS is not null) and (cam.cami_id is not null) and (ORDEN_TRABAJO_ESTADO is not null) and (ORDEN_TRABAJO_FECHA is not null)
	group by	cam.cami_id, ORDEN_TRABAJO_ESTADO, ORDEN_TRABAJO_FECHA
GO

CREATE PROCEDURE Insercion_Tabla_Tarea_Por_ODT AS
	INSERT INTO [GD2C2021].[SQLI].Tarea_Por_ODT (tarea_id, odt_id, tarea_mecanico, tarea_fecha_inicio, tarea_fecha_fin, tarea_fe_in_plani)
	SELECT tar.tarea_codigo, ord.odt_id, mec.meca_nro_legajo, TAREA_FECHA_INICIO, TAREA_FECHA_FIN, TAREA_FECHA_INICIO_PLANIFICADO
	FROM [GD2C2021].[gd_esquema].Maestra as MASTERTABLE
	join [GD2C2021].[SQLI].Tareas tar on MASTERTABLE.TAREA_CODIGO = tar.tarea_codigo
	join [GD2C2021].[SQLI].Orden_De_Trabajo ord on MASTERTABLE.ORDEN_TRABAJO_ESTADO = ord.odt_estado and MASTERTABLE.ORDEN_TRABAJO_FECHA = ord.odt_fecha_generado
	join [GD2C2021].[SQLI].Mecanico mec on MASTERTABLE.MECANICO_NRO_LEGAJO = mec.meca_nro_legajo
	where (MASTERTABLE.TAREA_CODIGO is not null) or (MASTERTABLE.ORDEN_TRABAJO_ESTADO is not null) or (MASTERTABLE.ORDEN_TRABAJO_FECHA is not null)
			or (MASTERTABLE.MECANICO_NRO_LEGAJO is not null) or (TAREA_FECHA_INICIO is not null) or (TAREA_FECHA_FIN is not null) or (TAREA_FECHA_INICIO_PLANIFICADO is not null)
	 group by tar.tarea_codigo, ord.odt_id, mec.meca_nro_legajo, TAREA_FECHA_INICIO, TAREA_FECHA_FIN, TAREA_FECHA_INICIO_PLANIFICADO
GO

/*
En la correcion del tp, nos pusieron que no se esta teniendo en cuenta el camion para identificar el viaje ==> Esto se hace en el procedure 
Insercion_Tabla_Orden_De_Trabajo ==> Usamos el id del camion en la tabla Orden_De_Trabajo, no en Tarea_Por_ODT
*/

CREATE PROCEDURE Insercion_Tabla_Herramienta_Por_Tarea AS
    INSERT INTO [GD2C2021].[SQLI].Herramienta_Por_Tarea (tarea_codigo, herra_id)--, mxt_cantidad) FE DE ERRATAS mxt_cantidad esta comentado porque no existe la columna en la tabla maestra.
    SELECT        tar.tarea_codigo, her.herra_id --', MXT_CANTIDAD'
    FROM        [GD2C2021].[gd_esquema].Maestra as MASTERTABLE
    join        [GD2C2021].[SQLI].Herramientas her on MASTERTABLE.MATERIAL_COD = her.herra_code and MASTERTABLE.MATERIAL_DESCRIPCION = her.herra_detalle
        and MASTERTABLE.MATERIAL_PRECIO = her.herra_precio
    join [GD2C2021].[SQLI].Tareas tar on MASTERTABLE.TAREA_CODIGO = tar.tarea_codigo
    where (MASTERTABLE.MATERIAL_COD is not null)
    group by tar.tarea_codigo, her.herra_id-- ', MXT_CANTIDAD'
GO

-------------------------------- procedure migracion ----------------------------------------------------------------

CREATE PROCEDURE Migracion AS
	
	EXEC Insercion_Tabla_Herramientas
	EXEC Insercion_Tabla_Mecanico
	EXEC Insercion_Tabla_Ciudad
	EXEC Insercion_Tabla_Tipo_Paquete
	EXEC Insercion_Tabla_Modelo
	EXEC Insercion_Tabla_Marca
	EXEC Insercion_Tabla_Camion
	EXEC Insercion_Tabla_Chofer
	EXEC Insercion_Tabla_Recorrido
	EXEC Insercion_Tabla_Taller
	EXEC Insercion_Tabla_Tipo_Tarea
	EXEC Insercion_Tabla_Viaje
	EXEC Insercion_Tabla_Paquete
	EXEC Insercion_Tabla_Tareas
	EXEC Insercion_Tabla_Herramienta_Por_Tarea
	EXEC Insercion_Tabla_Orden_De_Trabajo
	EXEC Insercion_Tabla_Tarea_Por_ODT
GO

-------------------------------- procedures para reseteos de tablas -------------------------------------------------
CREATE PROCEDURE Reseteo_Tablas AS

	IF (OBJECT_ID('GD2C2021.SQLI.Paquete')IS NOT NULL)					DROP TABLE [GD2C2021].[SQLI].Paquete
	IF (OBJECT_ID('GD2C2021.SQLI.Orden_De_Trabajo')IS NOT NULL)			DROP TABLE [GD2C2021].[SQLI].Orden_De_Trabajo
	IF (OBJECT_ID('GD2C2021.SQLI.Tareas')IS NOT NULL)					DROP TABLE [GD2C2021].[SQLI].Tareas
	IF (OBJECT_ID('GD2C2021.SQLI.Herramienta_Por_Tarea')IS NOT NULL)	DROP TABLE [GD2C2021].[SQLI].Herramienta_Por_Tarea
	IF (OBJECT_ID('GD2C2021.SQLI.Tarea_Por_ODT')IS NOT NULL)			DROP TABLE [GD2C2021].[SQLI].Tarea_Por_ODT
	IF (OBJECT_ID('GD2C2021.SQLI.Tipo_Paquete')IS NOT NULL)				DROP TABLE [GD2C2021].[SQLI].Tipo_Paquete
	IF (OBJECT_ID('GD2C2021.SQLI.Herramientas')IS NOT NULL)				DROP TABLE [GD2C2021].[SQLI].Herramientas
	IF (OBJECT_ID('GD2C2021.SQLI.Tipo_Tarea')IS NOT NULL)				DROP TABLE [GD2C2021].[SQLI].Tipo_Tarea
	IF (OBJECT_ID('GD2C2021.SQLI.Mecanico')IS NOT NULL)					DROP TABLE [GD2C2021].[SQLI].Mecanico
	IF (OBJECT_ID('GD2C2021.SQLI.Taller')IS NOT NULL)					DROP TABLE [GD2C2021].[SQLI].Taller
	IF (OBJECT_ID('GD2C2021.SQLI.Viaje')IS NOT NULL)					DROP TABLE [GD2C2021].[SQLI].Viaje
	IF (OBJECT_ID('GD2C2021.SQLI.Recorrido')IS NOT NULL)				DROP TABLE [GD2C2021].[SQLI].Recorrido
	IF (OBJECT_ID('GD2C2021.SQLI.Ciudad')IS NOT NULL)					DROP TABLE [GD2C2021].[SQLI].Ciudad
	IF (OBJECT_ID('GD2C2021.SQLI.Chofer')IS NOT NULL)					DROP TABLE [GD2C2021].[SQLI].Chofer
	IF (OBJECT_ID('GD2C2021.SQLI.Camion')IS NOT NULL)					DROP TABLE [GD2C2021].[SQLI].Camion
	IF (OBJECT_ID('GD2C2021.SQLI.Marca')IS NOT NULL)					DROP TABLE [GD2C2021].[SQLI].Marca
	IF (OBJECT_ID('GD2C2021.SQLI.Modelo')IS NOT NULL)					DROP TABLE [GD2C2021].[SQLI].Modelo

GO

CREATE PROCEDURE Reseteo_Procedures AS

	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Creacion_de_Tablas' AND type = 'p')						DROP PROCEDURE dbo.Creacion_de_Tablas
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'PK_Y_FK' AND type = 'p')								DROP PROCEDURE dbo.PK_Y_FK
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Tabla_Ciudad' AND type = 'p')					DROP PROCEDURE dbo.Insercion_Tabla_Ciudad
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Tabla_Herramientas' AND type = 'p')			DROP PROCEDURE dbo.Insercion_Tabla_Herramientas
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Tabla_Recorrido' AND type = 'p')				DROP PROCEDURE dbo.Insercion_Tabla_Recorrido
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Tabla_Taller' AND type = 'p')					DROP PROCEDURE dbo.Insercion_Tabla_Taller
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Tabla_Chofer' AND type = 'p')					DROP PROCEDURE dbo.Insercion_Tabla_Chofer
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Tabla_Modelo' AND type = 'p')					DROP PROCEDURE dbo.Insercion_Tabla_Modelo
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Tabla_Tipo_Paquete' AND type = 'p')			DROP PROCEDURE dbo.Insercion_Tabla_Tipo_Paquete
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Tabla_Marca' AND type = 'p')					DROP PROCEDURE dbo.Insercion_Tabla_Marca
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Tabla_Camion' AND type = 'p')					DROP PROCEDURE dbo.Insercion_Tabla_Camion
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Tabla_Mecanico' AND type = 'p')				DROP PROCEDURE dbo.Insercion_Tabla_Mecanico
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Tabla_Paquete' AND type = 'p')				DROP PROCEDURE dbo.Insercion_Tabla_Paquete
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Tabla_Viaje' AND type = 'p')					DROP PROCEDURE dbo.Insercion_Tabla_Viaje
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Tabla_Tipo_Tarea' AND type = 'p')				DROP PROCEDURE dbo.Insercion_Tabla_Tipo_Tarea
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Tabla_Tareas' AND type = 'p')					DROP PROCEDURE dbo.Insercion_Tabla_Tareas
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Tabla_Herramienta_Por_Tarea' AND type = 'p')  DROP PROCEDURE dbo.Insercion_Tabla_Herramienta_Por_Tarea
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Tabla_Orden_De_Trabajo' AND type = 'p')		DROP PROCEDURE dbo.Insercion_Tabla_Orden_De_Trabajo
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Insercion_Tabla_Tarea_Por_ODT' AND type = 'p')			DROP PROCEDURE dbo.Insercion_Tabla_Tarea_Por_ODT
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Migracion' AND type = 'p')								DROP PROCEDURE dbo.Migracion
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Reseteo_Tablas' AND type = 'p')							DROP PROCEDURE dbo.Reseteo_Tablas
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Reseteo_Procedures' AND type = 'p')						DROP PROCEDURE dbo.Reseteo_Procedures
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Reseteo' AND type = 'p')								DROP PROCEDURE dbo.Reseteo
	IF EXISTS (SELECT * FROM  sys.procedures WHERE  NAME = 'Play' AND type = 'p')									DROP PROCEDURE dbo.Play

GO

CREATE PROCEDURE Reseteo AS

	EXEC Reseteo_Tablas
	EXEC Reseteo_Procedures

GO
-------------------------------- procedure principal ----------------------------------------------------------------
/* si se toca f5 para iniciar y ya habia algo creado hay que tocar f5 2 veces porque tira un error que no supe sacar
( consulta a los ayudantes) pero funciona de 10 sin contar esa falopeada */
CREATE PROCEDURE Play AS
	IF EXISTS (SELECT * FROM   sys.schemas WHERE  NAME = 'SQLI')
	BEGIN
		EXEC Reseteo
		DROP SCHEMA SQLI
	END
	ELSE
	BEGIN
		EXEC ('use [GD2C2021]')
		EXEC ('create schema SQLI')
		EXEC Creacion_de_Tablas
		EXEC PK_Y_FK
		EXEC Migracion
	END

GO

-------------------------------- TOCA PLAY PAPAAAA ----------------------------------------------------------------
EXEC Play

