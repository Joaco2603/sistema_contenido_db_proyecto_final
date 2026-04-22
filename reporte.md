# Diseno de Base de Datos para Streaming de Peliculas y Series

## Introduccion
TvZ.net es una plataforma de streaming que ofrece peliculas, series, videos musicales y canciones descargables. El sistema debe soportar consultas por contenido, artista, genero, categoria, ano y actividad de uso como reproducciones, descargas y favoritos.

## Objetivo
Disenar una base de datos que permita administrar clientes con membresias, artistas con sus roles, contenidos multimedia en distintos formatos y consultas predefinidas para probar el funcionamiento del sistema.

## Diseno del modelo Entidad-Relacion (MER)
El modelo considera estas entidades principales:

- Paises, estilos, generos, categorias y formatos como catalogos.
- Personas como base para clientes y artistas.
- Clientes, formas de pago y membresias.
- Artistas, categorias de artista y su relacion con estilos.
- Contenidos base para peliculas, series, canciones, episodios y videos musicales.
- Sagas vinculadas a genero, categoria y autor.
- Reproducciones, descargas y preferencias como actividad del cliente.

## Diseno fisico de la Base de datos (DBD)
El diseno fisico esta implementado en [init.sql](init.sql), con claves primarias, foraneas, restricciones UNIQUE y CHECK para asegurar consistencia.

La carga de datos de prueba esta en [inserts.sql](inserts.sql) e incluye:

- 20 clientes.
- 20 peliculas.
- 5 series con 5 episodios cada una.
- 20 videos musicales.
- Catalogos y relaciones necesarias para probar consultas.

## Consultas predefinidas
Las consultas solicitadas estan en [queries.sql](queries.sql):

- Peliculas y series por genero, ano, actor/director y categoria.
- Sagas por genero, autor y ano.
- Canciones por artista, estilo y ano.
- Descargas realizadas por un cliente.
- Videos mas descargados.
- Contenidos mas vistos.

## Conclusiones
El modelo permite almacenar contenidos heterogeneos con una estructura normalizada y flexible. La separacion entre contenido base y tablas especializadas facilita el mantenimiento, la carga de datos y la ejecucion de consultas de negocio.

## Anexos
- [init.sql](init.sql)
- [inserts.sql](inserts.sql)
- [queries.sql](queries.sql)
