-- 1. Consulta sql en la que se trae un listado de las actividades con el tiempo planeado
-- para la ejecución.
SELECT A.ID_ACTIVIDAD, A.NOMBRE NOM_ACTIVIDAD, A.DURACION_DIAS TIEMPO_PLANEADO
FROM ACTIVIDADES A;

-- 2. Consulta sql en la que se trae un listado de los responsables con las actividades
-- asignadas.
SELECT CONCAT(CONCAT(I.NOMBRE," "), I.APELLIDO) NOM_INTEGRANTE, A.ID_ACTIVIDAD, A.NOMBRE NOM_ACTIVIDAD
FROM ACTIVIDADES A, INTEGRANTES I, INTEGRANTES_ACTIVIDADES IA
WHERE I.ID_INTEGRANTE = IA.ID_INTEGRANTE
AND IA.ID_ACTIVIDAD = A.ID_ACTIVIDAD;

-- 3. Consulta sql en la que se trae un listado de las actividades que presentaron
-- inconvenientes de tipo bajo.
SELECT A.ID_ACTIVIDAD, A.NOMBRE NOM_ACTIVIDAD, I.ID_INCONVENIENTE,
I.DESCRIPCION DESC_INCONVENIENTE, C.DESCRIPCION DESC_CATEGORIA
FROM ACTIVIDADES A, INCONVENIENTES I, CATEGORIAS_INCONVENIENTES C
WHERE A.ID_ACTIVIDAD = I.ID_ACTIVIDAD
AND C.ID_CATEGORIA = I.ID_CATEGORIA
AND UPPER(C.DESCRIPCION) LIKE '%BAJO%';

-- 4. Consulta sql en la que se trae un listado de las actividades que presentaron
-- inconvenientes de tipo medio con el tiempo planeado para la ejecución de las
-- actividades.
SELECT A.ID_ACTIVIDAD, A.NOMBRE NOM_ACTIVIDAD, A.DURACION_DIAS TIEMPO_PLANEADO,
I.ID_INCONVENIENTE, I.DESCRIPCION DESC_INCONVENIENTE, C.DESCRIPCION DESC_CATEGORIA
FROM ACTIVIDADES A, INCONVENIENTES I, CATEGORIAS_INCONVENIENTES C
WHERE A.ID_ACTIVIDAD = I.ID_ACTIVIDAD
AND C.ID_CATEGORIA = I.ID_CATEGORIA
AND UPPER(C.DESCRIPCION) LIKE '%MEDIO%';

-- 5. Consulta sql en la que se trae un listado de las actividades que presentaron
-- inconvenientes de tipo fuerte con los responsables de cada actividad.
SELECT A.ID_ACTIVIDAD, A.NOMBRE NOM_ACTIVIDAD, CONCAT(CONCAT(I.NOMBRE," "), I.APELLIDO) NOM_INTEGRANTE,
INC.ID_INCONVENIENTE, INC.DESCRIPCION DESC_INCONVENIENTE, C.DESCRIPCION DESC_CATEGORIA
FROM ACTIVIDADES A, INCONVENIENTES INC, CATEGORIAS_INCONVENIENTES C, INTEGRANTES I, INTEGRANTES_ACTIVIDADES IA
WHERE I.ID_INTEGRANTE = IA.ID_INTEGRANTE
AND IA.ID_ACTIVIDAD = A.ID_ACTIVIDAD
AND A.ID_ACTIVIDAD = INC.ID_ACTIVIDAD
AND C.ID_CATEGORIA = INC.ID_CATEGORIA
AND UPPER(C.DESCRIPCION) LIKE '%FUERTE%';

-- 6. Consulta sql en la que se trae un listado de las actividades que presentaron
-- inconvenientes de cualquier tipo con el calculo del total de tiempo empleado para la
-- actividad
SELECT A.ID_ACTIVIDAD, A.NOMBRE NOM_ACTIVIDAD, A.DURACION_DIAS TIEMPO_PLANEADO,
A.DURACION_DIAS + R.TOT_RETRASO TIEMPO_REAL
FROM ACTIVIDADES A, (SELECT A.ID_ACTIVIDAD, SUM(C.RETRASO_DIAS) TOT_RETRASO
FROM ACTIVIDADES A, INCONVENIENTES I, CATEGORIAS_INCONVENIENTES C
WHERE A.ID_ACTIVIDAD = I.ID_ACTIVIDAD
AND C.ID_CATEGORIA = I.ID_CATEGORIA
GROUP BY A.ID_ACTIVIDAD) R
WHERE A.ID_ACTIVIDAD = R.ID_ACTIVIDAD;

-- 7. Consulta sql en la que se trae un listado de las actividades que presentaron
-- inconvenientes de tipo bajo con los responsables y con el calculo del total de tiempo
-- empleado para las actividades
SELECT A.ID_ACTIVIDAD, CONCAT(CONCAT(I.NOMBRE," "), I.APELLIDO) NOM_INTEGRANTE, INC.ID_INCONVENIENTE,
 C.DESCRIPCION DESC_CATEGORIA,A.DURACION_DIAS + R.TOT_RETRASO TIEMPO_REAL
FROM ACTIVIDADES A, INCONVENIENTES INC, CATEGORIAS_INCONVENIENTES C, INTEGRANTES I, INTEGRANTES_ACTIVIDADES IA, 
(SELECT A.ID_ACTIVIDAD, SUM(C.RETRASO_DIAS) TOT_RETRASO
FROM ACTIVIDADES A, INCONVENIENTES I, CATEGORIAS_INCONVENIENTES C
WHERE A.ID_ACTIVIDAD = I.ID_ACTIVIDAD
AND C.ID_CATEGORIA = I.ID_CATEGORIA
GROUP BY A.ID_ACTIVIDAD) R
WHERE I.ID_INTEGRANTE = IA.ID_INTEGRANTE
AND IA.ID_ACTIVIDAD = A.ID_ACTIVIDAD
AND A.ID_ACTIVIDAD = INC.ID_ACTIVIDAD
AND C.ID_CATEGORIA = INC.ID_CATEGORIA
AND A.ID_ACTIVIDAD = R.ID_ACTIVIDAD
AND UPPER(C.DESCRIPCION) LIKE '%BAJO%';

-- 8. Consulta sql en la que se trae un listado de los responsables con las actividades
-- asignadas que presentaron inconvenientes de tipo medio
SELECT A.ID_ACTIVIDAD, A.NOMBRE NOM_ACTIVIDAD, CONCAT(CONCAT(I.NOMBRE," "), I.APELLIDO) NOM_INTEGRANTE,
INC.ID_INCONVENIENTE, INC.DESCRIPCION DESC_INCONVENIENTE, C.DESCRIPCION DESC_CATEGORIA
FROM ACTIVIDADES A, INCONVENIENTES INC, CATEGORIAS_INCONVENIENTES C, INTEGRANTES I, INTEGRANTES_ACTIVIDADES IA
WHERE I.ID_INTEGRANTE = IA.ID_INTEGRANTE
AND IA.ID_ACTIVIDAD = A.ID_ACTIVIDAD
AND A.ID_ACTIVIDAD = INC.ID_ACTIVIDAD
AND C.ID_CATEGORIA = INC.ID_CATEGORIA
AND UPPER(C.DESCRIPCION) LIKE '%MEDIO%';

-- 9. Consulta sql en la que se trae un listado de los responsables con las actividades
-- asignadas que presentaron inconvenientes de tipo fuerte y con el tiempo planeado
-- para la ejecución de las actividades.
SELECT A.ID_ACTIVIDAD, A.NOMBRE NOM_ACTIVIDAD, CONCAT(CONCAT(I.NOMBRE," "), I.APELLIDO) NOM_INTEGRANTE,
INC.ID_INCONVENIENTE, C.DESCRIPCION DESC_CATEGORIA, A.DURACION_DIAS TIEMPO_PLANEADO
FROM ACTIVIDADES A, INCONVENIENTES INC, CATEGORIAS_INCONVENIENTES C, INTEGRANTES I, INTEGRANTES_ACTIVIDADES IA
WHERE I.ID_INTEGRANTE = IA.ID_INTEGRANTE
AND IA.ID_ACTIVIDAD = A.ID_ACTIVIDAD
AND A.ID_ACTIVIDAD = INC.ID_ACTIVIDAD
AND C.ID_CATEGORIA = INC.ID_CATEGORIA
AND UPPER(C.DESCRIPCION) LIKE '%FUERTE%';

-- 10. Consulta sql en la que se trae un listado de los responsables con las actividades
-- asignadas que presentaron inconvenientes de tipo bajo o fuerte, con el calculo del
-- total de tiempo empleado para las actividades
SELECT A.ID_ACTIVIDAD, CONCAT(CONCAT(I.NOMBRE," "), I.APELLIDO) NOM_INTEGRANTE, INC.ID_INCONVENIENTE,
 C.DESCRIPCION DESC_CATEGORIA,A.DURACION_DIAS + R.TOT_RETRASO TIEMPO_REAL
FROM ACTIVIDADES A, INCONVENIENTES INC, CATEGORIAS_INCONVENIENTES C, INTEGRANTES I, INTEGRANTES_ACTIVIDADES IA, 
(SELECT A.ID_ACTIVIDAD, SUM(C.RETRASO_DIAS) TOT_RETRASO
FROM ACTIVIDADES A, INCONVENIENTES I, CATEGORIAS_INCONVENIENTES C
WHERE A.ID_ACTIVIDAD = I.ID_ACTIVIDAD
AND C.ID_CATEGORIA = I.ID_CATEGORIA
GROUP BY A.ID_ACTIVIDAD) R
WHERE I.ID_INTEGRANTE = IA.ID_INTEGRANTE
AND IA.ID_ACTIVIDAD = A.ID_ACTIVIDAD
AND A.ID_ACTIVIDAD = INC.ID_ACTIVIDAD
AND C.ID_CATEGORIA = INC.ID_CATEGORIA
AND A.ID_ACTIVIDAD = R.ID_ACTIVIDAD
AND (UPPER(C.DESCRIPCION) LIKE '%BAJO%'
OR UPPER(C.DESCRIPCION) LIKE '%FUERTE%');