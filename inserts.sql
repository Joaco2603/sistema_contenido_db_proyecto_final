-- =========================
-- CATALOGOS
-- =========================
INSERT INTO paises (id, nombre, codigo_iso) VALUES
('cr', 'Costa Rica', 'CRI'),
('us', 'Estados Unidos', 'USA'),
('mx', 'Mexico', 'MEX'),
('es', 'Espana', 'ESP'),
('ar', 'Argentina', 'ARG'),
('br', 'Brasil', 'BRA');

INSERT INTO estilos (id, nombre, tipo) VALUES
('st1', 'Rock', 'musica'),
('st2', 'Pop', 'musica'),
('st3', 'Jazz', 'musica'),
('st4', 'Drama', 'actuacion'),
('st5', 'Accion', 'actuacion'),
('st6', 'Electronica', 'musica');

INSERT INTO generos_contenido (id, nombre, tipo) VALUES
('g1', 'Accion', 'pelicula'),
('g2', 'Drama', 'serie'),
('g3', 'Musica', 'musica'),
('g4', 'Comedia', 'pelicula'),
('g5', 'General', 'general');

INSERT INTO categorias (id, nombre) VALUES
('cat1', 'Accion'),
('cat2', 'Drama'),
('cat3', 'Comedia'),
('cat4', 'Documental'),
('cat5', 'Musical');

INSERT INTO formatos (id, nombre, dispositivo) VALUES
('f1', 'mp4', 'movil'),
('f2', 'hd', 'smart_tv'),
('f3', 'tvz', 'pc');

-- =========================
-- PERSONAS / CLIENTES
-- =========================
INSERT INTO personas (id, nombre, apellido, genero, fecha_nacimiento, telefono, email, fk_pais)
SELECT
    'p' || lpad(gs::text, 2, '0'),
    'Cliente' || lpad(gs::text, 2, '0'),
    'Apellido' || lpad(gs::text, 2, '0'),
    CASE (gs - 1) % 3
        WHEN 0 THEN 'M'
        WHEN 1 THEN 'F'
        ELSE 'O'
    END,
    DATE '1980-01-01' + ((gs - 1) * 173),
    '8888' || lpad(gs::text, 4, '0'),
    'cliente' || lpad(gs::text, 2, '0') || '@tvz.net',
    CASE (gs - 1) % 6
        WHEN 0 THEN 'cr'
        WHEN 1 THEN 'us'
        WHEN 2 THEN 'mx'
        WHEN 3 THEN 'es'
        WHEN 4 THEN 'ar'
        ELSE 'br'
    END
FROM generate_series(1, 20) AS gs;

INSERT INTO clientes (id, clave_acceso, direccion, profesion, fecha_inclusion, fk_persona)
SELECT
    'c' || lpad(gs::text, 2, '0'),
    'pass' || lpad(gs::text, 3, '0'),
    'Direccion ' || gs,
    CASE (gs - 1) % 4
        WHEN 0 THEN 'Ingeniero'
        WHEN 1 THEN 'Docente'
        WHEN 2 THEN 'Disenador'
        ELSE 'Estudiante'
    END,
    DATE '2024-01-01' + ((gs - 1) * 7),
    'p' || lpad(gs::text, 2, '0')
FROM generate_series(1, 20) AS gs;

INSERT INTO tipos_pago (id, nombre) VALUES
('tp1', 'Tarjeta Credito'),
('tp2', 'Tarjeta Debito'),
('tp3', 'Bitcoin');

INSERT INTO formas_de_pago (id, numero_cuenta, titular, fecha_vencimiento, direccion_wallet, fk_tipo_pago, fk_cliente)
SELECT
    'fp' || lpad(gs::text, 2, '0'),
    CASE (gs - 1) % 3
        WHEN 2 THEN NULL
        ELSE 'ACC' || lpad(gs::text, 8, '0')
    END,
    'Cliente' || lpad(gs::text, 2, '0') || ' Apellido' || lpad(gs::text, 2, '0'),
    CASE (gs - 1) % 3
        WHEN 2 THEN NULL
        ELSE DATE '2027-12-31' - ((gs - 1) * 14)
    END,
    CASE (gs - 1) % 3
        WHEN 2 THEN 'wallet' || lpad(gs::text, 2, '0') || 'tvz'
        ELSE NULL
    END,
    CASE (gs - 1) % 3
        WHEN 0 THEN 'tp1'
        WHEN 1 THEN 'tp2'
        ELSE 'tp3'
    END,
    'c' || lpad(gs::text, 2, '0')
FROM generate_series(1, 20) AS gs;

INSERT INTO membresias (id, fecha_inicio, fecha_fin, monto_pagado, estado, fk_cliente, fk_forma_pago)
SELECT
    'm' || lpad(gs::text, 2, '0'),
    DATE '2024-01-01' + ((gs - 1) * 30),
    DATE '2025-01-01' + ((gs - 1) * 30),
    CAST(79.99 + (gs * 4.25) AS DECIMAL(10,2)),
    CASE (gs - 1) % 3
        WHEN 0 THEN 'activa'
        WHEN 1 THEN 'vencida'
        ELSE 'cancelada'
    END,
    'c' || lpad(gs::text, 2, '0'),
    'fp' || lpad(gs::text, 2, '0')
FROM generate_series(1, 20) AS gs;

-- =========================
-- ARTISTAS
-- =========================
INSERT INTO categoria_artista (id, nombre) VALUES
('ca1', 'Actor'),
('ca2', 'Director'),
('ca3', 'Productor'),
('ca4', 'Musico');

INSERT INTO personas (id, nombre, apellido, genero, fecha_nacimiento, telefono, email, fk_pais)
SELECT
    'p' || lpad(gs::text, 2, '0'),
    'Artista' || lpad(gs::text, 2, '0'),
    'Apellido' || lpad(gs::text, 2, '0'),
    CASE (gs - 21) % 3
        WHEN 0 THEN 'M'
        WHEN 1 THEN 'F'
        ELSE 'O'
    END,
    DATE '1970-01-01' + ((gs - 21) * 220),
    '7777' || lpad(gs::text, 4, '0'),
    'artista' || lpad(gs::text, 2, '0') || '@tvz.net',
    CASE (gs - 21) % 6
        WHEN 0 THEN 'cr'
        WHEN 1 THEN 'us'
        WHEN 2 THEN 'mx'
        WHEN 3 THEN 'es'
        WHEN 4 THEN 'ar'
        ELSE 'br'
    END
FROM generate_series(21, 40) AS gs;

INSERT INTO artistas (id, biografia, fk_persona)
SELECT
    'a' || lpad((gs - 20)::text, 2, '0'),
    'Biografia de Artista ' || (gs - 20),
    'p' || lpad(gs::text, 2, '0')
FROM generate_series(21, 40) AS gs;

INSERT INTO artista_categoria (id, fk_artista, fk_categoria, fk_estilo)
SELECT
    'ac' || lpad(gs::text, 2, '0'),
    'a' || lpad(gs::text, 2, '0'),
    'ca1',
    CASE (gs - 1) % 2
        WHEN 0 THEN 'st4'
        ELSE 'st5'
    END
FROM generate_series(1, 6) AS gs;

INSERT INTO artista_categoria (id, fk_artista, fk_categoria, fk_estilo)
SELECT
    'ac' || lpad(gs::text, 2, '0'),
    'a' || lpad(gs::text, 2, '0'),
    'ca2',
    NULL
FROM generate_series(7, 11) AS gs;

INSERT INTO artista_categoria (id, fk_artista, fk_categoria, fk_estilo)
SELECT
    'ac' || lpad(gs::text, 2, '0'),
    'a' || lpad(gs::text, 2, '0'),
    'ca3',
    NULL
FROM generate_series(12, 15) AS gs;

INSERT INTO artista_categoria (id, fk_artista, fk_categoria, fk_estilo)
SELECT
    'ac' || lpad(gs::text, 2, '0'),
    'a' || lpad(gs::text, 2, '0'),
    'ca4',
    CASE (gs - 16) % 5
        WHEN 0 THEN 'st1'
        WHEN 1 THEN 'st2'
        WHEN 2 THEN 'st3'
        WHEN 3 THEN 'st6'
        ELSE 'st2'
    END
FROM generate_series(16, 20) AS gs;

INSERT INTO sagas (id, nombre, descripcion, anio_inicio, fk_genero, fk_categoria, fk_artista) VALUES
('s01', 'Saga Horizonte', 'Accion y aventura', 2018, 'g1', 'cat1', 'a12'),
('s02', 'Saga Nocturna', 'Drama y misterio', 2020, 'g2', 'cat2', 'a13'),
('s03', 'Saga Risas', 'Comedia familiar', 2021, 'g4', 'cat3', 'a14'),
('s04', 'Saga Ritmo', 'Historias musicales', 2019, 'g3', 'cat5', 'a15'),
('s05', 'Saga Arena', 'Accion extrema', 2022, 'g1', 'cat1', 'a11');

-- =========================
-- CONTENIDOS BASE
-- =========================
INSERT INTO contenidos (id, titulo, anio, duracion, clasificacion, url_stream, tipo, fk_pais, fk_genero, fk_categoria)
SELECT
    'cont_m' || lpad(gs::text, 2, '0'),
    'Pelicula ' || lpad(gs::text, 2, '0'),
    2020 + ((gs - 1) % 5),
    90 + gs,
    CASE (gs - 1) % 3
        WHEN 0 THEN 'PG'
        WHEN 1 THEN 'PG-13'
        ELSE 'R'
    END,
    'https://tvz.net/movies/' || lpad(gs::text, 2, '0'),
    'pelicula',
    CASE (gs - 1) % 6
        WHEN 0 THEN 'cr'
        WHEN 1 THEN 'us'
        WHEN 2 THEN 'mx'
        WHEN 3 THEN 'es'
        WHEN 4 THEN 'ar'
        ELSE 'br'
    END,
    CASE (gs - 1) % 2
        WHEN 0 THEN 'g1'
        ELSE 'g4'
    END,
    CASE (gs - 1) % 2
        WHEN 0 THEN 'cat1'
        ELSE 'cat3'
    END
FROM generate_series(1, 20) AS gs;

INSERT INTO contenidos (id, titulo, anio, duracion, clasificacion, url_stream, tipo, fk_pais, fk_genero, fk_categoria)
SELECT
    'cont_s' || lpad(gs::text, 2, '0'),
    'Serie ' || lpad(gs::text, 2, '0'),
    2020 + (gs - 1),
    45,
    'TV-14',
    'https://tvz.net/series/' || lpad(gs::text, 2, '0'),
    'serie',
    CASE (gs - 1) % 6
        WHEN 0 THEN 'cr'
        WHEN 1 THEN 'us'
        WHEN 2 THEN 'mx'
        WHEN 3 THEN 'es'
        WHEN 4 THEN 'ar'
        ELSE 'br'
    END,
    'g2',
    'cat2'
FROM generate_series(1, 5) AS gs;

INSERT INTO contenidos (id, titulo, anio, duracion, clasificacion, url_stream, tipo, fk_pais, fk_genero, fk_categoria)
SELECT
    'cont_c' || lpad(gs::text, 2, '0'),
    'Cancion ' || lpad(gs::text, 2, '0'),
    2019 + ((gs - 1) % 6),
    3 + ((gs - 1) % 3),
    'G',
    'https://tvz.net/music/' || lpad(gs::text, 2, '0'),
    'cancion',
    CASE (gs - 1) % 6
        WHEN 0 THEN 'cr'
        WHEN 1 THEN 'us'
        WHEN 2 THEN 'mx'
        WHEN 3 THEN 'es'
        WHEN 4 THEN 'ar'
        ELSE 'br'
    END,
    'g3',
    'cat5'
FROM generate_series(1, 20) AS gs;

INSERT INTO contenidos (id, titulo, anio, duracion, clasificacion, url_stream, tipo, fk_pais, fk_genero, fk_categoria)
SELECT
    'cont_vm' || lpad(gs::text, 2, '0'),
    'Video Musical ' || lpad(gs::text, 2, '0'),
    2020 + ((gs - 1) % 5),
    4,
    'G',
    'https://tvz.net/videos/' || lpad(gs::text, 2, '0'),
    'video_musical',
    CASE (gs - 1) % 6
        WHEN 0 THEN 'cr'
        WHEN 1 THEN 'us'
        WHEN 2 THEN 'mx'
        WHEN 3 THEN 'es'
        WHEN 4 THEN 'ar'
        ELSE 'br'
    END,
    'g3',
    'cat5'
FROM generate_series(1, 20) AS gs;

WITH episodios_generados AS (
    SELECT
        gs,
        ((gs - 1) / 5) + 1 AS serie_num,
        ((gs - 1) % 5) + 1 AS episodio_num
    FROM generate_series(1, 25) AS gs
)
INSERT INTO contenidos (id, titulo, anio, duracion, clasificacion, url_stream, tipo, fk_pais, fk_genero, fk_categoria)
SELECT
    'cont_e' || lpad(gs::text, 2, '0'),
    'Serie ' || lpad(serie_num::text, 2, '0') || ' Episodio ' || lpad(episodio_num::text, 2, '0'),
    2020 + serie_num,
    42 + episodio_num,
    'TV-14',
    'https://tvz.net/episodes/' || lpad(gs::text, 2, '0'),
    'episodio',
    CASE (serie_num - 1) % 6
        WHEN 0 THEN 'cr'
        WHEN 1 THEN 'us'
        WHEN 2 THEN 'mx'
        WHEN 3 THEN 'es'
        WHEN 4 THEN 'ar'
        ELSE 'br'
    END,
    'g2',
    'cat2'
FROM episodios_generados;

-- =========================
-- PELICULAS Y SERIES
-- =========================
INSERT INTO peliculas (id, estudio, numero_en_saga, fk_contenido, fk_saga)
SELECT
    'pel' || lpad(gs::text, 2, '0'),
    'Studio ' || (((gs - 1) % 4) + 1),
    ((gs - 1) % 4) + 1,
    'cont_m' || lpad(gs::text, 2, '0'),
    's' || lpad((((gs - 1) / 4) + 1)::text, 2, '0')
FROM generate_series(1, 20) AS gs;

INSERT INTO peliculas_artistas (id, rol, nombre_personaje, fk_pelicula, fk_artista)
SELECT
    'pa' || lpad(gs::text, 2, '0') || 'a',
    'Actor',
    'Personaje ' || lpad(gs::text, 2, '0'),
    'pel' || lpad(gs::text, 2, '0'),
    'a' || lpad((((gs - 1) % 6) + 1)::text, 2, '0')
FROM generate_series(1, 20) AS gs
UNION ALL
SELECT
    'pa' || lpad(gs::text, 2, '0') || 'd',
    'Director',
    NULL,
    'pel' || lpad(gs::text, 2, '0'),
    'a' || lpad((((gs - 1) % 5) + 7)::text, 2, '0')
FROM generate_series(1, 20) AS gs;

INSERT INTO series (id, estudio, fk_contenido, fk_saga)
SELECT
    'ser' || lpad(gs::text, 2, '0'),
    'Studio Serie ' || lpad(gs::text, 2, '0'),
    'cont_s' || lpad(gs::text, 2, '0'),
    's' || lpad(gs::text, 2, '0')
FROM generate_series(1, 5) AS gs;

INSERT INTO series_artistas (id, rol, fk_serie, fk_artista)
SELECT
    'sa' || lpad(gs::text, 2, '0') || 'a',
    'Actor',
    'ser' || lpad(gs::text, 2, '0'),
    'a' || lpad((((gs - 1) % 6) + 1)::text, 2, '0')
FROM generate_series(1, 5) AS gs
UNION ALL
SELECT
    'sa' || lpad(gs::text, 2, '0') || 'd',
    'Director',
    'ser' || lpad(gs::text, 2, '0'),
    'a' || lpad((((gs - 1) % 5) + 7)::text, 2, '0')
FROM generate_series(1, 5) AS gs;

INSERT INTO temporadas (id, numero_temporada, anio, fk_serie)
SELECT
    'tem' || lpad(gs::text, 2, '0'),
    1,
    2020 + gs,
    'ser' || lpad(gs::text, 2, '0')
FROM generate_series(1, 5) AS gs;

WITH episodios_generados AS (
    SELECT
        gs,
        ((gs - 1) / 5) + 1 AS serie_num,
        ((gs - 1) % 5) + 1 AS episodio_num
    FROM generate_series(1, 25) AS gs
)
INSERT INTO episodios (id, numero_episodio, titulo, duracion, fk_temporada, fk_contenido)
SELECT
    'epi' || lpad(gs::text, 2, '0'),
    episodio_num,
    'Serie ' || lpad(serie_num::text, 2, '0') || ' Episodio ' || lpad(episodio_num::text, 2, '0'),
    42 + episodio_num,
    'tem' || lpad(serie_num::text, 2, '0'),
    'cont_e' || lpad(gs::text, 2, '0')
FROM episodios_generados;

-- =========================
-- MUSICA
-- =========================
INSERT INTO canciones (id, lirica, compositores, fk_contenido)
SELECT
    'can' || lpad(gs::text, 2, '0'),
    'Letra de la cancion ' || lpad(gs::text, 2, '0'),
    'Compositor ' || lpad(gs::text, 2, '0'),
    'cont_c' || lpad(gs::text, 2, '0')
FROM generate_series(1, 20) AS gs;

INSERT INTO videos_musicales (id, fk_contenido, fk_cancion)
SELECT
    'vm' || lpad(gs::text, 2, '0'),
    'cont_vm' || lpad(gs::text, 2, '0'),
    'can' || lpad(gs::text, 2, '0')
FROM generate_series(1, 20) AS gs;

INSERT INTO canciones_artistas (id, rol, fk_cancion, fk_artista)
SELECT
    'caa' || lpad(gs::text, 2, '0'),
    'Intérprete',
    'can' || lpad(gs::text, 2, '0'),
    'a' || lpad((((gs - 1) % 5) + 16)::text, 2, '0')
FROM generate_series(1, 20) AS gs;

-- =========================
-- ACTIVIDAD
-- =========================
INSERT INTO reproducciones (id, fecha_inicio, estado_actual, cantidad_veces, fk_cliente, fk_contenido)
SELECT
    'r' || lpad(gs::text, 2, '0'),
    TIMESTAMP '2025-01-01 10:00:00' + ((gs - 1) * INTERVAL '2 hours'),
    CASE (gs - 1) % 3
        WHEN 0 THEN 'completado'
        WHEN 1 THEN 'en_progreso'
        ELSE 'pausado'
    END,
    1 + ((gs - 1) % 4),
    'c' || lpad(gs::text, 2, '0'),
    CASE (gs - 1) % 5
        WHEN 0 THEN 'cont_m' || lpad(gs::text, 2, '0')
        WHEN 1 THEN 'cont_s' || lpad((((gs - 1) % 5) + 1)::text, 2, '0')
        WHEN 2 THEN 'cont_c' || lpad(gs::text, 2, '0')
        WHEN 3 THEN 'cont_vm' || lpad(gs::text, 2, '0')
        ELSE 'cont_e' || lpad(gs::text, 2, '0')
    END
FROM generate_series(1, 20) AS gs;

INSERT INTO descargas (id, fecha_inicio, estado_actual, cantidad_veces, fk_cliente, fk_contenido, fk_formato)
SELECT
    'd' || lpad(gs::text, 2, '0'),
    TIMESTAMP '2025-02-01 11:00:00' + ((gs - 1) * INTERVAL '3 hours'),
    CASE (gs - 1) % 3
        WHEN 0 THEN 'completado'
        WHEN 1 THEN 'pendiente'
        ELSE 'fallido'
    END,
    1 + ((gs - 1) % 3),
    'c' || lpad(gs::text, 2, '0'),
    CASE (gs - 1) % 5
        WHEN 0 THEN 'cont_m' || lpad(gs::text, 2, '0')
        WHEN 1 THEN 'cont_s' || lpad((((gs - 1) % 5) + 1)::text, 2, '0')
        WHEN 2 THEN 'cont_c' || lpad(gs::text, 2, '0')
        WHEN 3 THEN 'cont_vm' || lpad(gs::text, 2, '0')
        ELSE 'cont_e' || lpad(gs::text, 2, '0')
    END,
    CASE (gs - 1) % 3
        WHEN 0 THEN 'f1'
        WHEN 1 THEN 'f2'
        ELSE 'f3'
    END
FROM generate_series(1, 20) AS gs;

INSERT INTO preferencias (id, fecha_agregado, fk_cliente, fk_contenido)
SELECT
    'pr' || lpad(gs::text, 2, '0'),
    DATE '2025-03-01' + ((gs - 1) * 2),
    'c' || lpad(gs::text, 2, '0'),
    CASE (gs - 1) % 4
        WHEN 0 THEN 'cont_m' || lpad(gs::text, 2, '0')
        WHEN 1 THEN 'cont_s' || lpad((((gs - 1) % 5) + 1)::text, 2, '0')
        WHEN 2 THEN 'cont_c' || lpad(gs::text, 2, '0')
        ELSE 'cont_vm' || lpad(gs::text, 2, '0')
    END
FROM generate_series(1, 20) AS gs;