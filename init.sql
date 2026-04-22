-- 1. Tablas Catálogo
CREATE TABLE paises (
    id          VARCHAR(10)  PRIMARY KEY,
    nombre      VARCHAR(100) NOT NULL,
    codigo_iso  VARCHAR(3)
);

CREATE TABLE estilos (
    id     VARCHAR(10)  PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    tipo   VARCHAR(50)  NOT NULL
);

CREATE TABLE generos_contenido (
    id     VARCHAR(10)  PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    tipo   VARCHAR(50)  NOT NULL
);

CREATE TABLE categorias (
    id     VARCHAR(10)  PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE formatos (
    id          VARCHAR(10) PRIMARY KEY,
    nombre      VARCHAR(50) NOT NULL,
    dispositivo VARCHAR(50)
);

-- 2. Personas y Clientes
CREATE TABLE personas (
    id               VARCHAR(20)  PRIMARY KEY,
    nombre           VARCHAR(100) NOT NULL,
    apellido         VARCHAR(100) NOT NULL,
    genero           CHAR(1)      CHECK (genero IN ('M','F','O')),
    fecha_nacimiento DATE,
    telefono         VARCHAR(20),
    email            VARCHAR(150) UNIQUE NOT NULL,
    fk_pais          VARCHAR(10)  REFERENCES paises(id)
);

CREATE TABLE clientes (
    id              VARCHAR(20)  PRIMARY KEY,
    clave_acceso    VARCHAR(255) NOT NULL,
    direccion       VARCHAR(255),
    profesion       VARCHAR(100),
    fecha_inclusion DATE,
    fk_persona      VARCHAR(20)  UNIQUE NOT NULL REFERENCES personas(id)
    -- UNIQUE: una persona solo puede ser un cliente
);

CREATE TABLE tipos_pago (
    id     VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE formas_de_pago (
    id                VARCHAR(20)  PRIMARY KEY,
    numero_cuenta     VARCHAR(150),
    titular           VARCHAR(150),
    fecha_vencimiento DATE,
    direccion_wallet  VARCHAR(255),
    fk_tipo_pago      VARCHAR(10)  NOT NULL REFERENCES tipos_pago(id),
    fk_cliente        VARCHAR(20)  NOT NULL REFERENCES clientes(id),
    CHECK (
        (direccion_wallet IS NOT NULL AND numero_cuenta IS NULL)
        OR
        (direccion_wallet IS NULL AND numero_cuenta IS NOT NULL)
    )
);

CREATE TABLE membresias (
    id           VARCHAR(20)    PRIMARY KEY,
    fecha_inicio DATE           NOT NULL,
    fecha_fin    DATE           NOT NULL,
    monto_pagado DECIMAL(10,2)  NOT NULL,
    estado       VARCHAR(20)    NOT NULL
                                CHECK (estado IN ('activa','vencida','cancelada')),
    fk_cliente   VARCHAR(20)    NOT NULL REFERENCES clientes(id),
    fk_forma_pago VARCHAR(20)   NOT NULL REFERENCES formas_de_pago(id)
);

-- 3. Artistas
CREATE TABLE categoria_artista (
    id     VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE artistas (
    id         VARCHAR(20) PRIMARY KEY,
    biografia  TEXT,
    fk_persona VARCHAR(20) UNIQUE NOT NULL REFERENCES personas(id)
    -- UNIQUE: una persona solo puede ser un artista
);

CREATE TABLE artista_categoria (
    id           VARCHAR(20) PRIMARY KEY,
    fk_artista   VARCHAR(20) NOT NULL REFERENCES artistas(id),
    fk_categoria VARCHAR(10) NOT NULL REFERENCES categoria_artista(id),
    fk_estilo    VARCHAR(10)          REFERENCES estilos(id)
    -- fk_estilo nullable: directores/productores pueden no tener estilo
);

-- 4. Sagas y Contenido General
CREATE TABLE sagas (
    id           VARCHAR(20)  PRIMARY KEY,
    nombre       VARCHAR(150) NOT NULL,
    descripcion  TEXT,
    anio_inicio  INT,
    fk_genero    VARCHAR(10)  REFERENCES generos_contenido(id),
    fk_categoria VARCHAR(10)  REFERENCES categorias(id),
    fk_artista   VARCHAR(20)  REFERENCES artistas(id)
);

CREATE TABLE contenidos (
    id            VARCHAR(20)  PRIMARY KEY,
    titulo        VARCHAR(255) NOT NULL,
    anio          INT,
    duracion      INT,          -- en minutos (null para series: duración está en episodios)
    clasificacion VARCHAR(20),
    url_stream    VARCHAR(255),
    tipo          VARCHAR(50)  NOT NULL
                               CHECK (tipo IN (
                                   'pelicula','serie','cancion',
                                   'episodio','video_musical'
                               )),
    fk_pais      VARCHAR(10)  REFERENCES paises(id),
    fk_genero    VARCHAR(10)  REFERENCES generos_contenido(id),
    fk_categoria VARCHAR(10)  REFERENCES categorias(id)
);

-- 5. Películas
CREATE TABLE peliculas (
    id            VARCHAR(20) PRIMARY KEY,
    estudio       VARCHAR(150),
    numero_en_saga INT,
    fk_contenido  VARCHAR(20) UNIQUE NOT NULL REFERENCES contenidos(id),
    -- UNIQUE: un contenido solo puede ser una película
    fk_saga       VARCHAR(20)        REFERENCES sagas(id)
    -- nullable: no toda película pertenece a una saga
);

CREATE TABLE peliculas_artistas (
    id               VARCHAR(20) PRIMARY KEY,
    rol              VARCHAR(50) NOT NULL
                                 CHECK (rol IN ('Actor','Director','Productor')),
    nombre_personaje VARCHAR(150),
    fk_pelicula      VARCHAR(20) NOT NULL REFERENCES peliculas(id),
    fk_artista       VARCHAR(20) NOT NULL REFERENCES artistas(id)
);

-- 6. Series
CREATE TABLE series (
    id           VARCHAR(20)  PRIMARY KEY,
    estudio      VARCHAR(150),
    fk_contenido VARCHAR(20)  UNIQUE NOT NULL REFERENCES contenidos(id),
    -- UNIQUE: un contenido solo puede ser una serie
    fk_saga      VARCHAR(20)          REFERENCES sagas(id)
    -- nullable: no toda serie pertenece a una saga
);

CREATE TABLE series_artistas (
    id         VARCHAR(20) PRIMARY KEY,
    rol        VARCHAR(50) NOT NULL
                           CHECK (rol IN ('Actor','Director','Productor')),
    fk_serie   VARCHAR(20) NOT NULL REFERENCES series(id),
    fk_artista VARCHAR(20) NOT NULL REFERENCES artistas(id)
);

CREATE TABLE temporadas (
    id               VARCHAR(20) PRIMARY KEY,
    numero_temporada INT         NOT NULL,
    anio             INT,
    fk_serie         VARCHAR(20) NOT NULL REFERENCES series(id)
);

CREATE TABLE episodios (
    id               VARCHAR(20)  PRIMARY KEY,
    numero_episodio  INT          NOT NULL,
    titulo           VARCHAR(200),
    duracion         INT,
    fk_temporada     VARCHAR(20)  NOT NULL REFERENCES temporadas(id),
    fk_contenido     VARCHAR(20)  UNIQUE NOT NULL REFERENCES contenidos(id)
    -- UNIQUE: un contenido solo puede ser un episodio
);

-- 7. Música
CREATE TABLE canciones (
    id           VARCHAR(20) PRIMARY KEY,
    lirica       TEXT,
    compositores VARCHAR(255),
    fk_contenido VARCHAR(20) UNIQUE NOT NULL REFERENCES contenidos(id)
    -- UNIQUE: un contenido solo puede ser una canción
);

CREATE TABLE videos_musicales (
    id           VARCHAR(20) PRIMARY KEY,
    fk_contenido VARCHAR(20) UNIQUE NOT NULL REFERENCES contenidos(id),
    -- UNIQUE: un contenido solo puede ser un video musical
    fk_cancion   VARCHAR(20)        REFERENCES canciones(id)
    -- nullable: un video musical puede existir sin canción asociada
);

CREATE TABLE canciones_artistas (
    id         VARCHAR(20) PRIMARY KEY,
    rol        VARCHAR(50)
               CHECK (rol IN ('Intérprete','Compositor','Productor musical')),
    fk_cancion VARCHAR(20) NOT NULL REFERENCES canciones(id),
    fk_artista VARCHAR(20) NOT NULL REFERENCES artistas(id)
);

-- 8. Actividad de Clientes
CREATE TABLE reproducciones (
    id            VARCHAR(20)  PRIMARY KEY,
    fecha_inicio  TIMESTAMP    NOT NULL,
    estado_actual VARCHAR(50)
                  CHECK (estado_actual IN ('en_progreso','completado','pausado')),
    cantidad_veces INT         DEFAULT 1,
    fk_cliente    VARCHAR(20)  NOT NULL REFERENCES clientes(id),
    fk_contenido  VARCHAR(20)  NOT NULL REFERENCES contenidos(id)
);

CREATE TABLE descargas (
    id            VARCHAR(20)  PRIMARY KEY,
    fecha_inicio  TIMESTAMP    NOT NULL,
    estado_actual VARCHAR(50)
                  CHECK (estado_actual IN ('pendiente','completado','fallido')),
    cantidad_veces INT         DEFAULT 1,
    fk_cliente    VARCHAR(20)  NOT NULL REFERENCES clientes(id),
    fk_contenido  VARCHAR(20)  NOT NULL REFERENCES contenidos(id),
    fk_formato    VARCHAR(10)  NOT NULL REFERENCES formatos(id)
);

CREATE TABLE preferencias (
    id             VARCHAR(20) PRIMARY KEY,
    fecha_agregado DATE,
    fk_cliente     VARCHAR(20) NOT NULL REFERENCES clientes(id),
    fk_contenido   VARCHAR(20) NOT NULL REFERENCES contenidos(id),
    UNIQUE (fk_cliente, fk_contenido)
    -- evita duplicados: un cliente no puede tener el mismo favorito dos veces
);