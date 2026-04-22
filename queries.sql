-- 1. Peliculas y series por genero, ano, actor/director y categoria
SELECT
    'pelicula' AS tipo,
    c.titulo,
    c.anio,
    g.nombre AS genero,
    cat.nombre AS categoria,
    pa.rol,
    p_art.nombre,
    p_art.apellido
FROM contenidos c
JOIN peliculas p ON c.id = p.fk_contenido
JOIN peliculas_artistas pa ON p.id = pa.fk_pelicula
JOIN artistas a ON pa.fk_artista = a.id
JOIN personas p_art ON a.fk_persona = p_art.id
JOIN generos_contenido g ON c.fk_genero = g.id
JOIN categorias cat ON c.fk_categoria = cat.id
WHERE c.tipo = 'pelicula'
  AND g.nombre = 'Accion'
  AND c.anio = 2023
  AND pa.rol IN ('Actor', 'Director')
UNION ALL
SELECT
    'serie' AS tipo,
    c.titulo,
    c.anio,
    g.nombre AS genero,
    cat.nombre AS categoria,
    sa.rol,
    p_art.nombre,
    p_art.apellido
FROM contenidos c
JOIN series s ON c.id = s.fk_contenido
JOIN series_artistas sa ON s.id = sa.fk_serie
JOIN artistas a ON sa.fk_artista = a.id
JOIN personas p_art ON a.fk_persona = p_art.id
JOIN generos_contenido g ON c.fk_genero = g.id
JOIN categorias cat ON c.fk_categoria = cat.id
WHERE c.tipo = 'serie'
  AND g.nombre = 'Drama'
  AND c.anio = 2023
  AND sa.rol IN ('Actor', 'Director')
ORDER BY tipo, titulo;

-- 2. Sagas por genero, autor y ano
SELECT
    s.nombre AS saga,
    s.anio_inicio,
    g.nombre AS genero,
    cat.nombre AS categoria,
    p.nombre AS autor,
    p.apellido AS autor_apellido
FROM sagas s
JOIN artistas a ON s.fk_artista = a.id
JOIN personas p ON a.fk_persona = p.id
JOIN generos_contenido g ON s.fk_genero = g.id
JOIN categorias cat ON s.fk_categoria = cat.id
WHERE g.nombre = 'Accion'
  AND s.anio_inicio >= 2018
  AND p.nombre = 'Artista32';

-- 3. Canciones por artista, estilo y ano
SELECT
    c_info.titulo,
    c_info.anio,
    p_art.nombre AS artista,
    e.nombre AS estilo
FROM canciones c
JOIN contenidos c_info ON c.fk_contenido = c_info.id
JOIN canciones_artistas ca ON c.id = ca.fk_cancion
JOIN artistas a ON ca.fk_artista = a.id
JOIN personas p_art ON a.fk_persona = p_art.id
JOIN artista_categoria a_cat ON a.id = a_cat.fk_artista
JOIN estilos e ON a_cat.fk_estilo = e.id
WHERE p_art.nombre = 'Artista37'
  AND e.nombre = 'Pop'
  AND c_info.anio = 2023;

-- 4. Descargas realizadas por un cliente con detalle del formato
SELECT
    p.nombre AS cliente,
    c.titulo AS contenido_descargado,
    f.nombre AS formato,
    d.fecha_inicio,
    d.estado_actual
FROM descargas d
JOIN clientes cli ON d.fk_cliente = cli.id
JOIN personas p ON cli.fk_persona = p.id
JOIN contenidos c ON d.fk_contenido = c.id
JOIN formatos f ON d.fk_formato = f.id
WHERE cli.id = 'c01';

-- 5. Lista de videos (peliculas, episodios y musicales) mas descargados
SELECT
    c.titulo,
    c.tipo,
    SUM(d.cantidad_veces) AS total_descargas
FROM descargas d
JOIN contenidos c ON d.fk_contenido = c.id
GROUP BY c.id, c.titulo, c.tipo
ORDER BY total_descargas DESC
LIMIT 10;

-- 6. Lista de contenidos mas vistos por los clientes
SELECT
    c.titulo,
    c.tipo,
    SUM(r.cantidad_veces) AS total_reproducciones
FROM reproducciones r
JOIN contenidos c ON r.fk_contenido = c.id
GROUP BY c.id, c.titulo, c.tipo
ORDER BY total_reproducciones DESC
LIMIT 10;