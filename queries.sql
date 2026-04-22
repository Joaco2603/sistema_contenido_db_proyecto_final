-- 1. Películas | Series por: género, año, actor, director, categoría
-- Ejemplo para una Película específica (Buscando Acción, del año 2023, con actor "Tom Cruise")
SELECT c.titulo, c.anio, g.nombre AS genero, cat.nombre AS categoria, pa.rol, p_art.nombre, p_art.apellido
FROM contenidos c
JOIN peliculas p ON c.id = p.fk_contenido
JOIN peliculas_artistas pa ON p.id = pa.fk_pelicula
JOIN artistas a ON pa.fk_artista = a.id
JOIN personas p_art ON a.fk_persona = p_art.id
JOIN generos_contenido g ON c.fk_genero = g.id
JOIN categorias cat ON c.fk_categoria = cat.id
WHERE c.tipo = 'pelicula'
  AND g.nombre = 'Acción'
  AND c.anio = 2023
  AND pa.rol IN ('Actor', 'Director');

-- 2. Sagas por: género, autor (director/productor), año
SELECT s.nombre AS saga, s.anio_inicio, g.nombre AS genero, cat.nombre AS categoria
FROM sagas s
JOIN generos_contenido g ON s.fk_genero = g.id
JOIN categorias cat ON s.fk_categoria = cat.id
WHERE g.nombre = 'Ciencia Ficción' AND s.anio_inicio >= 2000;

-- 3. Canciones por artista, estilo, año
SELECT c_info.titulo, c_info.anio, p_art.nombre AS artista, e.nombre AS estilo
FROM canciones c
JOIN contenidos c_info ON c.fk_contenido = c_info.id
JOIN canciones_artistas ca ON c.id = ca.fk_cancion
JOIN artistas a ON ca.fk_artista = a.id
JOIN personas p_art ON a.fk_persona = p_art.id
JOIN artista_categoria a_cat ON a.id = a_cat.fk_artista
JOIN estilos e ON a_cat.fk_estilo = e.id
WHERE p_art.nombre = 'Michael' 
  AND e.nombre = 'Pop';

-- 4. Descargas realizadas por un cliente (Con detalle del formato utilizado)
SELECT p.nombre AS cliente, c.titulo AS contenido_descargado, f.nombre AS formato, d.fecha_inicio, d.estado_actual
FROM descargas d
JOIN clientes cli ON d.fk_cliente = cli.id
JOIN personas p ON cli.fk_persona = p.id
JOIN contenidos c ON d.fk_contenido = c.id
JOIN formatos f ON d.fk_formato = f.id
WHERE cli.id = 'CLI-001';

-- 5. Lista de videos (películas/episodios/musicales) más descargados
SELECT c.titulo, c.tipo, SUM(d.cantidad_veces) AS total_descargas
FROM descargas d
JOIN contenidos c ON d.fk_contenido = c.id
GROUP BY c.id, c.titulo, c.tipo
ORDER BY total_descargas DESC
LIMIT 10;

-- 6. Lista de contenidos más vistos (reproducidos) por los clientes
SELECT c.titulo, c.tipo, SUM(r.cantidad_veces) AS total_reproducciones
FROM reproducciones r
JOIN contenidos c ON r.fk_contenido = c.id
GROUP BY c.id, c.titulo, c.tipo
ORDER BY total_reproducciones DESC
LIMIT 10;