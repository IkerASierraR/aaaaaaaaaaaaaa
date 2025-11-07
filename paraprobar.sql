-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.4.32-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.11.0.7065
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para sisintupt
CREATE DATABASE IF NOT EXISTS `sisintupt` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `sisintupt`;

-- Volcando estructura para tabla sisintupt.administrativo
CREATE TABLE IF NOT EXISTS `administrativo` (
  `IdAdministrativo` int(11) NOT NULL AUTO_INCREMENT,
  `IdUsuario` int(11) NOT NULL,
  `Turno` enum('Mañana','Tarde','Noche','Completo') DEFAULT 'Completo',
  `Extension` varchar(10) DEFAULT NULL,
  `FechaIncorporacion` date NOT NULL,
  PRIMARY KEY (`IdAdministrativo`),
  UNIQUE KEY `IdUsuario` (`IdUsuario`),
  CONSTRAINT `FK_administrativo_usuario` FOREIGN KEY (`IdUsuario`) REFERENCES `usuario` (`IdUsuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla sisintupt.administrativo: ~0 rows (aproximadamente)

-- Volcando estructura para tabla sisintupt.auditoria_reserva
CREATE TABLE IF NOT EXISTS `auditoria_reserva` (
  `IdAuditoria` int(11) NOT NULL AUTO_INCREMENT,
  `IdReserva` int(11) NOT NULL,
  `EstadoAnterior` varchar(50) NOT NULL,
  `EstadoNuevo` varchar(50) NOT NULL,
  `FechaCambio` datetime NOT NULL DEFAULT current_timestamp(),
  `IdUsuarioCambio` int(11) DEFAULT NULL,
  PRIMARY KEY (`IdAuditoria`),
  KEY `FK_auditoria_reserva_reserva` (`IdReserva`),
  KEY `FK_auditoria_reserva_usuario` (`IdUsuarioCambio`),
  CONSTRAINT `FK_auditoria_reserva_reserva` FOREIGN KEY (`IdReserva`) REFERENCES `reserva` (`IdReserva`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_auditoria_reserva_usuario` FOREIGN KEY (`IdUsuarioCambio`) REFERENCES `usuario` (`IdUsuario`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla sisintupt.auditoria_reserva: ~0 rows (aproximadamente)

-- Volcando estructura para tabla sisintupt.bloque_horario
CREATE TABLE IF NOT EXISTS `bloque_horario` (
  `IdBloque` int(11) NOT NULL AUTO_INCREMENT,
  `Orden` int(11) NOT NULL,
  `Nombre` varchar(50) NOT NULL,
  `HoraInicio` time NOT NULL,
  `HoraFin` time NOT NULL,
  PRIMARY KEY (`IdBloque`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla sisintupt.bloque_horario: ~0 rows (aproximadamente)

-- Volcando estructura para tabla sisintupt.curso
CREATE TABLE IF NOT EXISTS `curso` (
  `IdCurso` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(100) NOT NULL,
  `IdEscuela` int(11) NOT NULL,
  `Ciclo` varchar(5) NOT NULL,
  `Estado` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`IdCurso`),
  KEY `FK_curso_escuela` (`IdEscuela`),
  CONSTRAINT `FK_curso_escuela` FOREIGN KEY (`IdEscuela`) REFERENCES `escuela` (`IdEscuela`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla sisintupt.curso: ~0 rows (aproximadamente)

-- Volcando estructura para tabla sisintupt.docente
CREATE TABLE IF NOT EXISTS `docente` (
  `IdDocente` int(11) NOT NULL AUTO_INCREMENT,
  `IdUsuario` int(11) NOT NULL,
  `CodigoDocente` varchar(20) NOT NULL,
  `IdEscuela` int(11) DEFAULT NULL,
  `TipoContrato` enum('Tiempo Completo','Medio Tiempo','Contratado') NOT NULL,
  `Especialidad` varchar(100) DEFAULT NULL,
  `FechaIncorporacion` date NOT NULL,
  PRIMARY KEY (`IdDocente`),
  UNIQUE KEY `IdUsuario` (`IdUsuario`),
  UNIQUE KEY `CodigoDocente` (`CodigoDocente`),
  KEY `FK_docente_escuela` (`IdEscuela`),
  CONSTRAINT `FK_docente_escuela` FOREIGN KEY (`IdEscuela`) REFERENCES `escuela` (`IdEscuela`),
  CONSTRAINT `FK_docente_usuario` FOREIGN KEY (`IdUsuario`) REFERENCES `usuario` (`IdUsuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla sisintupt.docente: ~0 rows (aproximadamente)

-- Volcando estructura para tabla sisintupt.escuela
CREATE TABLE IF NOT EXISTS `escuela` (
  `IdEscuela` int(11) NOT NULL AUTO_INCREMENT,
  `IdFacultad` int(11) NOT NULL,
  `Nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`IdEscuela`),
  KEY `FK_escuela_facultad` (`IdFacultad`),
  CONSTRAINT `FK_escuela_facultad` FOREIGN KEY (`IdFacultad`) REFERENCES `facultad` (`IdFacultad`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla sisintupt.escuela: ~19 rows (aproximadamente)
INSERT INTO `escuela` (`IdEscuela`, `IdFacultad`, `Nombre`) VALUES
	(1, 1, 'Ing. Civil'),
	(2, 1, 'Ing. de Sistemas'),
	(3, 1, 'Ing. Electronica'),
	(4, 1, 'Ing. Agroindustrial'),
	(5, 1, 'Ing. Ambiental'),
	(6, 1, 'Ing. Industrial'),
	(7, 2, 'Derecho'),
	(8, 3, 'Ciencias Contables y Financieras'),
	(9, 3, 'Economia y Microfinanzas'),
	(10, 3, 'Administracion'),
	(11, 3, 'Administracion Turistico-Hotel'),
	(12, 3, 'Administracion de Negocios Internacionales'),
	(13, 4, 'Educacion'),
	(14, 4, 'Ciencias de la Comunicacion'),
	(15, 4, 'Humanidades - Psicologia'),
	(16, 5, 'Medicina Humana'),
	(17, 5, 'Odontologia'),
	(18, 5, 'Tecnologia Medica'),
	(19, 6, 'Arquitectira');

-- Volcando estructura para tabla sisintupt.espacio
CREATE TABLE IF NOT EXISTS `espacio` (
  `IdEspacio` int(11) NOT NULL AUTO_INCREMENT,
  `Codigo` varchar(20) NOT NULL DEFAULT '',
  `Nombre` varchar(100) NOT NULL,
  `Tipo` enum('Laboratorio','Salon') NOT NULL DEFAULT 'Laboratorio',
  `Capacidad` int(11) NOT NULL,
  `Equipamiento` text DEFAULT NULL,
  `IdEscuela` int(11) NOT NULL,
  `Estado` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`IdEspacio`),
  UNIQUE KEY `Codigo` (`Codigo`),
  KEY `FK_espacio_escuela` (`IdEscuela`),
  CONSTRAINT `FK_espacio_escuela` FOREIGN KEY (`IdEscuela`) REFERENCES `escuela` (`IdEscuela`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla sisintupt.espacio: ~0 rows (aproximadamente)

-- Volcando estructura para tabla sisintupt.estudiante
CREATE TABLE IF NOT EXISTS `estudiante` (
  `IdEstudiante` int(11) NOT NULL AUTO_INCREMENT,
  `IdUsuario` int(11) NOT NULL,
  `Codigo` varchar(20) NOT NULL,
  `IdEscuela` int(11) NOT NULL,
  `Promedio` decimal(3,2) DEFAULT NULL,
  PRIMARY KEY (`IdEstudiante`),
  UNIQUE KEY `IdUsuario` (`IdUsuario`),
  UNIQUE KEY `Codigo` (`Codigo`),
  KEY `FK_estudiante_escuela` (`IdEscuela`),
  CONSTRAINT `FK_estudiante_escuela` FOREIGN KEY (`IdEscuela`) REFERENCES `escuela` (`IdEscuela`),
  CONSTRAINT `FK_estudiante_usuario` FOREIGN KEY (`IdUsuario`) REFERENCES `usuario` (`IdUsuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla sisintupt.estudiante: ~0 rows (aproximadamente)

-- Volcando estructura para tabla sisintupt.facultad
CREATE TABLE IF NOT EXISTS `facultad` (
  `IdFacultad` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(50) NOT NULL,
  `Abreviatura` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`IdFacultad`),
  UNIQUE KEY `Nombre` (`Nombre`),
  UNIQUE KEY `Abreviatura` (`Abreviatura`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla sisintupt.facultad: ~6 rows (aproximadamente)
INSERT INTO `facultad` (`IdFacultad`, `Nombre`, `Abreviatura`) VALUES
	(1, 'Facultad de Ingeniería', 'FAING'),
	(2, 'Facultad de Derecho y Ciencias Políticas', 'FADE'),
	(3, 'Facultad de Ciencias Empresariales', 'FACEM'),
	(4, 'Facultad de Educación, Ciencias de la Comunicación', 'FAEDCOH'),
	(5, 'Facultad de Ciencias De la Salud', 'FACSA'),
	(6, 'Facultad de Arquitectura y Urbanismo', 'FAU');

-- Volcando estructura para tabla sisintupt.horario
CREATE TABLE IF NOT EXISTS `horario` (
  `IdHorario` int(11) NOT NULL AUTO_INCREMENT,
  `IdEspacio` int(11) NOT NULL,
  `IdBloque` int(11) NOT NULL,
  `DiaSemana` enum('Lunes','Martes','Miercoles','Jueves','Viernes','Sabado') NOT NULL,
  `Ocupado` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`IdHorario`) USING BTREE,
  KEY `FK_horario_espacio` (`IdEspacio`) USING BTREE,
  KEY `FK_horario_bloque` (`IdBloque`) USING BTREE,
  CONSTRAINT `FK_horario_bloque` FOREIGN KEY (`IdBloque`) REFERENCES `bloque_horario` (`IdBloque`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_horario_espacio` FOREIGN KEY (`IdEspacio`) REFERENCES `espacio` (`IdEspacio`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=465 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla sisintupt.horario: ~0 rows (aproximadamente)

-- Volcando estructura para tabla sisintupt.horario_curso
CREATE TABLE IF NOT EXISTS `horario_curso` (
  `IdHorarioCurso` int(11) NOT NULL AUTO_INCREMENT,
  `IdCurso` int(11) NOT NULL,
  `IdDocente` int(11) NOT NULL,
  `IdEspacio` int(11) NOT NULL,
  `IdBloque` int(11) NOT NULL,
  `DiaSemana` enum('Lunes','Martes','Miercoles','Jueves','Viernes','Sabado') NOT NULL,
  `FechaInicio` date NOT NULL,
  `FechaFin` date NOT NULL,
  `Estado` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`IdHorarioCurso`),
  KEY `FK_horario_curso_usuario` (`IdDocente`),
  KEY `FK_horario_curso_espacio` (`IdEspacio`),
  KEY `FK_horario_curso_bloque_horario` (`IdBloque`),
  KEY `FK_horario_curso_curso` (`IdCurso`),
  CONSTRAINT `FK_horario_curso_bloque_horario` FOREIGN KEY (`IdBloque`) REFERENCES `bloque_horario` (`IdBloque`),
  CONSTRAINT `FK_horario_curso_curso` FOREIGN KEY (`IdCurso`) REFERENCES `curso` (`IdCurso`),
  CONSTRAINT `FK_horario_curso_espacio` FOREIGN KEY (`IdEspacio`) REFERENCES `espacio` (`IdEspacio`),
  CONSTRAINT `FK_horario_curso_usuario` FOREIGN KEY (`IdDocente`) REFERENCES `usuario` (`IdUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla sisintupt.horario_curso: ~0 rows (aproximadamente)

-- Volcando estructura para tabla sisintupt.incidencia
CREATE TABLE IF NOT EXISTS `incidencia` (
  `IdIncidencia` int(11) NOT NULL AUTO_INCREMENT,
  `IdReserva` int(11) NOT NULL,
  `Descripcion` text NOT NULL,
  `FechaReporte` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`IdIncidencia`),
  KEY `FK_incidencia_reserva` (`IdReserva`),
  CONSTRAINT `FK_incidencia_reserva` FOREIGN KEY (`IdReserva`) REFERENCES `reserva` (`IdReserva`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla sisintupt.incidencia: ~0 rows (aproximadamente)

-- Volcando estructura para tabla sisintupt.reserva
CREATE TABLE IF NOT EXISTS `reserva` (
  `IdReserva` int(11) NOT NULL AUTO_INCREMENT,
  `IdUsuario` int(11) NOT NULL,
  `IdEspacio` int(11) NOT NULL,
  `IdBloque` int(11) NOT NULL,
  `IdCurso` int(11) NOT NULL,
  `FechaReserva` date NOT NULL,
  `FechaSolicitud` datetime NOT NULL DEFAULT current_timestamp(),
  `DescripcionUso` text DEFAULT NULL,
  `CantidadEstudiantes` int(11) NOT NULL DEFAULT 1,
  `Estado` enum('Pendiente','Aprobada','Rechazada','Cancelada') NOT NULL DEFAULT 'Pendiente',
  PRIMARY KEY (`IdReserva`),
  KEY `FK_reserva_espacio` (`IdEspacio`),
  KEY `FK_reserva_usuario` (`IdUsuario`),
  KEY `FK_reserva_bloque_horario` (`IdBloque`),
  KEY `FK_reserva_curso` (`IdCurso`) USING BTREE,
  CONSTRAINT `FK_reserva_bloque_horario` FOREIGN KEY (`IdBloque`) REFERENCES `bloque_horario` (`IdBloque`),
  CONSTRAINT `FK_reserva_curso` FOREIGN KEY (`IdCurso`) REFERENCES `curso` (`IdCurso`),
  CONSTRAINT `FK_reserva_espacio` FOREIGN KEY (`IdEspacio`) REFERENCES `espacio` (`IdEspacio`),
  CONSTRAINT `FK_reserva_usuario` FOREIGN KEY (`IdUsuario`) REFERENCES `usuario` (`IdUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla sisintupt.reserva: ~0 rows (aproximadamente)

-- Volcando estructura para tabla sisintupt.reserva_gestion
CREATE TABLE IF NOT EXISTS `reserva_gestion` (
  `IdGestion` int(11) NOT NULL AUTO_INCREMENT,
  `IdReserva` int(11) NOT NULL,
  `FechaGestion` datetime NOT NULL DEFAULT current_timestamp(),
  `Accion` enum('Aprobar','Rechazar') NOT NULL,
  `Motivo` text NOT NULL COMMENT 'Motivo de la acción',
  `Comentarios` text DEFAULT NULL COMMENT 'Comentarios adicionales',
  PRIMARY KEY (`IdGestion`),
  KEY `FK_gestion_reserva` (`IdReserva`),
  CONSTRAINT `FK_gestion_reserva` FOREIGN KEY (`IdReserva`) REFERENCES `reserva` (`IdReserva`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla sisintupt.reserva_gestion: ~0 rows (aproximadamente)

-- Volcando estructura para evento sisintupt.reset_horarios_domingo
DELIMITER //
CREATE EVENT `reset_horarios_domingo` ON SCHEDULE EVERY 1 WEEK STARTS '2025-09-14 00:00:00' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE horarios SET ocupado = 0//
DELIMITER ;

-- Volcando estructura para tabla sisintupt.rol
CREATE TABLE IF NOT EXISTS `rol` (
  `IdRol` int(11) NOT NULL,
  `Nombre` varchar(15) NOT NULL,
  PRIMARY KEY (`IdRol`),
  UNIQUE KEY `Nombre` (`Nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla sisintupt.rol: ~4 rows (aproximadamente)
INSERT INTO `rol` (`IdRol`, `Nombre`) VALUES
	(1, 'Profesor'),
	(2, 'Estudiante'),
	(3, 'Administrador'),
	(4, 'Supervisor');

-- Volcando estructura para tabla sisintupt.sancion
CREATE TABLE IF NOT EXISTS `sancion` (
  `IdSancion` int(11) NOT NULL AUTO_INCREMENT,
  `IdUsuario` int(11) NOT NULL,
  `Motivo` text NOT NULL,
  `FechaInicio` date NOT NULL,
  `FechaFin` date NOT NULL,
  `Estado` enum('Activa','Cumplida') DEFAULT 'Activa',
  PRIMARY KEY (`IdSancion`),
  KEY `IdUsuario` (`IdUsuario`),
  CONSTRAINT `sancion_ibfk_1` FOREIGN KEY (`IdUsuario`) REFERENCES `usuario` (`IdUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla sisintupt.sancion: ~0 rows (aproximadamente)

-- Volcando estructura para tabla sisintupt.tipo_documento
CREATE TABLE IF NOT EXISTS `tipo_documento` (
  `IdTipoDoc` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(50) NOT NULL,
  `Abreviatura` varchar(10) NOT NULL,
  PRIMARY KEY (`IdTipoDoc`),
  UNIQUE KEY `Nombre` (`Nombre`),
  UNIQUE KEY `Abreviatura` (`Abreviatura`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla sisintupt.tipo_documento: ~12 rows (aproximadamente)
INSERT INTO `tipo_documento` (`IdTipoDoc`, `Nombre`, `Abreviatura`) VALUES
	(1, 'Documento Nacional de Identidad', 'DNI'),
	(2, 'Carnet de Extranjería', 'CE'),
	(3, 'Pasaporte', 'PAS'),
	(4, 'Permiso Temporal de Permanencia', 'PTP'),
	(5, 'Cédula de Identidad', 'CI'),
	(6, 'Registro Único de Contribuyente', 'RUC'),
	(7, 'Partida de Nacimiento', 'PN'),
	(8, 'Carnet de Refugiado', 'CR'),
	(9, 'Documento de Identidad Extranjero', 'DIE'),
	(10, 'Licencia de Conducir', 'LIC'),
	(11, 'Carnet Universitario', 'CU'),
	(12, 'Otro', 'OTRO');

-- Volcando estructura para tabla sisintupt.usuario
CREATE TABLE IF NOT EXISTS `usuario` (
  `IdUsuario` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(30) NOT NULL,
  `Apellido` varchar(30) NOT NULL,
  `IdTipoDoc` int(11) NOT NULL,
  `NumDoc` varchar(20) NOT NULL DEFAULT '',
  `IdRol` int(11) NOT NULL,
  `Celular` varchar(11) DEFAULT NULL,
  `Genero` bit(1) DEFAULT NULL,
  `Estado` int(11) NOT NULL DEFAULT 1,
  `FechaRegistro` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`IdUsuario`),
  UNIQUE KEY `NumDoc` (`NumDoc`),
  KEY `FK_usuario_rol` (`IdRol`),
  KEY `FK_usuario_tipo_documento` (`IdTipoDoc`),
  CONSTRAINT `FK_usuario_rol` FOREIGN KEY (`IdRol`) REFERENCES `rol` (`IdRol`),
  CONSTRAINT `FK_usuario_tipo_documento` FOREIGN KEY (`IdTipoDoc`) REFERENCES `tipo_documento` (`IdTipoDoc`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla sisintupt.usuario: ~0 rows (aproximadamente)

-- Volcando estructura para tabla sisintupt.usuario_auth
CREATE TABLE IF NOT EXISTS `usuario_auth` (
  `IdAuth` int(11) NOT NULL AUTO_INCREMENT,
  `IdUsuario` int(11) NOT NULL,
  `Correo` varchar(30) NOT NULL,
  `Password` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`IdAuth`),
  UNIQUE KEY `IdUsuario` (`IdUsuario`),
  UNIQUE KEY `Correo` (`Correo`),
  CONSTRAINT `FK_usuario_auth_usuario` FOREIGN KEY (`IdUsuario`) REFERENCES `usuario` (`IdUsuario`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla sisintupt.usuario_auth: ~0 rows (aproximadamente)

-- Volcando estructura para tabla sisintupt.usuario_sesion
CREATE TABLE IF NOT EXISTS `usuario_sesion` (
  `IdSesion` int(11) NOT NULL AUTO_INCREMENT,
  `IdUsuario` int(11) NOT NULL,
  `Dispositivo` varchar(50) DEFAULT NULL,
  `IP` varchar(45) DEFAULT NULL,
  `Activa` tinyint(1) NOT NULL DEFAULT 1,
  `UltimoLogin` datetime DEFAULT NULL,
  PRIMARY KEY (`IdSesion`),
  KEY `FK_usuario_sesion_usuario` (`IdUsuario`),
  CONSTRAINT `FK_usuario_sesion_usuario` FOREIGN KEY (`IdUsuario`) REFERENCES `usuario` (`IdUsuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla sisintupt.usuario_sesion: ~0 rows (aproximadamente)

-- Volcando estructura para disparador sisintupt.trg_actualizar_horario_update
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `trg_actualizar_horario_update` AFTER UPDATE ON `reserva` FOR EACH ROW BEGIN
    DECLARE dia ENUM('Lunes','Martes','Miercoles','Jueves','Viernes','Sabado');

    SET dia = CASE DAYOFWEEK(NEW.FechaReserva)
        WHEN 2 THEN 'Lunes'
        WHEN 3 THEN 'Martes'
        WHEN 4 THEN 'Miercoles'
        WHEN 5 THEN 'Jueves'
        WHEN 6 THEN 'Viernes'
        WHEN 7 THEN 'Sabado'
        ELSE 'Lunes' -- Default si cae domingo
    END;

    IF NEW.Estado = 'Aprobada' THEN
        UPDATE horario h
        SET h.Ocupado = 1
        WHERE h.IdEspacio = NEW.IdEspacio
          AND h.IdBloque = NEW.IdBloque
          AND h.DiaSemana = dia;
    ELSEIF NEW.Estado IN ('Pendiente','Rechazada','Cancelada') THEN
        UPDATE horario h
        SET h.Ocupado = 0
        WHERE h.IdEspacio = NEW.IdEspacio
          AND h.IdBloque = NEW.IdBloque
          AND h.DiaSemana = dia;
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sisintupt.trg_auditoria_reserva
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `trg_auditoria_reserva` AFTER UPDATE ON `reserva` FOR EACH ROW BEGIN
    DECLARE usuario_gestion INT;
    
    -- Solo registrar si el estado cambió
    IF OLD.Estado <> NEW.Estado THEN
        -- Obtener el ÚLTIMO usuario que gestionó esta reserva
        SELECT rg.IdUsuarioGestion INTO usuario_gestion
        FROM reserva_gestion rg
        WHERE rg.IdReserva = NEW.IdReserva
        ORDER BY rg.FechaGestion DESC
        LIMIT 1;
        
        -- Si no hay gestión, usar el usuario de la reserva
        SET usuario_gestion = COALESCE(usuario_gestion, NEW.IdUsuario);
        
        INSERT INTO auditoria_reserva (IdReserva, EstadoAnterior, EstadoNuevo, IdUsuarioCambio)
        VALUES (NEW.IdReserva, OLD.Estado, NEW.Estado, usuario_gestion);
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sisintupt.trg_bloquear_horario_curso_insert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `trg_bloquear_horario_curso_insert` AFTER INSERT ON `horario_curso` FOR EACH ROW BEGIN
    -- Si la fecha actual está dentro del rango del curso, bloquear inmediatamente
    IF CURDATE() BETWEEN NEW.FechaInicio AND NEW.FechaFin AND NEW.Estado = 1 THEN
        UPDATE horario 
        SET Ocupado = 1 
        WHERE IdEspacio = NEW.IdEspacio 
          AND IdBloque = NEW.IdBloque 
          AND DiaSemana = NEW.DiaSemana;
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sisintupt.trg_bloquear_horario_curso_update
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `trg_bloquear_horario_curso_update` AFTER UPDATE ON `horario_curso` FOR EACH ROW BEGIN
    -- Liberar el horario anterior si cambió espacio, bloque, día o si el curso expiró/desactivó
    IF (OLD.Estado = 1 AND NEW.Estado = 0) OR 
       (OLD.Estado = 1 AND (NEW.IdEspacio != OLD.IdEspacio OR NEW.IdBloque != OLD.IdBloque OR NEW.DiaSemana != OLD.DiaSemana)) OR
       (OLD.Estado = 1 AND CURDATE() NOT BETWEEN NEW.FechaInicio AND NEW.FechaFin) THEN
        
        UPDATE horario 
        SET Ocupado = 0 
        WHERE IdEspacio = OLD.IdEspacio 
          AND IdBloque = OLD.IdBloque 
          AND DiaSemana = OLD.DiaSemana;
    END IF;
    
    -- Bloquear el nuevo horario si está activo y en fecha válida
    IF NEW.Estado = 1 AND CURDATE() BETWEEN NEW.FechaInicio AND NEW.FechaFin THEN
        UPDATE horario 
        SET Ocupado = 1 
        WHERE IdEspacio = NEW.IdEspacio 
          AND IdBloque = NEW.IdBloque 
          AND DiaSemana = NEW.DiaSemana;
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sisintupt.trg_crear_horarios
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `trg_crear_horarios` AFTER INSERT ON `bloque_horario` FOR EACH ROW BEGIN
    -- Insertar horarios automáticamente para cada espacio y cada día de la semana
    INSERT INTO horario (IdEspacio, IdBloque, DiaSemana, Ocupado)
    SELECT e.IdEspacio, NEW.IdBloque, d.dia, 0
    FROM espacio e
    CROSS JOIN (
        SELECT 'Lunes' AS dia
        UNION ALL SELECT 'Martes'
        UNION ALL SELECT 'Miercoles'
        UNION ALL SELECT 'Jueves'
        UNION ALL SELECT 'Viernes'
        UNION ALL SELECT 'Sabado'
    ) d;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sisintupt.trg_crear_horarios_espacios
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `trg_crear_horarios_espacios` AFTER INSERT ON `espacio` FOR EACH ROW BEGIN
	INSERT INTO horario (IdEspacio, IdBloque, DiaSemana, Ocupado)
    SELECT NEW.IdEspacio, b.IdBloque, d.dia, 0
    FROM bloque_horario b
    CROSS JOIN (
        SELECT 'Lunes' AS dia UNION SELECT 'Martes' UNION SELECT 'Miercoles'
        UNION SELECT 'Jueves' UNION SELECT 'Viernes' UNION SELECT 'Sabado'
    ) d;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sisintupt.trg_eliminar_horarios_bloque
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `trg_eliminar_horarios_bloque` AFTER DELETE ON `bloque_horario` FOR EACH ROW BEGIN
	DELETE FROM horario 
    WHERE IdBloque = OLD.IdBloque;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sisintupt.trg_eliminar_horarios_espacio
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `trg_eliminar_horarios_espacio` AFTER DELETE ON `espacio` FOR EACH ROW BEGIN
	DELETE FROM horario 
    WHERE IdEspacio = OLD.IdEspacio;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sisintupt.trg_incrementar_intentos_fallidos
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `trg_incrementar_intentos_fallidos` AFTER UPDATE ON `usuario_auth` FOR EACH ROW BEGIN
    -- Si se incrementan los intentos fallidos y llegan a 3, bloquear por 24 horas
    IF NEW.IntentosFallidos > OLD.IntentosFallidos AND NEW.IntentosFallidos >= 3 THEN
        UPDATE usuario_auth 
        SET BloqueadoHasta = DATE_ADD(NOW(), INTERVAL 24 HOUR)
        WHERE IdAuth = NEW.IdAuth;
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sisintupt.trg_liberar_horario_curso_delete
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `trg_liberar_horario_curso_delete` AFTER DELETE ON `horario_curso` FOR EACH ROW BEGIN
    UPDATE horario 
    SET Ocupado = 0 
    WHERE IdEspacio = OLD.IdEspacio 
      AND IdBloque = OLD.IdBloque 
      AND DiaSemana = OLD.DiaSemana;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sisintupt.trg_sincronizar_estado_gestion
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `trg_sincronizar_estado_gestion` AFTER INSERT ON `reserva_gestion` FOR EACH ROW BEGIN
    DECLARE nuevo_estado VARCHAR(20);
    
    -- Convertir Accion a Estado
    CASE NEW.Accion
        WHEN 'Aprobar' THEN SET nuevo_estado = 'Aprobada';
        WHEN 'Rechazar' THEN SET nuevo_estado = 'Rechazada';
        WHEN 'Cancelar' THEN SET nuevo_estado = 'Cancelada';
        ELSE SET nuevo_estado = 'Pendiente';
    END CASE;
    
    -- Actualizar estado en reserva (esto disparará el trigger de horarios)
    UPDATE reserva 
    SET Estado = nuevo_estado 
    WHERE IdReserva = NEW.IdReserva;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
