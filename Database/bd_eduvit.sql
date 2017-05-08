CREATE DATABASE  IF NOT EXISTS `bd_eduvit` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `bd_eduvit`;
-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: localhost    Database: bd_eduvit
-- ------------------------------------------------------
-- Server version	5.7.10-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `clase`
--

DROP TABLE IF EXISTS `clase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clase` (
  `id_clase` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(50) NOT NULL,
  `resumen` varchar(255) NOT NULL,
  `no_clase` int(11) NOT NULL,
  `id_curso` int(11) NOT NULL,
  PRIMARY KEY (`id_clase`),
  KEY `fk_clase_curso_idx` (`id_curso`),
  CONSTRAINT `fk_clase_curso` FOREIGN KEY (`id_curso`) REFERENCES `curso` (`id_curso`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Almacena todas las clases en las que se divide un curso';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cuestionario`
--

DROP TABLE IF EXISTS `cuestionario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cuestionario` (
  `id_cuestionario` int(11) NOT NULL AUTO_INCREMENT,
  `no_preguntas` int(11) NOT NULL,
  `no_intentos` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_cuestionario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tipo de recurso para cuestionarios';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `curso`
--

DROP TABLE IF EXISTS `curso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `curso` (
  `id_curso` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Almacena todos los docentes que ',
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `enlace` varchar(100) NOT NULL,
  PRIMARY KEY (`id_curso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Almacena todos los cursos que estarán disponibles en la aplicación';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `curso_x_estudiante`
--

DROP TABLE IF EXISTS `curso_x_estudiante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `curso_x_estudiante` (
  `id_matricula` int(11) NOT NULL AUTO_INCREMENT,
  `id_oferta` int(11) NOT NULL,
  `id_estudiante` int(11) NOT NULL,
  `fecha_matricula` datetime NOT NULL,
  `nota_final` float DEFAULT NULL,
  PRIMARY KEY (`id_matricula`),
  KEY `fk_matricula_estudiante_idx` (`id_estudiante`),
  KEY `fk_matricula_oferta_idx` (`id_oferta`),
  CONSTRAINT `fk_matricula_estudiante` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiante` (`id_estudiante`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_matricula_oferta` FOREIGN KEY (`id_oferta`) REFERENCES `oferta` (`id_oferta`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Almacena todas las matriculas de un estudiante a un curso y permite la relacion y seguimiento del estudiante en ese curso';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `docente`
--

DROP TABLE IF EXISTS `docente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `docente` (
  `id_docente` int(11) NOT NULL AUTO_INCREMENT,
  `id_persona` int(11) NOT NULL,
  `titulo` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_docente`),
  KEY `fk_docente_persona_idx` (`id_persona`),
  CONSTRAINT `fk_docente_persona` FOREIGN KEY (`id_persona`) REFERENCES `persona` (`id_persona`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Almacena todos los docentes de la aplicacion y que pueden dictar un curso';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `documento`
--

DROP TABLE IF EXISTS `documento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documento` (
  `id_documento` int(11) NOT NULL AUTO_INCREMENT,
  `enlace` varchar(100) NOT NULL,
  PRIMARY KEY (`id_documento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tipo de recurso para un documento simple';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `estudiante`
--

DROP TABLE IF EXISTS `estudiante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estudiante` (
  `id_estudiante` int(11) NOT NULL AUTO_INCREMENT,
  `id_persona` int(11) NOT NULL,
  `promedio_acumulado` float DEFAULT NULL,
  PRIMARY KEY (`id_estudiante`),
  KEY `fk_estudiante_persona_idx` (`id_persona`),
  CONSTRAINT `fk_estudiante_persona` FOREIGN KEY (`id_persona`) REFERENCES `persona` (`id_persona`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Almacena todos los estudiantes de la aplicación';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mensaje`
--

DROP TABLE IF EXISTS `mensaje`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mensaje` (
  `id_mensaje` int(11) NOT NULL AUTO_INCREMENT,
  `id_clase` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  `mensaje` varchar(255) NOT NULL,
  `id_mensaje_origen` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_mensaje`),
  KEY `fk_mensaje_origen_idx` (`id_mensaje_origen`),
  KEY `fk_mensaje_clase_idx` (`id_clase`),
  CONSTRAINT `fk_mensaje_clase` FOREIGN KEY (`id_clase`) REFERENCES `clase` (`id_clase`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_mensaje_origen` FOREIGN KEY (`id_mensaje_origen`) REFERENCES `mensaje` (`id_mensaje`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Todos los posibles mensajes que envian los estudiantes o docentes a la clase';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nota_x_cuestionario`
--

DROP TABLE IF EXISTS `nota_x_cuestionario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nota_x_cuestionario` (
  `id_nota_x_cuestionario` int(11) NOT NULL AUTO_INCREMENT,
  `id_cuestionario` int(11) NOT NULL,
  `id_pregunta` int(11) NOT NULL,
  `id_respuesa_correcta` int(11) NOT NULL,
  `id_respuesta_elegida` int(11) NOT NULL,
  `intento` int(11) NOT NULL,
  PRIMARY KEY (`id_nota_x_cuestionario`),
  KEY `fk_nota_cuestionario_idx` (`id_cuestionario`),
  CONSTRAINT `fk_nota_cuestionario` FOREIGN KEY (`id_cuestionario`) REFERENCES `nota_x_recurso` (`id_nota`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cuando el recurso sea un cuestionario almacena la selección en cada una de las preguntas y ademas permite almacenar varios intentos de solución al cuestionario';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nota_x_recurso`
--

DROP TABLE IF EXISTS `nota_x_recurso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nota_x_recurso` (
  `id_nota` int(11) NOT NULL AUTO_INCREMENT,
  `id_matricula` int(11) NOT NULL,
  `id_estudiante` int(11) NOT NULL,
  `nota` float DEFAULT NULL,
  `comentario` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_nota`),
  KEY `fk_nota_x_recurso_recurso_idx` (`id_estudiante`),
  CONSTRAINT `fk_nota_x_recurso_estudiante` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiante` (`id_estudiante`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_nota_x_recurso_recurso` FOREIGN KEY (`id_estudiante`) REFERENCES `recurso` (`id_recurso`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Almacena todas las notas que puede obtener un estudiante para un recurso calificable';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notificacion`
--

DROP TABLE IF EXISTS `notificacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notificacion` (
  `id_notificacion` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(45) NOT NULL,
  `mensaje` longtext NOT NULL,
  `fecha_notificacion` datetime NOT NULL,
  `fecha_visto` datetime DEFAULT NULL,
  `id_usuario` int(11) NOT NULL,
  PRIMARY KEY (`id_notificacion`),
  KEY `fk_notificacion_usuario_idx` (`id_usuario`),
  CONSTRAINT `fk_notificacion_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Notificaciones realizadas a una persona';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `oferta`
--

DROP TABLE IF EXISTS `oferta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oferta` (
  `id_oferta` int(11) NOT NULL AUTO_INCREMENT,
  `id_docente` int(11) NOT NULL,
  `id_curso` int(11) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  PRIMARY KEY (`id_oferta`),
  KEY `fk_matricula_curso_idx` (`id_curso`),
  KEY `fk_matricula_docente_idx` (`id_docente`),
  CONSTRAINT `fk_matricula_curso` FOREIGN KEY (`id_curso`) REFERENCES `curso` (`id_curso`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_matricula_docente` FOREIGN KEY (`id_docente`) REFERENCES `docente` (`id_docente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Son las ofertas de los cursos que se ofrecen a los estudiantes y a los cuales se pueden matricular';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `persona`
--

DROP TABLE IF EXISTS `persona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `persona` (
  `id_persona` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(60) NOT NULL,
  `apellido` varchar(60) NOT NULL,
  `email` varchar(100) NOT NULL COMMENT 'Almacena todas las personas que tienen relación con el sitio',
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_persona`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Almacena todas las personas que tienen relación con la aplicación';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pregunta`
--

DROP TABLE IF EXISTS `pregunta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pregunta` (
  `id_pregunta` int(11) NOT NULL AUTO_INCREMENT,
  `pregunta` varchar(255) NOT NULL,
  `id_tipo_pregunta` int(11) NOT NULL,
  `valor` float NOT NULL,
  `id_cuestionario` int(11) NOT NULL,
  PRIMARY KEY (`id_pregunta`),
  KEY `fk_pregunta_cuestionario_idx` (`id_cuestionario`),
  KEY `fk_pregunta_tipo_idx` (`id_tipo_pregunta`),
  CONSTRAINT `fk_pregunta_cuestionario` FOREIGN KEY (`id_cuestionario`) REFERENCES `cuestionario` (`id_cuestionario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pregunta_tipo` FOREIGN KEY (`id_tipo_pregunta`) REFERENCES `tipo_pregunta` (`id_tipo_pregunta`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Almacena todas las pregunas de la aplicación, las cuales pueden formar parte de un cuestionario';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `presentacion`
--

DROP TABLE IF EXISTS `presentacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `presentacion` (
  `id_presentacion` int(11) NOT NULL AUTO_INCREMENT,
  `no_slides` int(11) NOT NULL,
  PRIMARY KEY (`id_presentacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tipo de recurso que agrupa otros recursos y se muestra a los estudiantes a manera de presentación de multiples slides';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recurso`
--

DROP TABLE IF EXISTS `recurso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recurso` (
  `id_recurso` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `vigencia` tinyint(1) NOT NULL COMMENT 'Determina si el recurso tiene vigencia, es decir si sólo estará activo y visible en un rango de fechas',
  `fecha_inicio` datetime DEFAULT NULL COMMENT 'Fecha en la que se inicia la vibilidad del recurso',
  `calificable` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Determina si el recurso es calificable',
  `fecha_fin` datetime DEFAULT NULL COMMENT 'Fecha en la que se termina la vibilidad del recurso',
  `id_clase` int(11) NOT NULL COMMENT 'Clase a la que pertenece el recurso',
  `id_tipo` int(11) NOT NULL COMMENT 'Tipo de recurso, según el tipo de recurso existirá una relación hacia la tabla con la información adicional para ese tipo de recurso',
  `id_recurso_x_tipo` int(11) NOT NULL COMMENT 'Relación con el registro con la información adicional segun el tipo de recurso ya seleccionado',
  `valor` float NOT NULL COMMENT 'Valor en porcentaje que representa la nota de este recurso en caso de ser calificable en la nota total del curso',
  PRIMARY KEY (`id_recurso`),
  KEY `fk_recurso_clase_idx` (`id_clase`),
  KEY `fk_recurso_tipo_idx` (`id_tipo`),
  KEY `fk_recurso_presentacion_idx` (`id_recurso_x_tipo`),
  CONSTRAINT `fk_recurso_clase` FOREIGN KEY (`id_clase`) REFERENCES `clase` (`id_clase`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_recurso_cuestionario` FOREIGN KEY (`id_recurso_x_tipo`) REFERENCES `cuestionario` (`id_cuestionario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_recurso_documento` FOREIGN KEY (`id_recurso_x_tipo`) REFERENCES `documento` (`id_documento`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_recurso_presentacion` FOREIGN KEY (`id_recurso_x_tipo`) REFERENCES `presentacion` (`id_presentacion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_recurso_tipo` FOREIGN KEY (`id_tipo`) REFERENCES `tipo_recurso` (`id_tipo_recurso`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Todos los recursos que se pueden agregar a una clase, pueden ser de varios tipos y segun el tipo tendra realación con una tabla externa que complementa su información';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `respuesta`
--

DROP TABLE IF EXISTS `respuesta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `respuesta` (
  `id_respuesta` int(11) NOT NULL AUTO_INCREMENT,
  `id_pregunta` int(11) NOT NULL,
  `respuesta` varchar(100) NOT NULL,
  `correcta` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Determin si la respuesta a la pregunta es la correcta',
  PRIMARY KEY (`id_respuesta`),
  KEY `fk_respuesta_pregunta_idx` (`id_pregunta`),
  CONSTRAINT `fk_respuesta_pregunta` FOREIGN KEY (`id_pregunta`) REFERENCES `pregunta` (`id_pregunta`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Almacena todas las posibles respuestas que puede tener una pregunta';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rol`
--

DROP TABLE IF EXISTS `rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rol` (
  `id_rol` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) NOT NULL,
  PRIMARY KEY (`id_rol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Almacena los posibles roles que puede tener un usario en la aplicación y que determina sus permisos';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `slide`
--

DROP TABLE IF EXISTS `slide`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `slide` (
  `id_slide` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(30) NOT NULL COMMENT 'Titulo que tendrá el slide',
  `parrafo` longtext COMMENT 'Posible contenido para el parrafo del slide',
  `imagen` varchar(100) DEFAULT NULL COMMENT 'Posible imagen para el slide',
  `can_back` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Establece si el estudiante puede volver atrás en este slide',
  `can_next` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Establece si el estudiante puede ir adelante en este slide',
  `can_goto` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Establece si el estudiante puede ir a cualquiera de los slides de la presentación desde este slide',
  `auto_delay` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Establece si el slide pasa automáticamente',
  `delay` int(11) DEFAULT NULL COMMENT 'Determina el tiempo en miliseguntos para hacer el autodelay del slide',
  `no_slide` int(11) NOT NULL COMMENT 'Determina el número del slide, con este número se establece el orden para presentarlos',
  `id_recurso` int(11) DEFAULT NULL COMMENT 'Posible recurso a presentar en el slide',
  `id_presentacion` int(11) NOT NULL COMMENT 'Presentación a la que pertenece el slide',
  PRIMARY KEY (`id_slide`),
  KEY `fk_slide_recurso_idx` (`id_recurso`),
  KEY `fk_slide_presentacion_idx` (`id_presentacion`),
  CONSTRAINT `fk_slide_presentacion` FOREIGN KEY (`id_presentacion`) REFERENCES `presentacion` (`id_presentacion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_slide_recurso` FOREIGN KEY (`id_recurso`) REFERENCES `recurso` (`id_recurso`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Slide de una presentación puede contener slides clasicos (titulo, parrafo, imagen) o puede a su vez presentar un recurso de otro tipo';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tipo_pregunta`
--

DROP TABLE IF EXISTS `tipo_pregunta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_pregunta` (
  `id_tipo_pregunta` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) NOT NULL,
  PRIMARY KEY (`id_tipo_pregunta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Almacena todos los posibles tipos de pregunta soportados por la aplicación';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tipo_recurso`
--

DROP TABLE IF EXISTS `tipo_recurso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_recurso` (
  `id_tipo_recurso` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) NOT NULL,
  PRIMARY KEY (`id_tipo_recurso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Todos los tipos de recurso soportados por la aplicación';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `usuario` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `id_rol` int(11) NOT NULL,
  `no_ingresos` int(11) NOT NULL,
  `id_persona` int(11) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `usuario_UNIQUE` (`usuario`),
  KEY `fk_usuario_persona_idx` (`id_persona`),
  KEY `fk_usuario_rol_idx` (`id_rol`),
  CONSTRAINT `fk_usuario_persona` FOREIGN KEY (`id_persona`) REFERENCES `persona` (`id_persona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_rol` FOREIGN KEY (`id_rol`) REFERENCES `rol` (`id_rol`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Almacena todos los usuarios que pueden tener acceso a la aplicación';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vista`
--

DROP TABLE IF EXISTS `vista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vista` (
  `id_recurso` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) NOT NULL,
  `url` varchar(100) NOT NULL,
  PRIMARY KEY (`id_recurso`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='Vistas que tiene la aplicación y sobre las cuales se puede otorgar un permiso';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vista_x_rol`
--

DROP TABLE IF EXISTS `vista_x_rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vista_x_rol` (
  `id_recurso_x_rol` int(11) NOT NULL AUTO_INCREMENT,
  `id_rol` int(11) NOT NULL,
  `id_vista` int(11) NOT NULL,
  PRIMARY KEY (`id_recurso_x_rol`),
  KEY `fk_recurso_x_rol_rol_idx` (`id_rol`),
  KEY `fk_recurso_x_rol_vista_idx` (`id_vista`),
  CONSTRAINT `fk_recurso_x_rol_rol` FOREIGN KEY (`id_rol`) REFERENCES `rol` (`id_rol`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_recurso_x_rol_vista` FOREIGN KEY (`id_vista`) REFERENCES `vista` (`id_recurso`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Vistas de la aplicación a las que puede acceder cualquier usuario perteneciente al rol';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-05-08  1:25:35
