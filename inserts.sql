-- =========================
-- PAISES
-- =========================
INSERT INTO paises VALUES
('cr', 'Costa Rica', 'CRI'),
('us', 'Estados Unidos', 'USA'),
('mx', 'México', 'MEX'),
('es', 'España', 'ESP');

-- =========================
-- ESTILOS
-- =========================
INSERT INTO estilos VALUES
('est1', 'Rock', 'musica'),
('est2', 'Pop', 'musica'),
('est3', 'Drama', 'actuacion'),
('est4', 'Accion', 'actuacion');

-- =========================
-- GENEROS CONTENIDO
-- =========================
INSERT INTO generos_contenido VALUES
('gen1', 'Accion', 'pelicula'),
('gen2', 'Drama', 'serie'),
('gen3', 'Pop', 'musica'),
('gen4', 'General', 'general');

-- =========================
-- CATEGORIAS
-- =========================
INSERT INTO categorias VALUES
('cat1', 'Accion'),
('cat2', 'Drama'),
('cat3', 'Comedia'),
('cat4', 'Documental');

-- =========================
-- FORMATOS
-- =========================
INSERT INTO formatos VALUES
('f1', 'mp4', 'movil'),
('f2', 'hd', 'smart_tv'),
('f3', 'tvz', 'pc');

-- =========================
-- PERSONAS
-- =========================
INSERT INTO personas VALUES
('p1', 'Juan', 'Perez', true, '1990-05-10', '88888888', 'juan@test.com', 'cr'),
('p2', 'Maria', 'Lopez', false, '1985-08-20', '87777777', 'maria@test.com', 'mx'),
('p3', 'Carlos', 'Smith', true, '1992-01-15', '86666666', 'carlos@test.com', 'us');

-- =========================
-- CLIENTES
-- =========================
INSERT INTO clientes VALUES
('c1', 'pass123', 'San Jose', 'Ingeniero', '2024-01-01', 'p1'),
('c2', 'pass456', 'CDMX', 'Diseñadora', '2024-02-01', 'p2');

-- =========================
-- TIPOS PAGO
-- =========================
INSERT INTO tipos_pago VALUES
('tp1', 'Tarjeta Crédito'),
('tp2', 'Bitcoin');

-- =========================
-- FORMAS DE PAGO
-- =========================
INSERT INTO formas_de_pago VALUES
('fp1', '12345678', 'Juan Perez', '2027-12-01', NULL, 'tp1', 'c1'),
('fp2', NULL, 'Maria Lopez', NULL, 'wallet123', 'tp2', 'c2');

-- =========================
-- MEMBRESIAS
-- =========================
INSERT INTO membresias VALUES
('m1', '2024-01-01', '2024-12-31', 120.00, 'activa', 'c1', 'fp1'),
('m2', '2024-02-01', '2024-08-01', 80.00, 'vencida', 'c2', 'fp2');

-- =========================
-- CATEGORIA ARTISTA
-- =========================
INSERT INTO categoria_artista VALUES
('ca1', 'Actor'),
('ca2', 'Director'),
('ca3', 'Musico');

-- =========================
-- ARTISTAS
-- =========================
INSERT INTO artistas VALUES
('a1', 'Actor famoso', 'p2'),
('a2', 'Director reconocido', 'p3');

-- =========================
-- ARTISTA CATEGORIA
-- =========================
INSERT INTO artista_categoria VALUES
('ac1', 'a1', 'ca1', 'est3'),
('ac2', 'a2', 'ca2', NULL);

-- =========================
-- CONTENIDOS
-- =========================
INSERT INTO contenidos VALUES
('cont1', 'Pelicula Accion 1', 2023, 120, 'PG-13', 'url1', 'pelicula', 'us', 'gen1', 'cat1'),
('cont2', 'Serie Drama 1', 2022, 45, 'PG', 'url2', 'serie', 'mx', 'gen2', 'cat2'),
('cont3', 'Cancion Pop 1', 2024, 3, 'G', 'url3', 'cancion', 'us', 'gen3', 'cat3');

-- =========================
-- SAGAS
-- =========================
INSERT INTO sagas VALUES
('s1', 'Saga Accion', 'Explosiones', 2020, 'gen1', 'cat1');

-- =========================
-- PELICULAS
-- =========================
INSERT INTO peliculas VALUES
('pel1', 'Marvel', 1, 'cont1', 's1');

-- =========================
-- PELICULAS ARTISTAS
-- =========================
INSERT INTO peliculas_artistas VALUES
('pa1', 'Actor', 'Heroe', 'pel1', 'a1'),
('pa2', 'Director', NULL, 'pel1', 'a2');

-- =========================
-- SERIES
-- =========================
INSERT INTO series VALUES
('ser1', 'Netflix', 'cont2', NULL);

-- =========================
-- SERIES ARTISTAS
-- =========================
INSERT INTO series_artistas VALUES
('sa1', 'Actor', 'ser1', 'a1');

-- =========================
-- TEMPORADAS
-- =========================
INSERT INTO temporadas VALUES
('t1', 1, 2022, 'ser1');

-- =========================
-- EPISODIOS
-- =========================
INSERT INTO episodios VALUES
('e1', 1, 'Episodio 1', 45, 't1', 'cont2');

-- =========================
-- CANCIONES
-- =========================
INSERT INTO canciones VALUES
('can1', 'Letra...', 'Autor X', 'cont3');

-- =========================
-- VIDEOS MUSICALES
-- =========================
INSERT INTO videos_musicales VALUES
('vm1', 'cont3', 'can1');

-- =========================
-- CANCIONES ARTISTAS
-- =========================
INSERT INTO canciones_artistas VALUES
('caa1', 'Interprete', 'can1', 'a1');

-- =========================
-- REPRODUCCIONES
-- =========================
INSERT INTO reproducciones VALUES
('r1', '2025-01-01 10:00:00', 'completado', 1, 'c1', 'cont1');

-- =========================
-- DESCARGAS
-- =========================
INSERT INTO descargas VALUES
('d1', '2025-01-01 11:00:00', 'completado', 1, 'c1', 'cont1', 'f1');

-- =========================
-- PREFERENCIAS
-- =========================
INSERT INTO preferencias VALUES
('pr1', '2025-01-02', 'c1', 'cont1');