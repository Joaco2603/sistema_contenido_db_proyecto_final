# Diseno de Base de Datos para Streaming de Peliculas y Series

## Introduccion
TvZ.net es una plataforma de streaming que ofrece peliculas, series, videos musicales y canciones descargables. El sistema soporta consultas por contenido, artista, genero, categoria, ano y actividad de uso como reproducciones, descargas y favoritos.

## Objetivo
Disenar una base de datos relacional para administrar:

- Clientes con membresias y formas de pago.
- Artistas y sus roles dentro del contenido.
- Contenidos multimedia (peliculas, series, episodios, canciones y videos musicales).
- Consultas de negocio para validacion del modelo.

## Modelo de Datos
El modelo considera estas entidades principales:

- Catalogos: paises, estilos, generos, categorias y formatos.
- Personas: base comun para clientes y artistas.
- Clientes: formas de pago y membresias.
- Artistas: categorias y estilos asociados.
- Contenidos: entidad base para especializaciones.
- Sagas: agrupacion de contenido por genero/categoria/autor.
- Actividad: reproducciones, descargas y preferencias.

## Estructura del Proyecto
- [init.sql](init.sql): creacion de tablas, PK, FK, UNIQUE y CHECK.
- [inserts.sql](inserts.sql): version original de carga de datos (no Oracle-compatible en su estado actual).
- [inserts_oracle.sql](inserts_oracle.sql): carga de datos compatible con Oracle para pruebas.
- [queries.sql](queries.sql): consultas solicitadas (ajustadas para Oracle con FETCH FIRST).
- [docker-compose.yml](docker-compose.yml): definicion del contenedor Oracle XE.

## Ejecucion en Oracle (Docker)
1. Verificar contenedor:

```bash
docker ps
```

2. Conectarse a SQL*Plus:

```bash
docker exec -it oracle-xe112 /opt/oracle/product/21c/dbhomeXE/bin/sqlplus system/oracle@//localhost:1521/XEPDB1
```

3. Usar el esquema del proyecto:

```sql
ALTER SESSION SET CURRENT_SCHEMA = JOACO;
```

4. Ejecutar scripts (si ya estan copiados en /tmp):

```sql
@/tmp/init.sql
@/tmp/inserts_oracle.sql
@/tmp/queries.sql
```

5. Si aun no estan en el contenedor, copiarlos desde host:

```bash
docker cp .\\init.sql oracle-xe112:/tmp/init.sql
docker cp .\\inserts_oracle.sql oracle-xe112:/tmp/inserts_oracle.sql
docker cp .\\queries.sql oracle-xe112:/tmp/queries.sql
```

## Estado de la Tarea
Estado actual: completada para Oracle.

- Esquema creado correctamente desde [init.sql](init.sql).
- Datos de prueba cargados correctamente desde [inserts_oracle.sql](inserts_oracle.sql).
- Consultas ejecutadas en [queries.sql](queries.sql) con resultados.

## Observaciones
- En Oracle no existe el tipo TEXT; se reemplazo por CLOB en [init.sql](init.sql).
- En Oracle no se usa LIMIT; se reemplazo por FETCH FIRST en [queries.sql](queries.sql).

## Anexos
- [dbml.txt](dbml.txt)
- [init.sql](init.sql)
- [inserts.sql](inserts.sql)
- [inserts_oracle.sql](inserts_oracle.sql)
- [queries.sql](queries.sql)
