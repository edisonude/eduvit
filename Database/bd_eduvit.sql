-- MySQL Script generated by MySQL Workbench
-- 05/10/17 01:54:56
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema bd_eduvit
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `bd_eduvit` ;

-- -----------------------------------------------------
-- Schema bd_eduvit
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bd_eduvit` DEFAULT CHARACTER SET utf8 ;
USE `bd_eduvit` ;

-- -----------------------------------------------------
-- Table `bd_eduvit`.`curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_eduvit`.`curso` (
  `id_curso` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Almacena todos los docentes que ',
  `nombre` VARCHAR(50) NOT NULL,
  `descripcion` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id_curso`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Almacena todos los cursos que estarán disponibles en la aplicación';


-- -----------------------------------------------------
-- Table `bd_eduvit`.`clase`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_eduvit`.`clase` (
  `id_clase` INT(11) NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(50) NOT NULL,
  `resumen` VARCHAR(255) NOT NULL,
  `no_clase` INT(11) NOT NULL,
  `id_curso` INT(11) NOT NULL,
  PRIMARY KEY (`id_clase`),
  INDEX `fk_clase_curso_idx` (`id_curso` ASC),
  CONSTRAINT `fk_clase_curso`
    FOREIGN KEY (`id_curso`)
    REFERENCES `bd_eduvit`.`curso` (`id_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Almacena todas las clases en las que se divide un curso';


-- -----------------------------------------------------
-- Table `bd_eduvit`.`action_cuestionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_eduvit`.`action_cuestionario` (
  `id_action` INT NOT NULL,
  `action` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id_action`))
ENGINE = InnoDB
COMMENT = 'Acciones que se pueden ejecutar en el momento que un cuestionario es terminado, puede ser ver la corrección, avanzar slide, entre otros.';


-- -----------------------------------------------------
-- Table `bd_eduvit`.`cuestionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_eduvit`.`cuestionario` (
  `id_cuestionario` INT(11) NOT NULL AUTO_INCREMENT,
  `no_preguntas` INT(11) NOT NULL,
  `no_intentos` INT(11) NOT NULL DEFAULT '1',
  `id_action_end` INT NULL COMMENT 'Acción que debe ejecutarse al finalizar el cuestionario',
  PRIMARY KEY (`id_cuestionario`),
  INDEX `fk_cuestionario_action_end_idx` (`id_action_end` ASC),
  CONSTRAINT `fk_cuestionario_action_end`
    FOREIGN KEY (`id_action_end`)
    REFERENCES `bd_eduvit`.`action_cuestionario` (`id_action`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Tipo de recurso para cuestionarios';


-- -----------------------------------------------------
-- Table `bd_eduvit`.`ciudad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_eduvit`.`ciudad` (
  `id_ciudad` INT NOT NULL AUTO_INCREMENT,
  `ciudad` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_ciudad`),
  UNIQUE INDEX `ciudad_UNIQUE` (`ciudad` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_eduvit`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_eduvit`.`persona` (
  `id_persona` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NOT NULL,
  `apellido` VARCHAR(60) NOT NULL,
  `email` VARCHAR(100) NOT NULL COMMENT 'Almacena todas las personas que tienen relación con el sitio',
  `telefono` VARCHAR(20) NULL DEFAULT NULL,
  `direccion` VARCHAR(100) NULL DEFAULT NULL,
  `id_ciudad` INT NULL,
  PRIMARY KEY (`id_persona`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  INDEX `fk_persona_ciudad_idx` (`id_ciudad` ASC),
  CONSTRAINT `fk_persona_ciudad`
    FOREIGN KEY (`id_ciudad`)
    REFERENCES `bd_eduvit`.`ciudad` (`id_ciudad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Almacena todas las personas que tienen relación con la aplicación';


-- -----------------------------------------------------
-- Table `bd_eduvit`.`estudiante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_eduvit`.`estudiante` (
  `id_estudiante` INT(11) NOT NULL AUTO_INCREMENT,
  `id_persona` INT(11) NOT NULL,
  `promedio_acumulado` FLOAT NULL DEFAULT NULL COMMENT 'Promedio de todos los cursos que haya cursado',
  PRIMARY KEY (`id_estudiante`),
  INDEX `fk_estudiante_persona_idx` (`id_persona` ASC),
  CONSTRAINT `fk_estudiante_persona`
    FOREIGN KEY (`id_persona`)
    REFERENCES `bd_eduvit`.`persona` (`id_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Almacena todos los estudiantes de la aplicación';


-- -----------------------------------------------------
-- Table `bd_eduvit`.`docente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_eduvit`.`docente` (
  `id_docente` INT(11) NOT NULL AUTO_INCREMENT,
  `id_persona` INT(11) NOT NULL,
  `titulo` VARCHAR(50) NULL DEFAULT NULL COMMENT 'Titulo académico que posee (Profesional,Maestria,Doctorado)',
  `no_cursos_dictados` INT NULL,
  PRIMARY KEY (`id_docente`),
  INDEX `fk_docente_persona_idx` (`id_persona` ASC),
  CONSTRAINT `fk_docente_persona`
    FOREIGN KEY (`id_persona`)
    REFERENCES `bd_eduvit`.`persona` (`id_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Almacena todos los docentes de la aplicacion y que pueden dictar un curso';


-- -----------------------------------------------------
-- Table `bd_eduvit`.`curso_ofertado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_eduvit`.`curso_ofertado` (
  `id_oferta` INT(11) NOT NULL AUTO_INCREMENT,
  `id_docente` INT(11) NOT NULL,
  `id_curso` INT(11) NOT NULL,
  `fecha_inicio` DATE NOT NULL,
  `fecha_fin` DATE NOT NULL,
  PRIMARY KEY (`id_oferta`),
  INDEX `fk_matricula_curso_idx` (`id_curso` ASC),
  INDEX `fk_matricula_docente_idx` (`id_docente` ASC),
  CONSTRAINT `fk_matricula_curso`
    FOREIGN KEY (`id_curso`)
    REFERENCES `bd_eduvit`.`curso` (`id_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_matricula_docente`
    FOREIGN KEY (`id_docente`)
    REFERENCES `bd_eduvit`.`docente` (`id_docente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Son las ofertas de los cursos que se ofrecen a los estudiantes y a los cuales se pueden matricular';


-- -----------------------------------------------------
-- Table `bd_eduvit`.`curso_x_estudiante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_eduvit`.`curso_x_estudiante` (
  `id_matricula` INT(11) NOT NULL AUTO_INCREMENT,
  `id_oferta` INT(11) NOT NULL,
  `id_estudiante` INT(11) NOT NULL,
  `fecha_matricula` DATETIME NOT NULL,
  `nota_final` FLOAT NULL DEFAULT NULL,
  PRIMARY KEY (`id_matricula`),
  INDEX `fk_matricula_estudiante_idx` (`id_estudiante` ASC),
  INDEX `fk_matricula_oferta_idx` (`id_oferta` ASC),
  CONSTRAINT `fk_matricula_estudiante`
    FOREIGN KEY (`id_estudiante`)
    REFERENCES `bd_eduvit`.`estudiante` (`id_estudiante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_matricula_oferta`
    FOREIGN KEY (`id_oferta`)
    REFERENCES `bd_eduvit`.`curso_ofertado` (`id_oferta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Almacena todas las matriculas de un estudiante a un curso y permite la relacion y seguimiento del estudiante en ese curso';


-- -----------------------------------------------------
-- Table `bd_eduvit`.`rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_eduvit`.`rol` (
  `id_rol` INT(11) NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_rol`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Almacena los posibles roles que puede tener un usario en la aplicación y que determina sus permisos';


-- -----------------------------------------------------
-- Table `bd_eduvit`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_eduvit`.`usuario` (
  `id_usuario` INT(11) NOT NULL AUTO_INCREMENT,
  `usuario` VARCHAR(20) NOT NULL,
  `password` VARCHAR(50) NOT NULL,
  `id_rol` INT(11) NOT NULL,
  `no_ingresos` INT(11) NOT NULL,
  `id_persona` INT(11) NOT NULL,
  `activo` TINYINT(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_usuario`),
  UNIQUE INDEX `usuario_UNIQUE` (`usuario` ASC),
  INDEX `fk_usuario_persona_idx` (`id_persona` ASC),
  INDEX `fk_usuario_rol_idx` (`id_rol` ASC),
  CONSTRAINT `fk_usuario_persona`
    FOREIGN KEY (`id_persona`)
    REFERENCES `bd_eduvit`.`persona` (`id_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_rol`
    FOREIGN KEY (`id_rol`)
    REFERENCES `bd_eduvit`.`rol` (`id_rol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Almacena todos los usuarios que pueden tener acceso a la aplicación';


-- -----------------------------------------------------
-- Table `bd_eduvit`.`mensaje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_eduvit`.`mensaje` (
  `id_mensaje` INT(11) NOT NULL AUTO_INCREMENT,
  `id_clase` INT(11) NOT NULL,
  `fecha` DATETIME NOT NULL,
  `mensaje` VARCHAR(255) NOT NULL,
  `id_mensaje_origen` INT(11) NULL,
  `id_usuario` INT NOT NULL,
  `id_curso_oferta` INT NOT NULL,
  PRIMARY KEY (`id_mensaje`),
  INDEX `fk_mensaje_origen_idx` (`id_mensaje_origen` ASC),
  INDEX `fk_mensaje_clase_idx` (`id_clase` ASC),
  INDEX `fk_mensaje_usuario_idx` (`id_usuario` ASC),
  INDEX `fk_mensaje_curso_idx` (`id_curso_oferta` ASC),
  CONSTRAINT `fk_mensaje_clase`
    FOREIGN KEY (`id_clase`)
    REFERENCES `bd_eduvit`.`clase` (`id_clase`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mensaje_origen`
    FOREIGN KEY (`id_mensaje_origen`)
    REFERENCES `bd_eduvit`.`mensaje` (`id_mensaje`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mensaje_curso`
    FOREIGN KEY (`id_curso_oferta`)
    REFERENCES `bd_eduvit`.`curso_ofertado` (`id_oferta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mensaje_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `bd_eduvit`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Todos los posibles mensajes que envian los estudiantes o docentes a la clase';


-- -----------------------------------------------------
-- Table `bd_eduvit`.`tipo_pregunta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_eduvit`.`tipo_pregunta` (
  `id_tipo_pregunta` INT(11) NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_tipo_pregunta`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Almacena todos los posibles tipos de pregunta soportados por la aplicación';


-- -----------------------------------------------------
-- Table `bd_eduvit`.`pregunta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_eduvit`.`pregunta` (
  `id_pregunta` INT(11) NOT NULL AUTO_INCREMENT,
  `pregunta` VARCHAR(255) NOT NULL,
  `id_tipo_pregunta` INT(11) NOT NULL,
  `valor` FLOAT NOT NULL,
  `id_cuestionario` INT(11) NOT NULL,
  PRIMARY KEY (`id_pregunta`),
  INDEX `fk_pregunta_cuestionario_idx` (`id_cuestionario` ASC),
  INDEX `fk_pregunta_tipo_idx` (`id_tipo_pregunta` ASC),
  CONSTRAINT `fk_pregunta_cuestionario`
    FOREIGN KEY (`id_cuestionario`)
    REFERENCES `bd_eduvit`.`cuestionario` (`id_cuestionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pregunta_tipo`
    FOREIGN KEY (`id_tipo_pregunta`)
    REFERENCES `bd_eduvit`.`tipo_pregunta` (`id_tipo_pregunta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Almacena todas las pregunas de la aplicación, las cuales pueden formar parte de un cuestionario';


-- -----------------------------------------------------
-- Table `bd_eduvit`.`respuesta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_eduvit`.`respuesta` (
  `id_respuesta` INT(11) NOT NULL AUTO_INCREMENT,
  `id_pregunta` INT(11) NOT NULL,
  `respuesta` VARCHAR(100) NOT NULL,
  `correcta` TINYINT(1) NOT NULL DEFAULT '0' COMMENT 'Determin si la respuesta a la pregunta es la correcta',
  PRIMARY KEY (`id_respuesta`),
  INDEX `fk_respuesta_pregunta_idx` (`id_pregunta` ASC),
  CONSTRAINT `fk_respuesta_pregunta`
    FOREIGN KEY (`id_pregunta`)
    REFERENCES `bd_eduvit`.`pregunta` (`id_pregunta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Almacena todas las posibles respuestas que puede tener una pregunta';


-- -----------------------------------------------------
-- Table `bd_eduvit`.`presentacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_eduvit`.`presentacion` (
  `id_presentacion` INT(11) NOT NULL AUTO_INCREMENT,
  `no_slides` INT(11) NOT NULL,
  PRIMARY KEY (`id_presentacion`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Tipo de recurso que agrupa otros recursos y se muestra a los estudiantes a manera de presentación de multiples slides';


-- -----------------------------------------------------
-- Table `bd_eduvit`.`tipo_recurso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_eduvit`.`tipo_recurso` (
  `id_tipo_recurso` INT(11) NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_tipo_recurso`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Todos los tipos de recurso soportados por la aplicación';


-- -----------------------------------------------------
-- Table `bd_eduvit`.`video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_eduvit`.`video` (
  `id_video` INT NOT NULL AUTO_INCREMENT,
  `autoplay` TINYINT(1) NOT NULL DEFAULT 0,
  `show_controls` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_video`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_eduvit`.`recurso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_eduvit`.`recurso` (
  `id_recurso` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `descripcion` VARCHAR(255) NULL DEFAULT NULL,
  `vigencia` TINYINT(1) NOT NULL COMMENT 'Determina si el recurso tiene vigencia, es decir si sólo estará activo y visible en un rango de fechas',
  `fecha_inicio` DATETIME NULL DEFAULT NULL COMMENT 'Fecha en la que se inicia la vibilidad del recurso',
  `calificable` TINYINT(1) NOT NULL DEFAULT '0' COMMENT 'Determina si el recurso es calificable',
  `fecha_fin` DATETIME NULL COMMENT 'Fecha en la que se termina la vibilidad del recurso',
  `id_clase` INT(11) NOT NULL COMMENT 'Clase a la que pertenece el recurso',
  `id_tipo` INT(11) NOT NULL COMMENT 'Tipo de recurso, según el tipo de recurso existirá una relación hacia la tabla con la información adicional para ese tipo de recurso',
  `id_recurso_x_tipo` INT(11) NOT NULL COMMENT 'Relación con el registro con la información adicional segun el tipo de recurso ya seleccionado',
  `valor` FLOAT NOT NULL COMMENT 'Valor en porcentaje que representa la nota de este recurso en caso de ser calificable en la nota total del curso',
  `enlace` VARCHAR(300) NULL COMMENT 'Enlace a un posible archivo adjunto en el recurso',
  `etiquetas` LONGTEXT NULL COMMENT 'Etiquetas para permitir una búsqueda fútura de recursos, al estilo de las etiquetas como se marca un video en youtube',
  PRIMARY KEY (`id_recurso`),
  INDEX `fk_recurso_clase_idx` (`id_clase` ASC),
  INDEX `fk_recurso_tipo_idx` (`id_tipo` ASC),
  INDEX `fk_recurso_video_idx` (`id_recurso_x_tipo` ASC),
  CONSTRAINT `fk_recurso_clase`
    FOREIGN KEY (`id_clase`)
    REFERENCES `bd_eduvit`.`clase` (`id_clase`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_recurso_cuestionario`
    FOREIGN KEY (`id_recurso_x_tipo`)
    REFERENCES `bd_eduvit`.`cuestionario` (`id_cuestionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_recurso_presentacion`
    FOREIGN KEY (`id_recurso_x_tipo`)
    REFERENCES `bd_eduvit`.`presentacion` (`id_presentacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_recurso_tipo`
    FOREIGN KEY (`id_tipo`)
    REFERENCES `bd_eduvit`.`tipo_recurso` (`id_tipo_recurso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_recurso_video`
    FOREIGN KEY (`id_recurso_x_tipo`)
    REFERENCES `bd_eduvit`.`video` (`id_video`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Todos los recursos que se pueden agregar a una clase, pueden ser de varios tipos y segun el tipo tendra realación con una tabla externa que complementa su información';


-- -----------------------------------------------------
-- Table `bd_eduvit`.`respuesta_x_recurso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_eduvit`.`respuesta_x_recurso` (
  `id_respuesta_recurso` INT NOT NULL AUTO_INCREMENT,
  `id_recurso` INT NOT NULL,
  `id_curso_estudiante` INT NOT NULL,
  `fecha_respuesta` DATETIME NOT NULL,
  `respuesta` LONGTEXT NULL,
  `archivo_respuesta` VARCHAR(300) NULL,
  `nota` FLOAT NULL,
  `comentario_nota` LONGTEXT NULL,
  `fecha_nota` DATETIME NULL,
  PRIMARY KEY (`id_respuesta_recurso`),
  INDEX `fk_respuesta_recurso_recurso_idx` (`id_recurso` ASC),
  INDEX `fk_respuesta_curso_estudiante_idx` (`id_curso_estudiante` ASC),
  CONSTRAINT `fk_respuesta_recurso_recurso`
    FOREIGN KEY (`id_recurso`)
    REFERENCES `bd_eduvit`.`recurso` (`id_recurso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_respuesta_curso_estudiante`
    FOREIGN KEY (`id_curso_estudiante`)
    REFERENCES `bd_eduvit`.`curso_x_estudiante` (`id_matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_eduvit`.`respuesta_x_cuestionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_eduvit`.`respuesta_x_cuestionario` (
  `id_respuesta_x_cuestionario` INT(11) NOT NULL AUTO_INCREMENT,
  `id_pregunta` INT(11) NOT NULL,
  `id_respuesa_correcta` INT(11) NOT NULL,
  `id_respuesta_elegida` INT(11) NOT NULL,
  `id_respuesta_x_recurso` INT NOT NULL,
  PRIMARY KEY (`id_respuesta_x_cuestionario`),
  INDEX `fk_respuesta_pregunta_idx` (`id_pregunta` ASC),
  INDEX `fk_respuesta_respuesta_correcta_idx` (`id_respuesa_correcta` ASC),
  INDEX `fk_respuesta_cuestionario_recurso_idx` (`id_respuesta_x_recurso` ASC),
  CONSTRAINT `fk_respuestaq_pregunta`
    FOREIGN KEY (`id_pregunta`)
    REFERENCES `bd_eduvit`.`pregunta` (`id_pregunta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_respuestaq_respuesta_correcta`
    FOREIGN KEY (`id_respuesa_correcta`)
    REFERENCES `bd_eduvit`.`respuesta` (`id_respuesta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_respuestaq_cuestionario_recurso`
    FOREIGN KEY (`id_respuesta_x_recurso`)
    REFERENCES `bd_eduvit`.`respuesta_x_recurso` (`id_respuesta_recurso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Cuando el recurso sea un cuestionario almacena la selección en cada una de las preguntas y ademas permite almacenar varios intentos de solución al cuestionario';


-- -----------------------------------------------------
-- Table `bd_eduvit`.`notificacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_eduvit`.`notificacion` (
  `id_notificacion` INT(11) NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NOT NULL,
  `mensaje` LONGTEXT NOT NULL,
  `fecha_notificacion` DATETIME NOT NULL,
  `fecha_visto` DATETIME NULL DEFAULT NULL,
  `id_usuario` INT(11) NOT NULL,
  PRIMARY KEY (`id_notificacion`),
  INDEX `fk_notificacion_usuario_idx` (`id_usuario` ASC),
  CONSTRAINT `fk_notificacion_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `bd_eduvit`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Notificaciones realizadas a una persona';


-- -----------------------------------------------------
-- Table `bd_eduvit`.`slide`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_eduvit`.`slide` (
  `id_slide` INT(11) NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(30) NOT NULL COMMENT 'Titulo que tendrá el slide',
  `parrafo` LONGTEXT NULL DEFAULT NULL COMMENT 'Posible contenido para el parrafo del slide',
  `imagen` VARCHAR(100) NULL DEFAULT NULL COMMENT 'Posible imagen para el slide',
  `can_back` TINYINT(1) NOT NULL DEFAULT '1' COMMENT 'Establece si el estudiante puede volver atrás en este slide',
  `can_next` TINYINT(1) NOT NULL DEFAULT '1' COMMENT 'Establece si el estudiante puede ir adelante en este slide',
  `can_goto` TINYINT(1) NOT NULL DEFAULT '1' COMMENT 'Establece si el estudiante puede ir a cualquiera de los slides de la presentación desde este slide',
  `auto_delay` TINYINT(1) NOT NULL DEFAULT '0' COMMENT 'Establece si el slide pasa automáticamente',
  `delay` INT(11) NULL DEFAULT NULL COMMENT 'Determina el tiempo en miliseguntos para hacer el autodelay del slide',
  `no_slide` INT(11) NOT NULL COMMENT 'Determina el número del slide, con este número se establece el orden para presentarlos',
  `id_recurso` INT(11) NULL DEFAULT NULL COMMENT 'Posible recurso a presentar en el slide',
  `id_presentacion` INT(11) NOT NULL COMMENT 'Presentación a la que pertenece el slide',
  PRIMARY KEY (`id_slide`),
  INDEX `fk_slide_recurso_idx` (`id_recurso` ASC),
  INDEX `fk_slide_presentacion_idx` (`id_presentacion` ASC),
  CONSTRAINT `fk_slide_presentacion`
    FOREIGN KEY (`id_presentacion`)
    REFERENCES `bd_eduvit`.`presentacion` (`id_presentacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_slide_recurso`
    FOREIGN KEY (`id_recurso`)
    REFERENCES `bd_eduvit`.`recurso` (`id_recurso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Slide de una presentación puede contener slides clasicos (titulo, parrafo, imagen) o puede a su vez presentar un recurso de otro tipo';


-- -----------------------------------------------------
-- Table `bd_eduvit`.`vista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_eduvit`.`vista` (
  `id_recurso` INT(11) NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(50) NOT NULL,
  `url` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_recurso`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8
COMMENT = 'Vistas que tiene la aplicación y sobre las cuales se puede otorgar un permiso';


-- -----------------------------------------------------
-- Table `bd_eduvit`.`vista_x_rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_eduvit`.`vista_x_rol` (
  `id_recurso_x_rol` INT(11) NOT NULL AUTO_INCREMENT,
  `id_rol` INT(11) NOT NULL,
  `id_vista` INT(11) NOT NULL,
  PRIMARY KEY (`id_recurso_x_rol`),
  INDEX `fk_recurso_x_rol_rol_idx` (`id_rol` ASC),
  INDEX `fk_recurso_x_rol_vista_idx` (`id_vista` ASC),
  CONSTRAINT `fk_recurso_x_rol_rol`
    FOREIGN KEY (`id_rol`)
    REFERENCES `bd_eduvit`.`rol` (`id_rol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_recurso_x_rol_vista`
    FOREIGN KEY (`id_vista`)
    REFERENCES `bd_eduvit`.`vista` (`id_recurso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Vistas de la aplicación a las que puede acceder cualquier usuario perteneciente al rol';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `bd_eduvit`.`action_cuestionario`
-- -----------------------------------------------------
START TRANSACTION;
USE `bd_eduvit`;
INSERT INTO `bd_eduvit`.`action_cuestionario` (`id_action`, `action`) VALUES (1, 'SHOW_CORRECTION');
INSERT INTO `bd_eduvit`.`action_cuestionario` (`id_action`, `action`) VALUES (2, 'NEXT_SLIDE_MANDATORY');
INSERT INTO `bd_eduvit`.`action_cuestionario` (`id_action`, `action`) VALUES (3, 'GENERATE_NOTIFICATION');

COMMIT;


-- -----------------------------------------------------
-- Data for table `bd_eduvit`.`ciudad`
-- -----------------------------------------------------
START TRANSACTION;
USE `bd_eduvit`;
INSERT INTO `bd_eduvit`.`ciudad` (`id_ciudad`, `ciudad`) VALUES (1, 'Medellin');
INSERT INTO `bd_eduvit`.`ciudad` (`id_ciudad`, `ciudad`) VALUES (2, 'Cali');
INSERT INTO `bd_eduvit`.`ciudad` (`id_ciudad`, `ciudad`) VALUES (3, 'Cartagena');
INSERT INTO `bd_eduvit`.`ciudad` (`id_ciudad`, `ciudad`) VALUES (4, 'Bogotá');

COMMIT;


-- -----------------------------------------------------
-- Data for table `bd_eduvit`.`persona`
-- -----------------------------------------------------
START TRANSACTION;
USE `bd_eduvit`;
INSERT INTO `bd_eduvit`.`persona` (`id_persona`, `nombre`, `apellido`, `email`, `telefono`, `direccion`, `id_ciudad`) VALUES (1, 'Admin', 'Admin', 'admin@admin.com', NULL, NULL, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `bd_eduvit`.`rol`
-- -----------------------------------------------------
START TRANSACTION;
USE `bd_eduvit`;
INSERT INTO `bd_eduvit`.`rol` (`id_rol`, `descripcion`) VALUES (1, 'Administrador');

COMMIT;


-- -----------------------------------------------------
-- Data for table `bd_eduvit`.`usuario`
-- -----------------------------------------------------
START TRANSACTION;
USE `bd_eduvit`;
INSERT INTO `bd_eduvit`.`usuario` (`id_usuario`, `usuario`, `password`, `id_rol`, `no_ingresos`, `id_persona`, `activo`) VALUES (1, 'admin', 'admin', 1, 0, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `bd_eduvit`.`tipo_pregunta`
-- -----------------------------------------------------
START TRANSACTION;
USE `bd_eduvit`;
INSERT INTO `bd_eduvit`.`tipo_pregunta` (`id_tipo_pregunta`, `descripcion`) VALUES (1, 'Selección única respuesta');

COMMIT;


-- -----------------------------------------------------
-- Data for table `bd_eduvit`.`tipo_recurso`
-- -----------------------------------------------------
START TRANSACTION;
USE `bd_eduvit`;
INSERT INTO `bd_eduvit`.`tipo_recurso` (`id_tipo_recurso`, `descripcion`) VALUES (1, 'DEFAULT');
INSERT INTO `bd_eduvit`.`tipo_recurso` (`id_tipo_recurso`, `descripcion`) VALUES (2, 'PRESENTATION');
INSERT INTO `bd_eduvit`.`tipo_recurso` (`id_tipo_recurso`, `descripcion`) VALUES (3, 'QUESTIONARY');
INSERT INTO `bd_eduvit`.`tipo_recurso` (`id_tipo_recurso`, `descripcion`) VALUES (4, 'VIDEO');

COMMIT;


-- -----------------------------------------------------
-- Data for table `bd_eduvit`.`vista`
-- -----------------------------------------------------
START TRANSACTION;
USE `bd_eduvit`;
INSERT INTO `bd_eduvit`.`vista` (`id_recurso`, `descripcion`, `url`) VALUES (1, 'all', 'all');

COMMIT;


-- -----------------------------------------------------
-- Data for table `bd_eduvit`.`vista_x_rol`
-- -----------------------------------------------------
START TRANSACTION;
USE `bd_eduvit`;
INSERT INTO `bd_eduvit`.`vista_x_rol` (`id_recurso_x_rol`, `id_rol`, `id_vista`) VALUES (1, 1, 1);

COMMIT;

