CREATE TABLE medicos
(
    idmedico  SERIAL PRIMARY KEY,
    nombre    VARCHAR(50),
    apellidos VARCHAR(50),
    ruc       VARCHAR(15) UNIQUE,
    direccion VARCHAR(60),
    correo    VARCHAR(30),
    telefono  VARCHAR(20),
    id_ciudad CHAR(5)
);

----- STORE PROCEDURE -------
drop procedure if exists fn_obtiene_medicos;

CREATE PROCEDURE fn_obtiene_medicos(i_nombre_medico VARCHAR(250))
    RETURNING int, varchar(50), varchar(50), varchar(15), varchar(60), varchar(30), varchar(20), char(5);

DEFINE v_idmedico INT;
    DEFINE v_nombre, v_apellidos varchar(50);
    DEFINE v_ruc varchar(15);
    DEFINE v_direccion varchar(60);
    DEFINE v_correo varchar(30);
    DEFINE v_telefono varchar(20);
    DEFINE v_id_ciudad char(5);

SELECT idmedico, nombre, apellidos, ruc, direccion, correo, telefono, id_ciudad
INTO v_idmedico, v_nombre, v_apellidos, v_ruc, v_direccion, v_correo, v_telefono, v_id_ciudad
FROM
    medicos
WHERE
    LOWER(nombre) LIKE LOWER('%' || i_nombre_medico || '%') OR
    LOWER(apellidos) LIKE LOWER('%' || i_nombre_medico || '%');

RETURN v_idmedico, v_nombre, v_apellidos, v_ruc, v_direccion, v_correo, v_telefono, v_id_ciudad;

END PROCEDURE;


EXECUTE PROCEDURE fn_obtiene_medicos('di');


----- STORE PROCEDURE -------

---- INSERT DEMO DATA -------

INSERT INTO medicos (nombre, apellidos, ruc, direccion, correo, telefono, id_ciudad) VALUES ('Juan', 'Pérez', '1234567890123', 'Calle 1, Ciudad A', 'juan.perez@email.com', '123-456-7890', 'C001');
INSERT INTO medicos (nombre, apellidos, ruc, direccion, correo, telefono, id_ciudad) VALUES ('María', 'González', '2234567890123', 'Calle 2, Ciudad B', 'maria.gonzalez@email.com', '223-456-7890', 'C002');
INSERT INTO medicos (nombre, apellidos, ruc, direccion, correo, telefono, id_ciudad) VALUES ('Carlos', 'Rodríguez', '3234567890123', 'Calle 3, Ciudad C', 'carlos.rodriguez@email.com', '323-456-7890', 'C003');
INSERT INTO medicos (nombre, apellidos, ruc, direccion, correo, telefono, id_ciudad) VALUES ('Ana', 'Ramírez', '4234567890123', 'Calle 4, Ciudad D', 'ana.ramirez@email.com', '423-456-7890', 'C004');
INSERT INTO medicos (nombre, apellidos, ruc, direccion, correo, telefono, id_ciudad) VALUES ('Luis', 'Morales', '5234567890123', 'Calle 5, Ciudad E', 'luis.morales@email.com', '523-456-7890', 'C005');
INSERT INTO medicos (nombre, apellidos, ruc, direccion, correo, telefono, id_ciudad) VALUES ('Sofía', 'Castro', '6234567890123', 'Calle 6, Ciudad F', 'sofia.castro@email.com', '623-456-7890', 'C006');
INSERT INTO medicos (nombre, apellidos, ruc, direccion, correo, telefono, id_ciudad) VALUES ('Javier', 'Ortega', '7234567890123', 'Calle 7, Ciudad G', 'javier.ortega@email.com', '723-456-7890', 'C007');
INSERT INTO medicos (nombre, apellidos, ruc, direccion, correo, telefono, id_ciudad) VALUES ('Carmen', 'Reyes', '8234567890123', 'Calle 8, Ciudad H', 'carmen.reyes@email.com', '823-456-7890', 'C008');
INSERT INTO medicos (nombre, apellidos, ruc, direccion, correo, telefono, id_ciudad) VALUES ('Roberto', 'García', '9234567890123', 'Calle 9, Ciudad I', 'roberto.garcia@email.com', '923-456-7890', 'C009');
INSERT INTO medicos (nombre, apellidos, ruc, direccion, correo, telefono, id_ciudad) VALUES ('Isabel', 'Fernández', '0234567890123', 'Calle 10, Ciudad J', 'isabel.fernandez@email.com', '023-456-7890', 'C010');


INSERT INTO medicos(nombre, apellidos, ruc, direccion, correo, telefono, id_ciudad) VALUES ('Diego', 'Condo', '010203040506070809', 'Av de las americas', 'correo@correo.com', '012-345-6789', 'C001') RETURNING *;




---- INSERT DEMO DATA -------

---- DEMO RETURN ONE STRING ----
drop procedure if exists fn_test_return_one_string;

CREATE PROCEDURE fn_test_return_one_string()
    RETURNING varchar(50);

RETURN 'Prueba de unico texto';

END PROCEDURE;


EXECUTE PROCEDURE fn_test_return_one_string();

---- DEMO RETURN ONE STRING ----

---- DEMO RETURN ONE NUMBER ----

drop procedure if exists fn_test_return_one_number;

CREATE PROCEDURE fn_test_return_one_number(numero NUMERIC)
    RETURNING INT;

RETURN numero * 2.1;

END PROCEDURE;


EXECUTE PROCEDURE fn_test_return_one_number();