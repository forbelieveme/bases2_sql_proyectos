DROP DATABASE IF EXISTS GESTION_PROYECTOS;

CREATE DATABASE IF NOT EXISTS GESTION_PROYECTOS;

USE GESTION_PROYECTOS;

CREATE TABLE IF NOT EXISTS PROYECTOS (
    ID_PROYECTO VARCHAR(255) NOT NULL,
    NOMBRE VARCHAR(255) NOT NULL,
    PRIMARY KEY (ID_PROYECTO)
);

CREATE TABLE IF NOT EXISTS EQUIPOS (
    ID_EQUIPO VARCHAR(255) NOT NULL,
    NOMBRE VARCHAR(255) NOT NULL,
    PRIMARY KEY (ID_EQUIPO)
);

CREATE TABLE IF NOT EXISTS PROYECTOS_EQUIPOS (
    ID_PROYECTOS_EQUIPOS INT NOT NULL AUTO_INCREMENT,
    ID_PROYECTO VARCHAR(255) NOT NULL,
    ID_EQUIPO VARCHAR(255) NOT NULL,
    PRIMARY KEY (ID_PROYECTOS_EQUIPOS),
    FOREIGN KEY (ID_PROYECTO) REFERENCES PROYECTOS(ID_PROYECTO),
    FOREIGN KEY (ID_EQUIPO) REFERENCES EQUIPOS(ID_EQUIPO)
);

CREATE TABLE IF NOT EXISTS INTEGRANTES (
    ID_INTEGRANTE VARCHAR(255) NOT NULL,
    NOMBRE VARCHAR(255) NOT NULL,
    APELLIDO VARCHAR(255) NOT NULL,
    ROL VARCHAR(255) NOT NULL,
    ID_MANAGER VARCHAR(255),
    PRIMARY KEY (ID_INTEGRANTE),
    FOREIGN KEY (ID_MANAGER) REFERENCES INTEGRANTES(ID_INTEGRANTE)
);

CREATE TABLE IF NOT EXISTS EQUIPOS_INTEGRANTES (
    ID_EQUIPOS_INTEGRANTES INT NOT NULL AUTO_INCREMENT,
    ID_EQUIPO VARCHAR(255) NOT NULL,
    ID_INTEGRANTE VARCHAR(255) NOT NULL,
    PRIMARY KEY (ID_EQUIPOS_INTEGRANTES),
    FOREIGN KEY (ID_EQUIPO) REFERENCES EQUIPOS(ID_EQUIPO),
    FOREIGN KEY (ID_INTEGRANTE) REFERENCES INTEGRANTES(ID_INTEGRANTE)
);

CREATE TABLE IF NOT EXISTS ACTIVIDADES (
    ID_ACTIVIDAD VARCHAR(255) NOT NULL,
    NOMBRE VARCHAR(255) NOT NULL,
    DURACION_DIAS INT NOT NULL,
    FECHA_CREACION TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (ID_ACTIVIDAD)
);

CREATE TABLE IF NOT EXISTS INTEGRANTES_ACTIVIDADES (
    ID_INTEGRANTES_ACTIVIDADES INT NOT NULL AUTO_INCREMENT,
    ID_INTEGRANTE VARCHAR(255) NOT NULL,
    ID_ACTIVIDAD VARCHAR(255) NOT NULL,
    PRIMARY KEY (ID_INTEGRANTES_ACTIVIDADES),
    FOREIGN KEY (ID_INTEGRANTE) REFERENCES INTEGRANTES(ID_INTEGRANTE),
    FOREIGN KEY (ID_ACTIVIDAD) REFERENCES ACTIVIDADES(ID_ACTIVIDAD)
);

CREATE TABLE IF NOT EXISTS ACTAS (
    ID_ACTA INT NOT NULL AUTO_INCREMENT,
    ID_ACTIVIDAD VARCHAR(255) NOT NULL,
    DESCRIPCION VARCHAR(255) NOT NULL,
    PRIMARY KEY (ID_ACTA, ID_ACTIVIDAD),
    FOREIGN KEY (ID_ACTIVIDAD) REFERENCES ACTIVIDADES(ID_ACTIVIDAD)
);

CREATE TABLE IF NOT EXISTS CATEGORIAS_INCONVENIENTES (
    ID_CATEGORIA INT NOT NULL AUTO_INCREMENT,
    DESCRIPCION VARCHAR(255) NOT NULL,
    RETRASO_DIAS INT NOT NULL,
    PRIMARY KEY (ID_CATEGORIA)
);

CREATE TABLE IF NOT EXISTS INCONVENIENTES (
    ID_INCONVENIENTE VARCHAR(255) NOT NULL,
    ID_ACTIVIDAD VARCHAR(255) NOT NULL,
    ID_CATEGORIA INT NOT NULL,
    DESCRIPCION VARCHAR(255) NOT NULL,
    PRIMARY KEY (ID_INCONVENIENTE),
    FOREIGN KEY (ID_ACTIVIDAD) REFERENCES ACTIVIDADES(ID_ACTIVIDAD),
    FOREIGN KEY (ID_CATEGORIA) REFERENCES CATEGORIAS_INCONVENIENTES(ID_CATEGORIA)
);

INSERT INTO PROYECTOS (ID_PROYECTO, NOMBRE)
VALUES ('PJ001', 'Aplicativo Fintech UD'); 
INSERT INTO PROYECTOS (ID_PROYECTO, NOMBRE)
VALUES ('PJ002', 'Pagina Web Javeriana'); 

INSERT INTO EQUIPOS (ID_EQUIPO, NOMBRE)
VALUES ('ED001', 'Desarrollo Comercial'); 
INSERT INTO EQUIPOS (ID_EQUIPO, NOMBRE)
VALUES ('ED002', 'Desarrollo Interno'); 

INSERT INTO PROYECTOS_EQUIPOS (ID_PROYECTO, ID_EQUIPO)
VALUES ('PJ001', 'ED001'); 
INSERT INTO PROYECTOS_EQUIPOS (ID_PROYECTO, ID_EQUIPO)
VALUES ('PJ002', 'ED001'); 

INSERT INTO INTEGRANTES (ID_INTEGRANTE, NOMBRE, APELLIDO, ROL, ID_MANAGER)
VALUES ('A001', 'Bridget', 'Allen', 'Gerente de Proyectos', NULL); 
INSERT INTO INTEGRANTES (ID_INTEGRANTE, NOMBRE, APELLIDO, ROL, ID_MANAGER)
VALUES ('A011', 'Percy', 'Gates', 'Lider Tecnico', 'A001'); 
INSERT INTO INTEGRANTES (ID_INTEGRANTE, NOMBRE, APELLIDO, ROL, ID_MANAGER)
VALUES ('A111', 'Phoebe', 'Shields', 'Desarrollador Backend', 'A011'); 
INSERT INTO INTEGRANTES (ID_INTEGRANTE, NOMBRE, APELLIDO, ROL, ID_MANAGER)
VALUES ('A002', 'Elijah', 'Silva', 'Desarrollador Frontend', 'A011'); 
INSERT INTO INTEGRANTES (ID_INTEGRANTE, NOMBRE, APELLIDO, ROL, ID_MANAGER)
VALUES ('A012', 'Luke', 'Antcliff', 'Disenador Web', 'A011'); 
INSERT INTO INTEGRANTES (ID_INTEGRANTE, NOMBRE, APELLIDO, ROL, ID_MANAGER)
VALUES ('A112', 'Darlene', 'Corbett', 'Tester', 'A011');

INSERT INTO EQUIPOS_INTEGRANTES (ID_EQUIPO, ID_INTEGRANTE)
VALUES ('ED001', 'A011');
INSERT INTO EQUIPOS_INTEGRANTES (ID_EQUIPO, ID_INTEGRANTE)
VALUES ('ED001', 'A111');
INSERT INTO EQUIPOS_INTEGRANTES (ID_EQUIPO, ID_INTEGRANTE)
VALUES ('ED001', 'A002');
INSERT INTO EQUIPOS_INTEGRANTES (ID_EQUIPO, ID_INTEGRANTE)
VALUES ('ED001', 'A012');
INSERT INTO EQUIPOS_INTEGRANTES (ID_EQUIPO, ID_INTEGRANTE)
VALUES ('ED001', 'A112');

INSERT INTO ACTIVIDADES (ID_ACTIVIDAD, NOMBRE, DURACION_DIAS)
VALUES ('CST001', 'Disminucion padding header', 2); 
INSERT INTO ACTIVIDADES (ID_ACTIVIDAD, NOMBRE, DURACION_DIAS)
VALUES ('CST002', 'Integrar API post usuario', 3); 
INSERT INTO ACTIVIDADES (ID_ACTIVIDAD, NOMBRE, DURACION_DIAS)
VALUES ('CST003', 'Insertar elemento input', 4); 
INSERT INTO ACTIVIDADES (ID_ACTIVIDAD, NOMBRE, DURACION_DIAS)
VALUES ('CST004', 'Configurar API servicio GET', 3); 

INSERT INTO INTEGRANTES_ACTIVIDADES (ID_INTEGRANTE, ID_ACTIVIDAD)
VALUES ('A001', 'CST001');
INSERT INTO INTEGRANTES_ACTIVIDADES (ID_INTEGRANTE, ID_ACTIVIDAD)
VALUES ('A001', 'CST002');
INSERT INTO INTEGRANTES_ACTIVIDADES (ID_INTEGRANTE, ID_ACTIVIDAD)
VALUES ('A001', 'CST003');
INSERT INTO INTEGRANTES_ACTIVIDADES (ID_INTEGRANTE, ID_ACTIVIDAD)
VALUES ('A001', 'CST004');
INSERT INTO INTEGRANTES_ACTIVIDADES (ID_INTEGRANTE, ID_ACTIVIDAD)
VALUES ('A111', 'CST002');
INSERT INTO INTEGRANTES_ACTIVIDADES (ID_INTEGRANTE, ID_ACTIVIDAD)
VALUES ('A002', 'CST001');

INSERT INTO ACTAS (ID_ACTIVIDAD, DESCRIPCION)
VALUES ('CST001', 'El padding del header esta muy grande. Hay que disminuirlo 3 px.');
INSERT INTO ACTAS (ID_ACTIVIDAD, DESCRIPCION)
VALUES ('CST002', 'Es necesario crear el metodo que realice el llamado de servicio post que inserta los usuarios.');
INSERT INTO ACTAS (ID_ACTIVIDAD, DESCRIPCION)
VALUES ('CST003', 'En el formulario hace falta el elemento de input del telefono.');
INSERT INTO ACTAS (ID_ACTIVIDAD, DESCRIPCION)
VALUES ('CST004', 'El servicio no esta devolviendo la informacion completa.');

INSERT INTO CATEGORIAS_INCONVENIENTES (DESCRIPCION, RETRASO_DIAS)
VALUES ('FUERTE', 5);
INSERT INTO CATEGORIAS_INCONVENIENTES (DESCRIPCION, RETRASO_DIAS)
VALUES ('MEDIO', 2);
INSERT INTO CATEGORIAS_INCONVENIENTES (DESCRIPCION, RETRASO_DIAS)
VALUES ('BAJO', 1);

INSERT INTO INCONVENIENTES (ID_INCONVENIENTE, ID_ACTIVIDAD, ID_CATEGORIA, DESCRIPCION)
VALUES ('INC0021', 'CST001', 1, 'El servidor de la aplicacion esta caido');
INSERT INTO INCONVENIENTES (ID_INCONVENIENTE, ID_ACTIVIDAD, ID_CATEGORIA, DESCRIPCION)
VALUES ('INC0022', 'CST001', 3, 'El diseno no esta completo');
INSERT INTO INCONVENIENTES (ID_INCONVENIENTE, ID_ACTIVIDAD, ID_CATEGORIA, DESCRIPCION)
VALUES ('INC0023', 'CST002', 3, 'El diseno de la respuesta no esta listo');
INSERT INTO INCONVENIENTES (ID_INCONVENIENTE, ID_ACTIVIDAD, ID_CATEGORIA, DESCRIPCION)
VALUES ('INC0024', 'CST003', 2, 'El formulario esta en proceso de rediseno');
INSERT INTO INCONVENIENTES (ID_INCONVENIENTE, ID_ACTIVIDAD, ID_CATEGORIA, DESCRIPCION)
VALUES ('INC0025', 'CST004', 2, 'La base de datos esta incompleta');