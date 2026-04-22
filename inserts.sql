-- Datos de prueba Oracle para ejecutar queries.sql en el esquema JOACO

-- 1) Catalogos
INSERT INTO paises (id, nombre, codigo_iso) VALUES ('cr', 'Costa Rica', 'CRI');
INSERT INTO paises (id, nombre, codigo_iso) VALUES ('us', 'Estados Unidos', 'USA');

INSERT INTO estilos (id, nombre, tipo) VALUES ('st_pop', 'Pop', 'musica');
INSERT INTO estilos (id, nombre, tipo) VALUES ('st_acc', 'Accion', 'actuacion');

INSERT INTO generos_contenido (id, nombre, tipo) VALUES ('g1', 'Accion', 'pelicula');
INSERT INTO generos_contenido (id, nombre, tipo) VALUES ('g2', 'Drama', 'serie');
INSERT INTO generos_contenido (id, nombre, tipo) VALUES ('g3', 'Musica', 'musica');

INSERT INTO categorias (id, nombre) VALUES ('cat1', 'Accion');
INSERT INTO categorias (id, nombre) VALUES ('cat2', 'Drama');
INSERT INTO categorias (id, nombre) VALUES ('cat5', 'Musical');

INSERT INTO formatos (id, nombre, dispositivo) VALUES ('f1', 'mp4', 'movil');
INSERT INTO formatos (id, nombre, dispositivo) VALUES ('f2', 'hd', 'smart_tv');

-- 2) Personas, clientes y pagos
INSERT INTO personas (id, nombre, apellido, genero, fecha_nacimiento, telefono, email, fk_pais)
VALUES ('p01', 'Cliente01', 'Apellido01', 'M', DATE '1990-01-01', '88880001', 'cliente01@tvz.net', 'cr');

INSERT INTO clientes (id, clave_acceso, direccion, profesion, fecha_inclusion, fk_persona)
VALUES ('c01', 'pass001', 'Direccion 1', 'Ingeniero', DATE '2024-01-10', 'p01');

INSERT INTO tipos_pago (id, nombre) VALUES ('tp1', 'Tarjeta');

INSERT INTO formas_de_pago (id, numero_cuenta, titular, fecha_vencimiento, direccion_wallet, fk_tipo_pago, fk_cliente)
VALUES ('fp1', '4111111111111111', 'Cliente01', DATE '2030-12-31', NULL, 'tp1', 'c01');

INSERT INTO membresias (id, fecha_inicio, fecha_fin, monto_pagado, estado, fk_cliente, fk_forma_pago)
VALUES ('m1', DATE '2025-01-01', DATE '2026-01-01', 59.99, 'activa', 'c01', 'fp1');

-- 3) Personas y artistas (incluye nombres esperados por queries)
INSERT INTO personas (id, nombre, apellido, genero, fecha_nacimiento, telefono, email, fk_pais)
VALUES ('p32', 'Artista32', 'Autor', 'F', DATE '1987-02-02', '88880032', 'artista32@tvz.net', 'us');

INSERT INTO personas (id, nombre, apellido, genero, fecha_nacimiento, telefono, email, fk_pais)
VALUES ('p37', 'Artista37', 'Singer', 'F', DATE '1992-03-03', '88880037', 'artista37@tvz.net', 'us');

INSERT INTO personas (id, nombre, apellido, genero, fecha_nacimiento, telefono, email, fk_pais)
VALUES ('p50', 'Actor50', 'Main', 'M', DATE '1988-04-04', '88880050', 'actor50@tvz.net', 'us');

INSERT INTO personas (id, nombre, apellido, genero, fecha_nacimiento, telefono, email, fk_pais)
VALUES ('p51', 'Director51', 'Lead', 'M', DATE '1979-05-05', '88880051', 'director51@tvz.net', 'us');

INSERT INTO categoria_artista (id, nombre) VALUES ('ca1', 'Actor');
INSERT INTO categoria_artista (id, nombre) VALUES ('ca2', 'Director');
INSERT INTO categoria_artista (id, nombre) VALUES ('ca3', 'Musico');

INSERT INTO artistas (id, biografia, fk_persona) VALUES ('a32', 'Autora de sagas de accion.', 'p32');
INSERT INTO artistas (id, biografia, fk_persona) VALUES ('a37', 'Interprete pop.', 'p37');
INSERT INTO artistas (id, biografia, fk_persona) VALUES ('a50', 'Actor principal.', 'p50');
INSERT INTO artistas (id, biografia, fk_persona) VALUES ('a51', 'Director de cine y series.', 'p51');

INSERT INTO artista_categoria (id, fk_artista, fk_categoria, fk_estilo) VALUES ('ac1', 'a32', 'ca2', 'st_acc');
INSERT INTO artista_categoria (id, fk_artista, fk_categoria, fk_estilo) VALUES ('ac2', 'a37', 'ca3', 'st_pop');
INSERT INTO artista_categoria (id, fk_artista, fk_categoria, fk_estilo) VALUES ('ac3', 'a50', 'ca1', 'st_acc');
INSERT INTO artista_categoria (id, fk_artista, fk_categoria, fk_estilo) VALUES ('ac4', 'a51', 'ca2', NULL);

-- 4) Sagas y contenidos
INSERT INTO sagas (id, nombre, descripcion, anio_inicio, fk_genero, fk_categoria, fk_artista)
VALUES ('saga1', 'Saga Accion Prime', 'Saga principal de accion', 2019, 'g1', 'cat1', 'a32');

INSERT INTO contenidos (id, titulo, anio, duracion, clasificacion, url_stream, tipo, fk_pais, fk_genero, fk_categoria)
VALUES ('ct_pel1', 'Pelicula Accion 2023', 2023, 125, 'PG-13', 'https://tvz.net/pel1', 'pelicula', 'us', 'g1', 'cat1');

INSERT INTO contenidos (id, titulo, anio, duracion, clasificacion, url_stream, tipo, fk_pais, fk_genero, fk_categoria)
VALUES ('ct_ser1', 'Serie Drama 2023', 2023, NULL, 'PG-13', 'https://tvz.net/ser1', 'serie', 'us', 'g2', 'cat2');

INSERT INTO contenidos (id, titulo, anio, duracion, clasificacion, url_stream, tipo, fk_pais, fk_genero, fk_categoria)
VALUES ('ct_epi1', 'Episodio 1', 2023, 48, 'PG-13', 'https://tvz.net/ser1/e1', 'episodio', 'us', 'g2', 'cat2');

INSERT INTO contenidos (id, titulo, anio, duracion, clasificacion, url_stream, tipo, fk_pais, fk_genero, fk_categoria)
VALUES ('ct_can1', 'Cancion Pop 2023', 2023, 4, 'G', 'https://tvz.net/can1', 'cancion', 'us', 'g3', 'cat5');

INSERT INTO contenidos (id, titulo, anio, duracion, clasificacion, url_stream, tipo, fk_pais, fk_genero, fk_categoria)
VALUES ('ct_vm1', 'Video Musical 2023', 2023, 5, 'G', 'https://tvz.net/vm1', 'video_musical', 'us', 'g3', 'cat5');

INSERT INTO peliculas (id, estudio, numero_en_saga, fk_contenido, fk_saga)
VALUES ('pel1', 'Studio One', 1, 'ct_pel1', 'saga1');

INSERT INTO peliculas_artistas (id, rol, nombre_personaje, fk_pelicula, fk_artista)
VALUES ('pa1', 'Actor', 'Heroe', 'pel1', 'a50');

INSERT INTO peliculas_artistas (id, rol, nombre_personaje, fk_pelicula, fk_artista)
VALUES ('pa2', 'Director', NULL, 'pel1', 'a51');

INSERT INTO series (id, estudio, fk_contenido, fk_saga)
VALUES ('ser1', 'Studio Two', 'ct_ser1', 'saga1');

INSERT INTO series_artistas (id, rol, fk_serie, fk_artista)
VALUES ('sa1', 'Actor', 'ser1', 'a50');

INSERT INTO series_artistas (id, rol, fk_serie, fk_artista)
VALUES ('sa2', 'Director', 'ser1', 'a51');

INSERT INTO temporadas (id, numero_temporada, anio, fk_serie)
VALUES ('t1', 1, 2023, 'ser1');

INSERT INTO episodios (id, numero_episodio, titulo, duracion, fk_temporada, fk_contenido)
VALUES ('e1', 1, 'Piloto', 48, 't1', 'ct_epi1');

INSERT INTO canciones (id, lirica, compositores, fk_contenido)
VALUES ('can1', 'Letra de prueba', 'Comp A, Comp B', 'ct_can1');

INSERT INTO videos_musicales (id, fk_contenido, fk_cancion)
VALUES ('vm1', 'ct_vm1', 'can1');

INSERT INTO canciones_artistas (id, rol, fk_cancion, fk_artista)
VALUES ('ca_song1', 'Intérprete', 'can1', 'a37');

INSERT INTO canciones_artistas (id, rol, fk_cancion, fk_artista)
VALUES ('ca_song2', 'Productor musical', 'can1', 'a51');

-- 5) Actividad de clientes
INSERT INTO reproducciones (id, fecha_inicio, estado_actual, cantidad_veces, fk_cliente, fk_contenido)
VALUES ('r1', TIMESTAMP '2025-03-10 10:00:00', 'completado', 4, 'c01', 'ct_pel1');

INSERT INTO reproducciones (id, fecha_inicio, estado_actual, cantidad_veces, fk_cliente, fk_contenido)
VALUES ('r2', TIMESTAMP '2025-03-11 12:00:00', 'completado', 6, 'c01', 'ct_can1');

INSERT INTO descargas (id, fecha_inicio, estado_actual, cantidad_veces, fk_cliente, fk_contenido, fk_formato)
VALUES ('d1', TIMESTAMP '2025-03-10 09:00:00', 'completado', 3, 'c01', 'ct_pel1', 'f1');

INSERT INTO descargas (id, fecha_inicio, estado_actual, cantidad_veces, fk_cliente, fk_contenido, fk_formato)
VALUES ('d2', TIMESTAMP '2025-03-11 13:00:00', 'completado', 5, 'c01', 'ct_vm1', 'f2');

INSERT INTO preferencias (id, fecha_agregado, fk_cliente, fk_contenido)
VALUES ('pref1', DATE '2025-03-11', 'c01', 'ct_pel1');

COMMIT;