-- 1. Tablas Catálogo
CREATE TABLE paises (
    id VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    codigo_iso VARCHAR(3)
);

CREATE TABLE estilos (
    id VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    tipo VARCHAR(50) NOT NULL
);

CREATE TABLE generos_contenido (
    id VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    tipo VARCHAR(50) NOT NULL
);

CREATE TABLE categorias (
    id VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE formatos (
    id VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    dispositivo VARCHAR(50)
);

-- 2. Personas y Clientes
CREATE TABLE personas (
    id VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    genero CHAR(1), -- 'M', 'F', 'O'
    fecha_nacimiento DATE,
    telefono VARCHAR(20),
    email VARCHAR(150) UNIQUE,
    fk_pais VARCHAR(10) REFERENCES paises(id)
);

CREATE TABLE clientes (
    id VARCHAR(20) PRIMARY KEY,
    clave_acceso VARCHAR(255) NOT NULL,
    direccion VARCHAR(255),
    profesion VARCHAR(100),
    fecha_inclusion DATE,
    fk_persona VARCHAR(20) REFERENCES personas(id)
);

CREATE TABLE tipos_pago (
    id VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(50)
);

CREATE TABLE formas_de_pago (
    id VARCHAR(20) PRIMARY KEY,
    numero_cuenta VARCHAR(150),
    titular VARCHAR(150),
    fecha_vencimiento DATE,
    direccion_wallet VARCHAR(255),
    fk_tipo_pago VARCHAR(10) REFERENCES tipos_pago(id),
    fk_cliente VARCHAR(20) REFERENCES clientes(id)
);

CREATE TABLE membresias (
    id VARCHAR(20) PRIMARY KEY,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    monto_pagado DECIMAL(10,2) NOT NULL,
    estado VARCHAR(20) NOT NULL,
    fk_cliente VARCHAR(20) REFERENCES clientes(id),
    fk_forma_pago VARCHAR(20) REFERENCES formas_de_pago(id)
);

-- 3. Artistas
CREATE TABLE categoria_artista (
    id VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(50)
);

CREATE TABLE artistas (
    id VARCHAR(20) PRIMARY KEY,
    biografia TEXT,
    fk_persona VARCHAR(20) REFERENCES personas(id)
);

CREATE TABLE artista_categoria (
    id VARCHAR(20) PRIMARY KEY,
    fk_artista VARCHAR(20) REFERENCES artistas(id),
    fk_categoria VARCHAR(10) REFERENCES categoria_artista(id),
    fk_estilo VARCHAR(10) REFERENCES estilos(id)
);

-- 4. Contenido General y Sagas
CREATE TABLE sagas (
    id VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    anio_inicio INT,
    fk_genero VARCHAR(10) REFERENCES generos_contenido(id),
    fk_categoria VARCHAR(10) REFERENCES categorias(id)
);

CREATE TABLE contenidos (
    id VARCHAR(20) PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    anio INT,
    duracion INT, -- En minutos
    clasificacion VARCHAR(20),
    url_stream VARCHAR(255),
    tipo VARCHAR(50) NOT NULL, -- 'pelicula', 'serie', 'video_musical'
    fk_pais VARCHAR(10) REFERENCES paises(id),
    fk_genero VARCHAR(10) REFERENCES generos_contenido(id),
    fk_categoria VARCHAR(10) REFERENCES categorias(id)
);

-- 5. Películas y Series
CREATE TABLE peliculas (
    id VARCHAR(20) PRIMARY KEY,
    estudio VARCHAR(150),
    numero_en_saga INT,
    fk_contenido VARCHAR(20) REFERENCES contenidos(id),
    fk_saga VARCHAR(20) REFERENCES sagas(id)
);

CREATE TABLE peliculas_artistas (
    id VARCHAR(20) PRIMARY KEY,
    rol VARCHAR(50) NOT NULL, -- 'Actor', 'Director', 'Productor'
    nombre_personaje VARCHAR(150),
    fk_pelicula VARCHAR(20) REFERENCES peliculas(id),
    fk_artista VARCHAR(20) REFERENCES artistas(id)
);

CREATE TABLE series (
    id VARCHAR(20) PRIMARY KEY,
    estudio VARCHAR(150),
    fk_contenido VARCHAR(20) REFERENCES contenidos(id),
    fk_saga VARCHAR(20) REFERENCES sagas(id)
);

CREATE TABLE series_artistas (
    id VARCHAR(20) PRIMARY KEY,
    rol VARCHAR(50) NOT NULL,
    fk_serie VARCHAR(20) REFERENCES series(id),
    fk_artista VARCHAR(20) REFERENCES artistas(id)
);

CREATE TABLE temporadas (
    id VARCHAR(20) PRIMARY KEY,
    numero_temporada INT NOT NULL,
    anio INT,
    fk_serie VARCHAR(20) REFERENCES series(id)
);

CREATE TABLE episodios (
    id VARCHAR(20) PRIMARY KEY,
    numero_episodio INT NOT NULL,
    titulo VARCHAR(200),
    duracion INT,
    fk_temporada VARCHAR(20) REFERENCES temporadas(id),
    fk_contenido VARCHAR(20) REFERENCES contenidos(id)
);

-- 6. Música y Videos Musicales
CREATE TABLE canciones (
    id VARCHAR(20) PRIMARY KEY,
    lirica TEXT,
    compositores VARCHAR(255),
    fk_contenido VARCHAR(20) REFERENCES contenidos(id)
);

CREATE TABLE videos_musicales (
    id VARCHAR(20) PRIMARY KEY,
    fk_contenido VARCHAR(20) REFERENCES contenidos(id),
    fk_cancion VARCHAR(20) REFERENCES canciones(id)
);

CREATE TABLE canciones_artistas (
    id VARCHAR(20) PRIMARY KEY,
    rol VARCHAR(50),
    fk_cancion VARCHAR(20) REFERENCES canciones(id),
    fk_artista VARCHAR(20) REFERENCES artistas(id)
);

-- 7. Transacciones y Actividad
CREATE TABLE reproducciones (
    id VARCHAR(20) PRIMARY KEY,
    fecha_inicio TIMESTAMP NOT NULL,
    estado_actual VARCHAR(50), -- 'en_progreso', 'completado'
    cantidad_veces INT DEFAULT 1,
    fk_cliente VARCHAR(20) REFERENCES clientes(id),
    fk_contenido VARCHAR(20) REFERENCES contenidos(id)
);

CREATE TABLE descargas (
    id VARCHAR(20) PRIMARY KEY,
    fecha_inicio TIMESTAMP NOT NULL,
    estado_actual VARCHAR(50), -- 'completado', 'fallido'
    cantidad_veces INT DEFAULT 1,
    fk_cliente VARCHAR(20) REFERENCES clientes(id),
    fk_contenido VARCHAR(20) REFERENCES contenidos(id),
    fk_formato VARCHAR(10) REFERENCES formatos(id)
);

CREATE TABLE preferencias (
    id VARCHAR(20) PRIMARY KEY,
    fecha_agregado DATE,
    fk_cliente VARCHAR(20) REFERENCES clientes(id),
    fk_contenido VARCHAR(20) REFERENCES contenidos(id)
);