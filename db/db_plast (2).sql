-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 22-02-2019 a las 15:39:54
-- Versión del servidor: 10.1.36-MariaDB
-- Versión de PHP: 7.2.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `db_plast`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `carga_caja_xdate` (IN `ini` DATE, IN `fin` DATE)  begin
SELECT *
FROM caja_chica c WHERE date_format(c.fecha,'%Y-%m-%d') BETWEEN ini AND fin;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `carga_detallecaja_xfecha` (IN `ini` DATE, IN `fin` DATE)  begin
SELECT *
FROM detalle_caja
WHERE date_format(fecha,'%Y-%m-%d') BETWEEN ini AND fin ORDER BY tipo_entrada;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `carga_detallecaja_xidcaja` (IN `dt` INT(11))  begin
SELECT *
FROM detalle_caja
WHERE idcaja = dt ORDER BY tipo_entrada;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `filtro_prod` (`dt` INT(11), `dt1` INT(11), `dt2` CHAR(40), `dt3` TINYINT(1))  begin
CASE dt3
WHEN 1 THEN
SELECT tbp.* FROM tb_productos tbp WHERE tbp.idg=dt;
WHEN 2 THEN
SELECT tbp.* FROM tb_productos tbp WHERE tbp.idm=dt1;
WHEN 3 THEN
SELECT tbp.* FROM tb_productos tbp WHERE tbp.nom LIKE concat('%',dt2,'%') OR tbp.nomtc LIKE concat('%',dt2,'%') OR tbp.nomtm LIKE concat('%',dt2,'%');
WHEN 4 THEN
SELECT tbp.* FROM tb_productos tbp WHERE tbp.nomtm=dt1 AND tbp.nom LIKE concat('%',dt2,'%') OR tbp.nomtc LIKE concat('%',dt2,'%') OR tbp.nomtm LIKE concat('%',dt2,'%');
WHEN 5 THEN
SELECT tbp.* FROM tb_productos tbp WHERE tbp.nomtc=dt AND tbp.nom LIKE concat('%',dt2,'%') OR tbp.nomtc LIKE concat('%',dt2,'%') OR tbp.nomtm LIKE concat('%',dt2,'%');
WHEN 6 THEN
SELECT tbp.* FROM tb_productos tbp WHERE tbp.nomtc=dt AND tbp.nomtm=dt1 AND tbp.nom LIKE concat('%',dt2,'%') OR tbp.nomtc LIKE concat('%',dt2,'%') OR tbp.nomtm LIKE concat('%',dt2,'%');
WHEN 7 THEN
SELECT tbp.* FROM tb_productos tbp WHERE tbp.idg=dt AND tbp.idm=dt1;
END CASE;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getProductxId` (`idct` INT(11))  begin
  select t.* from tb_products t where t.idct=idct;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_alm` (`dt` INT(11))  begin
SELECT ida, CAST(nom as CHAR(120)) as nomes, CAST(dir as CHAR(120)) as dir, est
FROM tb_almacen
WHERE ida = dt;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_cambiodolar_curdate` ()  begin
SELECT cambio FROM tipo_cambio WHERE fecha=CURDATE() AND idmoneda=2;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_cate` (`dt` INT(11))  begin
SELECT idg, CAST(nom as CHAR(120)) as nom, est
FROM tb_categ
WHERE idg = dt;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_cliente` (`dt` INT(11))  begin
SELECT *
FROM tb_cliente
WHERE idc = dt;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_descuento_adelanto` (IN `dt` INT(11))  begin
SELECT da.id,da.idpersonal,da.fecha,da.monto,da.motivo,da.tipo,da.estado,p.nombre FROM tb_descuento_adelanto da
INNER JOIN tb_personal p on da.idpersonal=p.id
WHERE da.id = dt;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_detacompra` (`dt` INT(11))  begin
UPDATE detalle_compra SET est=2 WHERE idcompra=dt;
SELECT idct, cant FROM detalle_compra WHERE idcompra=dt;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_detaventa` (`dt` INT(11))  begin
UPDATE detalle_venta SET est=2 WHERE idventa=dt;
SELECT idct, cant FROM detalle_venta WHERE idventa=dt;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_egreso_caja` (`dt` INT(11))  begin
SELECT *
FROM detalle_caja
WHERE id = dt;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_marca` (`dt` INT(11))  begin
SELECT idm, CAST(nom as CHAR(120)) as nom, est
FROM tb_marca
WHERE idm=dt;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_permiso_personal` (IN `dt` INT(11))  begin
SELECT pp.id,pp.idpersonal,p.nombre,CONCAT(DATE_FORMAT(pp.fecha_inicio,'%m/%d/%Y %h:%i %p'),' - ',DATE_FORMAT(pp.fecha_fin,'%m/%d/%Y %h:%i %p')) as rango, DATE_FORMAT(pp.fecha_inicio,'%m/%d/%Y %h:%i %p') as ini, DATE_FORMAT(pp.fecha_fin,'%m/%d/%Y %h:%i %p') as fin,pp.n_dias,pp.observacion,pp.idtip,pp.estado 
FROM tb_permiso_personal pp
INNER JOIN tb_personal p on pp.idpersonal=p.id
WHERE pp.id = dt;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_personal` (`dt` INT(11))  begin
SELECT *
FROM tb_personal
WHERE id = dt;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_personalxnom_dni` (`dt` VARCHAR(30))  begin
SELECT *
FROM tb_personal
WHERE nombre LIKE CONCAT("%",dt,"%") OR dni LIKE CONCAT("%",dt,"%");
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_precxidprod` (`dt` INT(11))  begin
SELECT p.*
FROM tb_precio p
WHERE p.idct = dt AND p.est=1;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_prod` (`dt` INT(11))  begin
SELECT t.* FROM tb_productos t WHERE t.idct=dt;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_prod_stockA` (IN `dt` INT(11))  begin
SELECT t.*, sum(s.ct_nuevo)+sum(s.ct_averiado)+sum(s.ct_roto) as stockr FROM tb_productos t LEFT JOIN tb_stock s on t.idct=s.idct
WHERE t.idct=dt;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_prod_x_sesion` (`dt` INT(11))  begin
SELECT p.idct, p.nom, ct.idg, ct.nom as cat, s.ids, s.nom as st, pc.compra, p.est
FROM tb_catalogo p
INNER JOIN tb_categ ct ON ct.idg=p.idg
INNER JOIN tb_stand s ON s.ids=p.ids
INNER JOIN tb_precio pc ON pc.idct=p.idct
WHERE p.idct = dt;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_prov` (`dt` INT(11))  begin
SELECT *
FROM tb_proveedor
WHERE idr = dt;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_sale` (`dt` INT(11))  begin
SELECT idV, CAST(nom as CHAR(120)) as nom, dir, cell, idti, usuario, CAST(AES_DECRYPT(clave,'juans') as CHAR(30)) pass, ida, est
FROM tb_sale
WHERE idv = dt;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_stand` (`dt` INT(11))  begin
SELECT *
FROM tb_stand
WHERE ids = dt;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_tardanza_personal` (IN `dt` INT(11))  begin
SELECT tp.id,tp.idpersonal,p.nombre,tp.fecha,tp.hora_llegada,tp.monto_desc,tp.observacion,tp.tiempo_tardo,tp.estado FROM tb_tardanza_personal tp INNER JOIN tb_personal p on tp.idpersonal=p.id
WHERE tp.id=dt;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_tipo` (`dt` INT(11))  begin
SELECT idti, CAST(nom as CHAR(120)) as nomes, est
FROM tb_tip
WHERE idti = dt;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_tiposd` (`dt` INT(11))  begin
SELECT idtip, CAST(nom as CHAR(120)) as nomes, est
FROM tb_tipo
WHERE idtip = dt;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_tipo_cambio` (IN `dt` INT(11))  begin
SELECT * FROM 
tipo_cambio
WHERE id = dt;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_adelanto_descuento` (IN `dt` INT(11), IN `dt1` INT(11), IN `dt2` DATE, IN `dt3` DECIMAL(12,2), IN `dt4` TINYINT(1), IN `dt5` TEXT, IN `dt6` INT(11), IN `dt7` TINYINT(1), IN `dt8` TINYINT(1))  begin
CASE dt8
WHEN 1 THEN
INSERT INTO tb_descuento_adelanto(idpersonal, fecha, monto, tipo, motivo, idtip) VALUES(dt1, dt2, dt3, dt4, dt5, dt6);
SELECT LAST_INSERT_ID() AS id;
WHEN 2 THEN
UPDATE tb_descuento_adelanto SET idpersonal=dt1, fecha=dt2, monto=dt3, tipo=dt4, motivo=dt5, idtip=dt6, estado=dt7 WHERE id = dt;
SELECT dt AS id;
end CASE;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_alm` (`dt` INT(11), `dt1` VARCHAR(120), `dt2` VARCHAR(120), `dt3` TINYINT(1), `dt4` TINYINT(1))  begin
CASE dt4
WHEN 1 THEN
INSERT INTO tb_almacen(nom, dir, est) VALUES(dt1, dt2, dt3);
SELECT LAST_INSERT_ID() AS ida;
WHEN 2 THEN
UPDATE tb_almacen SET nom=dt1, dir=dt2, est=dt3 WHERE ida = dt;
SELECT LAST_INSERT_ID() AS ida;
end CASE;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_cate` (`dt` INT(11), `dt1` CHAR(120), `dt2` TINYINT(1), `dt3` TINYINT(1))  begin
CASE dt3
WHEN 1 THEN
if(not exists(SELECT nom FROM tb_categ WHERE nom=dt1)) then
INSERT INTO tb_categ(nom, est) VALUES(dt1, dt2);
SELECT LAST_INSERT_ID() AS idg;
else
SELECT curdate();
end if;
WHEN 2 THEN
UPDATE tb_categ SET nom=dt1, est=dt2 WHERE idg = dt;
SELECT LAST_INSERT_ID() AS idg;
end CASE;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_cliente` (`dt` INT(11), `dt1` VARCHAR(120), `dt2` CHAR(12), `dt3` ENUM('NATURAL','JURIDICA'), `dt4` VARCHAR(120), `dt5` CHAR(9), `dt6` TINYINT(1), `dt7` CHAR(30), `dt8` CHAR(30), `dt9` CHAR(30), `dt10` TINYINT(1))  begin
CASE dt10
WHEN 1 THEN
INSERT INTO tb_cliente(nom, ruc, tipo, dir, cell, est, distrito, provincia, departamento) VALUES(dt1, dt2, dt3, dt4, dt5, dt6, dt7, dt8, dt9);
SELECT LAST_INSERT_ID() AS idc;
WHEN 2 THEN
UPDATE tb_cliente SET nom=dt1, ruc=dt2, tipo=dt3, dir=dt4, cell=dt5, est=dt6, distrito=dt7, provincia=dt8, departamento=dt9 WHERE idc = dt;
SELECT LAST_INSERT_ID() AS idc;
end CASE;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_marca` (`dt` INT(11), `dt1` CHAR(120), `dt2` TINYINT(1), `dt3` TINYINT(1))  begin
CASE dt3
WHEN 1 THEN
if(not exists(SELECT nom FROM tb_marca WHERE nom = dt1))then
INSERT INTO tb_marca(nom, est) VALUES(dt1, dt2);
SELECT LAST_INSERT_ID() AS idm;
else
SELECT curdate();
end if;
WHEN 2 THEN
UPDATE tb_marca SET nom=dt1, est=dt2 WHERE idm=dt;
SELECT LAST_INSERT_ID() AS idm;
end CASE;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_mov_caja` (IN `dt1` INT(11), IN `dt2` TINYINT(1), IN `dt3` TINYINT(1), IN `dt4` VARCHAR(40), IN `dt5` VARCHAR(18), IN `dt6` DECIMAL(12,2), IN `dt7` TEXT, IN `dt8` TINYINT(1), IN `dt9` TINYINT(1), IN `dtid` INT(11), IN `dt10` TINYINT(1))  begin
CASE dt9
    WHEN 1 THEN
    INSERT INTO detalle_caja (idcaja,tipo_entrada,tipo_documento,nom_doc,num_doc,monto,observacion,desc_entrada) VALUES (dt1, dt2, dt3, dt4, dt5, dt6, dt7,dt10);
	SELECT LAST_INSERT_ID() AS id;
    WHEN 2 THEN
    UPDATE detalle_caja SET idcaja=dt1, tipo_entrada=dt2, desc_entrada=dt10, tipo_documento=dt3, nom_doc=dt4, num_doc=dt5, monto=dt6, observacion=dt7, estado=dt8 WHERE id = dtid;
    SELECT dtid AS id;
    end CASE;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_permiso_personal` (IN `dt` INT(11), IN `dt1` INT(11), IN `dt2` DATETIME, IN `dt3` DATETIME, IN `dt4` INT(11), IN `dt5` TEXT, IN `dt6` INT(11), IN `dt7` TINYINT(1), IN `dt8` TINYINT(1))  begin
CASE dt8
WHEN 1 THEN
INSERT INTO tb_permiso_personal(idpersonal, fecha_inicio, fecha_fin, n_dias, observacion, idtip, estado) VALUES(dt1, dt2, dt3, dt4, dt5, dt6, dt7);
SELECT LAST_INSERT_ID() AS id;
WHEN 2 THEN
UPDATE tb_permiso_personal SET idpersonal=dt1, fecha_inicio=dt2, fecha_fin=dt3, n_dias=dt4, observacion=dt5, idtip=dt6, estado=dt7 WHERE id = dt;
SELECT dt AS id;
end CASE;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_personal` (IN `dt` INT(11), IN `dt1` VARCHAR(100), IN `dt2` VARCHAR(10), IN `dt3` VARCHAR(150), IN `dt4` VARCHAR(10), IN `dt5` DECIMAL(12,2), IN `dt6` TINYINT(1), IN `dt7` TINYINT(1))  begin
CASE dt7
WHEN 1 THEN
if(not exists(SELECT dni FROM tb_personal WHERE dni=dt2)) then
INSERT INTO tb_personal(nombre, dni, direccion, cel, sueldo) VALUES(dt1, dt2, dt3, dt4, dt5);
SELECT LAST_INSERT_ID() AS id;
else
SELECT FALSE;
end if;
WHEN 2 THEN
if(not exists(SELECT dni FROM tb_personal WHERE dni=dt2 AND id!=dt)) THEN
UPDATE tb_personal SET nombre=dt1, dni=dt2, direccion=dt3, cel=dt4, sueldo=dt5, estado=dt6 WHERE id = dt;
SELECT dt AS idpersonal;
else
SELECT FALSE;
end if;
end CASE;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_prov` (`dt` INT(11), `dt1` VARCHAR(120), `dt2` CHAR(12), `dt3` VARCHAR(120), `dt4` CHAR(9), `dt5` CHAR(16), `dt6` VARCHAR(100), `dt7` VARCHAR(100), `dt8` TINYINT(1), `dt9` TINYINT(1))  begin
CASE dt9
WHEN 1 THEN
if(not exists(SELECT nom FROM tb_proveedor WHERE nom=dt1)) then
INSERT INTO tb_proveedor(nom, ruc, dir, cell, est) VALUES(dt1, dt2, dt3, dt4, dt8);
SELECT LAST_INSERT_ID() AS idr;
else
SELECT curdate();
end if;
WHEN 2 THEN
UPDATE tb_proveedor SET nom=dt1, ruc=dt2, dir=dt3, cell=dt4, est=dt8 WHERE idr = dt;
SELECT LAST_INSERT_ID() AS idr;
end CASE;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_sale` (IN `id` INT(11), IN `dt` VARCHAR(120), IN `dt1` VARCHAR(120), IN `dt2` CHAR(9), IN `dt3` INT(11), IN `dt4` CHAR(30), IN `dt5` CHAR(30), IN `dt6` INT(1), IN `dt7` TINYINT(1), IN `dt8` TINYINT(1))  begin
case dt8
when 1 then
INSERT INTO tb_sale VALUES (NULL, dt, dt1, dt2, dt3, dt4, aes_encrypt(dt5,'juans'), dt6, dt7);
SELECT LAST_INSERT_ID() as idv;
when 2 then
UPDATE  tb_sale SET nom=dt, dir=dt1, cell=dt2, idti=dt3, usuario=dt4, clave=aes_encrypt(dt5,'juans'), ida=dt6, est=dt7 WHERE idv = id;
SELECT LAST_INSERT_ID() as idv;
end case;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_stand` (`dt` INT(11), `dt1` CHAR(120), `dt2` TINYINT(1), `dt3` TINYINT(1))  begin
CASE dt3
WHEN 1 THEN
if(not exists(SELECT nom FROM tb_stand WHERE nom = dt1))then
INSERT INTO tb_stand(nom, est) VALUES(dt1, dt2);
SELECT LAST_INSERT_ID() AS ids;
else
SELECT curdate();
end if;
WHEN 2 THEN
UPDATE tb_stand SET nom=dt1, est=dt2 WHERE ids = dt;
SELECT LAST_INSERT_ID() AS ids;
end CASE;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_tardanza_personal` (IN `dt` INT(11), IN `dt1` INT(11), IN `dt2` DATETIME, IN `dt3` VARCHAR(7), IN `dt4` DECIMAL(12,2), IN `dt5` TEXT, IN `dt6` VARCHAR(10), IN `dt7` INT(11), IN `dt8` TINYINT(1), IN `dt9` TINYINT(1))  begin
CASE dt9
WHEN 1 THEN
INSERT INTO tb_tardanza_personal(idpersonal, fecha, hora_llegada, monto_desc, observacion, tiempo_tardo,idtip, estado) VALUES(dt1, dt2, dt3, dt4, dt5, dt6, dt7, dt8);
SELECT LAST_INSERT_ID() AS id;
WHEN 2 THEN
UPDATE tb_tardanza_personal SET idpersonal=dt1, fecha=dt2, hora_llegada=dt3, monto_desc=dt4, observacion=dt5, tiempo_tardo=dt6, idtip=dt7, estado=dt8 WHERE id = dt;
SELECT dt AS id;
end CASE;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_tipocambio` (IN `dt1` INT(11), IN `dt2` DATE, IN `dt3` DECIMAL(12,2), IN `dt4` TINYINT(1), IN `dt5` TINYINT(1), IN `dt6` INT(11))  begin
CASE dt5
WHEN 1 THEN
	if(not exists(SELECT fecha FROM tipo_cambio WHERE fecha=dt2)) then
		INSERT INTO tipo_cambio(idmoneda, fecha, cambio, estado) VALUES(dt1, dt2, dt3, dt4);
		SELECT LAST_INSERT_ID() AS id;
	else
		SELECT FALSE;
	end if;
WHEN 2 THEN
	if(not exists(SELECT fecha FROM tipo_cambio WHERE fecha=dt2 AND id!=dt6)) THEN
	UPDATE tipo_cambio SET idmoneda=dt1, fecha=dt2, cambio=dt3, estado=dt4 WHERE id = dt6;
	SELECT dt6 AS id;
	else
	SELECT FALSE;
	end if;
end CASE;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rest_cate` ()  begin
SELECT *
FROM tb_categ
WHERE est=1;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rest_cliente` ()  begin
SELECT *
FROM tb_cliente
WHERE est = 1 ORDER BY idc DESC LIMIT 5;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rest_marca` ()  begin
SELECT *
FROM tb_marca
WHERE est=1 ORDER BY nom ASC;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rest_stand` ()  begin
SELECT *
FROM tb_stand
WHERE est=1 ORDER BY nom ASC;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rest_tipo` ()  begin
SELECT *
FROM tb_tip
WHERE est = 1;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rest_tiposd` ()  begin
SELECT *
FROM tb_tipo
WHERE est = 1;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `return_cataventa` (`dt` INT(11), `dt2` INT(11), `dt3` TINYINT(1))  begin
CASE dt3
WHEN 1 THEN
UPDATE tb_catalogo SET stk=stk+dt2 WHERE idct=dt;
WHEN 2 THEN
UPDATE tb_catalogo SET stk=stk-dt2 WHERE idct=dt;
END CASE;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rows_alm` ()  begin
SELECT *
FROM tb_almacen;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rows_cate` ()  begin
SELECT *
FROM tb_categ;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rows_cliente` ()  begin
SELECT *
FROM tb_cliente;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rows_descuento_adela` ()  begin
SELECT da.id,da.idpersonal,da.fecha,da.monto,da.motivo,da.tipo,da.estado,p.nombre FROM tb_descuento_adelanto da
INNER JOIN tb_personal p on da.idpersonal=p.id WHERE da.estado!=2;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rows_descuento_adela_liquidados` ()  begin
SELECT da.id,da.idpersonal,da.fecha,da.monto,da.motivo,da.tipo,da.estado,p.nombre FROM tb_descuento_adelanto da
INNER JOIN tb_personal p on da.idpersonal=p.id WHERE da.estado=2;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rows_egreso_caja` ()  begin
SELECT *
FROM detalle_caja WHERE tipo_entrada=2;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rows_marca` ()  begin
SELECT *
FROM tb_marca;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rows_permiso_personal` ()  begin
SELECT pp.id,pp.idpersonal,p.nombre,DATE_FORMAT(pp.fecha_inicio,'%Y-%m-%d %h:%i %p') as fechainicio, DATE_FORMAT(pp.fecha_fin,'%Y-%m-%d %h:%i %p') as fecha_fin,pp.n_dias,pp.observacion,pp.idtip,pp.estado 
FROM tb_permiso_personal pp
INNER JOIN tb_personal p on pp.idpersonal=p.id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rows_personal` ()  begin
SELECT *
FROM tb_personal;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rows_prov` ()  begin
SELECT *
FROM tb_proveedor;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rows_sale` ()  begin
SELECT s.idv, s.nom, t.nom as nmt, a.ida, a.nom nma, s.est
FROM tb_sale s
INNER JOIN tb_tip t ON t.idti = s.idti
INNER JOIN tb_almacen a ON a.ida=s.ida;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rows_stand` ()  begin
SELECT *
FROM tb_stand;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rows_tardanza_liquidados_personal` ()  begin
SELECT tp.id,tp.idpersonal,p.nombre,tp.fecha,tp.hora_llegada,tp.monto_desc,tp.observacion,tp.tiempo_tardo,tp.estado FROM tb_tardanza_personal tp INNER JOIN tb_personal p on tp.idpersonal=p.id WHERE tp.estado=2;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rows_tardanza_personal` ()  begin
SELECT tp.id,tp.idpersonal,p.nombre,tp.fecha,tp.hora_llegada,tp.monto_desc,tp.observacion,tp.tiempo_tardo,tp.estado FROM tb_tardanza_personal tp INNER JOIN tb_personal p on tp.idpersonal=p.id WHERE tp.estado!=2;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rows_tipo` ()  begin
SELECT *
FROM tb_tip;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rows_tiposd` ()  begin
SELECT *
FROM tb_tipo;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rows_tipo_cambio` ()  begin
SELECT * from tipo_cambio ORDER by fecha DESC;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_add_score` (IN `_id` INT, IN `_puntaje` INT)  begin
  set @puntaje = (select puntaje_fin from tb_puntaje where id= _id) + _puntaje;
    update tb_puntaje set puntaje_fin=@puntaje where id=_id;
  insert into detalle_puntaje(puntaje_id, puntaje, est, created_at, updated_at)
    values(_id, _puntaje, 1, now(), now());
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_add_score_venta` (IN `_idclie` INT, IN `_puntaje` INT)  begin
  DECLARE _idpunt INT(11);
  
  select id into _idpunt from tb_puntaje where cliente_id= _idclie;
  IF _idpunt IS NOT NULL THEN
  	set @puntaje = (select puntaje_fin from tb_puntaje where id= _idpunt) + _puntaje;
    update tb_puntaje set puntaje_fin=@puntaje where id=_idpunt;
  	insert into detalle_puntaje(puntaje_id, puntaje, est, created_at, updated_at)
    values(_idpunt, _puntaje, 1, now(), now());
  END IF;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_adelantos_caja` (IN `ini` CHAR(10), IN `fin` CHAR(10), IN `dt` INT(11))  begin
IF ini != '' && fin != '' THEN
SELECT da.id,da.fecha, da.tipo, da.motivo, da.monto, da.estado,p.nombre,da.created_at
FROM tb_descuento_adelanto da
INNER JOIN tb_personal p on da.idpersonal=p.id
WHERE da.idtip=dt AND da.estado!=0 AND date_format(da.fecha,'%Y-%m-%d') BETWEEN ini AND fin;
ELSE
SELECT da.id,da.fecha,da.tipo,da.motivo,da.monto,da.estado, p.nombre,da.created_at
FROM tb_descuento_adelanto da 
INNER JOIN tb_personal p on da.idpersonal=p.id
WHERE da.idtip=dt AND da.estado!=0 AND date_format(da.fecha,'%Y-%m-%d') BETWEEN CURDATE() AND CURDATE();
END IF;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_caja_compras` (IN `ini` CHAR(10), IN `fin` CHAR(10), IN `dt` INT(11))  begin
IF ini != '' && fin != '' THEN
SELECT pc.fecha as fechar, tp.nom, c.num_doc, p.nom as nmprov, pc.pago, pc.est
FROM tb_ccompras pc 
INNER JOIN tb_compra c ON c.idcompra=pc.idcompra
INNER JOIN tb_tipo tp ON tp.idtip = c.idtip
INNER JOIN tb_proveedor p ON p.idr = c.idr 
WHERE pc.idv=dt AND pc.est!=3 AND pc.pago != 0.00 AND date_format(pc.fecha,'%Y-%m-%d') BETWEEN ini AND fin;
ELSE
SELECT pc.fecha as fechar, tp.nom, c.num_doc, p.nom as nmprov, pc.pago, pc.est
FROM  tb_ccompras pc 
INNER JOIN tb_compra c ON c.idcompra=pc.idcompra
INNER JOIN tb_tipo tp ON tp.idtip = c.idtip
INNER JOIN tb_proveedor p ON p.idr = c.idr
WHERE pc.idv=dt AND pc.est!=3 AND pc.pago != 0.00 AND date_format(pc.fecha,'%Y-%m-%d') BETWEEN curdate() AND curdate();
END IF;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_caja_venta` (IN `ini` CHAR(10), IN `fin` CHAR(10), IN `dt` INT(11))  begin
IF ini!='' && fin != '' THEN
SELECT date_format(cv.fecha,'%d-%m-%Y %H:%i:%s %p') as fechar, tp.nom, v.num_doc, c.nom as nmcli, c.ruc, cv.cobro as ttl, cv.utilidad scosto, cv.est
FROM tb_cventa cv
INNER JOIN tb_venta v ON v.idventa = cv.idventa
INNER JOIN tb_tipo tp ON tp.idtip = v.idtip
INNER JOIN tb_cliente c ON c.idc = v.idc
WHERE cv.idv=dt AND cv.est!=3 and date_format(cv.fecha,'%Y-%m-%d') BETWEEN ini AND fin group by cv.fecha;
ELSE
SELECT date_format(cv.fecha,'%d-%m-%Y %H:%i:%s %p') as fechar, tp.nom, v.num_doc, c.nom as nmcli, c.ruc, cv.cobro as ttl, cv.utilidad scosto, cv.est
FROM tb_cventa cv
INNER JOIN tb_venta v ON v.idventa = cv.idventa
INNER JOIN tb_tipo tp ON tp.idtip = v.idtip
INNER JOIN tb_cliente c ON c.idc = v.idc
WHERE cv.idv=dt AND cv.est!=3 AND date_format(cv.fecha,'%Y-%m-%d') BETWEEN curdate() AND curdate() group by cv.fecha;
END IF;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_calcular_descuentoxpersonal` (IN `ini` CHAR(10), IN `fin` CHAR(10), IN `dt` INT(11))  begin
	SELECT fecha, tipo, motivo, monto, estado
    FROM tb_descuento_adelanto 
    WHERE idpersonal=dt AND estado!=2 AND estado!=0 and date_format(fecha,'%Y-%m-%d') BETWEEN ini AND fin group by fecha;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_calcular_tardanzaxpersonal` (IN `ini` CHAR(10), IN `fin` CHAR(10), IN `dt` INT(11))  begin
	SELECT *
    FROM tb_tardanza_personal 
    WHERE idpersonal=dt AND estado!=2 AND estado!=0 and date_format(fecha,'%Y-%m-%d') BETWEEN ini AND fin group by fecha;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_checkPrecioxProd` (`dt` DECIMAL(12,2), `dt1` INT(11))  begin 
  declare num decimal(12,2);
  set num=(select pre1.compra
      from tb_precio pre1
      where pre1.idct=dt1 and fecha_register=(
        select max(pre2.fecha_register)
        from tb_precio pre2 where pre2.idct=pre1.idct
      ));
  if num=dt then
  select true;
  else
  select false;
  end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cierre_caja` (IN `_fecha` DATE)  begin
	/* codigo para eliminar */
    DECLARE errno INT;
    DECLARE exit handler for sqlexception
	  BEGIN
		-- ERROR
        GET CURRENT DIAGNOSTICS CONDITION 1 errno = MYSQL_ERRNO;
		SELECT FALSE AS SMS_ERROR;
	  ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
	 BEGIN
		-- WARNING
        GET CURRENT DIAGNOSTICS CONDITION 1 errno = MYSQL_ERRNO;
		SELECT FALSE AS SMS_ERROR;
	 ROLLBACK;
	END;
    
    START TRANSACTION;
        set @idcaja=(select id from caja_chica where fecha=_fecha AND estado!=2 LIMIT 1);
			
            IF @idcaja <=> NULL THEN 
                SELECT FALSE AS SMS_SUCCESS;
            ELSE 
            	UPDATE caja_chica SET estado=2 WHERE id=@idcaja;
                UPDATE detalle_caja SET estado=2 WHERE idcaja=@idcaja;
                SELECT TRUE AS SMS_SUCCESS;
            END IF;
      
    COMMIT;
	
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cierre_caja1` (IN `_id` INT(11))  begin
	/* codigo para eliminar */
    DECLARE errno INT;
    DECLARE exit handler for sqlexception
	  BEGIN
		-- ERROR
        GET CURRENT DIAGNOSTICS CONDITION 1 errno = MYSQL_ERRNO;
		SELECT FALSE AS SMS_ERROR;
	  ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
	 BEGIN
		-- WARNING
        GET CURRENT DIAGNOSTICS CONDITION 1 errno = MYSQL_ERRNO;
		SELECT FALSE AS SMS_ERROR;
	 ROLLBACK;
	END;
    
    START TRANSACTION;
        UPDATE caja_chica SET estado=2 WHERE id=_id;
        UPDATE detalle_caja SET estado=2 WHERE idcaja=_id;
        SELECT TRUE AS SMS_SUCCESS;
    COMMIT;
	
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cobro_pend` ()  begin
SELECT cv.idcc, t.nom as nmt, v.num_doc, c.nom, (v.total-cv.pendiente) as cobros, cv.pendiente, date_format(cv.fecha,'%Y-%m-%d %H:%i:%s %p'), cv.idventa, v.total
FROM tb_cventa cv
INNER JOIN tb_venta v ON v.idventa = cv.idventa
INNER JOIN tb_cliente c ON c.idc = v.idc
INNER JOIN tb_tipo t ON t.idtip = v.idtip
WHERE cv.pendiente != 0 AND cv.est = 1 GROUP BY cv.idventa;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_del_prd_xidcompra` (`dt` INT(11), OUT `sms` INT(11))  begin
declare wm decimal(12,2);
declare sum int(11);
SET sms=(SELECT idcompra FROM detalle_compra WHERE iddcompra=dt);
SET wm=(SELECT total FROM detalle_compra WHERE iddcompra=dt);

UPDATE tb_ccompras SET pendiente=pendiente-wm WHERE idcompra=sms;
UPDATE tb_compra SET total=total-wm WHERE idcompra=sms;
DELETE FROM  detalle_compra WHERE iddcompra=dt;

SET sum=(SELECT count(iddcompra) FROM detalle_compra WHERE idcompra=sms);
if(sum<=0) then
DELETE FROM tb_ccompras WHERE idcompra=sms;
DELETE FROM tb_compra WHERE idcompra=sms; 
end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_del_prd_xidventa` (`dt` INT(11), OUT `sms` INT(11))  begin
declare mts_cobro decimal(12,2);
declare i int(11);
declare wm decimal(12,2);
declare ctss int(11);
declare counts int(11);
declare wstss decimal(12,2);
declare ttlventa decimal(12,2);
declare utilddvta decimal(12,2);
declare sum int(11);
SET i=(SELECT idct FROM detalle_venta WHERE iddetalle=dt);
SET sms=(SELECT idventa FROM detalle_venta WHERE iddetalle=dt);
SET wm=(SELECT total FROM detalle_venta WHERE iddetalle=dt);
SET wstss=(SELECT costo FROM detalle_venta WHERE iddetalle=dt);
SET ctss=(SELECT cant FROM detalle_venta WHERE iddetalle=dt);

UPDATE tb_venta SET total=total-wm WHERE idventa=sms;
DELETE FROM  detalle_venta WHERE iddetalle=dt;
UPDATE tb_catalogo SET stk=stk+ctss WHERE idct=i;

SET counts=(SELECT count(idcc) FROM tb_cventa WHERE idventa=sms);
SET mts_cobro=(SELECT SUM(cobro) FROM tb_cventa WHERE idventa=sms);

if(counts=1 and mts_cobro=0) then
SET ttlventa=(SELECT total FROM tb_venta WHERE idventa=sms);
SET utilddvta=(SELECT sum(costo) FROM detalle_venta WHERE idventa=sms);

UPDATE tb_cventa SET pendiente=ttlventa, utilidad=utilddvta, est=1  WHERE idventa=sms;
end if;

if(counts=1 and mts_cobro!=0) then
SET ttlventa=(SELECT total FROM tb_venta WHERE idventa=sms);
SET utilddvta=(SELECT sum(costo) FROM detalle_venta WHERE idventa=sms);

UPDATE tb_cventa SET cobro=0, pendiente=ttlventa, utilidad=utilddvta, est=1 WHERE idventa=sms;
end if;

if(counts>=2 and mts_cobro!=0) then
UPDATE tb_venta SET total=total-wm WHERE idventa=sms;
DELETE FROM  detalle_venta WHERE iddetalle=dt;
UPDATE tb_catalogo SET stk=stk+ctss WHERE idct=i;

SET ttlventa=(SELECT total FROM tb_venta WHERE idventa=sms);
SET utilddvta=(SELECT sum(costo) FROM detalle_venta WHERE idventa=sms);

DELETE FROM  tb_cventa WHERE cobro!=0 AND idventa=sms;
UPDATE tb_cventa SET cobro=0, pendiente=ttlventa, utilidad=utilddvta, est=1  WHERE cobro=0 AND idventa=sms;
end if;

SET sum=(SELECT count(iddetalle) FROM detalle_venta WHERE idventa=sms);
if(sum<=0) then
DELETE FROM tb_cventa WHERE idventa=sms;
DELETE FROM tb_venta WHERE idventa=sms; 
end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_det_compra_xid` (`dt` INT(11))  begin
SELECT tbp.nom, tbp.nomtc, tbp.nomta, tbp.unid, dt.cant, dt.precio, dt.total, tbp.idct, dt.iddcompra
FROM detalle_compra dt
INNER JOIN tb_productos tbp ON tbp.idct=dt.idct
WHERE dt.idcompra = dt;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_det_venta_xid` (`dt` INT(11))  begin
SELECT tbp.nom, tbp.nomtm, dt.cant, dt.precio, dt.costo, dt.total, tbp.unid, tbp.idct, dt.iddetalle, tbp.nomtc
FROM detalle_venta dt
INNER JOIN tb_productos tbp ON tbp.idct=dt.idct
WHERE dt.idventa = dt;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_disminuir_stock_nuevo` (`_id` INT, `_disminuir` INT, `_opc` INT)  begin
  case _opc
    when 1 then
    if (select count(ct_nuevo)> 0 from tb_stock where idct=_id) then
      set @n = (select ct_nuevo from tb_stock where idct=_id) - _disminuir;
      update tb_stock set ct_nuevo=@n where idct=_id;
    end if;
    end case;
  
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Gen_venta` (OUT `p_codigo_sec` VARCHAR(10))  BEGIN
    DECLARE contador INT;
    BEGIN
        SET contador= (SELECT COUNT(*)+1 FROM tb_venta); 
        
        IF(contador<10)THEN
    SET p_codigo_sec= CONCAT('000000',contador);
      ELSE IF(contador<100) THEN
      SET p_codigo_sec= CONCAT('00000',contador);
        ELSE IF(contador<1000)THEN
        SET p_codigo_sec= CONCAT('0000',contador);
          ELSE IF(contador<10000)THEN
          SET p_codigo_sec= CONCAT('000',contador);
            ELSE IF(contador<100000)THEN
            SET p_codigo_sec= CONCAT('00',contador);
              ELSE IF(contador<1000000)THEN
              SET p_codigo_sec= CONCAT('0',contador);
              END IF;
                        END IF;
                    END IF;
                END IF;
            END IF;
        END IF; 
    END;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getbuys_xid` (`dt` INT(11))  begin
SELECT c.idcompra, date_format(c.fecha,'%Y-%m-%d %H:%i:%s %p') fchar, c.num_doc, t.nom, p.nom nomp, s.nom noms, c.total, c.est
FROM tb_compra c
INNER JOIN tb_tipo t ON t.idtip=c.idtip
INNER JOIN tb_proveedor p ON p.idr=c.idr
INNER JOIN tb_sale s ON s.idv=c.idv
WHERE c.idcompra=dt;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getdtbuys_xid` (`dt` INT(11))  begin
SELECT tbp.nom, tbp.nomtc, tbp.nomtm, tbp.unid, c.cant, c.precio, c.total, tbp.nomta, ta.dir
FROM detalle_compra c
INNER JOIN tb_productos tbp ON tbp.idct=c.idct
INNER JOIN tb_almacen ta ON ta.ida=tbp.ida
WHERE c.idcompra=dt;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getdtsales_xid` (`dt` INT(11), `dt1` TINYINT(1))  begin
CASE dt1
WHEN 1 THEN
SELECT tbp.nomtc, tbp.nom, tbp.nomtm, tbp.unid, c.cant, c.precio, c.total, tbp.idct
FROM detalle_venta c
INNER JOIN tb_productos tbp ON tbp.idct=c.idct
WHERE c.idventa=dt;
WHEN 2 THEN
SELECT tv.est FROM tb_venta tv WHERE tv.idventa=dt;
END CASE;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getmontoscobros_xid` (`dt` INT(11))  begin
SELECT SUM(c.cobro), v.total
FROM tb_cventa c
INNER JOIN tb_venta v ON v.idventa=c.idventa
WHERE c.idventa=dt;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getProductXIdXDis` (IN `id` INT)  begin
  select concat(tg.nom , ' ', cast(tc.nom AS CHAR (120) CHARSET UTF8)) as nombre,
  tc.unid, tc.stk, ta.nom as almacen, tc.idct
  from tb_catalogo tc
  inner join tb_categ tg on tg.idg=tc.idg
  inner join  tb_almacen ta on ta.ida=tc.ida
  where tc.idct=id and tc.stk_min=1;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getrest_alm` (`dt` INT(11))  begin
SELECT *
FROM tb_almacen
WHERE est = 1 AND ida!=dt;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getsales_xid` (`dt` INT(11))  begin
SELECT c.idventa, date_format(c.fecha,'%Y-%m-%d %H:%i:%s %p') fchar, c.num_doc, t.nom, p.nom nomp, s.nom noms, c.total, c.est, a.nom noma, a.dir, p.idc
FROM tb_venta c
INNER JOIN tb_tipo t ON t.idtip=c.idtip
INNER JOIN tb_cliente p ON p.idc=c.idc
INNER JOIN tb_sale s ON s.idv=c.idv
INNER JOIN tb_almacen a ON a.ida=s.ida
WHERE c.idventa=dt;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_gets_depart` ()  begin
SELECT *
FROM departamento;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_compras_contable` (`dt` CHAR(10), `dt1` CHAR(10), `dt2` INT(11))  begin
SELECT date_format(v.fecha,'%Y-%m-%d %H:%i:%s %p') fechar, t.nom as tnom, v.num_doc, c.ruc, c.nom cnom, v.total, v.est, v.idcompra
FROM tb_compra v
INNER JOIN tb_tipo t ON t.idtip=v.idtip
INNER JOIN tb_proveedor c ON c.idr=v.idr
WHERE date_format(v.fecha,'%Y-%m-%d') BETWEEN dt AND dt1 AND v.idv=dt2;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_compras_x_idsale` (IN `dt` CHAR(10), IN `dt1` CHAR(10), IN `dt2` INT(11))  begin
if dt!='' && dt1!= '' THEN
SELECT v.idcompra,  t.nom, v.num_doc, date_format(v.fecha,'%d-%m-%Y %H:%i:%s %p') fchar, c.nom as nmcli, v.total, v.idtipomoneda, v.total_soles
FROM tb_compra v
INNER JOIN tb_tipo t ON t.idtip=v.idtip
INNER JOIN tb_proveedor c ON c.idr=v.idr
WHERE date_format(v.fecha,'%Y-%m-%d') BETWEEN dt AND dt1 AND v.idv = dt2;
else
SELECT v.idcompra,  t.nom, v.num_doc, date_format(v.fecha,'%d-%m-%Y %H:%i:%s %p') fchar, c.nom as nmcli, v.total, v.idtipomoneda, v.total_soles
FROM tb_compra v
INNER JOIN tb_tipo t ON t.idtip=v.idtip
INNER JOIN tb_proveedor c ON c.idr=v.idr
WHERE date_format(v.fecha,'%Y-%m-%d') BETWEEN curdate() AND curdate() AND  v.idv = dt2;
end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_precioxprd` (`dt` INT(11), `dt1` TINYINT(1))  begin
CASE dt1
WHEN 1 THEN
SELECT * FROM tb_stock WHERE idct=dt;
WHEN 2 THEN
SELECT stk FROM tb_catalogo WHERE idct=dt;
END CASE;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_products_not_dist` ()  begin
  select concat(tg.nom , ' ', cast(tc.nom AS CHAR (120) CHARSET UTF8)) as nombre,
  tc.unid, tc.stk, ta.nom as almacen, tc.idct, tc.opcdistri
  from tb_catalogo tc
  inner join tb_categ tg on tg.idg=tc.idg
  inner join  tb_almacen ta on ta.ida=tc.ida
  where tc.stk_min=1;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_ventas_contable` (`dt` CHAR(10), `dt1` CHAR(10), `dt2` INT(11))  begin
SELECT date_format(v.fecha,'%Y-%m-%d %H:%i:%s %p') fechar, t.nom as tnom, v.num_doc, c.ruc, c.nom cnom, v.total, v.est, v.idventa
FROM tb_venta v
INNER JOIN tb_tipo t ON t.idtip=v.idtip
INNER JOIN tb_cliente c ON c.idc=v.idc
WHERE date_format(v.fecha,'%Y-%m-%d') BETWEEN dt AND dt1 AND v.idv=dt2;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_ventas_x_idsale` (`dt` CHAR(10), `dt1` CHAR(10), `dt2` INT(11))  begin
if dt!='' && dt1!= '' THEN
SELECT v.idventa,  t.nom, v.num_doc, date_format(v.fecha,'%d-%m-%Y %H:%i:%s %p') fchar, c.nom nmcli, v.total, v.est, t.idtip
FROM tb_venta v
INNER JOIN tb_tipo t ON t.idtip=v.idtip
INNER JOIN tb_cliente c ON c.idc=v.idc
WHERE date_format(v.fecha,'%Y-%m-%d') BETWEEN dt AND dt1 AND v.idv = dt2;
else
SELECT v.idventa,  t.nom, v.num_doc, date_format(v.fecha,'%d-%m-%Y %H:%i:%s %p') fchar, c.nom nmcli, v.total, v.est, t.idtip
FROM tb_venta v
INNER JOIN tb_tipo t ON t.idtip=v.idtip
INNER JOIN tb_cliente c ON c.idc=v.idc
WHERE date_format(v.fecha,'%Y-%m-%d') BETWEEN curdate() AND curdate() AND  v.idv = dt2;
end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_idetalle_distribuir` (`dt` INT(11), OUT `nums` INT(11), `opc` INT)  begin
  case opc
  when 1 then
    SET nums=(SELECT count(dc.idcompra)
    FROM detalle_compra dc
    WHERE dc.idcompra=dt AND dc.tstk=1);
  when 2 then
    select tc.nom, tg.nom as nomg, tc.unid, 
    dc.idcompra, dc.idct, dc.cant, dc.total, dc.iddcompra
    from detalle_compra dc
    inner join tb_catalogo tc on dc.idct=tc.idct
    inner join tb_categ tg on tg.idg=tc.idg
    where idcompra=dt and tstk=1;
  end case;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_iniciar_caja` (IN `dt` INT(11), IN `dt1` DATE, IN `dt2` DECIMAL(12,2))  BEGIN
if(not exists(SELECT fecha from caja_chica WHERE estado=1)) then
INSERT INTO caja_chica (ids,fecha,saldo_inicial,saldo_actual) VALUES (dt,dt1,dt2,0.00);
SELECT LAST_INSERT_ID() AS id;
else
SELECT 0;
end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_init_puntaje` (`_puntaje_id` INT, `_puntaje_ini` INT, `_puntaje_fin` INT)  begin
 update tb_puntaje set puntaje_ini= _puntaje_ini,
 puntaje_fin=_puntaje_fin where id=_puntaje_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_liquidar_descuentoxpersonal` (IN `ini` CHAR(10), IN `fin` CHAR(10), IN `dt` INT(11))  begin
	UPDATE tb_descuento_adelanto SET estado=2
    WHERE idpersonal=dt AND estado!=2 and date_format(fecha,'%Y-%m-%d') BETWEEN ini AND fin;
    UPDATE tb_tardanza_personal SET estado=2
    WHERE idpersonal=dt AND estado!=2 and date_format(fecha,'%Y-%m-%d') BETWEEN ini AND fin;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_login` (`dt` CHAR(20), `dt1` CHAR(30))  begin
SELECT s.idv, s.nom, s.ida, s.usuario, CAST(aes_decrypt(s.clave,'juans') as CHAR(30)) AS clave, t.idti, s.est
FROM tb_sale s
INNER JOIN tb_tip t ON t.idti=s.idti
WHERE s.usuario = dt
AND CAST(AES_DECRYPT(s.clave,'juans') AS char(30)) = dt1;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_look_cliente` (`dt` CHAR(30))  begin
SELECT *
FROM tb_cliente
WHERE nom LIKE concat('%',dt,'%') OR ruc LIKE concat('%',dt,'%') ORDER BY idc DESC LIMIT 8;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_look_provee` (`dt` CHAR(30))  begin
SELECT *
FROM tb_proveedor
WHERE nom LIKE concat('%',dt,'%') OR ruc LIKE concat('%',dt,'%') ORDER BY idr DESC LIMIT 8;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_look_puntaje_cliente` (`dt` INT(11))  begin
SELECT * FROM tb_puntaje WHERE cliente_id=dt LIMIT 1;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_monto_adelantos_caja` (IN `ini` CHAR(10), IN `fin` CHAR(10), IN `dt` INT(11))  begin
IF ini != '' && fin != '' THEN
SELECT SUM(da.monto)
FROM tb_descuento_adelanto da
WHERE da.idtip=dt AND da.estado!=0 AND date_format(da.fecha,'%Y-%m-%d') BETWEEN ini AND fin;
ELSE
SELECT SUM(da.monto)
FROM tb_descuento_adelanto da 
WHERE da.idtip=dt AND da.estado!=0 AND date_format(da.fecha,'%Y-%m-%d') BETWEEN CURDATE() AND CURDATE();
END IF;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_monto_compra` (`ini` CHAR(10), `fin` CHAR(10), `dt` INT(11))  begin
IF ini != '' && fin != '' THEN
SELECT c.fecha, SUM(c.pago) as ttl
FROM tb_ccompras c
WHERE c.idv=dt AND date_format(c.fecha,'%Y-%m-%d') BETWEEN ini AND fin;
ELSE
SELECT c.fecha, SUM(c.pago) as ttl
FROM tb_ccompras c
WHERE c.idv=dt AND date_format(c.fecha,'%Y-%m-%d') BETWEEN CURDATE() AND CURDATE();
END IF;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_monto_descuentoxpersonal` (IN `ini` CHAR(10), IN `fin` CHAR(10), IN `dt` INT(11))  begin
	SELECT SUM(monto) as ttl
    FROM tb_descuento_adelanto
    WHERE idpersonal=dt AND estado!=2 AND date_format(fecha,'%Y-%m-%d') BETWEEN ini AND fin;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_monto_tardanzaxpersonal` (IN `ini` CHAR(10), IN `fin` CHAR(10), IN `dt` INT(11))  begin
	SELECT SUM(monto_desc) as ttl
    FROM tb_tardanza_personal 
    WHERE idpersonal=dt AND estado!=2 and date_format(fecha,'%Y-%m-%d') BETWEEN ini AND fin group by fecha;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_monto_venta` (IN `ini` CHAR(10), IN `fin` CHAR(10), IN `dt` INT(11))  begin
IF ini != '' && fin != '' THEN
SELECT c.fecha, SUM(c.cobro) as ttl
FROM tb_cventa c
WHERE c.idv=dt AND c.est!=2 AND date_format(c.fecha,'%Y-%m-%d') BETWEEN ini AND fin;
ELSE
SELECT c.fecha, SUM(c.cobro) as ttl
FROM tb_cventa c
WHERE c.idv=dt AND c.est!=2 AND date_format(c.fecha,'%Y-%m-%d') BETWEEN CURDATE() AND CURDATE();
END IF;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pago_pend` ()  begin
SELECT cv.idpago, t.nom as nmt, v.num_doc, c.nom, (v.total_soles-cv.pendiente), cv.pendiente, date_format(cv.fecha,'%Y-%m-%d %H:%i:%s %p'), cv.idcompra, v.total_soles,ccuota.id FROM tb_ccompras cv INNER JOIN tb_compra v ON v.idcompra = cv.idcompra INNER JOIN tb_proveedor c ON c.idr = v.idr INNER JOIN tb_tipo t ON t.idtip = v.idtip LEFT JOIN tb_compracuotas ccuota ON v.idcompra=ccuota.idpago WHERE cv.est=1 GROUP BY cv.idpago;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_proc_stock` (`dt` INT(11), `dt1` INT(11), `dt2` INT(11), `dt3` INT(11), `dt4` INT(11), `dt5` INT(11), `dt6` DATETIME, `dt7` TINYINT(1), `dt8` TINYINT(1))  BEGIN
CASE dt8
WHEN 1 THEN
INSERT INTO tb_stock VALUES(dt, dt1, dt2, dt3, dt4, dt5, dt6, dt7);
SELECT LAST_INSERT_ID() as id_stock;
WHEN 2 THEN
UPDATE tb_stock SET ct_nuevo=dt3, ct_averiado=dt4, ct_roto=dt5, fecha=now()  WHERE id_stock=dt;
SELECT LAST_INSERT_ID() as id_stock;
END CASE;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_proc_stock_2` (IN `dt1` INT, IN `dt3` INT, IN `dt4` INT, IN `dt5` INT, IN `dt6` INT, IN `dt7` DATETIME, IN `dt8` TINYINT(1), IN `dt2` INT)  begin 
  if not exists(select * from tb_stock where idct=dt1) then
    insert into tb_stock
      values(null, dt1, dt3, dt4, dt5, dt6, dt7, dt8);
  else
    set @nn=(select ct_nuevo from tb_stock where idct=dt1) + dt4;
        set @aa=(select ct_averiado from tb_stock where idct=dt1) + dt5;
        set @rr=(select ct_roto from tb_stock where idct=dt1) + dt6;

    update tb_stock set id_alm=dt3, ct_nuevo=@nn, ct_averiado=@aa, ct_roto=@rr,
        fecha=dt7, est=dt8 where idct=dt1;
        
    end if;
    update detalle_compra set tstk=0 
        where iddcompra=dt2 and idct=dt1;
    select idcompra from detalle_compra 
    where iddcompra=dt2 and idct=dt1;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_reestableciendo_puntaje` (`_id` INT, `_puntos` INT, `opc` INT)  begin
  case opc
    when 1 then
    set @ini=(select puntaje_ini from tb_puntaje where id=_id) - _puntos;
    update tb_puntaje set puntaje_ini=@ini, puntaje_fin=@ini where id=_id;
  when 2 then
    set @ini=(select puntaje_ini from tb_puntaje where id=_id) + _puntos;
    update tb_puntaje set puntaje_fin=@ini where id=_id;
    end case; 
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_register_oferta` (`_catalogo_id` INT, `_puntaje_id` INT, `_total` INT, `_gastar` INT)  begin
  insert into tb_oferta(catalogo_id, puntaje_id, total, gastar, est, created_at, updated_at)
    values(_catalogo_id, _puntaje_id, _total, _gastar, 1, now(), now());
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_register_puntaje` (`cli_id` INT, `punt_ini` INT, `punt_fin` INT)  begin
  if not exists(select * from tb_puntaje where cliente_id=cli_id) then
    insert into tb_puntaje 
        values(null, cli_id, punt_ini, punt_fin, 1, now(), now());
    else 
    select false;
    end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_reg_buypay` (IN `st` INT(11), IN `st1` INT(11), IN `st2` DECIMAL(12,7), IN `st3` DECIMAL(12,7), IN `st4` DATETIME, IN `st5` INT(11), IN `st6` TINYINT(1), IN `st7` TINYINT(1), IN `st8` VARCHAR(20), IN `st9` DECIMAL(12,7), IN `st10` DECIMAL(12,7), IN `st11` INT(11))  begin
DECLARE idcuota INT;
DECLARE _iddcuota INT;
CASE st7
WHEN 1 THEN
INSERT INTO tb_ccompras VALUES(null, st1, st2, st3, st4, st5, 1);
SELECT LAST_INSERT_ID() AS idpago;
WHEN 2 THEN
UPDATE tb_ccompras SET est=0 WHERE idpago = st;
INSERT INTO tb_ccompras VALUES(null, st1, st2, st3, st4, st5, 1);

SELECT id INTO idcuota FROM tb_compracuotas where idpago=st1;
# SELECT id INTO _iddcuota FROM tb_detalle_cuota where monto=st2 AND idccuota=idcuota AND estado=0 LIMIT 1;
UPDATE tb_detalle_cuota SET estado = 1, codigounico=st8,montopagado=st9,montointeres=st10 WHERE id = st11;
SELECT LAST_INSERT_ID() AS idpago;
end CASE;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_reg_catalogo` (IN `dt` INT(11), IN `dt1` VARCHAR(120), IN `dt2` VARCHAR(120), IN `dt3` VARCHAR(120), IN `dt4` INT(11), IN `dt5` INT(11), IN `dt6` INT(11), IN `dt7` INT(11), IN `dt8` ENUM('UNIDAD','DOCENA','BOLSA','SET','JUEGO'), IN `dt9` INT(11), IN `dt10` INT(11), IN `dt11` TINYINT(1), IN `dt12` TINYINT(1))  begin
CASE dt12
WHEN 1 THEN 
INSERT INTO tb_catalogo VALUES(NULL, dt1, dt2, dt3, dt4, dt5, dt6, dt7, dt8, dt9, dt10, 1,1);
SELECT LAST_INSERT_ID() AS idct;
WHEN 2 THEN
UPDATE tb_catalogo SET cod_barra=dt1, nom=dt2, imagen=dt3, ida=dt4, idg=dt5, idm=dt6, ids=dt7, unid=dt8, stk=dt9, stk_min=dt10, est=dt11 WHERE idct=dt;
SELECT LAST_INSERT_ID() AS idct;
WHEN 3 THEN
case dt11
when 1 then
UPDATE tb_stock SET ct_nuevo=ct_nuevo-dt9 WHERE idct=dt;
SELECT LAST_INSERT_ID() AS idct;
when 2 then
UPDATE tb_stock SET ct_averiado=ct_averiado-dt9 WHERE idct=dt;
SELECT LAST_INSERT_ID() AS idct;
when 3 then
UPDATE tb_stock SET ct_roto=ct_roto-dt9 WHERE idct=dt;
SELECT LAST_INSERT_ID() AS idct;
end case;
WHEN 4 THEN
case dt11
when 1 then
UPDATE tb_stock SET ct_nuevo=ct_nuevo+dt9 WHERE idct=dt;
SELECT LAST_INSERT_ID() AS idct;
when 2 then
UPDATE tb_stock SET ct_averiado=ct_averiado+dt9 WHERE idct=dt;
SELECT LAST_INSERT_ID() AS idct;
when 3 then
UPDATE tb_stock SET ct_roto=ct_roto+dt9 WHERE idct=dt;
SELECT LAST_INSERT_ID() AS idct;
end case;
END CASE;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_reg_compra` (IN `dt` INT(11), IN `dt1` DATETIME, IN `dt2` CHAR(12), IN `dt3` INT(11), IN `dt4` INT(11), IN `dt5` INT(11), IN `dt6` DECIMAL(12,7), IN `dt7` TINYINT(1), IN `dt8` TINYINT(1), IN `dt9` INT(11), IN `dt10` DECIMAL(12,7))  begin
CASE dt8 
WHEN 1 THEN
    INSERT INTO tb_compra VALUES(NULL, dt1, dt2, dt3, dt4, dt5, dt6, 1,dt9, dt10);
    SELECT LAST_INSERT_ID() AS idcompra;
WHEN 2 THEN
UPDATE tb_compra SET fecha=dt1, num_doc=dt2, idtip=dt3, idr=dt4, idv=dt5, total=dt6, est=dt7, idtipomoneda=dt9, total_soles=dt10 WHERE idcompra=dt;
SELECT LAST_INSERT_ID() AS idcompra;
WHEN 3 THEN
UPDATE tb_compra SET est=2 WHERE idcompra=dt;
SELECT LAST_INSERT_ID() AS idcompra;
END CASE;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_reg_detacompra` (IN `dt` INT(11), IN `dt1` INT(11), IN `dt2` INT(11), IN `dt3` INT(11), IN `dt4` DECIMAL(12,7), IN `dt5` DECIMAL(12,7), IN `dt6` DECIMAL(12,7), IN `dt7` DECIMAL(12,7), IN `dt8` TINYINT(1), IN `dt9` TINYINT(1), IN `dt10` TINYINT(1))  begin
CASE dt10
WHEN 1 THEN
INSERT INTO detalle_compra VALUES(NULL, dt1, dt2, dt3, dt4, dt5, dt6, dt7, 1, dt9);
SELECT LAST_INSERT_ID() AS iddcompra;
WHEN 2 THEN
UPDATE detalle_compra SET idcompra=dt1, idct=dt2, cant=dt3, precio=dt4, subtotal=dt5, igv=dt6, total=dt7, est=dt8, tstk=dt9 WHERE iddcompra=dt;
SELECT LAST_INSERT_ID() AS iddcompra;
END CASE;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_reg_detaventa` (`dt` INT(11), `dt1` INT(11), `dt2` INT(11), `dt3` INT(11), `dt4` DECIMAL(12,2), `dt5` DECIMAL(12,2), `dt6` DECIMAL(12,2), `dt7` DECIMAL(12,2), `dt8` DECIMAL(12,2), `dt9` TINYINT(1), `dt10` TINYINT(1), `dt11` TINYINT(1))  begin
CASE dt11
WHEN 1 THEN
INSERT INTO detalle_venta VALUES(NULL, dt1, dt2, dt3, dt4, dt5, dt6, dt7, dt8, 1, dt10);
SELECT LAST_INSERT_ID() AS iddetalle;
WHEN 2 THEN
UPDATE detalle_venta SET idventa=dt1, idct=dt2, cant=dt3, precio=dt4, costo=dt5, subtotal=dt6, igv=dt7, total=dt8, est=dt9, tstk=dt10 WHERE iddetalle=dt;
SELECT LAST_INSERT_ID() AS iddetalle;
END CASE;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_reg_paycompra` (IN `dt` INT(11), IN `dt1` INT(11), IN `dt2` DECIMAL(12,7), IN `dt3` DECIMAL(12,7), IN `dt4` DATETIME, IN `dt5` INT(11), IN `dt6` TINYINT(1), IN `dt7` TINYINT(1))  begin
CASE dt7
WHEN 1 THEN
INSERT INTO tb_ccompras VALUES(NULL, dt1, dt2, dt3, dt4, dt5, dt6);
SELECT LAST_INSERT_ID() AS idpago;
WHEN 2 THEN
UPDATE tb_ccompras SET pago=dt2, pendiente=dt3, fecha=dt4, idv=dt5, est=dt6 WHERE idpago=dt;
SELECT LAST_INSERT_ID() AS idpago;
WHEN 3 THEN
UPDATE tb_ccompras SET pago=dt2, pendiente=dt3, fecha=dt4, idv=dt5, est=dt6 WHERE idpago=dt;
SELECT LAST_INSERT_ID() AS idpago;
END CASE;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_reg_payventa` (`dt` INT(11), `dt1` INT(11), `dt2` DECIMAL(12,2), `dt3` DECIMAL(12,2), `dt4` DECIMAL(12,2), `dt5` DATETIME, `dt6` INT(11), `dt7` TINYINT(1), `dt8` TINYINT(1))  begin
CASE dt8 
WHEN 1 THEN
INSERT INTO tb_cventa VALUES(NULL, dt1, dt2, dt3, dt4, dt5, dt6, 1);
SELECT LAST_INSERT_ID() AS idcc;
WHEN 2 THEN
UPDATE tb_cventa SET est=0 WHERE idcc = dt;
INSERT INTO tb_cventa VALUES(null, dt1, dt2, dt3, dt4, dt5, dt6, 1);
SELECT LAST_INSERT_ID() AS idcc;
WHEN 3 THEN
UPDATE tb_cventa SET utilidad=0, est=2 WHERE idventa = dt1;
SELECT LAST_INSERT_ID() AS idcc;
END CASE;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_reg_precio` (IN `dt` INT(11), IN `dt1` INT(11), IN `dt2` DECIMAL(12,7), IN `dt3` DECIMAL(12,2), IN `dt4` DECIMAL(12,2), IN `dt5` DECIMAL(12,2), IN `dt6` DECIMAL(12,2), IN `dt7` DECIMAL(12,2), IN `dt8` DECIMAL(12,2), IN `dt9` TINYINT(1), IN `dt10` TINYINT(1))  begin
declare cpr decimal(12,2);
CASE dt10
WHEN 1 THEN
INSERT INTO tb_precio VALUES(NULL, dt1, dt2, dt3, dt4, dt5, dt6, dt7, dt8, 1);
SELECT LAST_INSERT_ID() AS idpre;
WHEN 2 THEN
UPDATE tb_precio SET compra=dt2, especial=dt3, normal=dt4, mayorista=dt5, minorista=dt6, oferta=dt7, remate=dt8, est=dt9 WHERE idpre=dt;
SELECT LAST_INSERT_ID() AS idpre;
WHEN 3 THEN
set cpr=(SELECT compra FROM tb_precio WHERE idct=dt1 AND est=1);
if cpr=dt2 then
    UPDATE tb_precio SET est=1 WHERE idct=dt1 AND est=1;
    SELECT dt1 AS idpre;
END IF;
if cpr!=dt2 then
    UPDATE tb_precio SET est=0 WHERE idct=dt1 AND est=1;
    INSERT INTO tb_precio VALUES(NULL, dt1, dt2, dt3, dt4, dt5, dt6, dt7, dt8, 1);
    SELECT LAST_INSERT_ID() AS idpre;
END IF;
WHEN 4 THEN
    UPDATE tb_precio SET est=0 WHERE idct=dt1 AND est=1;
    INSERT INTO tb_precio VALUES(NULL, dt1, dt2, dt3, dt4, dt5, dt6, dt7, dt8, 1);
    SELECT LAST_INSERT_ID() AS idpre;
END CASE;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_reg_venta` (IN `dt` INT(11), IN `dt1` DATETIME, IN `dt2` CHAR(12), IN `dt3` INT(11), IN `dt4` INT(11), IN `dt5` INT(11), IN `dt6` DECIMAL(12,2), IN `dt7` TINYINT(1), IN `dt8` TINYINT(1), IN `dt9` TINYINT(1))  begin
CASE dt8 
WHEN 1 THEN
if(not exists(SELECT num_doc FROM tb_venta WHERE num_doc=dt2)) then
INSERT INTO tb_venta VALUES(NULL, dt1, dt2, dt3, dt4, dt5, dt6, 1,dt9);
SELECT LAST_INSERT_ID() AS idventa;
else
SELECT curdate();
end if;
WHEN 2 THEN
UPDATE tb_venta SET fecha=dt1, num_doc=dt2, idtip=dt3, idc=dt4, idv=dt5, total=dt6, est=dt7 WHERE idventa=dt;
SELECT LAST_INSERT_ID() AS idventa;
WHEN 3 THEN
UPDATE tb_venta SET est=2 WHERE idventa=dt;
SELECT LAST_INSERT_ID() AS idventa;
END CASE;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_restricciones` (`Sidtipo` INT, `Sn1` BIT, `sn2` BIT, `sn3` BIT, `sn4` BIT, `sn5` BIT, `sn6` BIT, `sn7` BIT, `sn8` BIT, `sn9` BIT)  begin
if(not exists(SELECT idtip FROM restricciones WHERE idtip=Sidtipo)) then
insert into restricciones(idtipo,N1,N2,N3,N4,N5,N6,N7,N8,N9)
values (sidtipo,Sn1,Sn2,Sn3,Sn4,Sn5,Sn6,Sn7,Sn8,Sn9);
SELECT LAST_INSERT_ID() AS idrestri;
else
UPDATE restricciones SET N1=Sn1, N2=sn2, N3=sn3, N4=sn4, N5=sn5, N6=sn6, N7=sn7, N8=sn8, N9=sn9 WHERE idtip = Sidtipo;
SELECT LAST_INSERT_ID() AS idrestri;
end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_rest_alm` ()  begin
SELECT *
FROM tb_almacen
WHERE est=1;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_rows_compras` (`dt` INT(11))  begin
SELECT idcompra, num_doc, date_format(fecha,'%Y-%m-%d %H:%i:%s %p') fcha
FROM tb_compra 
WHERE est = 1 AND idv=dt;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_rows_ventas` (`dt` INT(11))  begin
SELECT idventa, num_doc, date_format(fecha,'%Y-%m-%d %H:%i:%s %p') fcha
FROM tb_venta 
WHERE est=1 AND idv=dt;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_cliente` (IN `search` VARCHAR(250))  begin
  select * from tb_cliente tc
  left join tb_puntaje tp on tc.idc=tp.cliente_id
  where (nom like concat('',search,'%') or ruc like concat('',search,'%'))
  and tp.cliente_id is null;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_product` (`_search` VARCHAR(250))  begin
  select tc.nom, tc.idct, ts.ct_nuevo, tg.nom
  from tb_catalogo tc
  inner join tb_stock ts on ts.idct=tc.idct
    inner join tb_categ tg on tg.idg=tc.idg
  where (tg.nom like concat('', _search, '%') or tc.nom like concat('', _search, '%')) and (ts.ct_nuevo > 0 and tc.est=1);
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_show_detail_score` (IN `id` INT)  begin
  select id, puntaje_id, puntaje, DATE_FORMAT(created_at, '%d-%m-%y') as created_at from detalle_puntaje
    where puntaje_id=id and est=1;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_show_puntajes` ()  begin
  select concat(tc.nom, ' (', tc.ruc, ')') as nombre, tp.puntaje_ini,
  tp.puntaje_fin, tp.id, tc.idc, tp.created_at
  from tb_puntaje tp 
  inner join tb_cliente tc on tc.idc=tp.cliente_id order by tp.created_at desc limit 0,20;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_show_puntajes_filter` (IN `search` VARCHAR(250))  begin
  select concat(tc.nom, ' (', tc.ruc, ')') as nombre, tp.puntaje_ini,
  tp.puntaje_fin, tp.id, tc.idc, tp.created_at
   from tb_puntaje tp 
  inner join tb_cliente tc on tc.idc=tp.cliente_id
  where tc.nom like concat('', search, '%') or tc.ruc like concat('', search, '%') order by tp.created_at desc limit 0,20;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_show_restric` (`dt` INT(11))  begin
SELECT *
FROM restricciones 
WHERE idtip = dt;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_show_subrestric` (`dt` INT(11), `dt1` CHAR(3))  begin
SELECT *
FROM subrestricciones 
WHERE idtip = dt AND idrestric = dt1;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_stock_addcatalogo` (IN `_idcata` INT, IN `stock_add` INT)  begin
  IF (NOT EXISTS(SELECT id_stock FROM tb_stock WHERE idct=_idcata )) THEN
  	UPDATE tb_catalogo set stk = stk + stock_add, stk_min=1, opcdistri=1 WHERE idct=_idcata;
  ELSE
  	UPDATE tb_catalogo set stk = stk + stock_add, stk_min=1, opcdistri=1 WHERE idct=_idcata;
  END IF;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_stock_product_p` (IN `idcatalogo` INT, IN `idalmacen` INT, IN `nuevo` INT, IN `averiado` INT, IN `roto` INT)  begin
	DECLARE _opcdistri tinyint(1);
  if not exists(select * from tb_stock where idct=idcatalogo) then
    insert into tb_stock
      values(null, idcatalogo, idalmacen, nuevo, averiado, roto, curdate(), 1);
  else
  	SELECT opcdistri into _opcdistri from tb_catalogo WHERE idct=idcatalogo;
    IF _opcdistri=1 THEN
		set @nn=(select ct_nuevo from tb_stock where idct=idcatalogo) + nuevo;
        set @aa=(select ct_averiado from tb_stock where idct=idcatalogo) + averiado;
        set @rr=(select ct_roto from tb_stock where idct=idcatalogo) + roto;
        
        update tb_stock set id_alm=idalmacen, ct_nuevo=@nn, ct_averiado=@aa, ct_roto=@rr,
            fecha=now(), est=1 where idct=idcatalogo;
	ELSEIF _opcdistri=2 THEN
    	update tb_stock set id_alm=idalmacen, ct_nuevo=nuevo, ct_averiado=averiado, ct_roto=roto,
            fecha=now(), est=1 where idct=idcatalogo;
    END IF;
   end if;
    update tb_catalogo set 	stk=0,stk_min=0 
        where idct=idcatalogo;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_stock_update` (IN `_id_alm` INT, IN `_fecha` DATETIME, IN `_ct_nuevo` INT, IN `_ct_averiado` INT, IN `_ct_roto` INT, IN `_idct` INT, IN `_iddcompra` INT)  begin
  update tb_stock set id_alm=_id_alm, fecha=_fecha, 
  ct_nuevo=_ct_nuevo, ct_averiado=_ct_averiado, ct_roto=_ct_roto 
  where idct=_idct and iddcompra=_iddcompra;
  select idcompra from detalle_compra
  where iddcompra=_iddcompra;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_subrestricciones` (`Sidtipo` INT(11), `idres` CHAR(3), `m1` BIT, `m2` BIT, `m3` BIT, `m4` BIT, `m5` BIT, `m6` BIT, `m7` BIT)  begin
declare i int(11);
if(not exists(SELECT idtip, idrestric FROM subrestricciones WHERE idtip=Sidtipo AND idrestric=idres)) then
insert into subrestricciones(idtipo,idrestric,M1,M2,M3,M4,M5,M6,M7)
values (Sidtipo,idres,m1,m2,m3,m4,m5,m6,m7);
else
set i=(SELECT idsubrestri FROM subrestricciones WHERE idtip=Sidtipo AND idrestric=idres);
UPDATE subrestricciones SET M1=m1, M2=m2, M3=m3,M4=m4, M5=m5, M6=m6, M7=m7 WHERE idsubrestri=i;
end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_sumar_stock_xidcata` (`dt` INT(11), OUT `nums` DECIMAL(12,2))  begin
declare num1 int(11);
declare num2 int(11);
declare num3 int(11);

set num1=(SELECT ct_nuevo FROM tb_stock tb WHERE tb.idct=dt);
set num2=(SELECT ct_averiado FROM tb_stock tb WHERE tb.idct=dt);
set num3=(SELECT ct_roto FROM tb_stock tb WHERE tb.idct=dt);

set nums=num1+num2+num3;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tipo_usu` (`Snom` CHAR(20), `Sstd` TINYINT(1))  begin
if(not exists(SELECT nom FROM tb_tipo WHERE nom=Snom)) then
insert into tb_tip (nom, est) values(Snom, Sstd);
SELECT LAST_INSERT_ID() as idti;
else
SELECT curdate();
end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_verifica` (`dt` INT(11))  begin
SELECT s.idv, s.nom, s.idti, t.nom as tnom
FROM tb_sale s
INNER JOIN tb_tip t ON t.idti=s.idti
WHERE s.idv = dt and s.est=1;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_verificar_puntaje` (`_id` INT, `_gastar` INT)  begin
  if (select sum(puntaje)>=_gastar from detalle_puntaje where puntaje_id=_id) then
    /* daremos de baja a los puntajes del detalle puntaje */        
    select true;
    else
    select false;
    end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_verif_precxprd` (`dt` DECIMAL(12,2), `dt1` INT(11))  BEGIN
declare num decimal(12,2);
set num=(SELECT compra FROM tb_precio WHERE idct=dt1 AND est=1);
if num=dt then
select true;
else
select false;
end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_verif_precxprd1` (IN `dt` DECIMAL(12,7), IN `dt1` INT(11))  BEGIN
declare num decimal(12,7);
set num=(SELECT compra FROM tb_precio WHERE idct=dt1 AND est=1 LIMIT 1);
if num=dt then
select true;
else
select false;
end if;
end$$

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `get_idcaja_actual` () RETURNS INT(11) BEGIN

declare _idcaja int;

SELECT id into _idcaja FROM caja_chica WHERE estado=1 LIMIT 1;
RETURN _idcaja;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `caja_chica`
--

CREATE TABLE `caja_chica` (
  `id` int(11) NOT NULL,
  `ids` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `saldo_inicial` decimal(12,2) NOT NULL,
  `saldo_actual` decimal(12,2) NOT NULL,
  `saldo_final` decimal(12,2) DEFAULT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `caja_chica`
--

INSERT INTO `caja_chica` (`id`, `ids`, `fecha`, `saldo_inicial`, `saldo_actual`, `saldo_final`, `estado`, `created_at`, `updated_at`) VALUES
(1, 1, '2019-01-02', '20.00', '3886.62', NULL, 2, '2019-01-03 10:36:20', '2019-01-07 16:47:27'),
(2, 1, '2019-01-07', '0.00', '1850.69', NULL, 2, '2019-01-07 16:47:33', '2019-01-07 19:03:45'),
(3, 1, '2019-01-07', '10.00', '3791.42', NULL, 1, '2019-01-07 19:03:52', '2019-01-09 17:32:47');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cierre_caja`
--

CREATE TABLE `cierre_caja` (
  `id` int(11) NOT NULL,
  `idcaja` int(11) NOT NULL,
  `total_facturas` int(11) NOT NULL,
  `total_boletas` int(11) NOT NULL,
  `total_proforma` int(11) NOT NULL,
  `total_compracredicto` decimal(12,2) NOT NULL,
  `total_ventacredicto` decimal(12,2) NOT NULL,
  `total_egreso` decimal(12,2) NOT NULL,
  `total_ingreso` decimal(12,2) NOT NULL,
  `total_ventas` decimal(12,2) NOT NULL,
  `total_compras` decimal(12,2) NOT NULL,
  `total_adelantos` decimal(12,2) NOT NULL,
  `estado` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_caja`
--

CREATE TABLE `detalle_caja` (
  `id` int(11) NOT NULL,
  `idcaja` int(11) NOT NULL,
  `fecha` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tipo_entrada` tinyint(1) NOT NULL COMMENT '1 ingresos/2egresos',
  `desc_entrada` tinyint(1) DEFAULT NULL COMMENT '1 venta/ 2 gastos/ 3 adelantos per/4 creditos cancelados',
  `tipo_documento` tinyint(1) NOT NULL COMMENT '1 Boleta/2 Factura/ 3 Proforma/ 4 Guia...',
  `nom_doc` varchar(40) DEFAULT NULL,
  `num_doc` varchar(18) DEFAULT NULL,
  `monto` decimal(12,2) NOT NULL,
  `observacion` text CHARACTER SET utf8 COLLATE utf8_spanish_ci,
  `estado` tinyint(1) DEFAULT '1',
  `idadel_personal` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `detalle_caja`
--

INSERT INTO `detalle_caja` (`id`, `idcaja`, `fecha`, `tipo_entrada`, `desc_entrada`, `tipo_documento`, `nom_doc`, `num_doc`, `monto`, `observacion`, `estado`, `idadel_personal`) VALUES
(1, 1, '2019-01-03 11:18:52', 2, 3, 8, 'OTROS', '000', '1.00', '', 2, 3),
(2, 1, '2019-01-03 11:28:13', 1, 4, 11, 'BOLETA', '003-6565', '90.00', '', 2, NULL),
(3, 1, '2019-01-03 11:28:41', 1, 4, 11, 'BOLETA', '003-6565', '90.00', '', 2, NULL),
(4, 1, '2019-01-03 12:27:38', 2, 2, 5, 'TICKET', '003-565', '10.00', 'Compre cuaderno', 2, NULL),
(5, 1, '2019-01-03 12:33:27', 1, 1, 1, 'BOLETA', '003-652', '270.00', '', 2, NULL),
(6, 1, '2019-01-04 10:25:15', 1, 1, 2, 'FACTURA', '003-65656', '254.88', '', 2, NULL),
(7, 1, '2019-01-04 17:27:21', 1, 1, 1, 'BOLETA', '003-655', '6.00', '', 2, NULL),
(8, 1, '2019-01-04 17:29:27', 1, 1, 1, 'BOLETA', '003-6565', '6.00', '', 2, NULL),
(9, 1, '2019-01-04 17:30:38', 1, 1, 1, 'BOLETA', '001-2425', '6.00', '', 2, NULL),
(10, 1, '2019-01-04 17:43:33', 1, 1, 1, 'BOLETA', '002-68565', '6.00', '', 2, NULL),
(11, 1, '2019-01-04 17:44:55', 1, 1, 1, 'BOLETA', '002', '6.00', '', 2, NULL),
(12, 1, '2019-01-04 17:45:43', 1, 1, 1, 'BOLETA', '002-3655', '6.00', '', 2, NULL),
(13, 1, '2019-01-04 17:46:18', 1, 1, 1, 'BOLETA', '03-565', '3.00', '', 2, NULL),
(14, 1, '2019-01-04 17:46:53', 1, 1, 1, 'BOLETA', '002-3353', '9.00', '', 2, NULL),
(15, 1, '2019-01-04 17:47:44', 1, 1, 1, 'BOLETA', '014-21424', '6.50', '', 2, NULL),
(16, 1, '2019-01-04 17:48:12', 1, 1, 1, 'BOLETA', '002-353', '6.50', '', 2, NULL),
(17, 1, '2019-01-04 17:48:50', 1, 1, 1, 'BOLETA', '001-3636', '6.50', '', 2, NULL),
(18, 1, '2019-01-04 17:50:04', 1, 1, 1, 'BOLETA', '003-565', '3.00', '', 2, NULL),
(19, 1, '2019-01-04 17:50:50', 1, 1, 1, 'BOLETA', '03-5665', '6.50', '', 2, NULL),
(20, 1, '2019-01-04 17:51:36', 1, 1, 1, 'BOLETA', '003-45654', '3.00', '', 2, NULL),
(21, 1, '2019-01-04 17:52:25', 1, 1, 1, 'BOLETA', '003-5656', '9.50', '', 2, NULL),
(22, 1, '2019-01-04 18:04:47', 1, 1, 1, 'BOLETA', '001-656', '15.50', '', 2, NULL),
(23, 1, '2019-01-04 18:10:19', 1, 1, 1, 'BOLETA', '005-6565', '9.00', '', 2, NULL),
(24, 1, '2019-01-04 18:11:50', 1, 1, 1, 'BOLETA', '002-5665', '6.50', '', 2, NULL),
(25, 1, '2019-01-05 12:23:04', 1, 1, 1, 'BOLETA', '003-223', '360.00', '', 2, NULL),
(26, 1, '2019-01-05 12:25:20', 1, 1, 1, 'BOLETA', '003-2256', '18.00', '', 2, NULL),
(27, 1, '2019-01-05 12:33:40', 1, 1, 1, 'BOLETA', '001-6635', '18.00', '', 2, NULL),
(28, 1, '2019-01-05 12:57:50', 1, 1, 1, 'BOLETA', '008-5665', '18.00', '', 2, NULL),
(29, 1, '2019-01-07 11:07:18', 1, 1, 1, 'BOLETA', '0010-5553', '39.60', '', 2, NULL),
(30, 1, '2019-01-07 11:53:52', 1, 1, 1, 'BOLETA', '005-1254', '2.20', '', 2, NULL),
(31, 1, '2019-01-07 15:21:14', 1, 1, 2, 'FACTURA', '002-522', '164.32', '', 2, NULL),
(32, 1, '2019-01-07 15:28:23', 1, 1, 1, 'BOLETA', '004-854', '3.00', '', 2, NULL),
(33, 1, '2019-01-07 15:31:40', 1, 1, 1, 'BOLETA', '002-8963', '3.00', '', 2, NULL),
(34, 1, '2019-01-07 15:35:32', 1, 1, 1, 'BOLETA', '006-652', '3.00', '', 2, NULL),
(35, 1, '2019-01-07 15:39:03', 1, 1, 1, 'BOLETA', '003-5652', '159.75', '', 2, NULL),
(36, 1, '2019-01-07 15:55:24', 1, 1, 1, 'BOLETA', '010-5221', '2283.37', '', 2, NULL),
(37, 2, '2019-01-07 18:14:34', 1, 1, 1, 'BOLETA', '005-6522', '1850.69', '', 2, NULL),
(38, 3, '2019-01-07 19:27:40', 1, 4, 11, 'FACTURA', '0010-214', '20.00', '', 1, NULL),
(39, 3, '2019-01-07 19:27:57', 1, 4, 11, 'FACTURA', '0010-214', '500.00', '', 1, NULL),
(40, 3, '2019-01-07 19:28:25', 1, 4, 11, 'FACTURA', '0010-214', '70.00', '', 1, NULL),
(41, 3, '2019-01-07 19:35:22', 2, 2, 3, 'PROFORMA', '003-52656', '20.00', 'compre cuaderno', 1, NULL),
(42, 3, '2019-01-08 09:21:49', 1, 1, 1, 'BOLETA', '007-1452', '252.29', '', 1, NULL),
(43, 3, '2019-01-08 09:39:59', 1, 1, 1, 'BOLETA', '009-2412', '146.00', '', 1, NULL),
(44, 3, '2019-01-08 09:48:33', 1, 1, 1, 'BOLETA', '0010-5532', '89.00', '', 1, NULL),
(45, 3, '2019-01-08 09:56:48', 1, 1, 1, 'BOLETA', '0011-3250', '301.79', '', 1, NULL),
(46, 3, '2019-01-08 11:07:40', 1, 1, 1, 'BOLETA', '0018-3521', '188.00', '', 1, NULL),
(47, 3, '2019-01-08 11:09:04', 1, 1, 1, 'BOLETA', '000-6233', '188.00', '', 1, NULL),
(48, 3, '2019-01-09 11:30:09', 1, 1, 4, '', '001-1111', '188.40', '', 1, NULL),
(49, 3, '2019-01-09 11:44:35', 1, 1, 4, '', '003-0263', '26.34', '', 1, NULL),
(50, 3, '2019-01-09 15:29:32', 1, 1, 1, 'BOLETA', '012-2241', '573.90', '', 1, NULL),
(51, 3, '2019-01-09 15:40:14', 1, 1, 4, '', '0012-3695', '26.00', '', 1, NULL),
(52, 3, '2019-01-09 15:52:40', 1, 1, 4, '', '003-1111', '97.00', '', 1, NULL),
(53, 3, '2019-01-09 15:54:18', 1, 1, 1, 'BOLETA', '0013-24242', '141.00', '', 1, NULL),
(54, 3, '2019-01-09 17:22:59', 1, 1, 2, 'FACTURA', '0018-0125', '467.26', '', 1, NULL),
(55, 3, '2019-01-09 17:25:30', 1, 1, 1, 'BOLETA', '001-0035', '3.00', '', 1, NULL),
(56, 3, '2019-01-09 17:26:03', 1, 1, 2, 'FACTURA', '1111-21212', '3.54', '', 1, NULL),
(57, 3, '2019-01-09 17:26:33', 1, 1, 3, 'PROFORMA', '0000051', '3.00', '', 1, NULL),
(58, 3, '2019-01-09 17:32:47', 1, 1, 3, 'PROFORMA', '0000052', '526.90', '', 1, NULL);

--
-- Disparadores `detalle_caja`
--
DELIMITER $$
CREATE TRIGGER `caja_mov_comp` AFTER INSERT ON `detalle_caja` FOR EACH ROW BEGIN
	IF NEW.tipo_entrada = 1 THEN 
    UPDATE caja_chica SET saldo_actual = saldo_actual + NEW.monto WHERE id = NEW.idcaja;
    ELSEIF NEW.tipo_entrada = 2 THEN
    UPDATE caja_chica SET saldo_actual = saldo_actual - NEW.monto WHERE id = NEW.idcaja;
    END IF;
    
    
  END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `caja_mov_update` AFTER UPDATE ON `detalle_caja` FOR EACH ROW BEGIN
	IF NEW.tipo_entrada = 2 THEN
    	IF NEW.estado=1 AND OLD.estado=1 THEN
            IF OLD.monto<NEW.monto THEN
                SET @montoretur = NEW.monto - OLD.monto;
                UPDATE caja_chica SET saldo_actual = saldo_actual - @montoretur WHERE id = NEW.idcaja;
            ELSEIF OLD.monto>NEW.monto THEN
                SET @montoretur = OLD.monto - NEW.monto;
                UPDATE caja_chica SET saldo_actual = saldo_actual + @montoretur WHERE id = NEW.idcaja;
            END IF;
         ELSEIF NEW.estado=0 AND OLD.estado=1 THEN
         	UPDATE caja_chica SET saldo_actual = saldo_actual + OLD.monto WHERE id = NEW.idcaja;
         ELSEIF OLD.estado=0 AND NEW.estado=1 THEN
         	UPDATE caja_chica SET saldo_actual = saldo_actual - NEW.monto WHERE id = NEW.idcaja;
         END IF;
    END IF;
  END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_compra`
--

CREATE TABLE `detalle_compra` (
  `iddcompra` int(11) NOT NULL,
  `idcompra` int(11) NOT NULL,
  `idct` int(11) NOT NULL,
  `cant` int(11) NOT NULL,
  `precio` decimal(12,7) NOT NULL,
  `subtotal` decimal(12,7) NOT NULL,
  `igv` decimal(12,7) NOT NULL,
  `total` decimal(12,7) NOT NULL,
  `est` tinyint(1) NOT NULL,
  `tstk` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `detalle_compra`
--

INSERT INTO `detalle_compra` (`iddcompra`, `idcompra`, `idct`, `cant`, `precio`, `subtotal`, `igv`, `total`, `est`, `tstk`) VALUES
(1, 1, 665, 28, '3.6000000', '82.6560000', '18.1440000', '100.8000000', 1, 0),
(2, 1, 659, 12, '6.3200000', '62.1888000', '13.6512000', '75.8400000', 1, 0),
(3, 2, 601, 5, '45.0000000', '184.5000000', '40.5000000', '225.0000000', 1, 1),
(4, 3, 507, 3, '6.0000000', '14.7600000', '3.2400000', '18.0000000', 1, 1),
(5, 4, 601, 6, '50.0000000', '246.0000000', '54.0000000', '300.0000000', 1, 1),
(6, 5, 297, 3, '10.0000000', '24.6000000', '5.4000000', '30.0000000', 1, 1),
(7, 6, 507, 8, '3.2500000', '21.3200000', '4.6800000', '26.0000000', 1, 1),
(8, 7, 16, 10, '8.0000000', '65.6000000', '14.4000000', '80.0000000', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_puntaje`
--

CREATE TABLE `detalle_puntaje` (
  `id` int(11) NOT NULL,
  `puntaje_id` int(11) NOT NULL,
  `puntaje` int(11) NOT NULL,
  `est` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `detalle_puntaje`
--

INSERT INTO `detalle_puntaje` (`id`, `puntaje_id`, `puntaje`, `est`, `created_at`, `updated_at`) VALUES
(1, 1, 5, 1, '2018-11-23 09:56:51', '2018-11-23 09:56:51'),
(2, 2, 10, 1, '2018-11-23 12:35:39', '2018-11-23 12:35:39'),
(3, 2, 10, 1, '2018-11-23 12:36:18', '2018-11-23 12:36:18'),
(4, 3, 10, 1, '2018-11-28 15:32:44', '2018-11-28 15:32:44'),
(5, 1, 200, 1, '2018-11-29 09:48:48', '2018-11-29 09:48:48'),
(6, 4, 20, 1, '2019-01-05 12:03:52', '2019-01-05 12:03:52'),
(7, 6, 4, 1, '2019-01-07 11:07:18', '2019-01-07 11:07:18'),
(8, 4, 6, 1, '2019-01-07 15:35:32', '2019-01-07 15:35:32'),
(9, 3, 0, 0, '2019-01-07 15:39:03', '2019-01-07 15:39:03'),
(10, 6, 0, 0, '2019-01-07 16:39:24', '2019-01-07 16:39:24'),
(11, 2, 3701, 1, '2019-01-07 18:14:34', '2019-01-07 18:14:34'),
(12, 7, 505, 1, '2019-01-08 09:21:49', '2019-01-08 09:21:49'),
(13, 7, 604, 1, '2019-01-08 09:56:48', '2019-01-08 09:56:48'),
(14, 4, 376, 1, '2019-01-08 11:09:04', '2019-01-08 11:09:04'),
(15, 4, 377, 1, '2019-01-09 11:30:09', '2019-01-09 11:30:09'),
(16, 7, 53, 1, '2019-01-09 11:44:35', '2019-01-09 11:44:35'),
(17, 1, 1148, 1, '2019-01-09 15:29:32', '2019-01-09 15:29:32'),
(18, 3, 52, 1, '2019-01-09 15:40:14', '2019-01-09 15:40:14'),
(19, 4, 194, 1, '2019-01-09 15:52:40', '2019-01-09 15:52:40'),
(20, 3, 1054, 1, '2019-01-09 17:32:47', '2019-01-09 17:32:47');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_venta`
--

CREATE TABLE `detalle_venta` (
  `iddetalle` int(11) NOT NULL,
  `idventa` int(11) NOT NULL,
  `idct` int(11) NOT NULL,
  `cant` int(11) NOT NULL,
  `precio` decimal(12,2) NOT NULL,
  `costo` decimal(12,2) NOT NULL COMMENT '/Peso',
  `subtotal` decimal(12,2) NOT NULL,
  `igv` decimal(12,2) NOT NULL,
  `total` decimal(12,2) NOT NULL,
  `est` tinyint(1) NOT NULL,
  `tstk` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `detalle_venta`
--

INSERT INTO `detalle_venta` (`iddetalle`, `idventa`, `idct`, `cant`, `precio`, `costo`, `subtotal`, `igv`, `total`, `est`, `tstk`) VALUES
(1, 1, 665, 10, '18.00', '157.00', '147.60', '32.40', '180.00', 1, 1),
(2, 2, 665, 15, '18.00', '235.50', '221.40', '48.60', '270.00', 1, 1),
(3, 3, 507, 5, '3.00', '4.00', '12.30', '2.70', '15.00', 1, 1),
(4, 3, 821, 15, '10.20', '0.00', '125.46', '27.54', '153.00', 1, 1),
(5, 3, 1, 8, '6.00', '31.20', '39.36', '8.64', '48.00', 1, 1),
(6, 4, 1, 1, '6.00', '3.90', '4.92', '1.08', '6.00', 1, 1),
(7, 5, 1, 1, '6.00', '3.90', '4.92', '1.08', '6.00', 1, 1),
(8, 6, 1, 1, '6.00', '3.90', '4.92', '1.08', '6.00', 1, 1),
(9, 7, 1, 1, '6.00', '3.90', '4.92', '1.08', '6.00', 1, 1),
(10, 8, 1, 1, '6.00', '3.90', '4.92', '1.08', '6.00', 1, 1),
(11, 9, 507, 2, '3.00', '1.60', '4.92', '1.08', '6.00', 1, 1),
(12, 10, 507, 1, '3.00', '0.80', '2.46', '0.54', '3.00', 1, 1),
(13, 11, 1, 1, '6.00', '3.90', '4.92', '1.08', '6.00', 1, 1),
(14, 11, 507, 1, '3.00', '0.80', '2.46', '0.54', '3.00', 1, 1),
(15, 12, 821, 1, '6.50', '-3.70', '5.33', '1.17', '6.50', 1, 1),
(16, 13, 821, 1, '6.50', '-3.70', '5.33', '1.17', '6.50', 1, 1),
(17, 14, 821, 1, '6.50', '-3.70', '5.33', '1.17', '6.50', 1, 1),
(18, 15, 507, 1, '3.00', '0.80', '2.46', '0.54', '3.00', 1, 1),
(19, 16, 821, 1, '6.50', '-3.70', '5.33', '1.17', '6.50', 1, 1),
(20, 17, 507, 1, '3.00', '0.80', '2.46', '0.54', '3.00', 1, 1),
(21, 18, 507, 1, '3.00', '0.80', '2.46', '0.54', '3.00', 1, 1),
(22, 18, 821, 1, '6.50', '-3.70', '5.33', '1.17', '6.50', 1, 1),
(24, 19, 507, 1, '3.00', '0.80', '2.46', '0.54', '3.00', 1, 1),
(25, 19, 1, 1, '6.00', '3.90', '4.92', '1.08', '6.00', 1, 1),
(26, 19, 821, 1, '6.50', '-3.70', '5.33', '1.17', '6.50', 1, 1),
(27, 20, 507, 1, '3.00', '0.80', '2.46', '0.54', '3.00', 1, 1),
(28, 20, 1, 1, '6.00', '3.90', '4.92', '1.08', '6.00', 1, 1),
(29, 21, 821, 1, '6.50', '-3.70', '5.33', '1.17', '6.50', 1, 1),
(30, 22, 665, 20, '18.00', '288.00', '295.20', '64.80', '360.00', 1, 1),
(31, 23, 665, 1, '18.00', '14.40', '14.76', '3.24', '18.00', 1, 1),
(38, 24, 665, 1, '18.00', '14.40', '14.76', '3.24', '18.00', 1, 1),
(46, 25, 665, 1, '18.00', '14.40', '14.76', '3.24', '18.00', 1, 1),
(47, 26, 507, 1, '3.00', '0.80', '2.46', '0.54', '3.00', 1, 1),
(48, 26, 1, 1, '6.00', '3.90', '4.92', '1.08', '6.00', 1, 1),
(49, 26, 821, 3, '10.20', '0.00', '25.09', '5.51', '30.60', 1, 1),
(51, 28, 507, 1, '2.20', '0.00', '1.80', '0.40', '2.20', 1, 1),
(52, 29, 674, 5, '27.85', '127.75', '114.19', '25.07', '139.25', 1, 1),
(53, 30, 507, 1, '3.00', '0.80', '2.46', '0.54', '3.00', 1, 1),
(54, 31, 507, 1, '3.00', '0.80', '2.46', '0.54', '3.00', 1, 1),
(55, 32, 507, 1, '3.00', '0.80', '2.46', '0.54', '3.00', 1, 1),
(56, 33, 1, 1, '6.00', '3.90', '4.92', '1.08', '6.00', 1, 1),
(57, 33, 821, 1, '10.20', '0.00', '8.36', '1.84', '10.20', 1, 1),
(58, 33, 507, 2, '3.00', '1.60', '4.92', '1.08', '6.00', 1, 1),
(59, 33, 665, 3, '18.00', '43.20', '44.28', '9.72', '54.00', 1, 1),
(60, 33, 674, 3, '27.85', '76.65', '68.51', '15.04', '83.55', 1, 1),
(61, 34, 665, 1, '18.00', '14.40', '14.76', '3.24', '18.00', 1, 1),
(62, 34, 674, 3, '29.99', '83.07', '73.78', '16.19', '89.97', 1, 1),
(63, 34, 821, 3, '8.00', '-6.60', '19.68', '4.32', '24.00', 1, 1),
(64, 34, 507, 3, '2.80', '1.80', '6.89', '1.51', '8.40', 1, 1),
(65, 34, 28, 7, '100.00', '350.00', '574.00', '126.00', '700.00', 1, 1),
(66, 34, 116, 10, '144.30', '-66.90', '1183.26', '259.74', '1443.00', 1, 1),
(67, 35, 97, 13, '45.63', '264.29', '486.42', '106.77', '593.19', 1, 1),
(68, 35, 674, 2, '27.85', '51.10', '45.67', '10.03', '55.70', 1, 1),
(69, 35, 821, 3, '8.00', '-6.60', '19.68', '4.32', '24.00', 1, 1),
(70, 35, 28, 3, '100.00', '150.00', '246.00', '54.00', '300.00', 1, 1),
(71, 35, 116, 6, '145.30', '-34.14', '714.88', '156.92', '871.80', 1, 1),
(72, 35, 1, 1, '6.00', '3.90', '4.92', '1.08', '6.00', 1, 1),
(73, 36, 28, 5, '100.00', '250.00', '410.00', '90.00', '500.00', 1, 1),
(74, 37, 507, 1, '3.00', '0.80', '2.46', '0.54', '3.00', 1, 1),
(75, 37, 1, 1, '6.00', '3.90', '4.92', '1.08', '6.00', 1, 1),
(76, 37, 116, 1, '145.30', '-5.69', '119.15', '26.15', '145.30', 1, 1),
(77, 37, 97, 1, '50.00', '24.70', '41.00', '9.00', '50.00', 1, 1),
(78, 37, 665, 1, '18.00', '14.40', '14.76', '3.24', '18.00', 1, 1),
(79, 37, 674, 1, '29.99', '27.69', '24.59', '5.40', '29.99', 1, 1),
(80, 38, 659, 2, '73.00', '133.36', '119.72', '26.28', '146.00', 1, 2),
(81, 39, 659, 1, '71.00', '64.68', '58.22', '12.78', '71.00', 1, 2),
(82, 39, 665, 1, '18.00', '14.40', '14.76', '3.24', '18.00', 1, 1),
(83, 40, 821, 1, '6.50', '-3.70', '5.33', '1.17', '6.50', 1, 1),
(84, 40, 97, 2, '50.00', '49.40', '82.00', '18.00', '100.00', 1, 1),
(85, 40, 116, 1, '144.30', '-6.69', '118.33', '25.97', '144.30', 1, 1),
(86, 40, 507, 1, '3.00', '0.80', '2.46', '0.54', '3.00', 1, 1),
(87, 40, 674, 1, '29.99', '27.69', '24.59', '5.40', '29.99', 1, 1),
(88, 40, 665, 1, '18.00', '14.40', '14.76', '3.24', '18.00', 1, 1),
(89, 41, 97, 1, '47.00', '21.70', '38.54', '8.46', '47.00', 1, 1),
(90, 41, 97, 3, '47.00', '65.10', '115.62', '25.38', '141.00', 1, 1),
(91, 42, 97, 4, '47.00', '86.80', '154.16', '33.84', '188.00', 1, 1),
(92, 48, 665, 9, '3.60', '0.00', '26.57', '5.83', '90.00', 1, 3),
(93, 48, 97, 1, '1.20', '-24.10', '0.98', '0.22', '98.40', 1, 3),
(94, 49, 357, 2, '1.25', '20.00', '2.05', '0.45', '25.00', 1, 3),
(95, 49, 665, 3, '0.32', '4.20', '0.79', '0.17', '1.34', 1, 3),
(96, 50, 97, 3, '47.00', '65.10', '115.62', '25.38', '141.00', 1, 1),
(97, 50, 116, 3, '144.30', '-20.07', '354.98', '77.92', '432.90', 1, 1),
(98, 51, 665, 1, '1.30', '20.00', '1.07', '0.23', '26.00', 1, 3),
(99, 52, 97, 10, '1.30', '50.00', '10.66', '2.34', '65.00', 1, 3),
(100, 52, 665, 1, '3.20', '10.00', '2.62', '0.58', '32.00', 1, 3),
(101, 53, 97, 3, '47.00', '65.10', '115.62', '25.38', '141.00', 1, 1),
(102, 54, 97, 2, '47.00', '43.40', '77.08', '16.92', '94.00', 1, 1),
(103, 54, 116, 2, '150.99', '0.00', '247.62', '54.36', '301.98', 1, 1),
(104, 55, 507, 1, '3.00', '0.80', '2.46', '0.54', '3.00', 1, 1),
(105, 56, 507, 1, '3.00', '0.80', '2.46', '0.54', '3.00', 1, 1),
(106, 57, 507, 1, '3.00', '0.80', '2.46', '0.54', '3.00', 1, 1),
(107, 58, 116, 3, '144.30', '-20.07', '354.98', '77.92', '432.90', 1, 1),
(108, 58, 97, 2, '47.00', '43.40', '77.08', '16.92', '94.00', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `restricciones`
--

CREATE TABLE `restricciones` (
  `idrestri` int(11) NOT NULL,
  `idtip` int(11) NOT NULL,
  `N1` bit(1) NOT NULL,
  `N2` bit(1) NOT NULL,
  `N3` bit(1) NOT NULL,
  `N4` bit(1) NOT NULL,
  `N5` bit(1) NOT NULL,
  `N6` bit(1) NOT NULL,
  `N7` bit(1) NOT NULL,
  `N8` bit(1) NOT NULL,
  `N9` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `restricciones`
--

INSERT INTO `restricciones` (`idrestri`, `idtip`, `N1`, `N2`, `N3`, `N4`, `N5`, `N6`, `N7`, `N8`, `N9`) VALUES
(1, 1, b'1', b'1', b'1', b'1', b'1', b'1', b'1', b'1', b'1'),
(2, 2, b'1', b'1', b'0', b'1', b'1', b'1', b'0', b'1', b'1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `subrestricciones`
--

CREATE TABLE `subrestricciones` (
  `idsubrestri` int(11) NOT NULL,
  `idtip` int(11) NOT NULL,
  `idrestric` char(3) NOT NULL,
  `M1` bit(1) NOT NULL,
  `M2` bit(1) NOT NULL,
  `M3` bit(1) NOT NULL,
  `M4` bit(1) NOT NULL,
  `M5` bit(1) NOT NULL,
  `M6` bit(1) NOT NULL,
  `M7` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `subrestricciones`
--

INSERT INTO `subrestricciones` (`idsubrestri`, `idtip`, `idrestric`, `M1`, `M2`, `M3`, `M4`, `M5`, `M6`, `M7`) VALUES
(1, 1, 'n4', b'1', b'1', b'1', b'1', b'1', b'1', b'1'),
(2, 1, 'n5', b'1', b'1', b'1', b'1', b'1', b'1', b'1'),
(3, 1, 'n6', b'1', b'1', b'1', b'1', b'1', b'1', b'1'),
(4, 1, 'n7', b'1', b'1', b'1', b'1', b'1', b'1', b'1'),
(5, 1, 'n8', b'1', b'1', b'1', b'1', b'1', b'1', b'1'),
(6, 2, 'n4', b'0', b'1', b'0', b'0', b'1', b'1', b'1'),
(7, 2, 'n5', b'1', b'1', b'1', b'1', b'1', b'1', b'1'),
(8, 2, 'n6', b'1', b'1', b'0', b'0', b'0', b'0', b'0'),
(9, 2, 'n7', b'0', b'0', b'1', b'1', b'1', b'1', b'1'),
(10, 2, 'n8', b'1', b'0', b'1', b'0', b'0', b'1', b'1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_almacen`
--

CREATE TABLE `tb_almacen` (
  `ida` int(11) NOT NULL,
  `nom` varchar(120) DEFAULT NULL,
  `dir` varchar(120) DEFAULT 'S/N',
  `est` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_almacen`
--

INSERT INTO `tb_almacen` (`ida`, `nom`, `dir`, `est`) VALUES
(1, 'ALM01', '', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_catalogo`
--

CREATE TABLE `tb_catalogo` (
  `idct` int(11) NOT NULL,
  `cod_barra` varchar(120) DEFAULT 'S/CB',
  `nom` varchar(120) NOT NULL,
  `imagen` varchar(120) DEFAULT '../root/image.png',
  `ida` int(11) NOT NULL,
  `idg` int(11) NOT NULL,
  `idm` int(11) NOT NULL,
  `ids` int(11) NOT NULL,
  `unid` enum('UNIDAD','DOCENA','BOLSA','SET','JUEGO') NOT NULL,
  `stk` int(11) NOT NULL,
  `stk_min` int(11) NOT NULL,
  `est` tinyint(1) NOT NULL,
  `opcdistri` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_catalogo`
--

INSERT INTO `tb_catalogo` (`idct`, `cod_barra`, `nom`, `imagen`, `ida`, `idg`, `idm`, `ids`, `unid`, `stk`, `stk_min`, `est`, `opcdistri`) VALUES
(1, '0', 'URPI N°12 SIN TAPA', 'images/catalogo/cc0aea70c189c7b921b661e1764b81c78f1e4010.jpg', 1, 2, 5, 1, 'UNIDAD', 0, 0, 1, 1),
(2, '0', 'BULT BALDE', 'images/catalogo/f85ebb07cc92ea4ed4f5079284b0e04f1703a6e8.jpg', 1, 31, 2, 1, 'UNIDAD', 0, 1, 1, 0),
(3, '0', 'BEEBTODO DISNEY 350MLPRESS NIÑA', 'images/catalogo/21aa0b579ea7362f06e0f5440508bb1ede10bbfb.jpg', 1, 3, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(4, '0', 'BEBETODO BIO LIFE 320ML COBERTOR', 'images/catalogo/495d539c60b581218ac048d8f27ca51843ff71c7.jpg', 1, 3, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(5, '0', 'SILLA TONERA- VERDE TELEFONICA', 'images/catalogo/93cca11d5d9feb15460e99ab37121206d0b9fdbe.jpg', 1, 34, 5, 1, 'UNIDAD', 0, 1, 1, 0),
(6, '0', 'SILLA TONERA - AZULINO', 'images/catalogo/76c6a044ad1b967380c35483c6aecf75548384b3.jpg', 1, 34, 5, 1, 'UNIDAD', 0, 1, 1, 0),
(7, '0', 'AUKA SEMI', 'images/catalogo/4b91efef561bb3f60a8a0a3884153ab47fbe9927.jpg', 1, 35, 5, 1, 'UNIDAD', 0, 1, 1, 0),
(8, '0', 'BATEA ORQUIDEA 40 LTS C/ASAS  - SEMI', 'images/catalogo/f3efac10e61fccf01e415f4c1d6f5d37397f9c6e.jpg', 1, 35, 5, 1, 'UNIDAD', 0, 1, 1, 0),
(9, '0', 'MULTIUSOS REDONDO N°18 C/TAPA COLOR', 'images/catalogo/2949dc787b477ca369eef729563d64e9090c6993.jpg', 1, 24, 6, 1, 'DOCENA', 0, 1, 1, 0),
(10, '0', 'MULTIUSO N° 18 COLOR C/ TAPA COLOR', 'images/catalogo/3e319c50c4d005ddf15d6e09ea56072213f0c37a.jpg', 1, 24, 6, 1, 'DOCENA', 0, 1, 1, 0),
(11, '0', 'JARRA 100 ML COLOR S/TAPA', 'images/catalogo/ce5beec879ce08fb70cae2bfb3c8c0b4ec5e774f.jpg', 1, 59, 6, 1, 'DOCENA', 0, 1, 1, 0),
(12, '0', ' 100 ML TRANSPARENTE S/TAPA', 'images/catalogo/af00604473c3ea9a698e4c23840fb9f9b9116402.jpg', 1, 59, 6, 1, 'DOCENA', 0, 1, 1, 0),
(13, '0', 'MULT.DECAGONO 0.50 GR COLOR C/TAPA COLOR', 'images/catalogo/db9749ace1916513e5ebeb1bd1426d3f35d018ff.jpg', 1, 24, 6, 1, 'DOCENA', 0, 1, 1, 0),
(14, '0', ' MEDIANA  COLOR', 'images/catalogo/3014c193293eb7f2f569dbd8afbde833a8547758.jpeg', 1, 15, 6, 1, 'DOCENA', 0, 1, 1, 0),
(15, '0', 'FIESTA SIN BRAZO', 'images/catalogo/32adee77ef8ec47d9a991b4f356f9fdf0e88fa79.jpg', 1, 50, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(16, '0', '7 LT COLORES SURTIDOS CON TAPA', 'images/catalogo/f72a10ff00dd5c7a87d125b2d7521494eea88111.jpg', 1, 2, 7, 1, 'DOCENA', 0, 1, 1, 0),
(17, '0', 'NUEVO', 'images/catalogo/92ed67c4d4e9e0954f17ccd0013270285b0fcd3e.jpg', 1, 44, 5, 1, 'UNIDAD', 0, 1, 1, 0),
(18, '0', 'LAVATORIO N° 46 SEMI', 'images/catalogo/09b972968250783324845d2ce41cfb786e3dd7ea.jpg', 1, 45, 5, 1, 'UNIDAD', 0, 1, 1, 0),
(19, '0', 'MESA CUADRADA KINA COLORES', 'images/catalogo/762774e45eb804ecbc2dbf2331342019e9044555.jpg', 1, 46, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(20, '0', 'CLASICA CANCUN', 'images/catalogo/1c725355038cb55743ae82383565b6d4e6687b67.jpg', 1, 47, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(21, '0', 'MODERNA CAOBA', 'images/catalogo/e13e553cd86a52cad83e20274f9e36395364102f.jpg', 1, 50, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(22, '0', 'SILLA CLASICA MIAMI', 'images/catalogo/bde26dae28c509f86d20f0eec4adb1b25bce33ee.jpg', 1, 49, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(23, '0', 'SILLA COQUITO DIDACTICA', 'images/catalogo/b1c3cc1eb429fcc9d64f594cd95af8bb8ba7cea4.jpg', 1, 50, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(24, '0', 'TACHO UMA 60 LTS SEMI', 'images/catalogo/37dcf80f5fcae67dbfc5d0940dc6800f87078209.jpg', 1, 51, 5, 1, 'UNIDAD', 0, 1, 1, 0),
(25, '0', '1 GL COLOR C/TAPA', 'images/catalogo/19a116cf3b6ed6edf25b85ed255c204e45442b96.jpg', 1, 2, 8, 1, 'UNIDAD', 0, 1, 1, 0),
(26, '0', 'TRANPARENTE C/TAPA', 'images/catalogo/5a4e7fe2a150fc7226bd463e7f3cdf9a9521ff0a.jpg', 1, 2, 8, 1, 'UNIDAD', 0, 1, 1, 0),
(27, '0', 'COLOR C/TAPA COLOR', 'images/catalogo/8c31537137cb5da33099653a961e16675d1280bf.jpg', 1, 24, 8, 1, 'UNIDAD', 0, 1, 1, 0),
(28, '0', '1 GALON TRANSPARENTE C/TAPA COLOR', 'images/catalogo/4ac97d6751d3dc98efd9db5c422299f132bb2783.jpg', 1, 2, 8, 1, 'UNIDAD', 0, 0, 1, 1),
(29, '0', 'REDONDO CON TAPA', 'images/catalogo/76e0ff50cc97684ca7a45f76059982b0c4c228e1.jpg', 1, 44, 8, 1, 'UNIDAD', 0, 1, 1, 0),
(33, '0', '4 LITROS CON TAPA COLOR', 'images/catalogo/a94210bb32ec83be253ff011411a1cd5216a481f.jpg', 1, 59, 8, 1, 'UNIDAD', 0, 1, 1, 0),
(35, '0', 'SILLON DIDACTICO', 'images/catalogo/d3d3380a8fa82f3ce3ea149485e0b4c8a08d482c.jpg', 1, 60, 8, 1, 'UNIDAD', 0, 1, 1, 0),
(38, '0', '2.5 LT COLOR C/TAPA', 'images/catalogo/e53b0fc0b1ebdac819580bce8e20a261279c2f42.jpg', 1, 59, 8, 1, 'UNIDAD', 0, 1, 1, 0),
(39, '0', '2.5 LTS TRANAPARENTE', 'images/catalogo/f47fb6e9fe3e736a384ebcceae2cdde3137afab0.jpg', 1, 59, 8, 1, 'UNIDAD', 0, 1, 1, 0),
(40, '0', 'N°19 COLOR C/TAPA', 'images/catalogo/203e1d95e0f3eb30881c95dbc948713ceb4489a8.jpg', 1, 24, 8, 1, 'UNIDAD', 0, 1, 1, 0),
(41, '0', '1/4 REDONDO C/C', 'images/catalogo/a0a7b6a37c22cc35bee364225151be8ea348c2b6.jpg', 1, 24, 8, 1, 'UNIDAD', 0, 1, 1, 0),
(42, '0', '1/4 REDONDO T/C', 'images/catalogo/0a0b7730ed2b8613f9e5a36ec5d10d946db8e29b.jpg', 1, 24, 8, 1, 'UNIDAD', 0, 1, 1, 0),
(43, '0', 'BARQUITA GRANDE  NUEVA', 'images/catalogo/822019b05a163aafb85f6651356325efb506cd8f.jpg', 1, 61, 8, 1, 'UNIDAD', 0, 1, 1, 0),
(44, '0', 'UTILITARIO DECORADO', 'images/catalogo/0ef89144839289a902a16f554171ceabd5098c07.jpg', 1, 62, 8, 1, 'UNIDAD', 0, 1, 1, 0),
(45, '0', '70 LITROS .II', 'images/catalogo/c499079143b4bfcef6d14b2b69d64273ee692e5b.jpg', 1, 51, 8, 1, 'UNIDAD', 0, 1, 1, 0),
(46, '0', 'COQUITO  2', 'images/catalogo/8cb88bdd1518d10388cb2b2f74eaad83484a95fb.jpg', 1, 50, 9, 1, 'UNIDAD', 0, 1, 1, 0),
(47, '0', 'POLIN #5', 'images/catalogo/84a254bca5bc9952327986951f666857ac59149c.jpg', 1, 63, 9, 1, 'UNIDAD', 0, 1, 1, 0),
(48, '0', 'DISNEY 350ML SORBETE NIÑO', 'images/catalogo/c31375eaf681caee44acf2595f941b58a2b658ba.jpg', 1, 3, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(49, '0', 'DISNEY 350 ML SORBETE ÑIÑA', 'images/catalogo/91f44ebb301c6f82cf8a2535209a990d4be5d0f0.jpg', 1, 3, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(50, '0', 'UMA 40 LTS SEMI', 'images/catalogo/2f30aa8188006f90b3050ce4cdbe9914f577b498.jpg', 1, 51, 5, 1, 'UNIDAD', 0, 1, 1, 0),
(51, '0', 'ROSE', 'images/catalogo/7cb552089945e7b52105941c22a46e66c7437215.jpg', 1, 64, 5, 1, 'UNIDAD', 0, 1, 1, 0),
(52, '0', 'GAUCHA - BLANCO', 'images/catalogo/e4c1b6dd39d7835b2dccc75433b9c0e94c4008a5.jpg', 1, 50, 5, 1, 'UNIDAD', 0, 1, 1, 0),
(53, '0', 'GAUCHA - CREMA', 'images/catalogo/22a9bcd430b1908fb5dbc1282eb8a777c3f2bbbe.jpg', 1, 50, 5, 1, 'UNIDAD', 0, 1, 1, 0),
(54, '0', 'GAUCHA - ROJO', 'images/catalogo/d69bd01ebcde70c71f2b50e6a5307d8ea13e1130.jpg', 1, 50, 5, 1, 'UNIDAD', 0, 1, 1, 0),
(55, '0', 'GAUCHA - VERDE TELEFONICA', 'images/catalogo/e4368f3cacbacb327558d33eccfd13072caa185a.png', 1, 50, 5, 1, 'UNIDAD', 0, 1, 1, 0),
(56, '0', 'GAUCHA - AZULINO', 'images/catalogo/ed369c9f7ba4718343f7702a07c4b560d347bda6.jpg', 1, 50, 5, 1, 'UNIDAD', 0, 1, 1, 0),
(57, '0', 'TONERA - ROJO', 'images/catalogo/2dfc337984573b352da010647e1763919e457cd1.jpg', 1, 50, 5, 1, 'UNIDAD', 0, 1, 1, 0),
(58, '0', 'TONERA - VERDE TELEFONICA', 'images/catalogo/2b0e1de5eac1451b961f65fb624edad523405dcc.jpg', 1, 50, 5, 1, 'UNIDAD', 0, 1, 1, 0),
(59, '0', 'WHISKERO TRANSPARENTE', 'images/catalogo/d3509da29be1c384ca28063ab2917ef26f31dbd2.jpg', 1, 30, 5, 1, 'UNIDAD', 0, 1, 1, 0),
(60, '0', 'WHISKERO CARAMELO', 'images/catalogo/ed196faf5d35e1ae17ae2aa06ac134b55df6fad2.jpg', 1, 30, 5, 1, 'UNIDAD', 0, 1, 1, 0),
(61, '0', 'URPI N° 40 SEMI', 'images/catalogo/4f74c97c9844ba619b2d0315488c54d80b0e2af0.jpg', 1, 45, 5, 1, 'UNIDAD', 0, 1, 1, 0),
(62, '0', 'TOT 6', 'images/catalogo/1944865ca3a0181a4c91ce4df535948c00da2468.jpg', 1, 65, 5, 1, 'UNIDAD', 0, 1, 1, 0),
(63, '0', 'INFANTIL SURTIDO', 'images/catalogo/62bebd6286d7ceebb4c21fba130cb275a96b2f41.jpg', 1, 46, 5, 1, 'UNIDAD', 0, 1, 1, 0),
(64, '0', 'APU N° 20', 'images/catalogo/bc98723892061083de65d0bf8b1bfa9411d4900f.jpg', 1, 66, 5, 1, 'UNIDAD', 0, 1, 1, 0),
(65, '0', 'DESPENSERO', 'images/catalogo/e09f053cea8cdf7aed8e21d988be767c657c3796.jpg', 1, 67, 8, 1, 'UNIDAD', 0, 1, 1, 0),
(66, '0', 'PACHACUTEC 150 LT', 'images/catalogo/80cfe7360d143e0ebf523f01a9a6998426efa2b7.jpg', 1, 51, 8, 1, 'UNIDAD', 0, 1, 1, 0),
(67, '0', 'OVALADO 0.8 LTS CON TAPA', 'images/catalogo/0e75ed661052ca812e7cdd29f412bcd108952f24.jpg', 1, 24, 10, 1, 'UNIDAD', 0, 1, 1, 0),
(68, '0', 'REDONDO T/ROSCA 125 ML CON TAPA', 'images/catalogo/b47a49fef50aca3b108ef6b8e9b48366ac87fc3b.jpg', 1, 24, 10, 1, 'UNIDAD', 0, 1, 1, 0),
(69, '0', 'REDONDO T/ROSA 500 ML CON TAPA', 'images/catalogo/56cfe13a030ffb24a2c311c9fee35d5918db0f04.jpg', 1, 24, 10, 1, 'UNIDAD', 0, 1, 1, 0),
(70, '0', 'TOMATODO 250 ML CON TAPA', 'images/catalogo/28636c8ac434110b99c2328855c07a774e3e86f6.jpg', 1, 30, 10, 1, 'UNIDAD', 0, 1, 1, 0),
(71, '0', 'TOMATODO 500 ML CONA TAPA', 'images/catalogo/a5a8240ef18d382850968e093dfeaecd5264736f.jpg', 1, 30, 10, 1, 'UNIDAD', 0, 1, 1, 0),
(72, '0', 'REDONDO ECONOMICO 500 ML CON TAPA', 'images/catalogo/f2e2df365e574bad009fce95ae97a585eb088b13.jpg', 1, 24, 10, 1, 'UNIDAD', 0, 1, 1, 0),
(73, '0', '# 15 CON TAPA', 'images/catalogo/daa01299d7ab3d394e923b733e8831a81ed49431.gif', 1, 4, 10, 1, 'UNIDAD', 0, 1, 1, 0),
(74, '0', '# 22 .5 CON TAPA', 'images/catalogo/4e0dc20fb2ae730a196487aceb1cbf9926103d69.jpg', 1, 4, 10, 1, 'UNIDAD', 0, 1, 1, 0),
(75, '0', '# 30 CON TAPA', 'images/catalogo/a6e47d3e349e7f3644a1a6ae77783c23a37d1e74.jpg', 1, 4, 10, 1, 'UNIDAD', 0, 1, 1, 0),
(76, '0', 'PREMIUM', 'images/catalogo/775dd9e548fb26676aba67082eef74f6ac6d0ec1.jpg', 1, 69, 9, 1, 'UNIDAD', 0, 1, 1, 0),
(77, '0', 'URPI N° 50 SEMI', 'images/catalogo/0d5f48f127a3d79909f21bce7439490d2516490c.jpg', 1, 45, 5, 1, 'UNIDAD', 0, 1, 1, 0),
(78, '0', 'HURACAN 15 SEMI ', 'images/catalogo/240f5fc48e6a625efe33b559ab199941c292bd16.jpeg', 1, 35, 5, 1, 'UNIDAD', 0, 1, 1, 0),
(79, '0', 'BELEN', 'images/catalogo/23adf300aed086a23f66e26c50adbc2e230bce38.jpg', 1, 70, 5, 1, 'UNIDAD', 0, 1, 1, 0),
(80, '0', 'MULTIUSO OVALADO .050 KG TRANSPARENTE C/TAPA A COLOR', 'images/catalogo/01430502cf018aabbb3128cfb4150dd2d1ad2981.jpg', 1, 24, 6, 1, 'DOCENA', 0, 1, 1, 0),
(81, '0', 'MULTIUSO OVALDDAO  0.50 KG  COLOR C/TAPA COLOR', 'images/catalogo/dd53c0aa390b6b754dc471e05fc6f0349a1819d0.jpg', 1, 24, 6, 1, 'DOCENA', 0, 1, 1, 0),
(82, '0', 'TONERA - DORADO', 'images/catalogo/a53a69baf6b3a5f6e74861081320c9ecea5042c2.png', 1, 50, 5, 1, 'UNIDAD', 0, 1, 1, 0),
(83, '0', 'ALTO BAR ERGONOMICO', 'images/catalogo/4f056f38f2b10a7a15dce3930fb025d87fd806b9.jpg', 1, 71, 9, 1, 'UNIDAD', 0, 1, 1, 0),
(84, '0', 'HERMETICO REY 1 LT PRESS MUNDIAL', 'images/catalogo/7aee4ce5558f7118ab104ddd06ffd636f0e61fe2.png', 1, 3, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(85, '0', 'HERMETICO REY 350 ML SORBETE MUNDIAL', 'images/catalogo/ba84db093728f85f38229c51babffd7e2bc5357e.png', 1, 3, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(86, '0', 'HERMETICO REY 350 ML PRESS MUNDIAL NIÑO', 'images/catalogo/1d6fcd4108681675cec01cac64e18aa85bce95e8.png', 1, 3, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(87, '0', 'HERMETICO REY 600 ML PRESS MUNDIAL', 'images/catalogo/e75954359ac25837910fa8d0e02602c0f6b10c66.png', 1, 3, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(88, '0', 'JARRAS REAL', 'images/catalogo/f8b9fce9c06494bb6d83e6638255d7b6174b5bc7.jpg', 1, 73, 11, 1, 'DOCENA', 0, 1, 1, 0),
(89, '0', 'REAL 6 KG', 'images/catalogo/b3ed3cea0d09266f0a88ce4097cab006194f0205.jpg', 1, 20, 11, 1, 'DOCENA', 0, 1, 1, 0),
(90, '0', 'ALEMAN 1/2 KG CARAMELADO ', 'images/catalogo/521d3a694a2e2ab65aa1042ddf3d538128c03df3.jpg', 1, 74, 11, 1, 'DOCENA', 0, 1, 1, 0),
(91, '0', 'REAL 4 KG', 'images/catalogo/0e520e2f9ad04502df6f200a33422d99d3ed8128.jpg', 1, 20, 11, 1, 'DOCENA', 0, 1, 1, 0),
(92, '0', 'INKA CUADRADA 73 X 73 CM COLOR', 'images/catalogo/cfc361b33e4c68930333237773726c9c6b3eaf73.jpg', 1, 46, 9, 1, 'UNIDAD', 0, 1, 1, 0),
(93, '0', 'INKA CUADRADA 73 X 73 CM BLANCO/CREMA', 'images/catalogo/5d0cd920574460c1f59810c5b61adc7479f247a3.jpg', 1, 46, 9, 1, 'UNIDAD', 0, 1, 1, 0),
(95, '0', 'PANERA CON TAPA', 'images/catalogo/4fa3dfec812fb780c9432f64318c7ae4272a6570.jpg', 1, 75, 12, 1, 'UNIDAD', 0, 1, 1, 0),
(96, '0', '2 LITOS TRANSPARENTE C/TAPA', 'images/catalogo/393c35eac23360fdec225ec6018e65a8e058bfd4.jpg', 1, 2, 12, 1, 'UNIDAD', 0, 1, 1, 0),
(97, '0', '13.5 LITROS TRANSPARENTE C/TAPA', 'images/catalogo/6760fe22f4a5cbb941d827f2b01791bcd2c2b064.jpg', 1, 2, 12, 1, 'UNIDAD', 0, 0, 1, 1),
(98, '0', '13.5 LITROS OLOR C/TAPA', 'images/catalogo/67ea6a6e0276109691268ed9b23f10204c6271ed.jpg', 1, 2, 12, 1, 'UNIDAD', 0, 1, 1, 0),
(99, '0', 'LEO N° 18', 'images/catalogo/5961f37b7befe3f68d9ff00734caa03285aefb33.jpeg', 1, 66, 12, 1, 'UNIDAD', 0, 1, 1, 0),
(100, '0', 'BANK BANK', 'images/catalogo/55589d9128466f0937503085716664f5c9ecc4da.jpg', 1, 71, 12, 1, 'UNIDAD', 0, 1, 1, 0),
(101, '0', 'AZUCARERO C/TAPA', 'images/catalogo/40358a5c12d4a534d1ac52564047fb42b5c502f2.jpg', 1, 1, 8, 1, 'UNIDAD', 0, 1, 1, 0),
(102, '0', 'BOLO ROMANO ', 'images/catalogo/dc89c1b977cb00792a2275434be114eb1ce4b84f.png', 1, 76, 8, 1, 'UNIDAD', 0, 1, 1, 0),
(103, '0', 'RECTANGULAR 2 GL T/C', 'images/catalogo/6375f9aec52f9eafefa70960b698ed5dc51584e4.jpg', 1, 2, 8, 1, 'UNIDAD', 0, 1, 1, 0),
(104, '0', 'BOLO ROMANO TRASLUCIDO ', 'images/catalogo/41a56429e69acac27cfc301bc6fbbf6504998716.jpg', 1, 76, 8, 1, 'UNIDAD', 0, 1, 1, 0),
(105, '0', 'RECTANGULAR COLOR', 'images/catalogo/51eb6b4fe62d190c4026f433ce7aab42650cde02.jpg', 1, 46, 8, 1, 'UNIDAD', 0, 1, 1, 0),
(106, '0', 'DECORADO C/ TAPA', 'images/catalogo/75c3a509a68771fdb097c0fdf1f544ea76166913.jpg', 1, 20, 8, 1, 'UNIDAD', 0, 1, 1, 0),
(107, '0', 'CUADRADO 1 KG ROSITA T/C', 'images/catalogo/698c8cd345c713deb330e08894ce14f34d1867ca.jpg', 1, 24, 8, 1, 'UNIDAD', 0, 1, 1, 0),
(108, '0', 'N° 45 II (40 LTS)', 'images/catalogo/7dedc412086f6afbb0273375f9b5191d4cb66067.jpg', 1, 51, 8, 1, 'UNIDAD', 0, 1, 1, 0),
(109, '0', 'ACANALADO SURTIDO', 'images/catalogo/db05a86f8b8f6098558da711762222040ccfffa7.jpg', 1, 30, 5, 1, 'UNIDAD', 0, 1, 1, 0),
(110, '0', 'LUCKY CON 3 VASOS ', 'images/catalogo/b73e400ad477d7bca6ab82f6b8fc1788ba0adbc7.jpg', 1, 59, 8, 1, 'UNIDAD', 0, 1, 1, 0),
(111, '0', 'BEGONIA 40 LITROS C/ JABONERAS Y - SEMI PICO', 'images/catalogo/d1187450eeca8af0802b42e6e1dde83cda435e7a.jpeg', 1, 35, 5, 1, 'UNIDAD', 0, 1, 1, 0),
(112, '0', 'HURACAN N° 40 ECONOMICO', 'images/catalogo/ef890ee7e60a8ea5b028814cbd3ad3c7546ad3a6.jpg', 1, 45, 5, 1, 'UNIDAD', 0, 1, 1, 0),
(113, '0', 'ACANALADO TRANSPARENTE', 'images/catalogo/e2e018bc869836bd1de949c597b53722ef74ced1.jpg', 1, 30, 5, 1, 'UNIDAD', 0, 1, 1, 0),
(114, '0', 'CORAZON JARRA 4 LT C/TAPA COLOR +  VASOS + CA', 'images/catalogo/0758818e92c4df40e0bb0e998903530e5c91e7e9.jpg', 1, 72, 5, 1, 'UNIDAD', 0, 1, 1, 0),
(115, '0', '4 LITROS TRANSPARENTE C/ TAPA COLOR', 'images/catalogo/e89f37029d8b9e46994c4bd4937cc7c902377bb3.jpg', 1, 2, 13, 1, 'UNIDAD', 0, 1, 1, 0),
(116, '0', '4 LITROS COLOR C/ TAPA BLANCA', 'images/catalogo/cf4c5af8b03d7440a4bd9431fc3923ba9d876b37.jpg', 1, 2, 13, 1, 'UNIDAD', 0, 0, 1, 1),
(117, '0', 'DOÑA PATA II', 'images/catalogo/320e5c46aaf8ac5ce83efa735742d6d9d2e75931.jpg', 1, 35, 13, 1, 'UNIDAD', 0, 1, 1, 0),
(118, '0', 'TUPAC 23 LT - TRANSPARENTE  C/TAPA COLOR', 'images/catalogo/cb66340011b664a6d77da919268a59019c86b787.jpg', 1, 2, 13, 1, 'UNIDAD', 0, 1, 1, 0),
(119, '0', 'KUSKA # 16 C/TAPAPIÑA + CUCHARON TAWA', 'images/catalogo/ced30a4536482b23d25e0fb9f2da3e9d3810702e.jpg', 1, 2, 13, 1, 'UNIDAD', 0, 1, 1, 0),
(120, '0', 'CLASICO ', 'images/catalogo/826c7f93b87b4ddf51a6407b2ce27e6b9cc89d9f.jpg', 1, 77, 14, 1, 'DOCENA', 0, 1, 1, 0),
(121, '0', 'HERMETICO 8 LTS TRANSPARENTE C/ TAPA COLOR', 'images/catalogo/2661740f84bced358fe5d50e65d6ead06a50d634.jpg', 1, 2, 13, 1, 'UNIDAD', 0, 1, 1, 0),
(122, '0', 'RELAMPAGO II N° 80 ', 'images/catalogo/cce79834f135ab0701c78d031ecdf175c9850729.jpeg', 1, 35, 13, 1, 'UNIDAD', 0, 1, 1, 0),
(123, '0', 'NORMAL', 'images/catalogo/56426a12343ba6fe076dd2dc61e27a02711c1533.jpg', 1, 27, 15, 1, 'DOCENA', 0, 1, 1, 0),
(124, '0', 'REDONDO', 'images/catalogo/e281cd5b4562d36095313dacb391b4a183cabb8f.jpg', 1, 24, 16, 1, 'DOCENA', 0, 1, 1, 0),
(125, '0', 'HINDU', 'images/catalogo/cda7521654eacd1194f14ee344def3f934be49e2.jpg', 1, 59, 16, 1, 'DOCENA', 0, 1, 1, 0),
(126, '0', 'N°36', 'images/catalogo/f3b266ead037e66b9e4050997d0979eceb2f4667.jpg', 1, 45, 16, 1, 'DOCENA', 0, 1, 1, 0),
(127, '0', 'PAPELERA 12 LTS', 'images/catalogo/2c3c84bdd5a7f8ce025190d91944b0ed248cdf4f.jpg', 1, 51, 17, 1, 'UNIDAD', 0, 1, 1, 0),
(128, '0', '3 NIVELES', 'images/catalogo/da0bc2f60c31664c2b7d3488211a5d414e790a30.jpg', 1, 67, 18, 1, 'UNIDAD', 0, 1, 1, 0),
(129, '0', 'JIREH', 'images/catalogo/cdf157a8a2903e8dfbf5e7edf67cc616461f7175.jpg', 1, 69, 19, 1, 'UNIDAD', 0, 1, 1, 0),
(130, '0', 'TRANSPARENTE 10 LTS CON TAPA ', 'images/catalogo/d73fe9b3358b75a1209d24e26b1b89bd91313d10.jpg', 1, 2, 4, 1, 'UNIDAD', 0, 1, 1, 0),
(131, '0', 'TRANSPARENTE  6 LITROS CON TAPA ', 'images/catalogo/4a900fb00724c86bee388dd2717be32641535a72.jpg', 1, 2, 4, 1, 'UNIDAD', 0, 1, 1, 0),
(132, '0', 'COSECHERA N°60', 'images/catalogo/75146f3d24903c140771ce0d41128ef7d08e087e.jpg', 1, 68, 4, 1, 'UNIDAD', 0, 1, 1, 0),
(133, '0', 'N°2', 'images/catalogo/ae9495100309c214df45b8daa6a8a972effd7850.jpg', 1, 58, 4, 1, 'UNIDAD', 0, 1, 1, 0),
(134, '0', 'N°3', 'images/catalogo/6e45644a1a3d750cc41dd10817f48fd8b5482180.jpg', 1, 58, 4, 1, 'UNIDAD', 0, 1, 1, 0),
(135, '0', 'N°4', 'images/catalogo/6f5aa2090ad950c8d1b08d95b6f90370d5e8c901.jpeg', 1, 58, 4, 1, 'UNIDAD', 0, 1, 1, 0),
(136, '0', 'N°5', 'images/catalogo/3868a9c282d72252ef53d1d93406ba511497897b.jpg', 1, 58, 4, 1, 'UNIDAD', 0, 1, 1, 0),
(137, '0', 'HONDO N°18 CON FLOR', 'images/catalogo/f365ba6e061804734d314c8631bb9026096f5a35.jpg', 1, 57, 14, 1, 'DOCENA', 0, 1, 1, 0),
(138, '0', 'HONDO N°20 CON FLOR', 'images/catalogo/1173fc25a925e10a22ac3b4151662df4fe89c74f.jpg', 1, 57, 14, 1, 'DOCENA', 0, 1, 1, 0),
(139, '0', 'N°29', 'images/catalogo/530a16ca2b3d75ffce7b2f55e2e6f548a0063624.jpg', 1, 27, 4, 1, 'DOCENA', 0, 1, 1, 0),
(140, '0', '20 LITROS 2DA', 'images/catalogo/a02f63aff3beafcbe437d1d55809eb56fcc28c56.jpg', 1, 35, 21, 1, 'DOCENA', 0, 1, 1, 0),
(141, '0', 'DELFIN 2DA', 'images/catalogo/fcff57e54b2041db8df10a30624f99cc7a02f41d.jpg', 1, 35, 21, 1, 'DOCENA', 0, 1, 1, 0),
(142, '0', '2DA', 'images/catalogo/fa638cb52e4ba8a815c171d244241006afd7f9a0.jpg', 1, 45, 24, 1, 'DOCENA', 0, 1, 1, 0),
(144, '0', 'SEGUNDA', 'images/catalogo/680c541186910dbcc89ee7a9ca0d72fe404e8c8d.jpg', 1, 45, 26, 1, 'DOCENA', 0, 1, 1, 0),
(145, '0', 'T.SEGUNDA', 'images/catalogo/ddc33728a50e2c64ce0766d200c47d0143e93b45.jpg', 1, 27, 22, 1, 'DOCENA', 0, 1, 1, 0),
(146, '0', 'A.SEGUNDA', 'images/catalogo/53f15e0322b684fa75570e0ba06af01bdc036061.jpg', 1, 27, 23, 1, 'UNIDAD', 0, 1, 1, 0),
(147, '0', 'S. SEGUNDA', 'images/catalogo/63afe90e1de6ae3c42d81d1cd0f892aeeaf0c20d.jpg', 1, 27, 20, 1, 'DOCENA', 0, 1, 1, 0),
(148, '0', 'PEZZ SEGUNDA', 'images/catalogo/a3180f8593fc9dedfbe00894686679a49c5ea47f.jpg', 1, 27, 25, 1, 'DOCENA', 0, 1, 1, 0),
(149, '0', '15 LTIROS', 'images/catalogo/f0bef4d4c9284fcc55d658d2845f644d211eb669.jpg', 1, 35, 21, 1, 'UNIDAD', 0, 1, 1, 0),
(151, '0', 'FLOR ', 'images/catalogo/11321c7b4fc66877aa55bbd65bb4476f8509a223.jpg', 1, 45, 4, 1, 'DOCENA', 0, 1, 1, 0),
(153, '0', 'PLASTICO', 'images/catalogo/66209bda8d93481811269893880aa7ba50181f35.jpg', 1, 55, 27, 1, 'DOCENA', 0, 1, 1, 0),
(154, '0', 'COLOR', 'images/catalogo/9ed5401f717b768d3f4430058d466cf249951883.jpg', 1, 27, 28, 1, 'UNIDAD', 0, 1, 1, 0),
(155, '0', 'MODELO NUEVO', 'images/catalogo/12ef31dcca14d06b019b3802d20f3e21bf0fdddb.jpg', 1, 27, 29, 1, 'UNIDAD', 0, 1, 1, 0),
(156, '0', 'UNA N°15', 'images/catalogo/84d0d1a446764cd6d65a9696d1d9d48cd29e3dd5.jpg', 1, 45, 30, 1, 'UNIDAD', 0, 1, 1, 0),
(157, '0', 'C/ASA N° 29', 'images/catalogo/34c175608aa13a4c9c8705efa5f31090b1f8fa1b.jpg', 1, 27, 30, 1, 'UNIDAD', 0, 1, 1, 0),
(158, '0', 'MINI TORTUGA', 'images/catalogo/e3412aa866c460755d79536e80b01c1be2829a11.jpg', 1, 27, 30, 1, 'UNIDAD', 0, 1, 1, 0),
(159, '0', 'CON ASA N°20 ', 'images/catalogo/e0fbb84691c5e0621839a2c51d9d390537199626.jpg', 1, 27, 30, 1, 'UNIDAD', 0, 1, 1, 0),
(160, '0', 'C/MANGO METÁLICO RAYADO TG', 'images/catalogo/acb3e190717d5ab7ab81f7f75278bd2d32af1bdd.jpg', 1, 54, 31, 1, 'UNIDAD', 0, 1, 1, 0),
(162, '0', 'PRACTICO', 'images/catalogo/634cc31a311a689802d24febe0da996207f3859f.jpg', 1, 53, 32, 1, 'UNIDAD', 0, 1, 1, 0),
(163, '0', 'CUADRADO 1.1 LT TRANSPARENTE C/T COLOR', 'images/catalogo/37cc91f376387d275699e919c27c0cef751ee90f.jpg', 1, 24, 33, 1, 'DOCENA', 0, 1, 1, 0),
(164, '0', ' 1 KILO TRANSPARENTE C/T COLOR', 'images/catalogo/a98e32b1875651bda68cfae06e0d7f43fa167d2e.jpg', 1, 24, 34, 1, 'DOCENA', 0, 1, 1, 0),
(165, '0', '1.1 LITRO COLOR C/T COLOR', 'images/catalogo/bd9125612cacd452743fc8b3c1f2aa0e9fa3b416.jpg', 1, 24, 33, 1, 'DOCENA', 0, 1, 1, 0),
(166, '0', '1 KILO COLOR C/T COLOR', 'images/catalogo/1f2972af7f04120d75616d10f95bf0c49974cccd.jpeg', 1, 24, 34, 1, 'DOCENA', 0, 1, 1, 0),
(167, '0', '2 LITROS COLOR C/T COLOR ', 'images/catalogo/28106f833c515f4069076b20d26833f085ca4ef5.jpg', 1, 2, 35, 1, 'UNIDAD', 0, 1, 1, 0),
(168, '0', '8 LITROS TRANSPARENTE C/TAPA', 'images/catalogo/f1b3bbd1d82dc8baea07749fb332d24d3254b555.png', 1, 2, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(169, '0', '8 LITROS COLOR C/TAPA', 'images/catalogo/32117c7cbe8d1b024df81c91eb737661834de031.jpg', 1, 2, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(170, '0', 'GRANDE', 'images/catalogo/793a16836cce65919be7da1608e96964bcc324dc.jpg', 1, 78, 41, 1, 'UNIDAD', 0, 1, 1, 0),
(171, '0', 'N°1', 'images/catalogo/5ea47186806af21123f8320a354ac9d4964d41e8.jpg', 1, 52, 38, 1, 'UNIDAD', 0, 1, 1, 0),
(173, '0', 'MODERNO N°3', 'images/catalogo/f5a008ed54e1383b9fac6b4ed3d6254cc09808c2.jpg', 1, 45, 39, 1, 'UNIDAD', 0, 1, 1, 0),
(174, '0', 'NUEVO N°2', 'images/catalogo/0a79c2f19fad1094a8597cdf7ab9f5785534abbe.jpg', 1, 45, 39, 1, 'UNIDAD', 0, 1, 1, 0),
(175, '0', '1 LITRO TRANSLUCIDO', 'images/catalogo/bcad6a0ad6572d50ef86dd91e8d3ee1bfa87b902.jpg', 1, 59, 40, 1, 'UNIDAD', 0, 1, 1, 0),
(176, '0', '1/2 LITROTRANSPARENTE', 'images/catalogo/2669a4369d73a3a40ed58281beb4f194063184aa.jpg', 1, 59, 40, 1, 'UNIDAD', 0, 1, 1, 0),
(177, '0', '1/2 LITRO TRASLUCIDO', 'images/catalogo/632b5d88301a6a837c20cf36ddbfe54f2d587c33.jpg', 1, 59, 40, 1, 'UNIDAD', 0, 1, 1, 0),
(178, '0', '1 LITRO TRANSPARENTE', 'images/catalogo/bae5995ef2883ed3d89819f0991b4d704a345ca5.jpg', 1, 59, 40, 1, 'UNIDAD', 0, 1, 1, 0),
(179, '0', 'N°40', 'images/catalogo/f22bd2f06c39515f029e68afbca55bfa9033cee1.jpg', 1, 61, 43, 1, 'UNIDAD', 0, 1, 1, 0),
(180, '0', 'N°70', 'images/catalogo/70816d6afa17c16041b078462e55cbab7737cb9f.jpg', 1, 61, 43, 1, 'UNIDAD', 0, 1, 1, 0),
(181, '0', 'MODERNOS DE COLORES', 'images/catalogo/32c2b50f80c869177b3320110efb5458ed4f0576.jpg', 1, 45, 22, 1, 'UNIDAD', 0, 1, 1, 0),
(182, '0', 'L.N°3', 'images/catalogo/8071d9a6da5acdfbb15e4f43d2963a1753030b48.jpg', 1, 45, 44, 1, 'UNIDAD', 0, 1, 1, 0),
(184, '0', 'OVALADO COLOR', 'images/catalogo/b036702bc3dc6d397fb54c0bb1cd715f79bf4944.jpg', 1, 27, 45, 1, 'UNIDAD', 0, 1, 1, 0),
(185, '0', 'ARCA DE NOE N° 110', 'images/catalogo/e41a8cc0400b49ef586f2c0d01f3176852607c8a.jpg', 1, 35, 13, 1, 'UNIDAD', 0, 1, 1, 0),
(186, '0', '1 KILO TRANSPARENTE C/T COLOR', 'images/catalogo/270a38d1c8d54600db2537079db7b663adff8dc2.jpg', 1, 24, 46, 1, 'DOCENA', 0, 1, 1, 0),
(187, '0', '1 KILO COLOT C/T COLOR', 'images/catalogo/11114f54d4a1d31d5238e4bda92aac0a9ff73710.jpg', 1, 24, 46, 1, 'DOCENA', 0, 1, 1, 0),
(188, '0', 'N°10 COLORES SURTIDOS', 'images/catalogo/3c15ae83a493a13cddc6ea81508c94ec679a87f3.jpg', 1, 66, 47, 1, 'DOCENA', 0, 1, 1, 0),
(189, '0', 'KIN MODERNO', 'images/catalogo/bdf028ddf2a4408aee6cea5422565c21f49ae338.jpg', 1, 78, 48, 1, 'DOCENA', 0, 1, 1, 0),
(190, '0', 'X3', 'images/catalogo/2368631cb4e33fd5ca20c9a0b441517f4b525749.jpg', 1, 78, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(191, '0', '40 LITROS', 'images/catalogo/19a0e34fcadb94aece6718f488ec25cb68440563.jpg', 1, 61, 3, 1, 'UNIDAD', 0, 1, 1, 0),
(192, '0', 'NEGRAS ', 'images/catalogo/00344b6796167e90ae32aed98c461514864c3275.jpg', 1, 35, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(193, '0', 'PEQUEÑAS NEGRAS', 'images/catalogo/6cd9e37bce99bdade09d30269180f5d707e5cf35.jpg', 1, 35, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(194, '0', 'MEDIANOS', 'images/catalogo/4443a319d484749d6a594bbf026b370683c182e1.jpg', 1, 78, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(195, '0', 'CON DETALLES', 'images/catalogo/61070ee10ae544bec860a642a2ea59cdfd52615b.jpg', 1, 43, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(196, '0', 'N° 30', 'images/catalogo/04f0691677b0a72d8fc8c84c348f0f39ea357ab2.jpg', 1, 27, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(197, '0', 'MOISES 13 LITROS', 'images/catalogo/4237d542a8cf01bb7a24370bda6347294c6e7d1b.jpg', 1, 35, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(198, '0', 'ECOLOGICO', 'images/catalogo/98caa1042d035b3ab11d1939fd68298d05fec6db.jpg', 1, 27, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(199, '0', 'JAEL N° 1 MULTIUSOS', 'images/catalogo/29ec035dd7a0f87fc8c1cc98ce1aa6b37418d6a7.jpg', 1, 40, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(201, '0', 'SUPER PRACTICO', 'images/catalogo/8502e3fa6e5bfa5d01b4eaecd40ceb7198732126.jpg', 1, 39, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(202, '0', 'MINI CON PICO C/TAPA', 'images/catalogo/bb3181bc56ece885de5a6bf0ab687aaafa52f10b.jpg', 1, 2, 3, 1, 'UNIDAD', 0, 1, 1, 0),
(203, '0', 'NUMERO 3', 'images/catalogo/710c80ad59b86f67a3879f7216af1bfd181203ec.jpg', 1, 6, 49, 1, 'UNIDAD', 0, 1, 1, 0),
(204, '0', 'HONDO', 'images/catalogo/f274307d1493e0b8f037ee147c8a5d3048ebff1f.jpg', 1, 75, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(205, '0', 'PODEROSO', 'images/catalogo/1a6fdec9c37869f7e03898afb0c95257a2fc7132.jpg', 1, 38, 50, 1, 'DOCENA', 0, 1, 1, 0),
(206, '0', 'VOLQUETE', 'images/catalogo/0f46980ff0661bc50b17b3c243771d80f10e8992.jpg', 1, 38, 51, 1, 'DOCENA', 0, 1, 1, 0),
(207, '0', 'GANADERO (4 RUEDAS)', 'images/catalogo/02c1897c3cca86c64048713e914d95b30cdf64da.jpg', 1, 38, 52, 1, 'DOCENA', 0, 1, 1, 0),
(208, '0', 'VOLQUETE (4 RUEDAS)', 'images/catalogo/fbc293b07158668627e4fe800534191eaf00f6a4.jpg', 1, 38, 52, 1, 'DOCENA', 0, 1, 1, 0),
(209, '0', 'CISTERNA', 'images/catalogo/681e3814cf7c55c30965ff30ef9edcfbf0403635.jpg', 1, 38, 52, 1, 'DOCENA', 0, 1, 1, 0),
(210, '0', 'NUMERO 24', 'images/catalogo/e8efb66336ac9fcac3a23730066ae21a61b5f3da.jpg', 1, 78, 37, 1, 'DOCENA', 0, 1, 1, 0),
(211, '0', 'NUMERO 30', 'images/catalogo/19e9f8967aac5fa663078062029bd5e914259b0d.jpg', 1, 78, 37, 1, 'DOCENA', 0, 1, 1, 0),
(212, '0', 'NUMERO 40', 'images/catalogo/d9d4a99992db1866dfa65c96e2b1ba7357993fcb.jpg', 1, 78, 37, 1, 'DOCENA', 0, 1, 1, 0),
(213, '0', '1/4 LITRO CRISTAL C/ MEDIDA', 'images/catalogo/02a170b9ab1b7842d3c897d0c94897cc0d41470c.jpg', 1, 59, 37, 1, 'DOCENA', 0, 1, 1, 0),
(214, '0', '1/2 COLOR C/MEDIDA', 'images/catalogo/b81f69f8e5c59c4f4af5299cd3c158be9362e8cb.jpg', 1, 59, 37, 1, 'DOCENA', 0, 1, 1, 0),
(215, '0', '1/2 LITRO CRISTAL S/TAPA', 'images/catalogo/aeed6daea3f835c2a26a4498103a9855c881b1e8.jpg', 1, 59, 37, 1, 'DOCENA', 0, 1, 1, 0),
(216, '0', '1 LITRO CRISTAL C/MEDIDA', 'images/catalogo/e8707ff8a19ca570449aa66e9661e277e1e776c4.jpg', 1, 59, 37, 1, 'DOCENA', 0, 1, 1, 0),
(217, '0', 'GORDITA 1 LITRO COLOR / TAPA', 'images/catalogo/80ea985d5618128bf3a08cb0ed965371ec12b101.jpg', 1, 59, 37, 1, 'DOCENA', 0, 1, 1, 0),
(218, '0', '1.5 LITRO CRISTAL C/TAPA', 'images/catalogo/2058ed011aa1290cf6dd14c5aca55e1e0c0f0c53.jpg', 1, 59, 37, 1, 'DOCENA', 0, 1, 1, 0),
(219, '0', 'CHICA', 'images/catalogo/e4f0fb71be54dc55554b3aa8d268c99550a7c280.jpg', 1, 37, 1, 1, 'DOCENA', 0, 1, 1, 0),
(221, '0', 'GRANDE  MOD.', 'images/catalogo/f2deb9165b9b4eed2df65528ab35cafa921be223.jpeg', 1, 37, 1, 1, 'DOCENA', 0, 1, 1, 0),
(223, '0', 'EMB. NUMERO 3', 'images/catalogo/a27411e83b0f1a68da5bf242403bb96218fe70f5.jpg', 1, 14, 37, 1, 'DOCENA', 0, 1, 1, 0),
(224, '0', 'NUMERO N°3', 'images/catalogo/7de2fc4f77225914481823231ea55a342dd64182.jpg', 1, 14, 37, 1, 'DOCENA', 0, 1, 1, 0),
(225, '0', 'REDONDA GRANDE C/TAPA CREMA - MARRON', 'images/catalogo/02bb02d5f9f689213dc3706d4cf4f4d3da0123fa.jpg', 1, 75, 37, 1, 'DOCENA', 0, 1, 1, 0),
(226, '0', 'REDONDA GRANDE C/TAPA ROJA', 'images/catalogo/3537c991ae8849dfc3bdf3c110a4bdac017d1e31.jpg', 1, 75, 37, 1, 'DOCENA', 0, 1, 1, 0),
(227, '0', 'REDONDA GRANDE C/ TAPA VERDE', 'images/catalogo/e361d3754899c91e96b5240f4bf1056a5eeb48bb.jpg', 1, 75, 37, 1, 'DOCENA', 0, 1, 1, 0),
(228, '0', 'REDONDA  GRANDE C/TAPA NARANJA', 'images/catalogo/d84e7e867a31dda24f8df2d61295f4eafc463099.jpg', 1, 75, 37, 1, 'DOCENA', 0, 1, 1, 0),
(229, '0', 'REDONDA GRANDE C/ TAPA AZUL ITALIANO', 'images/catalogo/7c4ea272f038a231b18651fff23e560173488701.jpg', 1, 75, 37, 1, 'DOCENA', 0, 1, 1, 0),
(230, '0', 'CON MANGO', 'images/catalogo/439ab9e41364d860a0f12dc853a33294b9b74e1d.JPG', 1, 78, 37, 1, 'DOCENA', 0, 1, 1, 0),
(231, '0', 'CHICO AZUL ITALIANO', 'images/catalogo/91d399645a0f231c250a354562ab9c63bc9eb601.jpg', 1, 65, 53, 1, 'DOCENA', 0, 1, 1, 0),
(232, '0', 'CHICO  AMARILLO ', 'images/catalogo/63668e8b237337deb773daf6cc68830423481432.jpg', 1, 65, 53, 1, 'DOCENA', 0, 1, 1, 0),
(233, '0', 'CHICOC ROSADO', 'images/catalogo/247c12b1ab3749ba78f4af186c572de4da7be01a.jpg', 1, 65, 53, 1, 'DOCENA', 0, 1, 1, 0),
(234, '0', 'CHICO VERDE', 'images/catalogo/a2f1477ceecbbea3a47c1404c1667282ce75d725.jpg', 1, 65, 53, 1, 'DOCENA', 0, 1, 1, 0),
(235, '0', 'CHICO NARANJA', 'images/catalogo/b27726a3ca43ab8a9f9a3627b9213df1b2399cf8.jpg', 1, 65, 53, 1, 'DOCENA', 0, 1, 1, 0),
(236, '0', '1.200 LITROS', 'images/catalogo/b9d4f5fa58ef06959314950d6ff8a4aea854a7b9.jpg', 1, 59, 54, 1, 'DOCENA', 0, 1, 1, 0),
(237, '0', '5 1/2 LITROS', 'images/catalogo/d47f1522436754d0a296b2b15a8ceaafa1b79e92.jpg', 1, 59, 54, 1, 'DOCENA', 0, 1, 1, 0),
(238, '0', 'ALEMAN 1/2 KG TRANSPARENTE', 'images/catalogo/1cef00c83a4d2d3728a979d92139b82dd69058f9.jpg', 1, 74, 37, 1, 'DOCENA', 0, 1, 1, 0),
(239, '0', 'ALEMAN 1.100 KILO', 'images/catalogo/88a92a9f59f32022ec2a7f2d6baf9b06fb1835d1.jpg', 1, 74, 37, 1, 'DOCENA', 0, 1, 1, 0),
(240, '0', 'C/ MANGO METALICO', 'images/catalogo/7e2fedb6b20a361682f1dbc9737c5753fd592ae3.jpg', 1, 54, 55, 1, 'UNIDAD', 0, 1, 1, 0),
(241, '0', 'NUMERO 20', 'images/catalogo/b417993292ba89c9557e07b90f4f9897f1a3730f.jpg', 1, 68, 56, 1, 'UNIDAD', 0, 1, 1, 0),
(242, '0', 'REDONDA N°7', 'images/catalogo/9cc1d266238283bb0e30410806834dc338098305.jpg', 1, 35, 57, 1, 'UNIDAD', 0, 1, 1, 0),
(243, '0', 'N° 7', 'images/catalogo/da5d16a1bb4388107b6b905ace6876f15d08f0fb.jpg', 1, 58, 4, 1, 'UNIDAD', 0, 1, 1, 0),
(244, '0', 'CONTAINER N° 0.50C/TAPA COLOR', 'images/catalogo/d7b4537e2e3413b3b8076a4267c9606a2ee621d7.jpg', 1, 24, 9, 1, 'UNIDAD', 0, 1, 1, 0),
(245, '0', 'CONTAINER N° 0.75 C/TAPA COLOR', 'images/catalogo/b70e47c6e1b4719beed99f5bfbe96a95608af5f6.jpg', 1, 24, 9, 1, 'UNIDAD', 0, 1, 1, 0),
(246, '0', 'N°25 CON TAPA', 'images/catalogo/b49a552c394de28c5215ec1dae0f37341257c238.jpg', 1, 68, 10, 1, 'UNIDAD', 0, 1, 1, 0),
(247, '0', 'N° 35 CON TAPA', 'images/catalogo/dd93a5eb23fd9b4ab3fa792d6b0a3f912424bb1a.jpg', 1, 68, 10, 1, 'UNIDAD', 0, 1, 1, 0),
(248, '0', 'N° 45 CON TAPA', 'images/catalogo/12aa9eea850cbeef593b812019a0db159ffe4716.png', 1, 68, 10, 1, 'UNIDAD', 0, 1, 1, 0),
(249, '0', 'CUADRADO 330 ML CON TAPA', 'images/catalogo/183bd71159e26809b446ab195a8d5e687d7c8c05.jpg', 1, 24, 10, 1, 'UNIDAD', 0, 1, 1, 0),
(250, '0', 'CUARDRADO 680 ML CON TAPA', 'images/catalogo/528405b1e6b2110e56634f8c01294a7659bd8759.jpg', 1, 24, 10, 1, 'UNIDAD', 0, 1, 1, 0),
(251, '0', 'OVALADO 0.8 LITROS CON TAPA', 'images/catalogo/56cc4658a9c05babc84ccc37c9d44dd85f86afe9.jpg', 1, 24, 10, 1, 'UNIDAD', 0, 1, 1, 0),
(252, '0', 'RECTANGULAR 160 ML CON TAPA', 'images/catalogo/0d5e8e55d20fd6dd0e46371456778edbbaf58e73.jpg', 1, 24, 10, 1, 'UNIDAD', 0, 1, 1, 0),
(253, '0', 'RECTANGULAR 2.0 LITROS CON TAPA', 'images/catalogo/a9227072697394cf5d8418066093877c2b83d95b.jpg', 1, 24, 10, 1, 'UNIDAD', 0, 1, 1, 0),
(254, '0', 'RECTANGULAR 3.0 LITROS CON TAPA', 'images/catalogo/f40e1870e566c3628cdcb23c8c565cf9809187c4.jpg', 1, 24, 10, 1, 'UNIDAD', 0, 1, 1, 0),
(255, '0', 'RECTANGULAR 10 LITROS CON TAPA', 'images/catalogo/641421a8e248a308aa86c7c9cc08f859b6662a9a.jpg', 1, 24, 10, 1, 'UNIDAD', 0, 1, 1, 0),
(256, '0', 'REDONDO CHICO 2.0 LITROS CON TAPA', 'images/catalogo/ec35830a6a69bb917eac0d5939655b669582559f.jpg', 1, 24, 10, 1, 'UNIDAD', 0, 1, 1, 0),
(257, '0', 'REDONDO CHICO 3.0 LITROS CON TAPA ', 'images/catalogo/a58c1112e0d443ce174690e1b5dd2ca03646c789.jpeg', 1, 24, 10, 1, 'UNIDAD', 0, 1, 1, 0),
(258, '0', 'REDONOD T/ ROSCA 500 ML CON TAPA', 'images/catalogo/49d84b700ae41cbbe82b1bcd04b4c3c56b94b5db.jpg', 1, 24, 10, 1, 'UNIDAD', 0, 1, 1, 0),
(259, '0', 'NUMERO 26', 'images/catalogo/4c08def44730c193aa8b19b55211b120578c968f.jpg', 1, 27, 4, 1, 'DOCENA', 0, 1, 1, 0),
(260, '0', 'CUADRADA', 'images/catalogo/c17a029a52771287b77103ab261b8e9b2c09880b.jpg', 1, 61, 4, 1, 'DOCENA', 0, 1, 1, 0),
(261, '0', 'MINI COLOR', 'images/catalogo/fb72a097dec0a2e7cabfc1094fda06aaa793f19f.jpg', 1, 27, 45, 1, 'UNIDAD', 0, 1, 1, 0),
(262, '0', 'REDONDA GRANDE C/TAPA CELESTE', 'images/catalogo/54f5630f70be3d490034ea6d39a698fb96ebd7e2.png', 1, 75, 37, 1, 'DOCENA', 0, 1, 1, 0),
(263, '0', 'CONICO N°3', 'images/catalogo/0ed9034cebd5967116b7198fa59f5f541b49aad8.jpg', 1, 14, 37, 1, 'DOCENA', 0, 1, 1, 0),
(264, '0', 'CONICO N°4', 'images/catalogo/4f7f89913232028cdf8a03111910b772e80ba111.jpg', 1, 14, 37, 1, 'DOCENA', 0, 1, 1, 0),
(265, '0', 'CONICO N°5', 'images/catalogo/073f0696c2b0f87d76f772e792e2daad0d30638c.jpg', 1, 14, 37, 1, 'DOCENA', 0, 1, 1, 0),
(266, '0', 'GANADERO', 'images/catalogo/a37c34f718a32b876e88887dd35165a91a611aad.jpg', 1, 38, 51, 1, 'DOCENA', 0, 1, 1, 0),
(268, '0', 'CISTERNA POWER', 'images/catalogo/f0809b629d3a9c8037a091d2091111e7b2d33c20.jpg', 1, 38, 51, 1, 'DOCENA', 0, 1, 1, 0),
(269, '0', ' SET COLOR SURTIDO', 'images/catalogo/5d93ea0d1a8927f232c006208aefc192ea0d8f22.jpg', 1, 8, 58, 1, 'UNIDAD', 0, 1, 1, 0),
(270, '0', ' 1.10 TRANSPARENTE   T/ COLOR', 'images/catalogo/a467e4982d70af6f4985ac06b7c558620baa0dba.jpg', 1, 24, 59, 1, 'UNIDAD', 0, 1, 1, 0),
(271, '0', '1.10 COLOR T/COLOR', 'images/catalogo/7bd01b5df9f111f7b653b4d6c8c14fb4ae888260.jpg', 1, 24, 59, 1, 'UNIDAD', 0, 1, 1, 0),
(272, '0', 'CON BROCHE1.20 TRANSPARENTE T/COLOR', 'images/catalogo/b565345be6caa735383a4814e05cbfe0b1aa1312.jpg', 1, 24, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(273, '0', 'CON BROCHE 1.20 COLOR T/COLOR', 'images/catalogo/7a5cba2de7a534c6b2b3b8dbec344af753eea985.jpg', 1, 24, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(274, '0', 'CUADRADO 5 KILOS TRANSPARENTE T/COLOR', 'images/catalogo/fd812caa37c4aed284f68463fe165765860b2a1c.JPG', 1, 24, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(275, '0', 'CUADRADO 0.50 TRANSPARENTE T/ COLOR', 'images/catalogo/a47023fe15fdd118c9aecea61fd72588e9cc97b5.jpg', 1, 24, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(276, '0', 'CUADRADO  0.520 COLOR T/COLOR', 'images/catalogo/7294c258b20dfcfe0fff41aa507c56f25e2b0f6c.jpg', 1, 24, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(277, '0', '0.50 TRANSPARENTE T/COLOR', 'images/catalogo/4af3834a84a44509d562bb13db7fb0ffa8883cbf.jpg', 1, 24, 59, 1, 'UNIDAD', 0, 1, 1, 0),
(278, '0', '0.50 COLOR T/COLOR', 'images/catalogo/115ddcbd432a59888a3576bd72dd2d37b9026328.png', 1, 24, 59, 1, 'UNIDAD', 0, 1, 1, 0),
(279, '0', '0.95 TRANSPARENTE T/ COLOR', 'images/catalogo/1bc48203aac07b595fef4353539b639a334a6b0b.jpg', 1, 20, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(281, '0', 'BACIN GRANDE', 'images/catalogo/7a0afe96c7c3fa19fa7b6bb0d632fd4a9a9cfcc2.jpg', 1, 65, 60, 1, 'UNIDAD', 0, 1, 1, 0),
(282, '0', 'CORAZON COLORES SURTIDOS', 'images/catalogo/4251dbbfd397cf11690851cab2c38f40f9cb11d3.jpg', 1, 79, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(283, '0', 'MINI CORAZON COLORES SURTIDOS', 'images/catalogo/49e5c6d743eca59a12259803094228a4aa2c089b.jpg', 1, 79, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(284, '0', 'RECTANGULAAR 0.60 TRANSPARENTE T/COLOR', 'images/catalogo/6033774c32498c19297908d026c287ae13117fda.jpg', 1, 24, 60, 1, 'UNIDAD', 0, 1, 1, 0),
(285, '0', 'RECTANGULAR 0.30 TRANSPARENTE T/COLOR', 'images/catalogo/ed4fc39fffd63a5a5f1d9c3a9a0a08fd20b146d8.jpg', 1, 24, 60, 1, 'UNIDAD', 0, 1, 1, 0),
(286, '0', 'CON BROCHE 0.60 TRANSPARENTE T/COLOR', 'images/catalogo/95599317136428b44def9328808ee28eb9b395dc.jpg', 1, 24, 60, 1, 'UNIDAD', 0, 1, 1, 0),
(287, '0', 'CON BROCHE 0.60 COLOR T/COLOR', 'images/catalogo/fc0af4631a25ad524febc80aae42698d36aa6863.jpg', 1, 24, 60, 1, 'UNIDAD', 0, 1, 1, 0),
(288, '0', 'SUPER N°140 GOLIAT C/TAPA BOMBA', 'images/catalogo/3224d64c5f45c02ee0733b3317d9ed975ba357d4.jpg', 1, 51, 57, 1, 'UNIDAD', 0, 1, 1, 0),
(289, '0', '12 LITROS TRANSPARENTE  C/TAPA', 'images/catalogo/9b993cdc3b1fc67fc00446c7952ce81a2ca068ae.jpg', 1, 2, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(290, '0', '12 LITROS COLOR  C/ TAPA- CUERPO', 'images/catalogo/d5c49e44ab4a5a1e43804a4902a10705bc156959.jpg', 1, 2, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(291, '0', '20 LITTROS TRANSPARENTE C/TAPA', 'images/catalogo/fa3ba810820dacc21a330e816ebdf9c33882aac5.jpg', 1, 2, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(292, '0', 'REDONDA N°3', 'images/catalogo/3721e36cfa29db7cb51e7e2482fe05b377fb1807.jpg', 1, 35, 57, 1, 'UNIDAD', 0, 1, 1, 0),
(293, '0', 'REDONDA N°5', 'images/catalogo/6e42b889e871507ac236504ec2ab8e8448dc8432.png', 1, 35, 57, 1, 'UNIDAD', 0, 1, 1, 0),
(294, '0', 'REDONDA  N°9', 'images/catalogo/6ea4326bf31eba9d0492294aa74451fe6042ebc2.jpg', 1, 35, 57, 1, 'UNIDAD', 0, 1, 1, 0),
(295, '0', 'REDONDA N° 10', 'images/catalogo/79d78100428fd8f1f5ac1ad6dee1f7ac2a1108dd.jpg', 1, 35, 57, 1, 'UNIDAD', 0, 1, 1, 0),
(296, '0', 'ROBUSTIN  GRANDE', 'images/catalogo/0d7572645b8418abadd5b3afdd0c1f9ba79786d4.jpg', 1, 65, 57, 1, 'UNIDAD', 0, 1, 1, 0),
(297, '0', 'GRANDE FAMILIAR', 'images/catalogo/cf2efb2c360a1bfe5fa5c365b60276d28cbfca77.jpg', 1, 1, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(298, '0', '1 KILO  COLORES', 'images/catalogo/6fea16e5c4d93cced50119e5c3d88654e62f6d20.jpg', 1, 2, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(299, '0', '1/2 LITRO COLORES', 'images/catalogo/28f461e71278f0f47c8dfa77e4b1579c19dc1f4c.jpg', 1, 2, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(300, '0', 'COLONIAL ESPECIAL ', 'images/catalogo/9c55e6af5132524d1bf73bb90143bac4c2065ce1.jpg', 1, 59, 61, 1, 'UNIDAD', 0, 1, 1, 0),
(301, '0', '2.5 LITROS COLORES C/VASO', 'images/catalogo/f5399140f21fb0a4e44e89b24b107eea6acb359a.jpg', 1, 59, 61, 1, 'UNIDAD', 0, 1, 1, 0),
(302, '0', '2.5 COLORES S/ VASO ', 'images/catalogo/39e78863e77a1472ec89336dffeda9619d649ec5.jpg', 1, 59, 61, 1, 'UNIDAD', 0, 1, 1, 0),
(303, '0', '2.5 LITROS TRANSPARENTE S/ VASO', 'images/catalogo/0a2d74cdb41445e6bc0d83e5ec0f269aab5f4013.jpg', 1, 59, 61, 1, 'UNIDAD', 0, 1, 1, 0),
(304, '0', '2.5 LITROS TRANSPARENTE C/ VASO', 'images/catalogo/711aa4cf2235b520015fc465f5e17b4b0dc8876b.jpg', 1, 59, 61, 1, 'UNIDAD', 0, 1, 1, 0),
(305, '0', 'LA REGALONA 26 LITROS DE COLORES', 'images/catalogo/c74f1d77566fb1d31929a42df30046d341b8a116.jpg', 1, 61, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(306, '0', 'ELEGANTE', 'images/catalogo/33afacc190e81e6e43c0147d8f2c2e714ea7a34f.jpg', 1, 29, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(307, '0', 'TRANSPARENTE 350 ML', 'images/catalogo/5857ddc3387a33e714bda3bbfac3f595529cac18.jpg', 1, 24, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(308, '0', 'TRANSPARENTE 700 ML', 'images/catalogo/e3df1cc5064a0accf840accccce975c78c697e56.jpg', 1, 24, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(310, '0', 'N° 25 C/TAPA', 'images/catalogo/73c937d55a157a6debd9c75b9dd8b0d083ef2bd8.jpg', 1, 51, 57, 1, 'UNIDAD', 0, 1, 1, 0),
(311, '0', 'CON TAPA COLORES VARIADOS', 'images/catalogo/ec24bb2ba58b6d61a1fe0540e671bb23e479cddd.jpg', 1, 51, 57, 1, 'UNIDAD', 0, 1, 1, 0),
(312, '0', 'REDONDO II', 'images/catalogo/1917e91ff0df4e63e6d9166a7c4e9b1e506a562b.jpg', 1, 45, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(313, '0', 'DOÑA FLOR ', 'images/catalogo/2c2da1f4683a108d9d7dac8f099053f5da4f93db.jpg', 1, 54, 57, 1, 'UNIDAD', 0, 1, 1, 0),
(314, '0', 'ESCOBESTIA', 'images/catalogo/47f84a511b1fea5f03268773ab898f3d7756bad8.jpg', 1, 54, 57, 1, 'UNIDAD', 0, 1, 1, 0),
(315, '0', 'ESCOBON', 'images/catalogo/b3c6eba02803553959aa72c0c6ca5d3f62fc6fbd.jpg', 1, 54, 57, 1, 'UNIDAD', 0, 1, 1, 0),
(316, '0', 'HOGAREÑA', 'images/catalogo/522b0a619ce8d13a70f511e401fe725ab9874a7b.jpg', 1, 54, 57, 1, 'UNIDAD', 0, 1, 1, 0),
(317, '0', 'LAVATODO', 'images/catalogo/6dd4ff8be28cd6beeef25a478c35d4c09826d58c.png', 1, 54, 57, 1, 'UNIDAD', 0, 1, 1, 0),
(318, '0', 'ESTRELLA', 'images/catalogo/4cc206ae884acaad2f39c45034d9dec9fed959d7.png', 1, 81, 57, 1, 'UNIDAD', 0, 1, 1, 0),
(319, '0', 'DE BASURA', 'images/catalogo/2752980514dca4881826d6d23d76e87948e26a4a.jpg', 1, 82, 57, 1, 'UNIDAD', 0, 1, 1, 0),
(320, '0', 'DE LIMPIEZA TATAY', 'images/catalogo/0f71ed8d7bf7f087a3c639cb16703f4235e3700b.png', 1, 72, 57, 1, 'UNIDAD', 0, 1, 1, 0),
(321, '0', '1.1 LTIROS TRANSPARENTE S/T', 'images/catalogo/d684564929d779e1a68906bc93b7ace45e9d7157.jpg', 1, 59, 62, 1, 'UNIDAD', 0, 1, 1, 0),
(322, '0', '1 LITRO TRANSPARENTE C/T COLOR', 'images/catalogo/9785fe7da57d443ac1515742d2b3deff62875e62.jpg', 1, 59, 36, 1, 'DOCENA', 0, 1, 1, 0),
(323, '0', '1/2 LITRO TRANSPARENTE C/T COLOR', 'images/catalogo/ed56217ddc8cc059d61239d752eb03527253bb3c.jpg', 1, 59, 36, 1, 'DOCENA', 0, 1, 1, 0),
(324, '0', 'CASTILLO', 'images/catalogo/3ac49fdb63648acf027eadb226cb8be25c8d9694.jpg', 1, 2, 63, 1, 'DOCENA', 0, 1, 1, 0),
(325, '0', 'N°1X12', 'images/catalogo/509f1205826c05a8de977a1131f18a2817044c16.jpg', 1, 14, 63, 1, 'DOCENA', 0, 1, 1, 0),
(326, '0', 'N° 2X12', 'images/catalogo/1016f9be4f5bc79506179dc8a97e5d438568cda5.jpg', 1, 14, 63, 1, 'DOCENA', 0, 1, 1, 0),
(327, '0', 'GIGANTE', 'images/catalogo/38ba7a6002b26f598137ce674bd170c75933ef1f.jpg', 1, 14, 63, 1, 'DOCENA', 0, 1, 1, 0),
(328, '0', 'COCO N°2', 'images/catalogo/c2d7e0aca24469b482879269776eb66e244025bd.jpg', 1, 45, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(329, '0', 'COCO N °3', 'images/catalogo/db51a9b087ae8706b02d541548ff1f01a29ff294.jpg', 1, 45, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(330, '0', 'N°18', 'images/catalogo/ad31ca4e736245da7559d43c0d558a50c949ad6a.jpg', 1, 61, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(331, '0', 'CHICO', 'images/catalogo/f550d92ae6cf8bb1184f39683108bb5dc62df448.jpg', 1, 27, 65, 1, 'UNIDAD', 0, 1, 1, 0),
(334, '0', 'GRANDE COLORES', 'images/catalogo/750fd12f80194e1d0f30494f86be2c72b1b37b4f.jpg', 1, 27, 65, 1, 'UNIDAD', 0, 1, 1, 0),
(335, '0', '2 LTS. TRANSPARENTE CT COLOR', 'images/catalogo/0b3c1ed583f23be79ae9765f2bb31c07dbc32cb3.jpg', 1, 2, 35, 1, 'UNIDAD', 0, 1, 1, 0),
(336, '0', '500 ML TRANSPARENTE C/T COLOR', 'images/catalogo/8384014779fd8fc9b19a5949a85cdb834658d211.jpg', 1, 59, 36, 1, 'DOCENA', 0, 1, 1, 0),
(337, '0', '1.1 KILO TRANSPARENTE C/T COLOR', 'images/catalogo/5a7b8a3d84e92ab4262cc8c56e9f9e08fa0c315e.jpg', 1, 24, 33, 1, 'DOCENA', 0, 1, 1, 0),
(338, '0', '1.1 KILO COLOR C/T COLOR ', 'images/catalogo/b3fd48a9b3c80193f5e2b1a750c814002a20d817.jpg', 1, 24, 33, 1, 'DOCENA', 0, 1, 1, 0),
(339, '0', 'PLASTICO N° 42 COLORES', 'images/catalogo/2ce77c783784450aa834ec1106763f4227693a7b.jpg', 1, 45, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(340, '0', 'N°18 COLORES', 'images/catalogo/4d1b4806e4981e562e47fa2d228a18b062083f3b.jpg', 1, 61, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(342, '0', 'TINA 40 LITROS', 'images/catalogo/5a7f9426ad98b61e346deb3a98d0f62bc825d98e.jpg', 1, 61, 66, 1, 'UNIDAD', 0, 1, 1, 0),
(343, '0', 'TINA 40 LITS', 'images/catalogo/ee594169500e954c4349cd1979d163dd91db1300.jpg', 1, 61, 54, 1, 'UNIDAD', 0, 1, 1, 0),
(344, '0', 'TINA DE 40 LITROS', 'images/catalogo/427d76a539549591f4961ab15aac6a53f53c386e.jpg', 1, 61, 68, 1, 'UNIDAD', 0, 1, 1, 0),
(345, '0', '30 LITROS', 'images/catalogo/5087a91a046774d8c0c946e81aca5055a2b8579e.jpg', 1, 61, 67, 1, 'UNIDAD', 0, 1, 1, 0),
(346, '0', '50 LITROS', 'images/catalogo/fe1ca868389748d6e26db77c881326c300540431.jpg', 1, 51, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(347, '0', '80 LITROS ', 'images/catalogo/89e135711616363291a53faa81e16b3175a47425.jpg', 1, 61, 66, 1, 'UNIDAD', 0, 1, 1, 0),
(348, '0', 'PLASTICAS ', 'images/catalogo/56cd3ff9aa580c84de206fec838be62866f32b2d.jpg', 1, 61, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(349, '0', 'COLORES N° 18', 'images/catalogo/0c6b1eb6bf3766be75f85e76056389e480c9baf0.jpg', 1, 66, 69, 1, 'UNIDAD', 0, 1, 1, 0),
(350, '0', 'N° 46 SEMI', 'images/catalogo/802c19c2eac2da0282f3577cb6c743baa41ba00b.jpg', 1, 45, 56, 1, 'UNIDAD', 0, 1, 1, 0),
(352, '0', '4 LITROS TRANSPARENTE C/TAPA', 'images/catalogo/f88c1072b102c657fab04639568d2410383324f6.jpg', 1, 59, 70, 1, 'UNIDAD', 0, 1, 1, 0),
(353, '0', 'DECORADO CON TAPA', 'images/catalogo/a29b334d5bce101540d9f53917e730df0eb53199.jpg', 1, 20, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(354, '0', 'K-192 500 ML', 'images/catalogo/cf5ebb6abd015a3135ce71075da3cd7dc2193039.jpg', 1, 83, 8, 1, 'UNIDAD', 0, 1, 1, 0),
(355, '0', 'H-373 650 ML', 'images/catalogo/18fe4eee6b3168e213dcf7e0e616a39eb1a273c9.jpg', 1, 83, 8, 1, 'UNIDAD', 0, 1, 1, 0),
(356, '0', 'H-558 300ML', 'images/catalogo/085849fab73c0b77d351462a5c0ad916bafc8745.jpg', 1, 83, 8, 1, 'UNIDAD', 0, 1, 1, 0),
(357, '0', 'H-096 1000 ML', 'images/catalogo/6abc622fe445d7d04f8ebfb85e93a0dc7fe11a8b.jpg', 1, 83, 8, 1, 'UNIDAD', 0, 0, 1, 1),
(358, '0', 'H-512 400 ML', 'images/catalogo/d7aad76164e80a313d09d3144945f3bf8de3653f.jpg', 1, 83, 8, 1, 'UNIDAD', 0, 1, 1, 0),
(359, '0', 'UTILISIMO', 'images/catalogo/a99eeec89cd7519ea3eb745e5362b67f74ab14c1.jpg', 1, 29, 8, 1, 'UNIDAD', 0, 1, 1, 0),
(360, '0', 'GARDEÑA 40 LTS C/ASAS JABONERA Y PICO - SEMI', 'images/catalogo/b664e8489e972882047b374c25e18b43763c4862.jpg', 1, 35, 5, 1, 'UNIDAD', 0, 1, 1, 0),
(362, '0', 'LIZ 2DA', 'images/catalogo/e1ab508fd736c1724181f856b0baf63b615de1e9.jpg', 1, 84, 71, 1, 'UNIDAD', 0, 1, 1, 0),
(363, '0', 'DECORADO ', 'images/catalogo/d9dbc5b8fc5d6fd7b7deacf9fb281ab969fd5e4c.jpg', 1, 71, 72, 1, 'UNIDAD', 0, 1, 1, 0),
(364, '0', 'MADRID COLOR ENTERO X3', 'images/catalogo/7838537fa6b4423ec47d8d86cfa8ca1e00384318.jpg', 1, 67, 13, 1, 'UNIDAD', 0, 1, 1, 0),
(365, '0', 'BARCELONA COLOR ENTERO X4', 'images/catalogo/4ada65dc01a51e09d1b3d0f32e19a21aede3bc7d.jpg', 1, 67, 13, 1, 'UNIDAD', 0, 1, 1, 0),
(366, '0', '1.1 LITROS TRANSP. DEC. C/TAPA COLOR ', 'images/catalogo/eb4da5185d04641f73aa856aee27aecd57b31b42.jpg', 1, 59, 13, 1, 'DOCENA', 0, 1, 1, 0),
(367, '0', 'WAYRA MEJORADO 8 LITROS COLOR C/TAPA COLOR', 'images/catalogo/ebbb4a838baa3492bea458e10cd3977009cc0a76.jpg', 1, 2, 13, 1, 'UNIDAD', 0, 1, 1, 0),
(368, '0', 'MULTICOLOR QELLA II', 'images/catalogo/a3b83a52b4253c16444afb5e3a89c00cb1f2f3cd.jpg', 1, 71, 13, 1, 'UNIDAD', 0, 1, 1, 0),
(369, '0', 'ART. N°14 (500ML) COLORES SURTIDOS ', 'images/catalogo/ebfa79883cd7dcd27550d000d6a03a3c9fc64b7e.jpg', 1, 27, 73, 1, 'UNIDAD', 0, 1, 1, 0),
(370, '0', 'ART. N° 15 (1000ML) COLORES SURTIDOS', 'images/catalogo/0558a688663c027448f74babd9c71ea510529890.jpg', 1, 27, 73, 1, 'UNIDAD', 0, 1, 1, 0),
(371, '0', 'N° 0858', 'images/catalogo/b4a1c8a505d7dddb1ba968a229d01e0273f31608.jpg', 1, 85, 14, 1, 'DOCENA', 0, 1, 1, 0),
(372, '0', 'N° 11 C', 'images/catalogo/64b926ae97048e5f75fd5e92f7327d154a8f9ce1.jpg', 1, 85, 14, 1, 'DOCENA', 0, 1, 1, 0),
(373, '0', 'OVALADO N° 16B', 'images/catalogo/7230f24ba8201349cf4b2cf93e1a4ed9eebc027b.jpg', 1, 86, 14, 1, 'DOCENA', 0, 1, 1, 0),
(374, '0', 'N° 37', 'images/catalogo/07ac338b076f162b17e1c7e0c3286d294c1de5bb.jpg', 1, 85, 14, 1, 'DOCENA', 0, 1, 1, 0),
(375, '0', 'CON OREJAS N° 16G', 'images/catalogo/996b443f817f6abb1e7c46bc71ed92310fb2b269.jpg', 1, 57, 14, 1, 'DOCENA', 0, 1, 1, 0),
(376, '0', 'GIRASOL N° 31L', 'images/catalogo/ed2eb641933815786a0716f2500bb2307417fc5f.jpg', 1, 87, 14, 1, 'DOCENA', 0, 1, 1, 0),
(377, '0', 'HONDO SOPERO N° 22B', 'images/catalogo/08fed256bab241eb70046f6038d6f1830a9c8573.jpg', 1, 57, 14, 1, 'UNIDAD', 0, 1, 1, 0),
(378, '0', 'GRANDE N° 17B', 'images/catalogo/134ae71f3d98eb31114354424baf68f40684f89c.jpg', 1, 86, 14, 1, 'DOCENA', 0, 1, 1, 0),
(379, '0', 'HONDO ENCONCHADO N° 18L', 'images/catalogo/fe4d4179d94cdccf0c3e58586d697ee9e2141a0e.jpg', 1, 57, 14, 1, 'UNIDAD', 0, 1, 1, 0),
(380, '0', 'HONDO LABRADO N° 225M', 'images/catalogo/bcb66849d4fcc99f1828946ed7057f221b592c33.jpg', 1, 57, 14, 1, 'DOCENA', 0, 1, 1, 0),
(381, '0', 'TENDIDO LABRADO N° 23M', 'images/catalogo/3b97cdf79eefdcdef261abff9418167a19a1c8b9.jpg', 1, 57, 14, 1, 'DOCENA', 0, 1, 1, 0),
(382, '0', 'HONDO N° 20 LA', 'images/catalogo/83566361bb674473968a4f5c617bb9baca9474c0.jpg', 1, 57, 14, 1, 'DOCENA', 0, 1, 1, 0),
(383, '0', '1.5 LITRO CON TAPA ', 'images/catalogo/bbed07200d854ac4c0dc016ca6df6499f6989f49.jpg', 1, 59, 14, 1, 'DOCENA', 0, 1, 1, 0),
(384, '0', 'HONDO N° 08', 'images/catalogo/7e277ebd2ee3eb9089b4600cc9dbb7518351f253.jpg', 1, 57, 14, 1, 'DOCENA', 0, 1, 1, 0),
(385, '0', 'HODO LABRADO N°13M', 'images/catalogo/261009b14317f7475c87441a52250212c8d78323.jpg', 1, 57, 14, 1, 'DOCENA', 0, 1, 1, 0),
(386, '0', 'HONDO N° 21B', 'images/catalogo/e3a960699c1f9bff60153ad421be0bffb2b33b3f.jpg', 1, 57, 14, 1, 'DOCENA', 0, 1, 1, 0),
(387, '0', 'HONDO LABRADO N° 25L', 'images/catalogo/5930fcdd515c3b31fc377831c52a816921e27cc5.jpg', 1, 57, 14, 1, 'DOCENA', 0, 1, 1, 0),
(388, '0', 'TENDIDO LABRADO N° 16M', 'images/catalogo/cd9b9f808a0a7a2f3d399f1877204a84562e5fe7.jpg', 1, 57, 14, 1, 'DOCENA', 0, 1, 1, 0),
(389, '0', 'POSTRE N° 19', 'images/catalogo/2ac40174a8e93d9e39f174fb5dfc088d76e610a6.jpg', 1, 57, 14, 1, 'DOCENA', 0, 1, 1, 0),
(390, '0', 'DE TE N° 10B', 'images/catalogo/4e7f75b9f7d5d6ea587f06a6a6b976e815a3a093.png', 1, 25, 14, 1, 'DOCENA', 0, 1, 1, 0),
(391, '0', 'FELIZ ', 'images/catalogo/18a958c6cd3417bf76a1fd82890941fa23238085.jpg', 1, 71, 74, 1, 'UNIDAD', 0, 1, 1, 0),
(392, '0', '160 GUINDA PODEROSO ', 'images/catalogo/3653e29952071ad88663f820f867238994f040ad.jpg', 1, 88, 45, 1, 'UNIDAD', 0, 1, 1, 0),
(393, '0', '160 AZUL PODEROSO', 'images/catalogo/42997162b7f0d97d84f0a9601e59b990abb41ff2.jpg', 1, 88, 45, 1, 'UNIDAD', 0, 1, 1, 0),
(394, '0', '75 PODEROSO GUINDA', 'images/catalogo/9016a6553720694581d1a8551874d7abb9e3b909.jpg', 1, 88, 45, 1, 'UNIDAD', 0, 1, 1, 0),
(395, '0', 'GIGANTE NARANJA', 'images/catalogo/d69f24e21458a324c16c226be50fa60b8a906fcb.jpg', 1, 69, 3, 1, 'UNIDAD', 0, 1, 1, 0),
(396, '0', 'GIGANTE ROJO', 'images/catalogo/c70479b335249f3312fc70464d1ee9e97af3c43f.jpg', 1, 69, 3, 1, 'UNIDAD', 0, 1, 1, 0),
(397, '0', 'GIGANTE VERDE TELFONICA', 'images/catalogo/48ca664a47cbf34aa85ef93e3348078a2437cf89.jpg', 1, 69, 3, 1, 'UNIDAD', 0, 1, 1, 0),
(398, '0', 'GIGANTE AZUL ITALIA', 'images/catalogo/3fb7906836c7422ec46cd3fa9538dd05d52bab20.jpg', 1, 69, 3, 1, 'UNIDAD', 0, 1, 1, 0),
(399, '0', 'GIGANTE TURQUESA', 'images/catalogo/ef3c823ff373f44a05254584ed53223888c95edd.jpg', 1, 69, 3, 1, 'UNIDAD', 0, 1, 1, 0),
(400, '0', 'GIGANTE FUCSIA  EXP', 'images/catalogo/4fefde376376a44d07ee8c1ecb00c4aaddf5c6e6.JPG', 1, 69, 3, 1, 'UNIDAD', 0, 1, 1, 0),
(401, '0', 'HOGAR ', 'images/catalogo/77cea54e4edc8b64ab2bd422cf5d9308401232c8.jpg', 1, 69, 9, 1, 'UNIDAD', 0, 1, 1, 0),
(402, '0', 'BB ANATONICA CHICA', 'images/catalogo/d4f9dbd9b86b52d6a02252c2e34e3389d294447b.jpg', 1, 49, 9, 1, 'UNIDAD', 0, 1, 1, 0),
(403, '0', 'VENUS TRANSPARENTE', 'images/catalogo/03218324b7fb6347b34e82c1e983fcfa3f52f027.jpg', 1, 24, 9, 1, 'UNIDAD', 0, 1, 1, 0);
INSERT INTO `tb_catalogo` (`idct`, `cod_barra`, `nom`, `imagen`, `ida`, `idg`, `idm`, `ids`, `unid`, `stk`, `stk_min`, `est`, `opcdistri`) VALUES
(404, '0', 'COMODINA N° 6(CAJA)', 'images/catalogo/596525db112251b997e2f1a40841b8f85eb2ae37.jpg', 1, 63, 9, 1, 'UNIDAD', 0, 1, 1, 0),
(406, '0', 'DE COLORES ', 'images/catalogo/107fe360197d26c4aaf39885b11308daf29ba82b.jpg', 1, 24, 9, 1, 'UNIDAD', 0, 1, 1, 0),
(407, '0', 'ITALIANO 1 KG TRANSPARENTE C/TAPA', 'images/catalogo/8de7d99ca1b9cff9af30098f07b85fb5b76e27b6.jpg', 1, 24, 9, 1, 'UNIDAD', 0, 1, 1, 0),
(408, '0', '1KG ITALIANO COLOR C/TAPA', 'images/catalogo/ae928ce4ef07fe7fc0dc9fdf745bceaf04f8645f.jpg', 1, 24, 9, 1, 'UNIDAD', 0, 1, 1, 0),
(409, '0', 'BUZON RECTANGULAR N° 80 TAPA VAIVEN', 'images/catalogo/00dff1f0a3f46cde0f5361305508b2ab313ec30a.jpg', 1, 88, 9, 1, 'UNIDAD', 0, 1, 1, 0),
(410, '0', 'PAPELERA ARTUR N° 80 ', 'images/catalogo/852c56e89203f519ecc5e82af2aa04f4ed7101d0.jpg', 1, 88, 9, 1, 'UNIDAD', 0, 1, 1, 0),
(411, '0', '16 LITROS TR ANSPARENTE C/ TAPA', 'images/catalogo/49dc163775b42647590b6f13fb6691851b4231aa.jpg', 1, 2, 9, 1, 'UNIDAD', 0, 1, 1, 0),
(412, '0', 'MEGA DUBAI', 'images/catalogo/0f7266df7de95a8768541a7dd807a8f25c9dce6e.jpg', 1, 44, 9, 1, 'UNIDAD', 0, 1, 1, 0),
(413, '0', 'ARTUR N° 18', 'images/catalogo/fdca5111924370097272cb3e4cf231ade41bb75f.jpg', 1, 66, 9, 1, 'UNIDAD', 0, 1, 1, 0),
(414, '0', 'SUPER AVALADA N° 120', 'images/catalogo/da1d50d16229327623be46a8960405634e1549b3.jpeg', 1, 35, 9, 1, 'UNIDAD', 0, 1, 1, 0),
(415, '0', 'LISO POLIN INMOLD DISEÑOS VARIADOS', 'images/catalogo/c506d9025a3ce945ef45d6d71627a67420ef57a0.jpg', 1, 30, 51, 1, 'UNIDAD', 0, 1, 1, 0),
(416, '0', 'OVALADO CHICO II', 'images/catalogo/1500f5fd0ea17bff1cb556937cba0a0887b1fca0.jpg', 1, 27, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(417, '0', '100 PODEROSO GINDA', 'images/catalogo/26097bcd6cde3bfe7e1b29cc73cc716fb5d101aa.jpg', 1, 61, 3, 1, 'UNIDAD', 0, 1, 1, 0),
(418, '0', '100 PODEROSO AZUL', 'images/catalogo/96e19224b9d02186d71aa4d407b1cd95d1b07827.jpg', 1, 61, 3, 1, 'UNIDAD', 0, 1, 1, 0),
(419, '0', 'MARINA SOLIDO CELESTE ', 'images/catalogo/1e0bb133f02f818434880c934b86b9883d3ec1c3.jpg', 1, 49, 3, 1, 'UNIDAD', 0, 1, 1, 0),
(420, '0', 'MARINA SOLIDO ROSADO', 'images/catalogo/4e30a604c545773db1c5113d03d572f156cefe2e.jpg', 1, 49, 3, 1, 'UNIDAD', 0, 1, 1, 0),
(421, '0', 'GRANDE NARANJA ', 'images/catalogo/a52b1b118b52a487c9af1f9be4b868d25f5bce29.jpg', 1, 89, 3, 1, 'UNIDAD', 0, 1, 1, 0),
(422, '0', 'GRANDE AZUL ITALIA', 'images/catalogo/4c7aa4a272f82dee4979921c6b5049fb4bde7d2e.jpg', 1, 89, 3, 1, 'UNIDAD', 0, 1, 1, 0),
(423, '0', 'GRANDE VERDE TELEFONICA ', 'images/catalogo/70f828e08f4a119608a2317af26939478f8df3c4.jpg', 1, 89, 3, 1, 'UNIDAD', 0, 1, 1, 0),
(424, '0', 'GRANDE ROJO', 'images/catalogo/4d27b097c29a16ae6dbbf36f09b9e9f78fe86c29.png', 1, 89, 3, 1, 'UNIDAD', 0, 1, 1, 0),
(425, '0', 'GRANDE BLANCO', 'images/catalogo/fd6ce12225cb381e85968fc46eebca1c9c5b585a.png', 1, 89, 3, 1, 'UNIDAD', 0, 1, 1, 0),
(426, '0', 'GRANDE ALMENDRA', 'images/catalogo/19405466687502d668405644d3c1d61a8271b136.png', 1, 89, 3, 1, 'UNIDAD', 0, 1, 1, 0),
(427, '0', 'IBIZA AZUL ITALIA ', 'images/catalogo/8f26bb52a6104b0f4d53e263c3bd376a238b8d61.jpg', 1, 60, 3, 1, 'UNIDAD', 0, 1, 1, 0),
(428, '0', 'CONFORTABLE BLANCO ', 'images/catalogo/0211cedea2954266314495f6cbc9a9b40da0f23d.jpg', 1, 60, 3, 1, 'UNIDAD', 0, 1, 1, 0),
(429, '0', 'CONFORTABLE ROJO', 'images/catalogo/9b1363542c1e4c483fb10c003ec4bf0574761f76.jpg', 1, 60, 3, 1, 'UNIDAD', 0, 1, 1, 0),
(430, '0', 'CONFORTABLE ALMENDRA', 'images/catalogo/217527792c2ceff16e6bb319a1c8d7d114f113cb.jpg', 1, 60, 3, 1, 'UNIDAD', 0, 1, 1, 0),
(431, '0', 'CONFORTABLE VERDE TELEFONICA', 'images/catalogo/ede3a98b2361fca3bb38eadfa71024c8ace29200.png', 1, 60, 3, 1, 'UNIDAD', 0, 1, 1, 0),
(432, '0', 'ICONFORTABLE AZUL ATALIA', 'images/catalogo/d985c357ade2e1b2d897cc752fedfa8a416b5ca5.jpg', 1, 60, 3, 1, 'UNIDAD', 0, 1, 1, 0),
(433, '0', 'BUSON CLASICO N° 80 AZUL', 'images/catalogo/f004c3a7a4001f837a1d0ce5247f6bf7a505d6dd.jpg', 1, 66, 3, 1, 'UNIDAD', 0, 1, 1, 0),
(434, '0', 'IBAZA VERDE TEELFONICA', 'images/catalogo/b49aaecf53b16cb70acb41aa1595da40ad644187.png', 1, 60, 3, 1, 'UNIDAD', 0, 1, 1, 0),
(435, '0', 'IBAZA ROJO', 'images/catalogo/ee9e40b34cc8c4ec9a8552f14e8de34bcb9ef3c4.jpg', 1, 60, 3, 1, 'UNIDAD', 0, 1, 1, 0),
(436, '0', 'IBAZA BLANCO', 'images/catalogo/8663d31a46192d2056bf54bf8d3361e0cf717bd2.png', 1, 60, 3, 1, 'UNIDAD', 0, 1, 1, 0),
(437, '0', 'IBAZA ALMENDRA', 'images/catalogo/400c5203e546772d410ecb9fed233d03312c1e66.png', 1, 60, 3, 1, 'UNIDAD', 0, 1, 1, 0),
(438, '0', 'DOBLE MEDIDA - JUEGO X 4', 'images/catalogo/d063a4c8300d1e4e5b25084ee881ba992e7c5030.jpg', 1, 48, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(439, '0', 'PARAISO - JUEGO X3 NIVELES', 'images/catalogo/d5cbc8743de7bf32eecef2121d22ac67faec7ff5.jpg', 1, 67, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(440, '0', 'GIGANTE DE LUXE DE 3 NIVELES C/ RUEDA', 'images/catalogo/254b3519d2ce415b1fbfb58c735af0c72c21acd2.jpg', 1, 67, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(441, '0', 'OVALADO FORTE 3 NIVELES', 'images/catalogo/7d915d46ab2712f71bd364ec460f30457e08ab4a.jpg', 1, 67, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(443, '0', 'CHICO DE LCOLORES', 'images/catalogo/ef17933ce5f217d9afd6228ece726fdde07b9941.png', 1, 14, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(444, '0', 'N° 140', 'images/catalogo/fd737cfbff012100368138400ecd6368c23a369a.jpg', 1, 14, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(445, '0', 'GOURMET 380 ML', 'images/catalogo/ff7a641cd85e81555a61342a6432dd0cf4c1229f.jpg', 1, 74, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(446, '0', 'GOURMET 480 ML', 'images/catalogo/5ffc66a3e975f9ff13a52f9a0618ee6e0e77fea1.jpg', 1, 74, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(447, '0', 'GOURMET 880 ML', 'images/catalogo/1e89f3b224bf9256d1cfa4d61d88c780d0193ad4.jpg', 1, 74, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(448, '0', 'CEVICHERO ', 'images/catalogo/dec8736f89eac0dd3c95489b081090137763e032.jpg', 1, 42, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(450, '0', 'ESC. HOGAR', 'images/catalogo/d00543cc6695415b8f1a51e9759502c54e395e12.jpg', 1, 47, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(451, '0', 'GRANDE MISTURA  C/ BANDEJA INCLINADA', 'images/catalogo/9af4ad7034df044b348787ceec13913398bacea9.jpg', 1, 47, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(452, '0', 'ELECTRICO 2.5 LITROS C/ TAPA', 'images/catalogo/72f9cd0db913128d6d3d9cc2d8b3a91d85956e75.jpg', 1, 16, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(453, '0', 'REY C/TAPA ', 'images/catalogo/1eabcb5620098701f62e67562cbf47b016495fe6.jpg', 1, 34, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(454, '0', 'BONITA 2.5 LITROS C/TAPA', 'images/catalogo/0881ec28deb36739ca8031c1f6f05704767f3e23.jpg', 1, 59, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(455, '0', 'BOI 4.3 LITROS', 'images/catalogo/e2c826f48cf127c20babe4008529483d447dd595.png', 1, 59, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(456, '0', 'BONITA 4 LITROS C/TAPA', 'images/catalogo/9642992f54f52eced2b7d1823922b2ffc3fbda47.jpg', 1, 59, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(457, '0', 'REYWARE JUGUERA 1.0 LITROS C/TAPA', 'images/catalogo/90af245ce0077f497521b5c9d0db65acff61d63f.jpg', 1, 59, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(458, '0', 'MINI 0.5 LITROS C/TAPA ', 'images/catalogo/9bba571f129a50336e1c8e68ca4b971ea13e0352.jpg', 1, 59, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(459, '0', 'FAMILIAR 3 LITROS C/TAPA', 'images/catalogo/95f246c7a2526883db1d3d2c3689eabc3385c90e.jpg', 1, 59, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(460, '0', 'ZARAI 4 LITROS C/TAPA', 'images/catalogo/e5b70c82b069295b9a3a0a7110564d654cfd262c.jpg', 1, 59, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(461, '0', 'CRISTALUX 2.5 LITOS C/ TAPA', 'images/catalogo/92fd224664ca387b160c1c2a7116a446e827fb8d.jpg', 1, 59, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(462, '0', 'TULIPAN N° 23 C/BASE', 'images/catalogo/66cefd0689e8f64259d74b058235b38cd6b09c99.jpg', 1, 33, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(463, '0', 'TULIPAN N°19 C/BASE', 'images/catalogo/2dd6bb12b29932f633b7f065f10d892663c77b7d.jpg', 1, 33, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(464, '0', 'TULIPAN N° 16', 'images/catalogo/387a360b133e4c6e08e8ebe1c41608503cdeaf2d.jpg', 1, 33, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(465, '0', 'GRANDE CHEFF', 'images/catalogo/857189002bca970fed278b31de00f4bb4926de02.jpg', 1, 18, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(466, '0', 'COSMOS N° 15 CON TAPA', 'images/catalogo/1aa4efe2b133e8d92f5823ea45a857fcf7eaaa64.jpg', 1, 66, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(467, '0', 'COSMOS N° 20 C/TAPA', 'images/catalogo/42e88aad382e7e3543386caad0d3a1e69a9174a0.jpg', 1, 66, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(468, '0', 'MAGALY N° 15 C/TAPA', 'images/catalogo/63dfaf04b517720655b81e401c3ee84409f04a33.jpg', 1, 66, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(469, '0', 'MAGALY N° 20 C/TAPA', 'images/catalogo/167dbf102d5c9a68d0e11dad3ee7b93970bb9b1d.jpg', 1, 66, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(470, '0', 'VENUS N° 15 C/TAPA', 'images/catalogo/91ac542dab4de71a7550b1f7340a9fb1d02b4ecf.jpg', 1, 66, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(471, '0', 'VENUS N° 20 C/TAPA', 'images/catalogo/36994fc87982f8afb55507ca82aa8c276956d742.jpg', 1, 66, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(472, '0', 'AHORRA ESPACIO N° 18', 'images/catalogo/577c8919791358917a1429c61ff8dbb66af3052e.jpeg', 1, 66, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(473, '0', 'GALAX N° 15', 'images/catalogo/f3ce9c84dd25b2365241f4aa1561cc767a1bdca7.jpg', 1, 66, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(474, '0', 'GALAX N° 15 DECORADA', 'images/catalogo/83ff9ebd449f7856f6cacb5b44c19b86b9ba61dd.jpg', 1, 66, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(475, '0', 'GALAX N° 20', 'images/catalogo/3eac1049a88fddc8af933a3c47db42ae9a9aee7d.jpg', 1, 66, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(476, '0', 'GALAX N° 25', 'images/catalogo/b0bb13897018ca5d970fd1836ed57fb757485501.jpg', 1, 66, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(477, '0', 'MASCOTA RATONCITO N° 18', 'images/catalogo/037012f4ecbb9bf1c5c13641faca57cd26a1df27.jpg', 1, 66, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(478, '0', 'MASCOTA PERRITO N° 18', 'images/catalogo/667d70304201100f9789e4470167ac0117805f2f.jpg', 1, 66, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(479, '0', 'MASCOTA CANARIO N° 18', 'images/catalogo/e683520fecad863eaec8d71cbda05c4df402dc79.jpg', 1, 66, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(480, '0', 'MASCOTA GATITA', 'images/catalogo/d3036696a4f2b4ceed0f8a7a2b679d5d03e32faf.jpg', 1, 66, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(481, '0', 'AUTOMATICA DANUBIO N° 16', 'images/catalogo/9feee2e9e1d1bda5e558e9bf86308a21c972297c.jpg', 1, 66, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(482, '0', 'AUTOMATICA DANUBIO N° 25', 'images/catalogo/7ce7768e1f253567a7e686cb573308ae4d0d0927.jpg', 1, 66, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(483, '0', 'MASCOTA RANITA N° 18', 'images/catalogo/01839b0b9daa5ef0995e7b24084556c6c5064a9e.jpg', 1, 66, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(484, '0', 'HERMICO 0.5 LITROS C/ TAPA ROSCA', 'images/catalogo/b3eeb6e473ccb61c67daa1071f539056217f0e3c.jpeg', 1, 74, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(485, '0', 'HERMETICO 1 LITRO C/TAPA ROSCA ', 'images/catalogo/3141e98733aee3f8e3df54bf975a1777ccf3b736.jpg', 1, 74, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(486, '0', 'HERMETICO 2 LITROS C/TAPA ROSCA ', 'images/catalogo/ee5ad033c1ad3eff0f44d5f2dcf9ce9b7c195e5a.jpg', 1, 74, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(487, '0', 'HERMÉTICO CON TAPA ROSCA 0.75 LT', 'images/catalogo/3f4cf1be3e1327341a1703f8af3c4b6128d41edf.jpg', 1, 74, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(488, '0', 'HERMETICO CON TAPA ROSCA ANCHA 1.0 LT', 'images/catalogo/c1fc10ec994e3c5d858dd930ce1df891a9938921.jpg', 1, 74, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(489, '0', 'TAPER TWIST 1.0 LITROS C/ TAPA ROSCA ', 'images/catalogo/3e44e7fbcfeed1f132ba70b4bce0ab187279c918.jpg', 1, 74, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(490, '0', 'HERMETICO CON TAPA ROSCA 1.50 LT', 'images/catalogo/c0498ac679cdf4479d60069478d20c4fca6240d0.jpg', 1, 74, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(491, '0', 'GOURMET 0.8 LT', 'images/catalogo/797d3b63334583001826e9af2c1b00198733f81c.jpg', 1, 24, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(492, '0', 'GOURMET 1.9 LITROS', 'images/catalogo/f298c5904c3a2575abbc4280f1b201bea5f18529.jpg', 1, 24, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(493, '0', 'HERMÉTICO REY 350 ML. SORBETE', 'images/catalogo/bdefae3a9f3cc15eab5a39cdac24c1e59dd2373f.jpg', 1, 3, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(494, '0', 'HERMÉTICO REY 350 ML PRESS', 'images/catalogo/a0a022141949dc2d9ddf6ae203cf78be6235771b.jpg', 1, 3, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(495, '0', 'HERMETICO REY 500 ML SORBETE', 'images/catalogo/2610015beb58c7f2c9c1e028fbd95b07b0397f7e.jpg', 1, 3, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(496, '0', 'HERMETICO REY 500 ML PRESS', 'images/catalogo/f241edeee9ec45eb55a6b6bb8ec9e3c7ad007721.jpg', 1, 3, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(497, '0', 'BIO LIFE 320 ML COBERTOR', 'images/catalogo/d1273333d69ef3f7306bed63bc5a629c2313fa8f.jpg', 1, 3, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(498, '0', 'SALSA X 3PIEZAS ', 'images/catalogo/c0efd3eec4c5e96b63de0ccdabc6115cacd4d8a9.jpg', 1, 29, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(499, '0', 'SUPER PREMIUM', 'images/catalogo/ded8b3b1da5c0bc409f54a2e80f2657367f1495b.jpg', 1, 29, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(500, '0', 'TROPICAL', 'images/catalogo/a5e0dac8b4663c9f032a8022f258223937e5f0c3.jpeg', 1, 30, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(501, '0', 'GIGANTE 5 PISOS C/TAPA TOCADOR ', 'images/catalogo/aefaa5f4d7226b38ea7c0f68f638133acae4081b.jpg', 1, 63, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(502, '0', 'GIGANTE D 6 PISOS C/TAPA TOCADOR', 'images/catalogo/1744caf529581614d8ee4be975e1a107e87ae406.jpg', 1, 63, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(503, '0', 'GIGANTE DE 5 PISOS ', 'images/catalogo/f46a54ad87d4d01535f237a8a0c718506d62e93d.png', 1, 63, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(505, '0', 'GIGANTE DE 6 PISOS', 'images/catalogo/65d7b1797e3be7eb5f1a63bc5ec8762c0d186ce9.jpg', 1, 63, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(506, '0', 'GIGANTE 4 PISOS C/TAPA TOCADOR', 'images/catalogo/c8a2a86b0cc0c96889148071872de0cebb956b5d.jpeg', 1, 63, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(507, '0', 'DIAMANTE C/TAPA -PC', 'images/catalogo/ee3ba9f82a724e1cfbc857e72bd6707e7d5c975a.jpg', 1, 1, 1, 1, 'UNIDAD', 0, 0, 1, 1),
(508, '0', 'ANATOMICO CON TAPA -PC', 'images/catalogo/769d4a4476d05d75016f69b635a2a31e7d08e87d.jpg', 1, 65, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(509, '0', 'MASCOTA CON TAPA ', 'images/catalogo/4750309944f9399fc740269cb1e02e9ee0f503ca.jpg', 1, 65, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(510, '0', 'BABY KING DECORADO ', 'images/catalogo/c0143ddfd2cf67c80395dafc8a508101434c2f25.jpg', 1, 65, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(511, '0', 'SILLA CON TAPA', 'images/catalogo/0e838dcad29e62529008e6bc85344624afd05166.jpg', 1, 65, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(512, '0', 'DIDÁCTICO HIPPO', 'images/catalogo/aa313222380f019a7f23c95a9dc4f67744723f01.png', 1, 65, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(513, '0', 'SNACK', 'images/catalogo/080554c857aaaabeb4ebb775fc68cdfcac33db9e.jpg', 1, 91, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(514, '0', 'COMERCIAL 12 LT C/TAPA', 'images/catalogo/e0adff2e71935119b4ec7f91a54854b17e8ef9f9.jpg', 1, 2, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(515, '0', '15 LTS. CON PICO Y SUPER ASA ', 'images/catalogo/b531f0d544ee1a4cdaca9719eefa6a397262b313.jpg', 1, 2, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(516, '0', 'COMERCIAL 1 GL C/TAPA C/ASA DE METAL ', 'images/catalogo/a378f584f37ae0445228daebd33638d138529fea.jpg', 1, 2, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(517, '0', 'TRAPEADOR ESCURRIDOR GRANDE MÁGICO ', 'images/catalogo/ce9e013b483cb562a336f0d1f8170e3b0b235692.jpg', 1, 72, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(518, '0', 'TRAPEADOR ESCURRIDOR  GIGANTE MAGICO', 'images/catalogo/15dcf3ff644c5c9cd469ffa3991a0e37ba92c2c6.jpg', 1, 72, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(519, '0', 'IDEAL ', 'images/catalogo/bc5a342f6ecde89b027ee8dc88b5eb8eebbc64af.jpeg', 1, 71, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(520, '0', 'ATILA PREMIUM', 'images/catalogo/9cce828a4c63ab1e6eee1d9be8074e3cd5755922.jpg', 1, 71, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(521, '0', 'ROBUSTA N° 100 CLASICA', 'images/catalogo/75d2f1110161657e9f4392bea33c5557059c5f5f.jpg', 1, 35, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(522, '0', 'MODERNO', 'images/catalogo/be9f8bbcddadf9f28422082ce1d065d8fc9d2f03.jpg', 1, 92, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(523, '0', 'RECTANGULAR CON BROCHE Y ASA N°20', 'images/catalogo/1818278b2b67655c2778811c735c71ddbbb05a37.jpg', 1, 68, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(524, '0', 'RECTANGULAR CON BROCHE Y ASA N°30', 'images/catalogo/1d8db9418a74c2c32309f1fb4293774474bd0e79.jpg', 1, 68, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(525, '0', 'RECTANGULAR CON BROCHE Y ASA N° 45', 'images/catalogo/0993bf15be66cb18396a8b64172b38478dc82206.jpg', 1, 68, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(526, '0', 'MULTIPLE REDONDO REONDO FORTE C/18 GANCHOS ', 'images/catalogo/023670d5fd0f417de87a4df38a344b17c5ed3dfd.jpg', 1, 55, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(527, '0', 'MULTIUSO N°02', 'images/catalogo/599db6eb93e6d09ab9cd79fa65c49e1774d2b95c.jpg', 1, 55, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(528, '0', 'MULTIUSO N°03', 'images/catalogo/dbe47fa446c2d59fdefd79ad47ef49921433eae7.jpg', 1, 55, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(529, '0', 'MULTIUSO N° 04', 'images/catalogo/9580a49208ccc79ce333700f4f9ac7b58d6c2f05.jpg', 1, 55, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(530, '0', 'KIKO', 'images/catalogo/5cbf22897769dd2b0a88d974aaf33811a50e15a9.jpg', 1, 78, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(531, '0', 'DE CEREALES ', 'images/catalogo/617f243cdcb13b44fe3284494ed0da0c92c2391a.jpeg', 1, 48, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(532, '0', 'PIKI N° 18', 'images/catalogo/f2d18e7fd094e00e8be2db5004b6f73345058a96.jpg', 1, 66, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(533, '0', 'EMOCIONES N° 15 CARITA FELIZ', 'images/catalogo/cc298c2bc4d64083b71edde7c18b28fa31c17534.jpg', 1, 66, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(534, '0', 'GIGANTE C/TAPA', 'images/catalogo/6ec11de4ec7c21f41324e3621944613548e6c77b.jpg', 1, 69, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(535, '0', 'SUPER GIGANTE C/TAPA', 'images/catalogo/345bd8f92470102afeb7bcd005d3280be0240b05.jpg', 1, 69, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(536, '0', 'GRANDE MISTURA', 'images/catalogo/c7605a3eddfbeaa841eb90d3bb18ce7924dad797.jpg', 1, 69, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(537, '0', 'UTIL UNIVERSAL ', 'images/catalogo/6ebe3b3f7b0d21bdefa3cc155a08aa65f2285aa2.jpg', 1, 93, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(538, '0', 'VASOS PRACTICO \"PULPITO\"', 'images/catalogo/807b88b5ff5a182437a9db5c2956d9ff04470f5e.jpeg', 1, 93, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(539, '0', 'C/SUGETADOR DE ESCOBA ', 'images/catalogo/08004827652b91fbd140f6eeb891c5b877694737.jpg', 1, 82, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(540, '0', 'PRACTICO REY', 'images/catalogo/abc8847890e7be694f9b5f80253371fbde13de52.jpg', 1, 82, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(541, '0', 'TORTA GIGANTE C/BASE + ESPATULA CANDY', 'images/catalogo/98fd928855c804a3a37ae98b250191312d5217a8.jpg', 1, 93, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(542, '0', 'DE LIMPIEZA UNIVERSAL ', 'images/catalogo/cb7e3278f5fb7affa6113b6588331c96b111096a.jpg', 1, 72, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(543, '0', 'DE LUXE ', 'images/catalogo/2e0e4954e4462853d290e839728fa2d5e4b053d4.jpeg', 1, 22, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(544, '0', 'GASTON PARA CORTAR Y PICAR MEDIANO ', 'images/catalogo/b63d5b96c5a8211a68615cc2afeb43008938f102.png', 1, 23, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(545, '0', 'GASTON PARA CORTAR Y PICAR GRANDE ', 'images/catalogo/250eb174b98a06bd5e382ea8a5ad41ca9858ff4a.jpg', 1, 23, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(546, '0', 'GOURMET FORTE N° 35226 MEDIANA', 'images/catalogo/60ffd58fc61c9f66b6c93364a2da85cae1bdf3c8.jpg', 1, 23, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(547, '0', 'SUPER REY N° 90 C/TAPA LIMPIA', 'images/catalogo/9c1ccb0cfd2c4d6daca10633621a37fd3fa6b6fe.jpg', 1, 51, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(548, '0', 'SUPER REY N° 150 C/ TAPA', 'images/catalogo/5dcc0c74886988d1212b4448532a45ee3a3e7a3c.jpg', 1, 51, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(549, '0', 'SUPER REY N° 240 C/TAPA', 'images/catalogo/38d01a50e31e5681c1730c1deaa41d4cdd672001.jpg', 1, 51, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(550, '0', 'SUPER REY N° 140 C/ TAPA PLANA ', 'images/catalogo/5a461faad3aa5cf4efeacb8b6cf0805d817aa376.jpg', 1, 51, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(551, '0', 'HERMETIC CUADRADO TREBOL .50 LITROS', 'images/catalogo/8e047b63d0a96a725e5748a389683f1cb054e4da.jpg', 1, 24, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(552, '0', 'HERMETIC CUADRADO TREBOL 1.20 LITROS', 'images/catalogo/941c21e7799656bd7cc4ae18066612a4db04473a.jpg', 1, 24, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(553, '0', 'REYWARE RECTANGULAR DE LUXE 0.85 LITROS', 'images/catalogo/59d3d37c2fe1a628627576ae42d717747a56c55b.jpg', 1, 24, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(554, '0', 'REYWARE CUADRADO 1 KILO', 'images/catalogo/ffb397034cc0661ba65a992bc0fb0f5b5c9e03a0.jpg', 1, 24, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(555, '0', 'MAGALY N° 20 METALIZADA ', 'images/catalogo/b996d36ddd65e4369da66e5515e3635e67eacfa3.jpg', 1, 66, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(556, '0', 'CUADRADA KINA BLANCA', 'images/catalogo/e200fe6f380b65b15fa7ef5b749bd545d413701f.jpg', 1, 46, 1, 1, 'UNIDAD', 0, 1, 1, 0),
(557, '0', 'CEVICHERA ', 'images/catalogo/9de51e8cef28e5d2b253710c94d6aa1600ff30f9.jpg', 1, 27, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(558, '0', 'POLIGONAL X900', 'images/catalogo/6ddfbe0deede9325b305fbd173c90747b3e2f899.jpg', 1, 24, 37, 1, 'DOCENA', 0, 1, 1, 0),
(559, '0', 'REDONDO X 900', 'images/catalogo/425d04a797f45f9612f48f02eb772b7630306cc9.jpg', 1, 24, 37, 1, 'DOCENA', 0, 1, 1, 0),
(560, '0', 'TIBURON 1ERA', 'images/catalogo/e11dc9352ee1932b8ec25c3fb9173ee90b88649a.jpg', 1, 82, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(561, '0', 'CON PUNTA DE GOMA 2DA', 'images/catalogo/206237de18dcb3655358ca5de58bed955fea72c7.png', 1, 82, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(562, '0', 'HERMETICO 8 LTS COLOR C/TAPA BLANCA', 'images/catalogo/962ab93d2da4f94c5bc8865def79711b290f1c72.jpg', 1, 31, 13, 1, 'UNIDAD', 0, 1, 1, 0),
(563, '0', 'ROSITA - NUEVO', 'images/catalogo/976ca79c4d2f7931757d06ba10251eedaf6ba8e3.jpg', 1, 44, 5, 1, 'UNIDAD', 0, 1, 1, 0),
(564, '0', 'VASO ANGELITO PP', 'images/catalogo/2cc794280f3a20c094e970880ecf438e18ab57ca.png', 1, 83, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(565, '0', 'KAMILA ', 'images/catalogo/e55511888423e8771b70e19b3c782b94d7f20642.jpg', 1, 20, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(566, '0', 'MEDIDOR N° 3', 'images/catalogo/7e13e2c7e0cd56e24cdd076f25368a71f62779f6.jpg', 1, 48, 37, 1, 'DOCENA', 0, 1, 1, 0),
(567, '0', 'MR. CHEF MEDIANO PAED', 'images/catalogo/a407ba0b26f1c08d2c0f4764ffeb0ede4838b562.jpg', 1, 21, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(568, '0', 'CORAZON ', 'images/catalogo/30c4801ef5fea8bf614ec56d11c86b6c80e36b44.jpg', 1, 35, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(569, '0', 'CUADRADO SM 09 CUADRADO', 'images/catalogo/00806061d00859482b57a9862c35da8d29919732.png', 1, 86, 14, 1, 'DOCENA', 0, 1, 1, 0),
(570, '0', 'TENAZA', 'images/catalogo/7dc9f985131ecfea19a05a282817c3377c3ecf6d.jpg', 1, 77, 14, 1, 'DOCENA', 0, 1, 1, 0),
(571, '0', 'SALSERITO N° 14G', 'images/catalogo/091fe81ad4209b014a63c44823dd8c81a92057d9.jpg', 1, 21, 14, 1, 'DOCENA', 0, 1, 1, 0),
(572, '0', 'DE TE N° 09B', 'images/catalogo/9f0f503e7c1e03b9bd74fdd8a6d0b4e6f4c70af0.jpg', 1, 25, 14, 1, 'DOCENA', 0, 1, 1, 0),
(573, '0', 'PERICO', 'images/catalogo/8af0150956b9efa83a2c5771689631f84d0b90f6.jpg', 1, 53, 57, 1, 'UNIDAD', 0, 1, 1, 0),
(574, '0', 'ZOPAPO ECO', 'images/catalogo/3786c7204fc5022855a8f3d52e685aea4379581e.png', 1, 94, 57, 1, 'UNIDAD', 0, 1, 1, 0),
(575, '0', 'ITALIANO', 'images/catalogo/b5ca450a83b7d473423a24a17c83f2daf5575634.jpg', 1, 70, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(576, '0', 'COQUITO', 'images/catalogo/910132973617b4694ddabde9933452bf5ecf92a2.jpg', 1, 70, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(577, '0', 'LIMON X 1000 GR', 'images/catalogo/964853644d4c4a6cc60a81a85362ad707bdd64d4.jpg', 1, 95, 75, 1, 'UNIDAD', 0, 1, 1, 0),
(578, '0', 'ALOE VERA X 1000 GR', 'images/catalogo/b43b498e98b0515e8ff281367291411ad108924d.png', 1, 95, 75, 1, 'UNIDAD', 0, 1, 1, 0),
(580, '0', 'BALLERINA DP X 1000 ML', 'images/catalogo/991d42154614d0ec18b1e9f8895cfbb6ceb030f4.jpg', 1, 96, 77, 1, 'UNIDAD', 0, 1, 1, 0),
(581, '0', 'LIQUIDO ANTIBACTERIAL ALGAS MARINAS X 444 ML', 'images/catalogo/9cac2fa4d07fe374c5d2b044505dcef36a60a5ae.jpg', 1, 97, 79, 1, 'UNIDAD', 0, 1, 1, 0),
(582, '0', 'MULTIUSO X 12 UND. C/TUBO MATALICO', 'images/catalogo/e9ba09962ece964526938f429c36e0744b7aad97.png', 1, 98, 80, 1, 'UNIDAD', 0, 1, 1, 0),
(583, '0', 'MANZANILLA DP 1000 ML', 'images/catalogo/270374574f0cdbe0b8ec2b23a851c6ff7ff51321.jpg', 1, 96, 76, 1, 'UNIDAD', 0, 1, 1, 0),
(584, '0', 'LIQUIDO ANTIBACTERIAL LAVANDA X 444 ML', 'images/catalogo/c85ff94ddc7665b6ce2840853d375d8c53eea962.jpg', 1, 97, 79, 1, 'UNIDAD', 0, 1, 1, 0),
(585, '0', 'SACHETS PALTA 24 X 60 GR', 'images/catalogo/b34341455b1d1d3f1dbb115e7a53ed4c1c93a3f8.png', 1, 96, 76, 1, 'UNIDAD', 0, 1, 1, 0),
(586, '0', 'QUITASARRO X 1000 ', 'images/catalogo/06c000e146d6839bd9c033de0d1f2f4f9f8217ad.jpg', 1, 99, 81, 1, 'DOCENA', 0, 1, 1, 0),
(587, '0', 'SCRUBBER - MIX SALVA UÑAS & ABRASIVA', 'images/catalogo/d259a5c8b625ebac4ca124d1900c32e678af8fa0.jpg', 1, 100, 80, 1, 'UNIDAD', 0, 1, 1, 0),
(588, '0', 'FRUTAL FRUTILLA 75 GR', 'images/catalogo/4896b2fbb90ddeb931b2c89005acec272d24f0a2.jpg', 1, 97, 79, 1, 'UNIDAD', 0, 1, 1, 0),
(589, '0', 'LIQUIDO ANTIBACTERIAL PETALOS DE ROSA X 444 ML', 'images/catalogo/4ccc77070c1dc9ce8ede9ef5e0217e808fcc1dfa.jpg', 1, 97, 79, 1, 'UNIDAD', 0, 1, 1, 0),
(590, '0', 'SUPER ITLIANA C/PALO FORADO NACIONAL ', 'images/catalogo/7ff35b384f5a4203a066c3078c9aa9d44743cf8e.jpg', 1, 98, 34, 1, 'DOCENA', 0, 1, 1, 0),
(591, '0', 'LORETO ', 'images/catalogo/5eb79cf76e2c0b7e4b687fce3b463cd2b030964e.png', 1, 82, 34, 1, 'DOCENA', 0, 1, 1, 0),
(592, '0', 'LUCERITO CON PALO FORRADO ESCLUCER2', 'images/catalogo/3c90f55f570b2d237f305d0fe88ee623b490be0a.jpg', 1, 98, 34, 1, 'DOCENA', 0, 1, 1, 0),
(594, '0', 'DE PLASTICO ART. N9 C/DISEÑO (3.5LT) COLORES SURTIDOS', 'images/catalogo/b157c23aaf186f3c79a8b4248ae26a059a7ab45a.jpg', 1, 20, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(595, '0', 'DE PLASTICO ART.N14 (500ML) COLORES SURTIDOS', 'images/catalogo/4aae1a2eae2fc6a2029d8572c956570114f6fa47.jpg', 1, 27, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(596, '0', 'DE PLASTICO ART. N16 (7000 ML) COLORES SURTIDOS', 'images/catalogo/fd64602520e540085bbe5c27ef303e277b26f77d.jpg', 1, 35, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(597, '0', 'DE PLASTICO ART.N18 (10 LT)COLORES SURTIDOS', 'images/catalogo/388be5f1da54e98c6a450b429ac7cbfaaddb2eeb.jpeg', 1, 35, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(598, '0', 'DE PLASTICO ART. N1 (300 ML) COLORES SURTIDOS', 'images/catalogo/40030eb78ff16fa3df837b72a86bd49321aff128.jpg', 1, 24, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(599, '0', 'DE PLASTICO ART. N1 (650 ML) COLORES SURTIDOS', 'images/catalogo/71ed2730d580a8f95a2bf3365b6046581bbbe4cb.jpg', 1, 24, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(600, '0', 'DE PLASTICO ART. N1 (1.100 ML) COLORES SURTIDOS', 'images/catalogo/9f7ad201e0d3924b988a621135e2db41d19ad3ff.jpg', 1, 24, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(601, '0', 'PARIS TRANSP C/T COLOR', 'images/catalogo/223732faf4723a9ed472486c65d98f78db88bd68.jpg', 1, 1, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(602, '0', 'CHICA DE COLRES 2 LITROS', 'images/catalogo/20b29976f9e38aab5090ce2094fc3a8c132e37fc.jpg', 1, 59, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(603, '0', 'MAGALY 1 LITRO TRANSP. C/T COLOR', 'images/catalogo/18a6c66d15210b41cf644d1c599b022606120941.jpg', 1, 59, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(604, '0', 'MAGALY 2 1/4 TRANSP. C/T COLOR', 'images/catalogo/955d41ca244420a78bce152a405059852e7df229.jpg', 1, 59, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(605, '0', 'HINDU TRANSP.2.80 LITROS C/T COLOR ', 'images/catalogo/e979347a11bf8bbeb87435d9bff787f437f9bf0f.jpg', 1, 20, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(606, '0', '1 KG TRANSPARENTE C/T COLOR', 'images/catalogo/d1aef7439c762bffdf62bc7f39791428685303a8.jpg', 1, 20, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(607, '0', 'VENECIA TRANSP. C/T COLOR', 'images/catalogo/4e610763bc2119debd21814c98ebb2821fa9b3b7.jpg', 1, 24, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(608, '0', 'VERONA  TRANSP. C/T COLOR', 'images/catalogo/5d5ef6e4c71282b253d68249df6a60f5eb55a14f.jpg', 1, 27, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(609, '0', 'CISTERNA COLORES', 'images/catalogo/88e4e7ea5d4398beafa1021d34b4b01b0a6a8968.jpg', 1, 102, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(610, '0', 'PODEROSO COLORES', 'images/catalogo/05f01dac8741a4ed395e723624cea9db8c5471fb.jpg', 1, 102, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(611, '0', 'MANUELITO C/T RANSPARENTE ', 'images/catalogo/39bfb44c033991467b0f57c652ead1ba610f40c7.jpg', 1, 29, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(612, '0', 'BALLERINA SACHETS CANELA 24X60 GR', 'images/catalogo/9106166b03581b031f484a07984b89d9f80f6d2d.png', 1, 96, 76, 1, 'UNIDAD', 0, 1, 1, 0),
(613, '0', 'BALLERINA SACHETS GRANADA 24X60 GR', 'images/catalogo/389152fb8436a2d876104b3adc27f333c57cbfa8.png', 1, 96, 76, 1, 'UNIDAD', 0, 1, 1, 0),
(614, '0', 'BALLERINA SACHETS MANZANILLA 24X60 GR', 'images/catalogo/c7acf2a0b898bbc24a4cc975406fe9742b17062a.png', 1, 96, 76, 1, 'UNIDAD', 0, 1, 1, 0),
(615, '0', 'HUMEDAS CHIQUILIN PACK 80 PCS + 2 BABEROS', 'images/catalogo/3551f530aa4f6890d7c4cf0bd665b58d40436292.jpg', 1, 101, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(616, '0', 'UVA X 1000 GR ', 'images/catalogo/4b9df001719b8f54c6530205c5de06e846b5edf5.png', 1, 95, 75, 1, 'UNIDAD', 0, 1, 1, 0),
(617, '0', 'SUR SA 5.5 % 12 FRASCOS X 580 ML', 'images/catalogo/d0f58019e472cd21a2b67fd8ebca7be6bbf79e54.jpg', 1, 103, 83, 1, 'UNIDAD', 0, 1, 1, 0),
(618, '0', 'CALIBRE 35 TALLA M (8-81/2)', 'images/catalogo/623d7a212642eee843daa38828727fe7e7ed5c35.jpg', 1, 104, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(619, '0', 'CEVICHERAS - NUEVA', 'images/catalogo/ebe84a905f84c9b90494fb4d54464087a30deaf7.jpg', 1, 43, 84, 1, 'UNIDAD', 0, 1, 1, 0),
(620, '0', 'PRIETO', 'images/catalogo/afc600d528c316318794bf66fb36da4c5cbe98ce.jpg', 1, 2, 84, 1, 'JUEGO', 0, 1, 1, 0),
(621, '0', 'DE PLASTICO', 'images/catalogo/e81b974c91c01f21441845131f95cc3b8055b320.jpg', 1, 105, 84, 1, 'JUEGO', 0, 1, 1, 0),
(622, '0', 'COLORES', 'images/catalogo/6a584d686fed96e245ff1da2d4ac91c53ab5fa92.jpg', 1, 29, 85, 1, 'DOCENA', 0, 1, 1, 0),
(623, '0', 'PATRULLERO MILITAR ', 'images/catalogo/d5d10e57de3434cb9cd8edde6f15fb40f8837e6c.png', 1, 38, 63, 1, 'DOCENA', 0, 1, 1, 0),
(624, '0', 'TRÁILER VOLVO MADERERO', 'images/catalogo/6399c6be84a2757584b79aa105c26084e74965f0.jpg', 1, 38, 63, 1, 'DOCENA', 0, 1, 1, 0),
(625, '0', 'TRÁILER VOLVO PETROLERO', 'images/catalogo/df12d4ba6c35dcd6d05b0ea71526bbc6f4b07e19.jpg', 1, 38, 63, 1, 'DOCENA', 0, 1, 1, 0),
(626, '0', 'CAMIÓN ANDINO CON GANADO', 'images/catalogo/356134dd2d46d543bdbc656cc5c16bade97c6f42.jpeg', 1, 38, 63, 1, 'DOCENA', 0, 1, 1, 0),
(627, '0', 'DE COSINA JANET', 'images/catalogo/d8f050fc72fe087ec285c208df9bc8728709eae1.jpg', 1, 72, 63, 1, 'DOCENA', 0, 1, 1, 0),
(628, '0', 'DE COSINA ANITA ', 'images/catalogo/99f4aa002ef77c949e2ba8d9d50472dc7b46afe5.jpg', 1, 76, 63, 1, 'DOCENA', 0, 1, 1, 0),
(629, '0', 'ESCARABAJO TAXI', 'images/catalogo/a881eb0756a2ed6653c5403feeccad3ff44962be.jpg', 1, 38, 63, 1, 'DOCENA', 0, 1, 1, 0),
(630, '0', 'FABIOLA', 'images/catalogo/7c77a1b393c2d0aa7fa91639ef54d6a403827283.jpg', 1, 106, 63, 1, 'DOCENA', 0, 1, 1, 0),
(631, '0', 'CISTERNA AGUILA ', 'images/catalogo/ece83c234243957f24f8df0518716cf7a63681cb.jpg', 1, 38, 63, 1, 'DOCENA', 0, 1, 1, 0),
(632, '0', 'GANADERO AGUILA C/ GANADO', 'images/catalogo/f60a0213f8df300e677be0af140337736aaf1ee4.jpg', 1, 38, 63, 1, 'DOCENA', 0, 1, 1, 0),
(633, '0', 'DE TE PATTY', 'images/catalogo/7eb569f4e42fceffb5c4b210d0e204bbaf1d33f9.jpg', 1, 76, 63, 1, 'DOCENA', 0, 1, 1, 0),
(634, '0', 'ALEMAN 1/2 KILO COLOR PASTEL', 'images/catalogo/952b556b831b85237455ebb354918908757c90c1.jpg', 1, 74, 63, 1, 'DOCENA', 0, 1, 1, 0),
(636, '0', 'ALEMAN 1/2 KILO TRANSPARENTE ', 'images/catalogo/ee9aefcd6dc15d4ce80650a595bc7c9a63823c93.jpg', 1, 74, 63, 1, 'DOCENA', 0, 1, 1, 0),
(637, '0', 'VOLQUETE MADERERO', 'images/catalogo/d1cdf3d19e09878ba1631a2806d4149150b8580a.jpg', 1, 38, 63, 1, 'DOCENA', 0, 1, 1, 0),
(638, '0', 'ESPAÑOLA', 'images/catalogo/62a7fa2450d81ae7ef2209d81ef6f450f7d4adfc.jpg', 1, 35, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(639, '0', 'LAS DOÑAS DOÑA LOLA REPUESTO ', 'images/catalogo/845d367177512f22658e02c05469bc6434005774.jpg', 1, 54, 57, 1, 'UNIDAD', 0, 1, 1, 0),
(640, '0', 'LAS DOÑAS DOÑA LUCHA REPUESTO', 'images/catalogo/b2961ccd641aba2f730511a299586c8f64c11b2f.jpg', 1, 54, 57, 1, 'UNIDAD', 0, 1, 1, 0),
(641, '0', 'FENIX 10 LITROS', 'images/catalogo/77b7e185da8578d178f7bf38b1b1657b725ee3f9.jpg', 1, 45, 49, 1, 'UNIDAD', 0, 1, 1, 0),
(642, '0', 'MOISES MEDIANO', 'images/catalogo/5da3b94aa66e0767f42a2f0bfa6fdbeb55124b18.jpg', 1, 45, 49, 1, 'UNIDAD', 0, 1, 1, 0),
(643, '0', 'MINI ESPAÑOLA', 'images/catalogo/9a581579b34f95aa583ff580fe6ef9336036dd1c.jpg', 1, 27, 49, 1, 'UNIDAD', 0, 1, 1, 0),
(644, '0', 'MOISES MINI', 'images/catalogo/f393f61153141701e1d516818a9b1b9ce7821ca9.jpg', 1, 24, 49, 1, 'UNIDAD', 0, 1, 1, 0),
(645, '0', 'ROBUSTITA', 'images/catalogo/06f1fc00fdfa4171eacd977f2dc045d88a7fb61b.jpg', 1, 27, 49, 1, 'UNIDAD', 0, 1, 1, 0),
(646, '0', 'OVALADA # 30', 'images/catalogo/fdc0e53a6119d258d0ea67051ff7e5fa26606f34.jpg', 1, 61, 49, 1, 'UNIDAD', 0, 1, 1, 0),
(647, '0', 'DE ROPA C/RUEDAS', 'images/catalogo/1c42eac6682e98eded80f7555c9219d34007cf64.jpg', 1, 44, 49, 1, 'UNIDAD', 0, 1, 1, 0),
(648, '0', 'PRINCESA ACRISA COLORES VARIADOS', 'images/catalogo/1d4d422039754ba20e4a46852976828af97e4775.jpg', 1, 50, 36, 1, 'DOCENA', 0, 1, 1, 0),
(650, '0', 'ACRISA COLORES VARIADOS', 'images/catalogo/97ee1eb64cfc996959ecbbac2edb5f3a771f8d58.jpg', 1, 46, 36, 1, 'DOCENA', 0, 1, 1, 0),
(651, '0', 'BAÑERA ACRISA COLORES  VARIADOS', 'images/catalogo/05b61dfd776452fd673fbcdac4abf293f9aff4c3.jpg', 1, 36, 50, 1, 'DOCENA', 0, 1, 1, 0),
(652, '0', 'ACRISA COLS  VARIADOS', 'images/catalogo/f91218f925cc751aed7023fc37032d44e1c3a816.jpg', 1, 56, 37, 1, 'DOCENA', 0, 1, 1, 0),
(653, '0', 'DE SALA ACRISA COLORES VARIADOS', 'images/catalogo/5476f21059ecde738aa2854383f57bcfbf34e1d3.jpg', 1, 76, 37, 1, 'DOCENA', 0, 1, 1, 0),
(654, '0', 'PLAYA ACRISA COLORES VARIADOS', 'images/catalogo/4c4c4df9408701e7ef488e046b3b3bf50e39d97f.jpg', 1, 50, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(655, '0', 'FLORAL ', 'images/catalogo/5a99add1550e3e5d895b464178c67422b91de609.JPG', 1, 35, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(656, '0', 'N° 020', 'images/catalogo/04fbc6ad99342ed2fea22c702ca585466dcbd055.jpg', 1, 35, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(657, '0', 'SUMO', 'images/catalogo/0b76b0684d4a7af3903ec069c4c45fc999f4f422.jpg', 1, 71, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(658, '0', 'CHATIN', 'images/catalogo/43f9f6dc8689856a0da2ac780988b00aed8ac7b0.jpg', 1, 71, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(659, '0', ' RECTANGU.PEQ.1.6LT GD16532011', 'images/catalogo/22d72705b720f4dd94558e9b3715f06e2fc15f3a.png', 1, 107, 86, 1, 'UNIDAD', 0, 1, 1, 0),
(660, '0', ' RECTANG.MED.2.2LT GD16534019', 'images/catalogo/b72aa828d9f2713b39893485b4408e0fb6790030.png', 1, 107, 86, 1, 'UNIDAD', 0, 1, 1, 0),
(661, '0', ' RECTANG.GDE 2.9LT GD16536 417', 'images/catalogo/4d72e30964725495668bdaffc7b1f22ddcb8312e.png', 1, 107, 86, 1, 'UNIDAD', 0, 1, 1, 0),
(662, '0', ' OVAL MEDIANA 3.2 LT 66630 200978421 ', 'images/catalogo/7c5678e7c96086ae161381c7cee0a68a9e8e1ebc.jpg', 1, 107, 87, 1, 'UNIDAD', 0, 1, 1, 0),
(663, '0', ' OVAL GRANDE 4.2 LT 666502 00978455 SELETTAXD', 'images/catalogo/9ccc013535a573fc673c80b341b33e6cd5128b47.jpg', 1, 107, 69, 1, 'UNIDAD', 0, 1, 1, 0),
(664, '0', ' RECTG.2.7 LT SELETTA MED.6 5350200962496', 'images/catalogo/c11bb39121b23861a92d5acf981f039c6a5e32ee.jpg', 1, 15, 86, 1, 'UNIDAD', 0, 1, 1, 0),
(665, '0', ' CUADRADA GRANDE SELETTA 6 2240200999598XD', 'images/catalogo/f757e39d7685436383f922c860420c30466c0f67.jpg', 1, 107, 69, 2, 'DOCENA', 0, 0, 1, 1),
(666, '0', ' RECTG.HONDA 5.3LT GD165384 14 ', 'images/catalogo/b0be7874f3b64350d45b740bcde6279b489217a6.jpg', 1, 15, 86, 1, 'UNIDAD', 0, 1, 1, 0),
(667, '0', ' OVALADA INDIVIDUAL 1.6 LT GD 16343410', 'images/catalogo/b7e4983f93a219d874b4b588f274407c70c8523b.png', 1, 107, 86, 1, 'UNIDAD', 0, 1, 1, 0),
(668, '0', 'OVALADA PEQUEÑA.2.4L 16345016 ', 'images/catalogo/787bfb7556cbde86adf3deddda02b8e07d498995.jpg', 1, 107, 86, 1, 'UNIDAD', 0, 1, 1, 0),
(669, '0', 'CERVECERO MUNICH 7 OZ # 710 9 ', 'images/catalogo/25b2b7890a2eacab37f804ac9a4321dec3bb2063.jpg', 1, 30, 88, 1, 'UNIDAD', 0, 1, 1, 0),
(670, '0', ' CERVECERO MUNICH 10 OZ # 770 90200764060 ', 'images/catalogo/4c7df8779cd3416914c1a3c0559a89dd063274bd.jpg', 1, 30, 88, 1, 'UNIDAD', 0, 1, 1, 0),
(671, '0', ' WINDSOR COCKTAIL 335ML # 7928 ', 'images/catalogo/542e065367a5d73e9adfc8462e8fc68c772107de.jpg', 1, 10, 88, 1, 'UNIDAD', 0, 1, 1, 0),
(672, '0', ' REFRACTARIO 170ML # 44 01 ', 'images/catalogo/c450fdf35e38882ea5d50bfc8bf9eaa46e45630e.jpg', 1, 41, 88, 1, 'UNIDAD', 0, 1, 1, 0),
(673, '0', ' BRISTOL 17.5 OZ LONG DRINK #  2911', 'images/catalogo/f135b7179fb859d2b0e04d4327d23d15cf2d98f3.jpg', 1, 30, 88, 1, 'UNIDAD', 0, 1, 1, 0),
(674, '0', ' CUADRADA MEDIANA SELETTA 62190200999580', 'images/catalogo/0b52a19b35ee4a1038d74b196da15d8f42ab5590.jpg', 1, 107, 20, 1, 'DOCENA', 0, 0, 1, 1),
(675, '0', ' BRISTOL 11.5 OZ LONG DRINK #  26110200742135', 'images/catalogo/e70638496327dea338dbfaa15dde14acbb05774a.jpg', 1, 30, 88, 1, 'UNIDAD', 0, 1, 1, 0),
(676, '0', ' BRISTOL 13.75 OZ LONG DRINK # 2711 ', 'images/catalogo/c1ac79c09c64aaaee16c5d3045f68a3e8ff688ac.jpg', 1, 30, 88, 1, 'UNIDAD', 0, 1, 1, 0),
(677, '0', ' ILHABELA 6 OZ # 7323', 'images/catalogo/e7503444b66e5bc9a91bc38dc8fa97c33b6191c3.jpg', 1, 30, 88, 1, 'UNIDAD', 0, 1, 1, 0),
(678, '0', ' WINDSOR MARTINI 8.5 OZ # 722 8 ', 'images/catalogo/105364535e5f55adaea137a376e1dd79da1026d5.PNG', 1, 10, 88, 1, 'UNIDAD', 0, 1, 1, 0),
(679, '0', ' 1 LT BELLA MARINEX SM400031503840 ', 'images/catalogo/2c87d0274027e4c1dfd4eb8f108a185f184860b2.jpg', 1, 108, 86, 1, 'UNIDAD', 0, 1, 1, 0),
(680, '0', '2 LT BELLA MARINEX SM400031703840', 'images/catalogo/ba9214760267e27a4d952fdc76df18f34d520c1d.jpg', 1, 108, 86, 1, 'UNIDAD', 0, 1, 1, 0),
(681, '0', ' 3 LT BELLA MARINEX SM400031803840', 'images/catalogo/60512c613df08f375cda3b059b7717bd4cbc4096.jpg', 1, 108, 86, 1, 'UNIDAD', 0, 1, 1, 0),
(682, '0', ' MEDIANO DEC GRANJA 2017 # 2140AD', 'images/catalogo/a1adf9246befafad02baaa48dfb2f6d771ebcbfb.png', 1, 109, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(683, '0', ' MEDIANO DECO. GRANJA 2018 # 2140AD', 'images/catalogo/c925b95b5c49f0cb6338f127b4ad1a2ca4679c1f.jpg', 1, 109, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(684, '0', 'MEDIANO DEC. BUHOS 2017 # 2 140AD ', 'images/catalogo/be8a41e48a17513bd3660104b03888b4a6601707.jpg', 1, 109, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(685, '0', ' MEDIANO DEC. BODEGON 2017 #  2140AD', 'images/catalogo/1abf3dcbe3b3874ff40250b3ca766021760033ba.jpg', 1, 109, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(686, '0', 'GRANDE DEC. BODEGON 2018 # 2915AD ', 'images/catalogo/344c402b7b8026c2a5ef933bc08a292fa40beb24.jpg', 1, 109, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(687, '0', 'GRANDE DEC. GRANJA 2018 # 2 915AD', 'images/catalogo/4c5ff0dc9a5a26224ea7cc1cadd318dbfde66f16.jpg', 1, 109, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(688, '0', 'GRANDE DEC. PAJAROS 2018 # 2915AD ', 'images/catalogo/7bfa644d75c1dc813537cefdafed5abe50ac91d4.jpg', 1, 109, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(689, '0', ' DIAMANT.C/6 COPAS 9001 EL ', 'images/catalogo/09162c7d6323d53aff10be5b8a0363f63972557f.jpg', 1, 110, 90, 1, 'UNIDAD', 0, 1, 1, 0),
(690, '0', ' AV. LISO PRISMA ROCKS 11 0269 AL 055', 'images/catalogo/253db94a1fef9dc7dbaf6ec70c8534ad94c3ff9f.png', 1, 30, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(691, '0', ' AV. LISA SODERA 2805AL72 ', 'images/catalogo/fb6521a271eeb61dbb4c9e189c67e39f3f49118c.jpg', 1, 10, 90, 1, 'UNIDAD', 0, 1, 1, 0),
(692, '0', ' AV LISO LEXINGTON.JUGO 0024AL ', 'images/catalogo/0587647da1dbd9c99680376a1832d500317a4b3d.png', 1, 30, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(693, '0', ' AV LISO LEX.BEBIDA 0044AL ', 'images/catalogo/b86042fe4925a97ce9576bb8e18251dfb05f793d.jpg', 1, 30, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(694, '0', ' AV LISO LEX.ROCKS 0045AL ', 'images/catalogo/d77cdb8be2a033e822e650e5eaa23b5c07d94897.png', 1, 30, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(695, '0', 'AV LISO LEX.AGUA 0046AL ', 'images/catalogo/80c49cc3bb54f297666b8d5fa1ac274f0f780bb9.jpg', 1, 30, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(696, '0', ' AV LISO LEX.WHISKY 0022AL ', 'images/catalogo/7a5839058ec9c625c851f32624a8745b64afc931.jpg', 1, 30, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(697, '0', ' DULCERA X 7 PZ ROSE MRB-9/7 - MBE-RS095/07AGB 882', 'images/catalogo/0e4d416df20469a386da4c90f78a746e3a1a488c.jpg', 1, 76, 91, 1, 'UNIDAD', 0, 1, 1, 0),
(698, '0', ' DULCERA X 7 PZ SLAYER MBE-SL0 95/07GB 882 ', 'images/catalogo/a7998262b48febe680d877348c31d30dd14aada9.jpg', 1, 76, 92, 1, 'UNIDAD', 0, 1, 1, 0),
(699, '0', ' DULCERA X 7 PZ TULIPAN MBE-TL 095/07GB 882CAJA X08', 'images/catalogo/6f9697368f2bbea1da5ad04398422d3c80cdccab.jpg', 1, 76, 93, 1, 'UNIDAD', 0, 1, 1, 0),
(700, '0', 'DULCERA X 7 PZ CRYSAN MBE-CR0 95/07GB 882 CAJA X 08', 'images/catalogo/5c05d9ffce0b0636586d685c7dc9328eb3d7c655.jpg', 1, 76, 94, 1, 'UNIDAD', 0, 1, 1, 0),
(701, '0', ' DULCERA X 7 PZ ASYA MBE-AS095 -07GB CAJA X08', 'images/catalogo/3a223ca3955ac8cb4146ae78d29d50ef04ae9c43.jpg', 1, 76, 95, 1, 'UNIDAD', 0, 1, 1, 0),
(702, '0', ' 5\" ROSE MRB-5 882 CAJ AX72', 'images/catalogo/621259ce58c7509fabf34f936aea4170c34075bb.jpg', 1, 13, 91, 1, 'UNIDAD', 0, 1, 1, 0),
(703, '0', ' 5\" TULIPAN MB45-5 882 C AJAX72', 'images/catalogo/0277958e53a1a3477782d4a7f18e13f7b39c637d.jpg', 1, 13, 93, 1, 'UNIDAD', 0, 1, 1, 0),
(704, '0', 'AV LISO VERONA ROCKS 0668AL CAJAX48', 'images/catalogo/5617f229bea06362b2d0eefff12bc999114b3509.jpg', 1, 30, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(705, '0', ' AV LISA LEX.VINO BLANCO 0505 AL48  CAJAX48', 'images/catalogo/fba813858adcbbb4f85cfe76d16a0d399b035afc.jpg', 1, 10, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(706, '0', ' AV LISA LEX.VINO ROJO 0500AL 48  CAJAX48', 'images/catalogo/934e1faf741c221874b1d580f36db8390727478b.jpg', 1, 10, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(707, '0', ' AV CERVECERO VELERO 1152AL  CAJAX48', 'images/catalogo/47368e31ed426743eb29733249c4081d7bb10b33.jpg', 1, 85, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(708, '0', ' AV LISO CERVECERO BRUSELAS 15.25 OZ # 0625AL  CAJA X24', 'images/catalogo/cc44cd378d2d0413309b2bc7474421492446d7b1.jpg', 1, 85, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(709, '0', ' CERVEC.AV LISO HAMBURGO 0314 AL  CAJAX24', 'images/catalogo/998fc446cc6bc3e9dd535a783620ee15244e055c.jpg', 1, 30, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(710, '0', ' NAUTICO BEBIDAS 11. OZ # T12 91 CAJAX72', 'images/catalogo/fad1b71a32ba5719b8a66e0cc83bab752737b063.jpg', 1, 30, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(711, '0', 'FORTE BEBIDAS 11. OZ # T1236 CAJAX72', 'images/catalogo/0573a9f82ca5af6a9544f6c9804e8dfd1ba514ce.jpg', 1, 30, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(712, '0', ' CHOPP NEVADA M-20N 882  CAJAX72', 'images/catalogo/c4946143797959dd6d56dfc24cb0748fe59c7830.jpg', 1, 85, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(713, '0', ' AV LISA LEX.HELADO 7.5 OZ 05 07AL  CAJAX48', 'images/catalogo/f4e8aaa5c9259dff7d69af8cfd29a1b5cc1c7664.jpg', 1, 10, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(714, '0', ' DEC. FRESH FRUIT ALT 2 11.5 OZ # M-212P 882 CAJAX72', 'images/catalogo/4a3ffe622c49bd6784e91589d629aca08928f3bb.jpg', 1, 30, 96, 1, 'UNIDAD', 0, 1, 1, 0),
(715, '0', ' DEC. OLAS AMARILLO /NARANJA 1 1.5 OZ # M-212P 882 CAJAX72', 'images/catalogo/fc570d49181c70c8797981668460987b5d453c5b.jpg', 1, 30, 95, 1, 'UNIDAD', 0, 1, 1, 0),
(716, '0', ' AV LISA 0.5 LT S/TAPA 3800AL  CAJAX12', 'images/catalogo/08f01ad4c62ee778b996c70c5aa1f051fe71bb16.jpg', 1, 59, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(717, '0', ' AV LISO LISBOA 16 OZ 0375AL  CAJAX24', 'images/catalogo/803131c8a6d6fdb1cea54b286e8c5c823ccbff18.jpg', 1, 30, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(718, '0', 'AV LISO PRISMA BEBIDAS 11.3 OZ # 0257AL  CAJAX70', 'images/catalogo/f6ac7a01e6d6478828b3f3206f8be635b6c23865.jpg', 1, 30, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(719, '0', 'AV LISO LISBOA BEBIDAS 9.5 O Z 0376AL  CAJAX24', 'images/catalogo/4f674882cff1882d1a9078a8d1caedfec9c78073.jpg', 1, 30, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(720, '0', ' AV LISO HERRADURA 7 OZ 0100AL  CAJAX48', 'images/catalogo/f4dd234bd51d4ff1efe3f97f8547355f912eb37b.jpg', 1, 30, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(721, '0', ' AV LISO PRISMA 8 OZ # 0256AL  CAJAX72', 'images/catalogo/9686a61b717b5a6f1c22f6e525fd3a27532982aa.jpg', 1, 30, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(722, '0', ' AV LISO OPTICO ONDAS 8 OZ # 0261AL 055 CAJAX72', 'images/catalogo/b74160de5ad1e83bef3c41550ca8d85f030bc6f6.jpg', 1, 30, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(723, '0', 'NAUTICO 8 OZ MT16-8 IMG CAJAX72', 'images/catalogo/1f6870cd15b53b0ddc75961479a76302f2d45302.jpg', 1, 30, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(724, '0', ' VELERO MD-9 882 CAJAX72', 'images/catalogo/d6c9456ae4292c077c386c4a27dc5d1918211478.jpg', 1, 30, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(725, '0', ' LOTUS (NUEVO) MWS-9 882 CAJAX72', 'images/catalogo/4e2b4f65f973fbc3c6334498d339eb3d9854d266.jpg', 1, 30, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(726, '0', ' ESPIGA M-509 882 CAJAX7 2', 'images/catalogo/4f604c12b29b5d8386714490e83c9af28b68af9e.jpg', 1, 30, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(727, '0', ' AV LISA ARAGON CHAMPAÑA 6 OZ  # 5436AL24 CAJAX 24', 'images/catalogo/e6552dbea30474b8457446ca09ac15c26dc6d353.jpg', 1, 10, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(728, '0', ' AV LISA ARAGON VINO TINTO/AGUA 5434AL24 (300ML/10OZ) CAJAX24', 'images/catalogo/61535981acb8b6e68d616e4f301ad041d3a03321.jpg', 1, 10, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(729, '0', ' AV LISA ARAGON VINO BLANCO #  5435AL24 (250ML/8.5OZ)  CAJAX24', 'images/catalogo/3dad30fa3b8eba76b14fd8b79a2dc28ac0115699.jpg', 1, 10, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(730, '0', ' AV LISA VENECIA 1.115 LT # 0620AL  CAJAX12', 'images/catalogo/9b025ecb266c3488aad8cdbd9691fb5d35b2bac0.jpg', 1, 59, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(731, '0', ' ESCARCHA 4484AL12  CAJAX12', 'images/catalogo/fd727ded6c65a4985c81dded1789e43a6dda0151.jpg', 1, 59, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(732, '0', ' AV LISA NOBILE 2913AL  CAJAX12', 'images/catalogo/0d9531e00ff1ab4dcaf3399900cb9858e5dfa032.jpg', 1, 59, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(733, '0', 'AV LISA POPULAR 1.87 LT 253 1AL  CAJAX12', 'images/catalogo/5d12b2a4a5e7c9f9065dc64da2fe0fa576596143.jpg', 1, 59, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(734, '0', ' AV LISA PRISMA C/T 3573AL  CAJAX06', 'images/catalogo/7d25f7edb78c35fa88eb375ba90a2400e275a530.jpg', 1, 59, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(735, '0', ' T/PLASTICA 0796AL  CAJAX12', 'images/catalogo/43846ac4fa09f5a332ede50e27765f24c1b753ff.jpg', 1, 111, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(736, '0', ' AV LISA ARTICO 0310AL  CAJAX12', 'images/catalogo/680935886cd6b46ac82030aae2be48f7d366c513.jpg', 1, 112, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(737, '0', ' MILKSHAKE II (9 ONZ)  CAJAX48', 'images/catalogo/458d39ed0da6ec61e45436b04aa0e8137f565090.jpg', 1, 10, 97, 1, 'UNIDAD', 0, 1, 1, 0),
(738, '0', ' VENCEDOR - COCADA 28   CAJAX48', 'images/catalogo/003f03b7f850a721e2d4fb2b21a3cbf033443e58.jpg', 1, 30, 98, 1, 'UNIDAD', 0, 1, 1, 0),
(739, '0', 'PS-212 FLINT (VASO BOLICHE 2 37ML-SURTIDO) 75221208 CAJAX240', 'images/catalogo/ff82efb9c6544a1085a323b0918bbc2ac34a82ff.jpg', 1, 30, 89, 1, 'UNIDAD', 0, 1, 1, 0),
(740, '0', 'VIDRIO MOD II  CAJAX120', 'images/catalogo/13adef18e9bb5e2de317b9d3e49db8e06d9919f1.jpg', 1, 41, 98, 1, 'UNIDAD', 0, 1, 1, 0),
(741, '0', 'VIDRIO MODELO I CAJA X 120', 'images/catalogo/54e7b2c56575128800aebe7981f7676aa38c8c84.jpg', 1, 41, 98, 1, 'UNIDAD', 0, 1, 1, 0),
(742, '0', ' PRENSADA 1/2 LT  CAJAX24', 'images/catalogo/cbe40cfb8f1667a296ade2f72628efecde95d094.JPG', 1, 59, 97, 1, 'UNIDAD', 0, 1, 1, 0),
(743, '0', ' PRENSADA 1 LT  CAJAX24', 'images/catalogo/b73ccd050269111b7e38e8104bd8098c9bf7dd12.jpg', 1, 59, 97, 1, 'UNIDAD', 0, 1, 1, 0),
(744, '0', ' WAVE 1.6 LT C/TAPA # PCL1624 CAJAX12', 'images/catalogo/b001831f3a8bf3057479ced3c02cf7fa2e484b6b.jpg', 1, 59, 97, 1, 'UNIDAD', 0, 1, 1, 0),
(745, '0', 'IMPERIAL CON TAPA 1.6 LT C/TAPA CAJA X 12', 'images/catalogo/a31743de70c046d43501fa45ce89bddcc39d276b.jpg', 1, 59, 98, 1, 'UNIDAD', 0, 1, 1, 0),
(746, '0', ' PELOTA 1.7 LT # YZ30 737 CAJAX12', 'images/catalogo/4774bb5e2f1c6356e96ef11aa2824b7c337f67bc.jpg', 1, 59, 97, 1, 'UNIDAD', 0, 1, 1, 0),
(747, '0', 'MANCORA  MANCORA 2.8 LT TAPA PLASTIC A COLOR (JI72800-G) 737 CAJ AX06', 'images/catalogo/f05948d2fa0d8b669942055ebabb7479d2f3aaee.jpg', 1, 59, 97, 1, 'UNIDAD', 0, 1, 1, 0),
(748, '0', 'A VIDRIO 1.5 LT C/TAPA # J28 1500-G CAJAX06', 'images/catalogo/4975752c40e44d216e5219a83603e9d277fe9a1e.jpg', 1, 59, 97, 1, 'UNIDAD', 0, 1, 1, 0),
(749, '0', ' KID 1 LT # J031000 737 CAJ AX12', 'images/catalogo/5cb39665dd4b6b3e30eb85830fb85be0064957bc.jpg', 1, 59, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(750, '0', ' KID 1.3 LT # J031250G 737 CAJAX06', 'images/catalogo/107e6f1d8aa64c795395e0fbb4d7581fced2d727.jpg', 1, 59, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(751, '0', 'JARRA OCTOGONAL 0.50 LT C/TAPA # BTH-2-5 901 CAJAX24', 'images/catalogo/46d4d51d002982199df492859b6043371fa218de.jpg', 1, 59, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(752, '0', 'MEDIDORA 1 LT # HSMC100 9 01 CAJAX12', 'images/catalogo/dfc8d547fd1f171a7a82fbf34bafc847081f40b4.jpg', 1, 59, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(753, '0', 'MEDIDORA 0.50 LT. # HSMC050901 CAJA X 24', 'images/catalogo/3f597265da5a328fb38a86a3202f217f192ce778.jpg', 1, 59, 99, 2, 'UNIDAD', 0, 1, 1, 0),
(754, '0', ' X6 COPA MILKSHAKE 390CC JXI C-87185 CAJAX06', 'images/catalogo/6789ec899ca045545316ec19ac5f17f0806ec386.jpg', 1, 72, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(755, '0', '11 ONZ RECTO LOZA BLANCA 737 CAJAX48', 'images/catalogo/46d5caf11c8d43e18b0027b7733b5f232564d595.jpg', 1, 85, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(756, '0', '16 ONZ RECTO LOZA BLANCA  737 CAJAX48', 'images/catalogo/a89273c1b95264d7854d1268f578bcb204be18a1.jpg', 1, 85, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(757, '0', ' 11 ONZ RECTO (STONEWARE) DE C # M731 737 CAJAX48', 'images/catalogo/fb981ea7ea8391b8ddf1a5d0c063049ebb38c60c.jpg', 1, 85, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(758, '0', ' 11 ONZ RECTO (STONEWARE) DE C # M726737 CAJAX48', 'images/catalogo/09b5990f9936ffd8666a6a86234a3152ef583217.jpg', 1, 85, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(759, '0', ' 11 ONZ RECTO (STONEWARE) DE C # M728737 CAJAX48', 'images/catalogo/ad0c630b144995d5694e376ea19a9e4e87b05f73.jpg', 1, 85, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(760, '0', ' 15 ONZ RECTO (STONEWARE) DEC H006737 CAJAX36', 'images/catalogo/c11ed6eb0231e1fd612207501482327da4bab3bb.jpg', 1, 85, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(761, '0', '15ONZ RECTO (STONEWARE) DEC H001 737 CAJAX48', 'images/catalogo/a0dd0b12db8eb49579b7ae5b9a967ef5d26f2bd7.jpg', 1, 85, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(762, '0', ' ELEGANTE 500CC # 060500 737  CAJAX24', 'images/catalogo/28cfebdebab526f83a0a38059a7550068a3ac450.jpg', 1, 59, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(763, '0', ' TAPER DE VIDRIO C/TAPA PLASTICA X 5 PZS 737 CAJAX12', 'images/catalogo/591fd2cc1ef892157a5179e14f9a0b9b2ba55d42.jpg', 1, 76, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(764, '0', 'HONDO LOZA 9\" MOD.A11-07 FLOR ROJA/NEGRO S/FILO 737 CAJAX48', 'images/catalogo/7a62b5d544e5bf7d61bdf1a6927d8d17d8f21a72.jpg', 1, 57, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(765, '0', 'TENDIDO LOZA 9\" MOD.A11-07 FL OR ROJA/NEGRO S/FILO 737 CAJAX48', 'images/catalogo/f6442fb98fc22b0bc99d51c5a42a981c0df39c82.jpg', 1, 57, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(766, '0', 'HONDO LOZA 9\" MOD.A16-03 S /FILO 737 CAJAX48', 'images/catalogo/614d8b1b2866f2dba8769328fffa224ad7f9f91d.jpg', 1, 57, 99, 1, 'UNIDAD', 0, 1, 1, 0);
INSERT INTO `tb_catalogo` (`idct`, `cod_barra`, `nom`, `imagen`, `ida`, `idg`, `idm`, `ids`, `unid`, `stk`, `stk_min`, `est`, `opcdistri`) VALUES
(767, '0', 'PLATO TENDIDO LOZA 9\" MOD.A16-03  S/FILO 737 CAJAX48', 'images/catalogo/2c60e42690b4cf67e5d2897543471def9adaca08.jpg', 1, 57, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(768, '0', 'PLATO HONDO LOZA 9\" MOD.A16-04 S /FILO 737 CAJAX48', 'images/catalogo/b956db3e63a630a196b2aa2ace9f612e620137b1.jpg', 1, 57, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(769, '0', 'PLATO HONDO LOZA 9\" MOD.A12-58 S /FILO 737 CAJAX48', 'images/catalogo/e482582d13f5314b221c5ce39a8290ccc9aabf1a.jpg', 1, 57, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(770, '0', 'TENDIDO LOZA 9\" MOD.A16-04 S /FILO 737 CAJAX48', 'images/catalogo/776809b89c74945e7d78f78cad1704584cfad336.jpg', 1, 57, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(771, '0', 'PLATO HONDO LOZA 9\" MOD.A13-11   737 CAJAX48', 'images/catalogo/47b63d68fb7491019fe10fab962b8c2df51e31c0.jpg', 1, 57, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(772, '0', 'TENDIDO LOZA 9\" MOD.A13-11  737 CAJAX48', 'images/catalogo/6d5e9ccf4c1bfa50047459d081be4a210e92f14c.jpg', 1, 57, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(773, '0', 'HONDO LOZA 9\" MOD.A15-26   737 CAJAX48', 'images/catalogo/150d6bbd4ba718991097e90a920213019c296949.jpg', 1, 57, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(774, '0', 'TENDIDO LOZA 9\" MOD.A15-26   737 CAJAX48', 'images/catalogo/2bcdea8c5bacee5373c207d0ae4103f9b8eccd97.jpg', 1, 57, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(775, '0', 'PLATO HONDO LOZA 9\" MOD.A14-15   737 CAJAX48', 'images/catalogo/b36925a0326a2b780146ad6e0fbb571cb3db1ab6.jpg', 1, 57, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(776, '0', 'TENDIDO LOZA 9\" MOD.A14-15  737 CAJAX48', 'images/catalogo/196d43ee6ba5936e5b4fff1087469a786f399d32.JPG', 1, 57, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(777, '0', ' PLATO HONDO LOZA 9\" MOD.A12-33 FL OR ROJA/MORADA S/FILO CAJAX48', 'images/catalogo/f52efeadd4a0a849a4e7345d7e13c3c448abe5bf.jpg', 1, 57, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(778, '0', 'TENDIDO LOZA 9\" MOD.A12-33 FLOR ROJA/MORADA S/FILO CAJAX48', 'images/catalogo/3bb427f035a5ad472f71f66a4a85181c8f1944fc.jpg', 1, 57, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(779, '0', ' PLATO HONDO LOZA 9\" MOD.A12-32 CAJAX48', 'images/catalogo/c5f972dcd2ea7c67668e50b8faa4b2507358c8fa.jpg', 1, 57, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(780, '0', '5 PLATO HONDO LOZA 9\" MOD.A12-26  S/FILO CAJAX48', 'images/catalogo/4b9bd05ef7e86c66e9e1ca745b3c1ef2294a8e78.jpg', 1, 57, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(781, '0', ' TENDIDO LOZA 9\" MOD.A12-26 SIN FILO 737 CAJAX48', 'images/catalogo/490e45df38483da23def4db6861e27eb67fa8800.jpg', 1, 57, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(782, '0', ' TENDIDO LOZA 9\" MOD.A16-04  SIN FILO  737 CAJAX48', 'images/catalogo/319d7e2c41979886862645c9e9408a03a7937e3a.jpg', 1, 57, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(783, '0', ' TENDIDO LOZA 9\" MOD.A12-32 SIN FILO 737 CAJAX48', 'images/catalogo/ffa99676847c2044e8b7c431d6be11a1c922815b.jpg', 1, 57, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(784, '0', 'DECANTADOR VIDRIO 1 LT # 71402801  CAJAX12', 'images/catalogo/47ad524111b50e43cbac571801325f9a502b34bb.jpg', 1, 59, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(785, '0', ' 1 LT NUEVO ESCOCES 16QH T. PERU CAJAX06', 'images/catalogo/905b60dcc9784c101e735bbbabd7f05af6b6f904.jpg', 1, 113, 103, 1, 'UNIDAD', 0, 1, 1, 0),
(786, '0', ' 1.8 LT NUEVO ESCOCES 18 QH   CAJAX06', 'images/catalogo/2e6843f30024e50a444583e273dd8baff8295aad.jpg', 1, 113, 103, 1, 'UNIDAD', 0, 1, 1, 0),
(787, '0', ' 1 LT VOGUE 30-100  T.PERU CAJAX06', 'images/catalogo/ae62a99b94a0f765a9160680769b4d68e484a73a.jpg', 1, 113, 103, 1, 'UNIDAD', 0, 1, 1, 0),
(788, '0', ' 1.8 LT VOGUE 30-180    CAJAX06', 'images/catalogo/445776f03a05bcb244d477254459d69b7fe2c2f9.jpg', 1, 113, 103, 1, 'UNIDAD', 0, 1, 1, 0),
(789, '0', ' ACERO 1.8 LT SUNFLOWER # 883-1800S 901 CAJAX12', 'images/catalogo/5e156c902daa6a248a22f43129f81fce608f1702.jpg', 1, 114, 102, 1, 'UNIDAD', 0, 1, 1, 0),
(790, '0', ' COLOR 1 LT SUNFLOWER SUNB30 4-1000 901 CAJAX12', 'images/catalogo/c307d32e3603b636c82158cdd740c83e4ec83016.jpg', 1, 114, 102, 1, 'UNIDAD', 0, 1, 1, 0),
(791, '0', ' ANTIADH.# 18 NEGRO 2MM C/E SPAT.(JDFP-18) ICHIMATSU CAJAX06', 'images/catalogo/42ca41bcb900bb0a6bed6635cf8e670ecab85ecb.jpg', 1, 115, 100, 1, 'UNIDAD', 0, 1, 1, 0),
(792, '0', ' ANTIADH.#20 NEGRO 2MM C/E SPAT.(JDFP-20) ICHIMATSU CAJAX06', 'images/catalogo/0c89ece6d6c7b459d957513dc0de5e33085d5e35.jpg', 1, 115, 100, 1, 'UNIDAD', 0, 1, 1, 0),
(793, '0', 'ANTIADH.# 22 NEGRO 2MM C/E SPAT.(JDFP-22) ICHIMATSU CAJAX06', 'images/catalogo/10282687cb50fd64d4628b84cc0b7079148e3e98.png', 1, 115, 100, 1, 'UNIDAD', 0, 1, 1, 0),
(794, '0', ' ANTIADH.# 24 NEGRO 2.5MM C/E SPAT.(JDFP-24) ICHIMATSU CAJAX06', 'images/catalogo/e6d5f77405452eb40ad707bf1e815d0740826b02.jpg', 1, 115, 100, 1, 'UNIDAD', 0, 1, 1, 0),
(795, '0', ' ANTIADH.# 26 NEGRO 2.5MM C/E SPAT.(JDFP-26) ICHIMATSU CAJAX06', 'images/catalogo/23c11c802e1ffc6523f11a55ddee85a09fa137ce.jpg', 1, 115, 100, 1, 'UNIDAD', 0, 1, 1, 0),
(796, '0', ' LUNA 1.75 LT TAPA ROJA (435 44)  CAJAX06', 'images/catalogo/ca0a3107d50eda7f2d53227926c4e244e69e105c.jpg', 1, 59, 101, 1, 'UNIDAD', 0, 1, 1, 0),
(797, '0', ' CITY 2LT C/T Y CAJA REGALO  43038  CAJAX06', 'images/catalogo/db1f7ece0b7554d9623a605656a89b6813863b53.jpg', 1, 59, 101, 1, 'UNIDAD', 0, 1, 1, 0),
(798, '0', ' KANALAR BISTRO 1.85 LTC/TAP A- (80119) /726 CAJAX06', 'images/catalogo/3cbf38c8af90238e0b80bcf568f3ed2d089fe3be.jpg', 1, 59, 101, 1, 'UNIDAD', 0, 1, 1, 0),
(799, '0', ' LUMIN.ARC 1 LT C/TAPA G2635  726 CAJAX06', 'images/catalogo/ccb64721d138537c0c38a05adb7a49d0d1a62a3b.jpg', 1, 59, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(800, '0', ' AZUR 1.50 LT (43018) -C/TAPA /726 CAJAX06', 'images/catalogo/00728038e9887a6196a03babe52fb0c324eb81e2.jpg', 1, 59, 101, 1, 'UNIDAD', 0, 1, 1, 0),
(801, '0', ' LUMIN.ARC 1.3 LT C/T G2662  726 CAJAX06', 'images/catalogo/31cf19e902b4be90642ebeb6d92de8616b20d60b.jpg', 1, 59, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(802, '0', ' LUMIN.TIVOLI 1.6 LT C/T G26 74 726 CAJAX06', 'images/catalogo/fe4f8455602786216519cf671ecc70e7cadfe479.JPG', 1, 59, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(803, '0', 'SOPERITO 7\" LOZA BLCO 737 CAJA X72', 'images/catalogo/a08ce8686147d919161960f7f54c3b1f0d2aaf20.jpg', 1, 116, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(804, '0', 'SOPERITO 8\" LOZA BLCO 737 CAJA X72', 'images/catalogo/8ac328975b5b25b464443ad06785b685b15c3dba.jpg', 1, 116, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(805, '0', ' LOZA 7\" BLCO 737 CA JAX36', 'images/catalogo/58f373b10048e7919e8c0ea53538f53409c43067.jpg', 1, 117, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(806, '0', ' LOZA 6\" BLCO 737 CAJAX 60', 'images/catalogo/d6be3b855217d579a0efc4202f6882e0fdf4dfee.jpg', 1, 117, 99, 2, 'UNIDAD', 0, 1, 1, 0),
(807, '0', ' TENDIDO LOZA 6\"BLANCO  737 CAJAX144', 'images/catalogo/68674d507b41f7e743986414c4f8804addac920e.jpg', 1, 57, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(808, '0', ' TENDIDO LOZA 7\"BLCO 73 7 CAJAX96', 'images/catalogo/3f96e46a3fd68c2d47b56728bed238c9ad22e6e8.jpg', 1, 57, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(809, '0', ' TENDIDO LOZA 8\"BLANCO 737 CAJAX72', 'images/catalogo/e06d2e93b1778a91d3f152aff614fd9850d2d2ca.jpg', 1, 57, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(810, '0', ' TENDIDO LOZA 9\"BLANCO 73 7 CAJAX48', 'images/catalogo/c4c0bdb8320af741279a31c80a640a0b63de78d5.jpg', 1, 57, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(811, '0', ' HONDO LOZA 6\" BLCO 737 C AJAX144', 'images/catalogo/65cdf9d67c686ff04f9a7a45119addcf7b38676d.png', 1, 57, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(812, '0', 'HONDO LOZA 7\" BLANCO 737 CAJAX96', 'images/catalogo/f1c68ef10b870f8d113e0f3ed7e036139e222771.jpg', 1, 57, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(813, '0', 'HONDO LOZA 8\"BLANCO 737 CA JAX72', 'images/catalogo/ef2ae5e099fd8ffdf6fc2ae941b2b74fa2bc3a6d.jpg', 1, 57, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(814, '0', ' HONDO LOZA 9\"BLANCO 737 C AJAX48', 'images/catalogo/4f0957075e253acb0a2ce6f5a9ec5350ea026d4e.jpg', 1, 57, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(815, '0', ' PLATON 11\" CUADRADO LOZA BLCO T/OSLO (24#) 737 CAJAX24', 'images/catalogo/f70c2e75f1d664b34dbfc6934a6215696091bc5f.jpg', 1, 57, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(816, '0', 'TENDIDO LOZA CUAD.9.5\" BLAN CO T/OSLO (24#) 737 CAJAX48', 'images/catalogo/747336814bb3031f3ddacca583ae64537fdfacf2.jpg', 1, 57, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(817, '0', 'TENDIDO LOZA CUAD.8\"BLCO T/ OSLO (24#) 737 CAJAX72', 'images/catalogo/43b36c50ac87100577b29962b3069e610081bc96.jpg', 1, 57, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(818, '0', ' 10.75\" CUADRADO LOZA BLANC A (19#) 737 CAJAX24', 'images/catalogo/0cdffb7f46f32eca6b59d1b5254133da2b3804e6.jpg', 1, 57, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(819, '0', 'C/P TE LOZA 220CC BLANCO (NU EVO) CJA/REG.', 'images/catalogo/9f470905e24b51df8a13ce53566a1ba127fb2ccb.jpg', 1, 25, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(820, '0', 'DESAYUNO 350CC LOZA BLAN CA 737 CAJAX24', 'images/catalogo/dba833919d4000ddc417d886446c05383f8a9a0a.jpg', 1, 26, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(821, '0', ' C/CUCHARITA # JY2190  901 CAJAX48', 'images/catalogo/39601b2676340c34856c56749bfae564912c0306.jpg', 1, 1, 99, 1, 'UNIDAD', 0, 0, 1, 1),
(822, '0', 'LOZA CUAD.BLCO HOTELERO  737 CAJAX144', 'images/catalogo/0abf8e0ba61491c9b496318f71489c1376e44f27.jpg', 1, 118, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(823, '0', ' MERMELADA HOTELERO 73 7 CAJAX144', 'images/catalogo/7dcdbd93e3efea9c55285a725f5ef4be9bfb84c8.jpg', 1, 57, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(824, '0', 'LOZA REDONDA 2.75\" HOTELE RO 737 CAJAX144', 'images/catalogo/52de4fbc154346344cfd5d365a26a9319056dae3.jpg', 1, 21, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(825, '0', ' BOLO LOZA 3.75\" BLANCO 737 CA JAX144', 'images/catalogo/d45cc45228bf7fbd2dbff95563f7daf338f69f5f.png', 1, 117, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(826, '0', ' LOZA 2.7\" SOUFLE (DULCERITA)  6.8X3.6CM # JY-7340-2.7\" 901 C AJAX144', 'images/catalogo/3f83de4f69d946d15bea8a34330f449914a55710.jpg', 1, 117, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(827, '0', ' 8\" LOZA CUAD.BLCO 737 CAJAX48', 'images/catalogo/9f99013d3014027829eec63b82d4b8facfb6e916.jpg', 1, 116, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(828, '0', ' LOZA 12\" OVALADA C/ASAS JY -9843-12 CAJAX08', 'images/catalogo/04d73df4007193544a66ed747a2bdb56761fd7c5.jpg', 1, 15, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(829, '0', ' LOZA 9.5\" OVALADA C/ASAS J Y-9843-9.5 CAJAX08', 'images/catalogo/416abc7b0a4998368f107f23e33e981dda5cf8d1.jpg', 1, 15, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(830, '0', ' LOZA 12\" OVAL. BLCO # ST-J Y-3154-12 901 CAJAX24', 'images/catalogo/d98f4f57e720f2902879c981008707348b357419.jpg', 1, 15, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(831, '0', ' LOZA REDONDO 29 CM C/5 DIV ISIONES JY-3158-12\" CAJAX08', 'images/catalogo/b3eb75b3a4af16904b9fe08e242340c8e86a5b0a.jpg', 1, 15, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(832, '0', 'DE MESA MODELO 60 (CF-60/ 01) 990600101 ', 'images/catalogo/d006465736f038aa3e4530f15fdbc17e74cd2604.jpg', 1, 119, 104, 1, 'DOCENA', 0, 1, 1, 0),
(833, '0', ' DE MESA MODELO 60 (CF-60/ 02) 990600201 FACUSA', 'images/catalogo/81b16badebdf2f4ef49b1d00c213cd176f4d7a0e.jpg', 1, 120, 104, 1, 'DOCENA', 0, 1, 1, 0),
(834, '0', ' DE MESA MODELO 60 (CF-6 0/03) 990600301 ', 'images/catalogo/55b39a066456ad46a2d9e183e7951ab207f73391.jpg', 1, 121, 104, 1, 'DOCENA', 0, 1, 1, 0),
(835, '0', ' DE TE MODELO 60 (CF-60 /04) 990600401 ', 'images/catalogo/ffc73205eb9fce74a278e38c1c964a470c008bfc.jpg', 1, 119, 104, 1, 'DOCENA', 0, 1, 1, 0),
(836, '0', 'DE MESA MOD.010-1 (990100 100) ', 'images/catalogo/5695a3718d588cd528ef0a416637a1c431c79d80.jpeg', 1, 119, 104, 1, 'DOCENA', 0, 1, 1, 0),
(837, '0', ' DE MESA MOD. 010-2 (99010 0200) FACUSA', 'images/catalogo/9a3957ab87ed843a42c07483d9abce61d0ba720c.jpg', 1, 120, 104, 1, 'DOCENA', 0, 1, 1, 0),
(838, '0', ' DE MESA MOD.730-1 ', 'images/catalogo/7766a693e67604d235b028b33f537d9fa9392c76.jpg', 1, 119, 104, 1, 'DOCENA', 0, 1, 1, 0),
(839, '0', ' DE MESA MOD.730-2 (997300 200) ', 'images/catalogo/c5b7079477e50f89ac4de7c27418b8b3d56f5a31.jpg', 1, 120, 104, 1, 'DOCENA', 0, 1, 1, 0),
(840, '0', ' DE MESA MOD.730-3 (99730 0300) ', 'images/catalogo/5913a4ad7c24863cfed61c02566e7933ace4dbac.jpg', 1, 121, 104, 1, 'DOCENA', 0, 1, 1, 0),
(841, '0', ' DE TE MOD.730-4 ', 'images/catalogo/919b62e86a59007076cdef895560a3cfe29f1158.jpg', 1, 119, 104, 1, 'DOCENA', 0, 1, 1, 0),
(842, '0', ' MESA X 24 MOD.CF-12 01 2024002 ', 'images/catalogo/7f7b3a7a1987bcb3aa160ba995914c7977a03e25.jpg', 1, 122, 104, 1, 'UNIDAD', 0, 1, 1, 0),
(843, '0', ' 5 M/MAD.2 REMACH FA-5 2R ', 'images/catalogo/19ae45bfc7d14fd17836c0bd4a640e310f92235f.jpg', 1, 121, 104, 1, 'UNIDAD', 0, 1, 1, 0),
(844, '0', ' 6 M/MAD.2 REMACH FA-6 2R', 'images/catalogo/c02480562de70207a1103eb2aff0a4bd50c2e35b.jpg', 1, 121, 104, 1, 'UNIDAD', 0, 1, 1, 0),
(845, '0', '7M/MAD.2 REMACH FA-72R ', 'images/catalogo/c10d391a6ba57f0a67bc36b0ce4822b6211f9a08.jpg', 1, 121, 104, 1, 'UNIDAD', 0, 1, 1, 0),
(846, '0', ' 8 M/MAD.2 REMACH FA-8 2R ', 'images/catalogo/a7e6b2e49414b5cc28a0065880918dc4ebd33799.jpg', 1, 121, 104, 1, 'UNIDAD', 0, 1, 1, 0),
(847, '0', 'CHICO A/INOX B-EH/R1-1 B LISTER (131001001) ', 'images/catalogo/a151f6d478a36fc65359975bc6e03a9879907931.jpg', 1, 123, 104, 1, 'UNIDAD', 0, 1, 1, 0),
(848, '0', ' MEDIANO A/INOX B-EH/R2-1  BLISTER (131001004)', 'images/catalogo/8108707e9156756d0f7ef252376e77505b2d8449.jpg', 1, 123, 104, 1, 'UNIDAD', 0, 1, 1, 0),
(849, '0', ' GRANDE A/INOX B-EH/R3-1 BLISTER (131001002) ', 'images/catalogo/286bbfcea7d4a1b8bc7dbd4989ba5560970ded17.png', 1, 123, 104, 1, 'UNIDAD', 0, 1, 1, 0),
(850, '0', ' ACERO M/PLST.MP-3U4A/NE', 'images/catalogo/11e858614582f1baff691023df4fc8f330ba4447.jpg', 1, 124, 104, 1, 'UNIDAD', 0, 1, 1, 0),
(851, '0', ' SPAGUETTI M/PLAST.BAT 4 8U4A/NE (991100102) ', 'images/catalogo/23cbb466c989ed4d0745f2644d45dda3ed68aa18.jpg', 1, 119, 104, 1, 'UNIDAD', 0, 1, 1, 0),
(852, '0', ' ACERO M/PLST.MP-6U4A/NE (991100600)', 'images/catalogo/f5775293d98675cd87c336469c64e18140a021e9.jpg', 1, 48, 104, 1, 'UNIDAD', 0, 1, 1, 0),
(853, '0', ' CHINO (MP-820U4/NE) B.C 4 M/P.NE (991100602)', 'images/catalogo/1ea35d79db6c9d4a1fc69f96382edd6a1f145df9.jpg', 1, 48, 104, 1, 'UNIDAD', 0, 1, 1, 0),
(854, '0', 'CALADA ACERO M/PLST.MP-4 UB4A/NE ', 'images/catalogo/b9ff8fdb5f1dc2a198af830d476e4722991e14cd.jpg', 1, 125, 104, 1, 'UNIDAD', 0, 1, 1, 0),
(855, '0', ' LLANA ACERO M/PLST.MP-1U4 A/NE (991100100) ', 'images/catalogo/83f7e39ebc70da5b92229e4bd1c26161f90a3e77.jpg', 1, 119, 104, 1, 'UNIDAD', 0, 1, 1, 0),
(856, '0', ' REDONDA ACERO EH-3U4 M /MAD. Nº 04 (991030301)', 'images/catalogo/95e14abbeb256b26d1a9aba06d9861c56c947476.jpg', 1, 125, 104, 1, 'UNIDAD', 0, 1, 1, 0),
(857, '0', ' A/INOX PROFESIONAL 28 CM KB28 809', 'images/catalogo/fb7f9fcba70e6235173795e65ceb3e925563e724.jpg', 1, 117, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(858, '0', ' A/INOX PROFESIONAL 30 CM KB800', 'images/catalogo/c9c60e252edf1d478c33e4d16221c953bc516d66.jpg', 1, 117, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(859, '0', ' A/INOX PROFESIONAL 32 CM KB900', 'images/catalogo/284aa49603393ccdda441bfc103985d962612ed8.jpg', 1, 117, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(860, '0', ' A/INOX PROFESIONAL 22 CM KB300', 'images/catalogo/2c5a89afff7712fb49b655bd64dd9b279e1b8d3a.jpg', 1, 117, 99, 1, 'UNIDAD', 0, 1, 1, 0),
(861, '0', 'A/INOX PROFESIONAL 20 CM ', 'images/catalogo/dec225744b9468a8b9420b7a31b3fd32d5b44fd8.jpg', 1, 117, 105, 1, 'UNIDAD', 0, 1, 1, 0),
(862, '0', ' A/INOX PROFESIONAL 24 CM KB400 ', 'images/catalogo/b8593dde2dbb1c2325edd6953320bf124b592f95.jpg', 1, 117, 105, 1, 'UNIDAD', 0, 1, 1, 0),
(863, '0', ' A/INOX PROFESIONAL 26 CM KB500', 'images/catalogo/1ad82e1a8632ff2a01bddb390ea09d0bc8ba6c1a.jpg', 1, 117, 105, 1, 'UNIDAD', 0, 1, 1, 0),
(864, '0', ' A/INOX 24 CM 3 QT (CLD-3 00)', 'images/catalogo/382eac262c0c3b2e96d2abcc628ae9708fa4dc5c.jpg', 1, 40, 105, 1, 'UNIDAD', 0, 1, 1, 0),
(865, '0', 'A/INOX 28 CM 5QT CLD500  ', 'images/catalogo/fefe3ae171584f28658bf490e3d202dcaa779e8c.jpg', 1, 40, 105, 1, 'UNIDAD', 0, 1, 1, 0),
(866, '0', ' A/INOX 34 CM (CLD-800) ', 'images/catalogo/b742db50fa2961aa981b10b8d2c00264917c4b81.jpg', 1, 40, 105, 1, 'UNIDAD', 0, 1, 1, 0),
(867, '0', ' A/INOX 38 CM CLD-38 ', 'images/catalogo/5ceb13e4c21339b99f7fb0b3a660329ff6a89a24.jpg', 1, 40, 105, 1, 'UNIDAD', 0, 1, 1, 0),
(868, '0', ' A/INOX PROFESIONAL 38 CM KB38 (KB-1200) ', 'images/catalogo/3a1731eb0805ac13908d3c1d72cea33560762958.jpg', 1, 117, 105, 1, 'UNIDAD', 0, 1, 1, 0),
(869, '0', ' A/INOX PROFESIONAL 35 CM KB35 (KB-1300)', 'images/catalogo/f0a648adc1717258db3f4055680ce7d25556abc6.jpg', 1, 117, 105, 1, 'UNIDAD', 0, 1, 1, 0),
(870, '0', ' A/INOX RED.28 CM (RTS-12)  ', 'images/catalogo/791ef75e7d90ae85df21ace348bfbf5fde8ac0c5.jpg', 1, 87, 105, 1, 'UNIDAD', 0, 1, 1, 0),
(871, '0', ' A/INOX RED.30CM/0.7MM (R TS-13) ', 'images/catalogo/85d8ac6f6b5fe2b1e40bc5b6d82d0f4089226a1a.jpg', 1, 87, 105, 1, 'UNIDAD', 0, 1, 1, 0),
(872, '0', ' A/INOX RED.32CM/0.7MM (R TS-14) ', 'images/catalogo/3daa2200266b0f775a95b8b39da82706212d52cb.jpg', 1, 87, 105, 1, 'UNIDAD', 0, 1, 1, 0),
(873, '0', ' A/INOX RED.35 CM (RTSL-15 ) ', 'images/catalogo/b715e5fbcd3dc4f1e3d226fb7b71715072ea4e54.jpg', 1, 87, 105, 1, 'UNIDAD', 0, 1, 1, 0),
(874, '0', ' A/INOX RED.40 CM (RTS-17)  ', 'images/catalogo/99fdb8270f87e8833511ee5831c976169bb6fccf.jpg', 1, 87, 105, 1, 'UNIDAD', 0, 1, 1, 0),
(875, '0', ' LASAGÑA 30 X 22 CM (LP-30)', 'images/catalogo/72033c079a43b9f5d2ca08d610d8a6d3dfd30e80.jpg', 1, 15, 105, 1, 'UNIDAD', 0, 1, 1, 0),
(876, '0', 'FUENTE LASAGÑA 35 X 26 CM (LP-35)', 'images/catalogo/4453b036a962928dbbcb1fd312f41606dccbb5d4.jpg', 1, 15, 105, 1, 'UNIDAD', 0, 1, 1, 0),
(877, '0', ' LASAGÑA 40 X 30 CM (LP-40)  ', 'images/catalogo/c012099721bd15cdad2d572f033115908c7a745a.jpg', 1, 15, 105, 1, 'UNIDAD', 0, 1, 1, 0),
(878, '0', ' LIMON A/INOX (LMNSQ)  ', 'images/catalogo/60fce8aa6d10e05f57448c93caf8a1a6f6c81a4e.jpg', 1, 42, 105, 1, 'UNIDAD', 0, 1, 1, 0),
(879, '0', ' A/INOX PROFESIONAL 43 CM KB1500 ', 'images/catalogo/6bdec4fa9dbdcbb9561820b728c244caddc91843.jpg', 1, 117, 105, 1, 'UNIDAD', 0, 1, 1, 0),
(880, '0', 'ESQUINERA P/BAÑO II TAUPE  # 6237 CAJAX06', 'images/catalogo/3812b3ce7d7f9bb6ed88794e4b849aa6e25dd692.jpg', 1, 126, 106, 1, 'UNIDAD', 0, 1, 1, 0),
(881, '0', ' ESQUINERA P/BAÑO II BLANCO  # 6236 CAJAX06', 'images/catalogo/eee6b8e1b12ecec875536dad88dabbc70cdd4513.jpg', 1, 110, 106, 1, 'UNIDAD', 0, 1, 1, 0),
(882, '0', ' P/BAÑO TAUPE C/ESPEJO # 7316  CAJAX04', 'images/catalogo/4817501eddf4b647335fffdc110652b9533f73a4.jpg', 1, 127, 106, 1, 'UNIDAD', 0, 1, 1, 0),
(883, '0', 'ORGANIZ.180 (7\"-11 COMPARTIM .) NATURAL 5515  CAJAX12', 'images/catalogo/f810788a35059f63836ce615743ebb7057a2b9f4.jpg', 1, 68, 106, 1, 'UNIDAD', 0, 1, 1, 0),
(884, '0', 'ORGANIZ.230 (9\"-8 COMPARTIM. ) TRANSP.#3864 CAJAX12', 'images/catalogo/1c9975897a791dc060cf7ef8f65c391f13d86a39.JPG', 1, 68, 106, 1, 'UNIDAD', 0, 1, 1, 0),
(885, '0', ' ORGANIZ.330 (13\"-10 COMPARTI M.) NATURAL # 3614  CAJAX12', 'images/catalogo/6408196240d69224fe1368692c0d016991a236ac.jpg', 1, 68, 106, 1, 'UNIDAD', 0, 1, 1, 0),
(886, '0', 'ORGANIZ.270 (11\"-15 COMPARTI M.) NATURAL 5520 CAJAX12', 'images/catalogo/3896e3a9f9e649165b802f25aa27a8011a133841.jpg', 1, 68, 106, 1, 'UNIDAD', 0, 1, 1, 0),
(887, '0', ' ORGANIZ.360 (14\"-21 COMPARTI M.) NATURAL 5525-XP  CAJAX12', 'images/catalogo/312d865f5a24ac9f96647b3a3d7620faad9a09b7.jpg', 1, 68, 106, 1, 'UNIDAD', 0, 1, 1, 0),
(888, '0', ' VANITY 14\" NATURA/ROSADO # 4 757  CAJAX06', 'images/catalogo/94e648cface1ee3f8cc93939f8992bacc0799a5d.jpg', 1, 68, 106, 1, 'UNIDAD', 0, 1, 1, 0),
(889, '0', ' HER.12\"T.P.NATUR.4220  MIN CAJAX06', 'images/catalogo/19d918e84e8cc45bb302a422796ee6fa9dbc4d58.jpg', 1, 68, 106, 1, 'UNIDAD', 0, 1, 1, 0),
(890, '0', ' REDONDO 20CM WENGUE #846 6-XP  CAJAX12', 'images/catalogo/a8371f94ef8f3f0563eeb132db74dbe8839e03bf.jpg', 1, 128, 106, 1, 'UNIDAD', 0, 1, 1, 0),
(891, '0', ' REDONDO 25CM WENGUE #846 8-XP  CAJAX12', 'images/catalogo/505047ca927542f0ba60fd670393ab545c9b9723.jpg', 1, 128, 106, 1, 'UNIDAD', 0, 1, 1, 0),
(892, '0', ' REDONDO 35CM WENGUE #847 3-XP  CAJAX12', 'images/catalogo/e9fa36c573e113ada8b24764c4ebd8224b5e344c.jpg', 1, 128, 106, 1, 'UNIDAD', 0, 1, 1, 0),
(893, '0', ' REDONDO 30CM WENGUE #847 1-XP CAJAX12', 'images/catalogo/e5f47b309d8cd2c544da15bd05d2a27160717fce.jpg', 1, 128, 106, 1, 'UNIDAD', 0, 1, 1, 0),
(894, '0', ' REDONDO 40CM WENGUE #847 4-XP  CAJAX12', 'images/catalogo/c5d02eee6e863c5caeba11ded5e9b9cbff60a33f.jpg', 1, 128, 106, 1, 'UNIDAD', 0, 1, 1, 0),
(895, '0', 'VOLQUETE CHECHICAR', 'images/catalogo/0a68d70abe96ebc95216993b4cf62b0875ee94c5.jpg', 1, 38, 107, 1, 'DOCENA', 0, 1, 1, 0),
(896, '0', 'MINITRACTOR', 'images/catalogo/88a4600ba3ae553ae6d3830bf8cb3fdc3d7d6413.jpg', 1, 38, 107, 1, 'DOCENA', 0, 1, 1, 0),
(897, '0', 'ALICIA CON TAPA', 'images/catalogo/7c463c0b06e245d7696b6c73b1322d7806ea4257.jpg', 1, 27, 108, 1, 'UNIDAD', 0, 1, 1, 0),
(898, '0', 'PLANA', 'images/catalogo/ec5a8a4da1d864b3fab3bffc9b4a90d1431cf026.jpg', 1, 35, 108, 1, 'UNIDAD', 0, 1, 1, 0),
(899, '0', 'MARITA', 'images/catalogo/fcce2020c92c5dfb7ddea548eff5d2e2a91ae0cd.jpg', 1, 35, 108, 1, 'UNIDAD', 0, 1, 1, 0),
(900, '0', 'CARMENCITA', 'images/catalogo/f57d33de7e8911d7ed78071cd51b56d74a0ad226.jpg', 1, 35, 108, 1, 'DOCENA', 0, 1, 1, 0),
(901, '0', 'ESPIGA', 'images/catalogo/d12b266fdebbea60e6ac2744c4f376205678ebe0.jpg', 1, 35, 108, 1, 'UNIDAD', 0, 1, 1, 0),
(902, '0', 'NEGRO CHICO', 'images/catalogo/6f82167d270ac77b72815f9bcccfe794a5967ee5.jpg', 1, 82, 84, 1, 'DOCENA', 0, 1, 1, 0),
(903, '0', 'COLOR CHICO', 'images/catalogo/8def2f64d1255827bceb23fabc0e4b030d4362be.jpg', 1, 82, 108, 1, 'DOCENA', 0, 1, 1, 0),
(904, '0', 'COMODINA # 5 CAJONES', 'images/catalogo/15d158cb410a91bd5b5dc9fcfe7843a295345b21.jpg', 1, 63, 9, 1, 'UNIDAD', 0, 1, 1, 0),
(905, '0', 'ARUBA GRANDE CON TAPA', 'images/catalogo/aa69218cbd422bea9515c27c366d7fd53551d6f3.jpg', 1, 44, 9, 1, 'DOCENA', 0, 1, 1, 0),
(906, '0', 'VENUS COLOR ', 'images/catalogo/92dcd4d3983539b6f480283d0e1d15668267e6a8.jpg', 1, 24, 9, 1, 'UNIDAD', 0, 1, 1, 0),
(907, '0', 'BOX N° 14 VANITY CON ACESORIOS', 'images/catalogo/0a23759781aafb72f140ffb52aa42efa3227c4d4.png', 1, 129, 9, 1, 'UNIDAD', 0, 1, 1, 0),
(908, '0', 'BOX N° 16 VANITY BOX', 'images/catalogo/6f281196cf403ab989ca7d9e9144352a118c633c.jpg', 1, 129, 9, 1, 'UNIDAD', 0, 1, 1, 0),
(909, '0', 'MEDIDORA PLION N° 0.25 C/TAPA', 'images/catalogo/8259706506e6abb999bcdb083a284eeec09eb30e.jpg', 1, 59, 9, 1, 'UNIDAD', 0, 1, 1, 0),
(910, '0', 'MEDIDORA POLIN N° 0.50 SIN TAPA', 'images/catalogo/9e772463a10e8577d23e3e68561b009bdd7f6f71.jpg', 1, 59, 9, 1, 'UNIDAD', 0, 1, 1, 0),
(911, '0', 'MEDIDORA POLIN N° 1.0 SIN TAPA', 'images/catalogo/b1c56fb3e835c1cc560bf8ce911345a3db85b400.jpg', 1, 59, 9, 1, 'UNIDAD', 0, 1, 1, 0),
(912, '0', 'POLIN CHICO', 'images/catalogo/2bd444337ab05f1b678612e07695e08a274f8aa6.jpg', 1, 48, 9, 1, 'UNIDAD', 0, 1, 1, 0),
(913, '0', 'POLIN GRANDE', 'images/catalogo/2733f1f77d4e0cd163673fe64eb36999e608f457.png', 1, 48, 9, 1, 'UNIDAD', 0, 1, 1, 0),
(914, '0', 'ITALIANO 1 KILO TRANSPARENTE CON TAPA', 'images/catalogo/2e33e4e9ff9144e69ef670b8bd6506e43b9b46d1.jpg', 1, 24, 9, 1, 'UNIDAD', 0, 1, 1, 0),
(915, '0', 'POLIN JUEGO X 12 UNIDADES', 'images/catalogo/f7b5501075ad6e8520106c9d8f0f1893f9140897.jpg', 1, 130, 9, 1, 'UNIDAD', 0, 1, 1, 0),
(916, '0', 'BB ANATONICA GRANDE ', 'images/catalogo/ac6073a9dd15489ea31ba117eec589c60dd0c26b.jpg', 1, 49, 9, 1, 'UNIDAD', 0, 1, 1, 0),
(917, '0', 'POLIN DECORADA NIÑA + 2 BANCO DIDACTICO', 'images/catalogo/8193062d79cf5dab475fb91e5e1a492ba11d8bc5.jpg', 1, 46, 9, 1, 'UNIDAD', 0, 1, 1, 0),
(918, '0', 'POLIN UNISEX + 2 BANCOS DIDACTICOS ', 'images/catalogo/60ad04b5ce36772358c6ea3af6901c71d26bdc74.jpg', 1, 46, 9, 1, 'UNIDAD', 0, 1, 1, 0),
(920, '0', 'PELOTA DE PLASTICO', 'images/catalogo/f54b532b1b8d706b8c7259c64bdb3e4fdeaf0c7a.jpg', 1, 131, 37, 1, 'DOCENA', 0, 1, 1, 0),
(921, '0', ' DE PLASTICO', 'images/catalogo/975831ebf16c9155afe9066630c9fb47c32123ea.jpg', 1, 79, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(922, '0', 'OVNI TRANSPARENTE ', 'images/catalogo/ceea87c53abf3c19acf86adb96dab099b4a768f5.jpg', 1, 24, 51, 1, 'UNIDAD', 0, 1, 1, 0),
(923, '0', 'OVNI COLOR', 'images/catalogo/2779128c301042ee773d165e894dede1699b26d5.jpg', 1, 24, 9, 1, 'UNIDAD', 0, 1, 1, 0),
(924, '0', 'GALAXIA 3/4 KG TRANSPARENTE C/TAPA COLOR', 'images/catalogo/fdf72ea16f18a77f53e884345b793fd8b45ba5fd.jpg', 1, 24, 9, 1, 'UNIDAD', 0, 1, 1, 0),
(925, '0', 'CUBIERTO NEW', 'images/catalogo/fecfee91dd91fd1dd77c2ada7ee2c73d08f423bc.JPG', 1, 93, 9, 1, 'UNIDAD', 0, 1, 1, 0),
(926, '0', '500 ML TRANSPARENTE SIN TAPA', 'images/catalogo/5d3a9e858dad32d0d6dec37b664de16f81713565.jpg', 1, 59, 62, 1, 'DOCENA', 0, 1, 1, 0),
(927, '0', 'CALADA NUMERO 10 COLORES SURTIDOS', 'images/catalogo/bf27e0df196f74763388d090b300075d39b5507d.jpg', 1, 66, 37, 1, 'DOCENA', 0, 1, 1, 0),
(928, '0', 'PREMIUM 10 LITROS TRANSPARENTE CON TAPA COLOR', 'images/catalogo/f2a410b38281adce926b73a372e908650bbf97f3.jpg', 1, 2, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(929, '0', 'PREMIUM 10 LITROS COLOR CON TAPA BLANCA', 'images/catalogo/6e3d89bd5a5acad22d7388a7346bd3ae5b26f07a.jpg', 1, 2, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(930, '0', 'EBENECER CON TAPA Y ASA', 'images/catalogo/ec42f44219854e01d1d3becdfd6c072fa838195e.jpg', 1, 44, 37, 1, 'UNIDAD', 0, 1, 1, 0),
(931, '0', 'PRUEBA5XD', 'images/catalogo/fa5541785ddabda477ee0e1a5a6b4419ab5957db.png', 1, 3, 27, 1, 'DOCENA', 0, 1, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_categ`
--

CREATE TABLE `tb_categ` (
  `idg` int(11) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `est` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_categ`
--

INSERT INTO `tb_categ` (`idg`, `nom`, `est`) VALUES
(1, 'AZUCARERO', 1),
(2, 'BALDE', 1),
(3, 'BEBETODO', 1),
(4, 'CAJAS', 1),
(5, 'CANASTA PICNIC', 1),
(6, 'CANASTILLA', 1),
(7, 'CESTA', 1),
(8, 'CONDIMENTERO', 1),
(9, 'CONSERVADOR', 1),
(10, 'COPAS', 1),
(11, 'DESPENSEROS', 1),
(12, 'DISPENSADOR', 1),
(13, 'DULCERAS', 1),
(14, 'EMBUDO', 1),
(15, 'FUENTE', 1),
(16, 'HERVIDOR', 1),
(17, 'MENTEQUILLERA', 1),
(18, 'PROTECTOR DE ALIMENTOS', 1),
(19, 'RAYADOR', 1),
(20, 'REPOSTERO', 1),
(21, 'SALSERO', 1),
(22, 'SERVILLETERO', 1),
(23, 'TABLA', 1),
(24, 'TAPER', 1),
(25, 'TAZA', 1),
(26, 'TAZA Y PLATO', 1),
(27, 'TAZON', 1),
(28, 'UTENSILIOS', 1),
(29, 'UTILITARIO', 1),
(30, 'VASO', 1),
(31, 'BULT BALDE', 1),
(32, 'BULT BEBETODO', 1),
(33, 'MACETA', 1),
(34, 'JABONERA', 1),
(35, 'BATEA', 1),
(36, 'MINI', 1),
(37, 'LAVACUELA', 1),
(38, 'CARRO', 1),
(39, 'TALLARINERA', 1),
(40, 'COLADERA', 1),
(41, 'GELATINERO', 1),
(42, 'EXPRIMIDOR', 1),
(43, 'CEVICHERAS', 1),
(44, 'CESTO', 1),
(45, 'LAVATORIO', 1),
(46, 'MESA', 1),
(47, 'ESCURRIDOR', 1),
(48, 'CUCHARON', 1),
(49, 'BAÑERA', 1),
(50, 'SILLA', 1),
(51, 'TACHO', 1),
(52, 'JARRITO', 1),
(53, 'TRAPEADOR', 1),
(54, 'ESCOBA', 1),
(55, 'COLGADOR', 1),
(56, 'COCHE', 1),
(57, 'PLATO', 1),
(58, 'GALONERA', 1),
(59, 'JARRA', 1),
(60, 'SILLON', 1),
(61, 'TINA', 1),
(62, 'POTE', 1),
(63, 'COMODA', 1),
(64, 'ESPEJO', 1),
(65, 'BACIN', 1),
(66, 'PAPELERA', 1),
(67, 'DESPENSERO', 1),
(68, 'CAJA', 1),
(69, 'PORTAVAJILLA', 1),
(70, 'BANQUITO', 1),
(71, 'BANCO', 1),
(72, 'SET', 1),
(73, 'PACK', 1),
(74, 'ENVASE', 1),
(75, 'PANERA', 1),
(76, 'JUEGO', 1),
(77, 'GANCHO', 1),
(78, 'COLADOR', 1),
(79, 'CANASTA', 1),
(80, 'KOSMOTACHO', 1),
(81, 'HISOPO', 1),
(82, 'RECOGEDOR', 1),
(83, 'TOMATODO', 1),
(84, 'PRACTICESTA', 1),
(85, 'JARRO', 1),
(86, 'CHIFERO', 1),
(87, 'AZAFATE', 1),
(88, 'SUPER', 1),
(89, 'DURAMESA', 1),
(90, 'PROTECTOR', 1),
(91, 'BANDEJA', 1),
(92, 'CAÑO', 1),
(93, 'PORTA', 1),
(94, 'DESATORADOR', 1),
(95, 'LAVAVAJILLA', 1),
(96, 'SHAMPOO', 1),
(97, 'JABON', 1),
(98, 'ESCOBILLON', 1),
(99, 'DESINFECTANTE', 1),
(100, 'ESPONJA', 1),
(101, 'TOALLITAS', 1),
(102, 'CAMION', 1),
(103, 'LEJIA', 1),
(104, 'GUANTE', 1),
(105, 'VERDULERO', 1),
(106, 'MUÑECA', 1),
(107, 'ASADERA', 1),
(108, 'BOWL', 1),
(109, 'FRASCO', 1),
(110, 'LICORERA', 1),
(111, 'CONFITERO', 1),
(112, 'HIELERA', 1),
(113, 'THERMO', 1),
(114, 'TERMO', 1),
(115, 'SARTEN', 1),
(116, 'SOPERITO', 1),
(117, 'BOLO', 1),
(118, 'SALCERITA', 1),
(119, 'CUCHARA', 1),
(120, 'TENEDOR', 1),
(121, 'CUCHILLO', 1),
(122, 'CUBIERTOS', 1),
(123, 'RALLADOR', 1),
(124, 'ESPUMADERA', 1),
(125, 'ESPATULA', 1),
(126, 'REPISA', 1),
(127, 'GABINETE', 1),
(128, 'MACETERO', 1),
(129, 'MASTER', 1),
(130, 'MATAMOSCA', 1),
(131, 'PELLOTA', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_ccompras`
--

CREATE TABLE `tb_ccompras` (
  `idpago` int(11) NOT NULL,
  `idcompra` int(11) NOT NULL,
  `pago` decimal(12,7) NOT NULL,
  `pendiente` decimal(12,7) NOT NULL,
  `fecha` datetime NOT NULL,
  `idv` int(11) NOT NULL,
  `est` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_ccompras`
--

INSERT INTO `tb_ccompras` (`idpago`, `idcompra`, `pago`, `pendiente`, `fecha`, `idv`, `est`) VALUES
(1, 1, '0.0000000', '176.6400000', '2019-01-03 15:43:55', 1, 1),
(2, 2, '225.0000000', '0.0000000', '2019-02-02 12:22:26', 1, -1),
(3, 3, '18.0000000', '0.0000000', '2019-02-02 12:23:42', 1, -1),
(4, 4, '300.0000000', '0.0000000', '2019-02-02 12:36:19', 1, -1),
(5, 5, '20.0000000', '10.0000000', '2019-02-02 12:39:19', 1, 1),
(6, 6, '15.0000000', '35.7500000', '2019-02-07 10:09:21', 1, 0),
(7, 6, '15.0000000', '20.7500000', '2019-02-07 10:12:01', 1, 1),
(8, 6, '15.0000000', '20.7500000', '2019-02-07 10:12:03', 1, 1),
(9, 7, '80.0000000', '0.0000000', '2019-02-07 10:14:19', 1, -1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_cliente`
--

CREATE TABLE `tb_cliente` (
  `idc` int(11) NOT NULL,
  `nom` varchar(120) NOT NULL,
  `ruc` char(12) NOT NULL,
  `tipo` enum('NATURAL','JURIDICA') DEFAULT NULL,
  `dir` varchar(120) DEFAULT 'S/N',
  `cell` char(9) DEFAULT '000000000',
  `est` tinyint(1) NOT NULL,
  `distrito` char(30) DEFAULT 'CHICLAYO',
  `provincia` char(30) DEFAULT 'CHICLAYO',
  `departamento` char(30) DEFAULT 'LAMBAYEQUE'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_cliente`
--

INSERT INTO `tb_cliente` (`idc`, `nom`, `ruc`, `tipo`, `dir`, `cell`, `est`, `distrito`, `provincia`, `departamento`) VALUES
(1, 'CLIENTES VARIOS', '00000000', 'NATURAL', 'S/N', '000000000', 1, '', '', ''),
(2, 'MARIO', '55694523', 'NATURAL', 'CHICLAYO', '56456165', 1, '', '', ''),
(3, 'ADRIAN', '54616855', 'NATURAL', 'CHICLAYO', '996865828', 1, '', '', ''),
(4, 'PLASTISEC. E,I,R,L', '20424586523', 'JURIDICA', 'AV LOS MANFOG N° 15598 VHIVSLRKGH', '219846326', 1, '', '', ''),
(5, 'EMILI', '42156325', 'NATURAL', 'AV. LOS ROSALES #452', '952147823', 1, '', '', ''),
(7, 'XDXDXD', '12345678', 'JURIDICA', 'S/N', '000000000', 1, '', '', ''),
(8, 'VICTORIA', '96325874122', 'JURIDICA', 'S/N', '000000000', 1, '', '', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_compra`
--

CREATE TABLE `tb_compra` (
  `idcompra` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  `num_doc` char(12) NOT NULL,
  `idtip` int(11) NOT NULL,
  `idr` int(11) NOT NULL,
  `idv` int(11) NOT NULL,
  `total` decimal(12,7) NOT NULL,
  `est` tinyint(1) NOT NULL,
  `idtipomoneda` int(11) DEFAULT NULL,
  `total_soles` decimal(12,7) NOT NULL DEFAULT '0.0000000'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_compra`
--

INSERT INTO `tb_compra` (`idcompra`, `fecha`, `num_doc`, `idtip`, `idr`, `idv`, `total`, `est`, `idtipomoneda`, `total_soles`) VALUES
(1, '2019-01-03 15:43:55', '003-2266', 2, 2, 1, '176.6400000', 1, 1, '176.6400000'),
(2, '2019-02-02 12:22:26', '1020', 1, 1, 1, '225.0000000', 1, 2, '733.5000000'),
(3, '2019-02-02 12:23:42', '5552', 1, 1, 1, '18.0000000', 1, 1, '18.0000000'),
(4, '2019-02-02 12:36:19', '525', 1, 1, 1, '300.0000000', 1, 1, '300.0000000'),
(5, '2019-02-02 12:39:19', '456', 1, 1, 1, '30.0000000', 1, 1, '30.0000000'),
(6, '2019-02-07 10:09:21', '001-0025', 2, 6, 1, '26.0000000', 1, 2, '84.5000000'),
(7, '2019-02-07 10:14:19', '02184', 1, 1, 1, '80.0000000', 1, 1, '80.0000000');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_compracuotas`
--

CREATE TABLE `tb_compracuotas` (
  `id` int(11) NOT NULL,
  `idpago` int(11) NOT NULL COMMENT 'rename idcompra',
  `n_cuotas` int(11) NOT NULL,
  `total` decimal(12,7) NOT NULL,
  `fecha` date DEFAULT NULL,
  `idv` int(11) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tb_compracuotas`
--

INSERT INTO `tb_compracuotas` (`id`, `idpago`, `n_cuotas`, `total`, `fecha`, `idv`, `estado`, `created_at`, `updated_at`) VALUES
(2, 6, 2, '35.7500000', NULL, 1, 0, '2019-02-07 10:11:35', '2019-02-07 10:11:35');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_cventa`
--

CREATE TABLE `tb_cventa` (
  `idcc` int(11) NOT NULL,
  `idventa` int(11) NOT NULL,
  `cobro` decimal(12,2) NOT NULL,
  `pendiente` decimal(12,2) NOT NULL,
  `utilidad` decimal(12,2) NOT NULL,
  `fecha` datetime NOT NULL,
  `idv` int(11) NOT NULL,
  `est` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_cventa`
--

INSERT INTO `tb_cventa` (`idcc`, `idventa`, `cobro`, `pendiente`, `utilidad`, `fecha`, `idv`, `est`) VALUES
(1, 1, '0.00', '180.00', '157.00', '2019-01-03 11:27:46', 1, 0),
(2, 1, '90.00', '90.00', '0.00', '2019-01-03 11:28:13', 1, 0),
(3, 1, '90.00', '0.00', '0.00', '2019-01-03 11:28:41', 1, 1),
(4, 2, '270.00', '0.00', '235.50', '2019-01-03 12:33:27', 1, 1),
(5, 3, '254.88', '0.00', '35.20', '2019-01-04 10:25:14', 1, 1),
(6, 4, '6.00', '0.00', '3.90', '2019-01-04 17:27:20', 1, 1),
(7, 5, '6.00', '0.00', '3.90', '2019-01-04 17:29:27', 1, 1),
(8, 6, '6.00', '0.00', '3.90', '2019-01-04 17:30:38', 1, 1),
(9, 7, '6.00', '0.00', '3.90', '2019-01-04 17:43:33', 1, 1),
(10, 8, '6.00', '0.00', '3.90', '2019-01-04 17:44:55', 1, 1),
(11, 9, '6.00', '0.00', '1.60', '2019-01-04 17:45:43', 1, 1),
(12, 10, '3.00', '0.00', '0.80', '2019-01-04 17:46:18', 1, 1),
(13, 11, '9.00', '0.00', '4.70', '2019-01-04 17:46:53', 1, 1),
(14, 12, '6.50', '0.00', '-3.70', '2019-01-04 17:47:44', 1, 1),
(15, 13, '6.50', '0.00', '-3.70', '2019-01-04 17:48:12', 1, 1),
(16, 14, '6.50', '0.00', '-3.70', '2019-01-04 17:48:50', 1, 1),
(17, 15, '3.00', '0.00', '0.80', '2019-01-04 17:50:04', 1, 1),
(18, 16, '6.50', '0.00', '-3.70', '2019-01-04 17:50:50', 1, 1),
(19, 17, '3.00', '0.00', '0.80', '2019-01-04 17:51:36', 1, 1),
(20, 18, '9.50', '0.00', '-2.90', '2019-01-04 17:52:25', 1, 1),
(21, 19, '15.50', '0.00', '1.00', '2019-01-04 18:04:47', 1, 1),
(22, 20, '9.00', '0.00', '4.70', '2019-01-04 18:10:19', 1, 1),
(23, 21, '6.50', '0.00', '-3.70', '2019-01-04 18:11:50', 1, 1),
(24, 22, '360.00', '0.00', '288.00', '2019-01-05 12:23:04', 1, 1),
(25, 23, '18.00', '0.00', '14.40', '2019-01-05 12:25:20', 1, 1),
(26, 24, '18.00', '0.00', '14.40', '2019-01-05 12:33:40', 1, 1),
(27, 25, '18.00', '0.00', '14.40', '2019-01-05 12:57:50', 1, 1),
(28, 26, '39.60', '0.00', '4.70', '2019-01-07 11:07:18', 1, 1),
(30, 28, '2.20', '0.00', '0.00', '2019-01-07 11:53:51', 1, 1),
(31, 29, '164.32', '0.00', '127.75', '2019-01-07 15:21:14', 1, 1),
(32, 30, '3.00', '0.00', '0.80', '2019-01-07 15:28:23', 1, 1),
(33, 31, '3.00', '0.00', '0.80', '2019-01-07 15:31:40', 1, 1),
(34, 32, '3.00', '0.00', '0.80', '2019-01-07 15:35:32', 1, 1),
(35, 33, '159.75', '0.00', '125.35', '2019-01-07 15:39:03', 1, 1),
(36, 34, '2283.37', '0.00', '375.77', '2019-01-07 15:55:24', 1, 1),
(37, 35, '1850.69', '0.00', '428.55', '2019-01-07 18:14:34', 1, 1),
(38, 36, '0.00', '590.00', '250.00', '2019-01-07 19:27:02', 1, 0),
(39, 36, '20.00', '570.00', '0.00', '2019-01-07 19:27:40', 1, 0),
(40, 36, '500.00', '70.00', '0.00', '2019-01-07 19:27:57', 1, 0),
(41, 36, '70.00', '0.00', '0.00', '2019-01-07 19:28:25', 1, 1),
(42, 37, '252.29', '0.00', '65.80', '2019-01-08 09:21:49', 1, 1),
(43, 38, '146.00', '0.00', '133.36', '2019-01-08 09:39:59', 1, 1),
(44, 39, '89.00', '0.00', '79.08', '2019-01-08 09:48:32', 1, 1),
(45, 40, '301.79', '0.00', '81.90', '2019-01-08 09:56:48', 1, 1),
(46, 41, '188.00', '0.00', '86.80', '2019-01-08 11:07:40', 1, 1),
(47, 42, '188.00', '0.00', '86.80', '2019-01-08 11:09:04', 1, 1),
(48, 48, '188.40', '0.00', '-24.10', '2019-01-09 11:30:09', 1, 1),
(49, 49, '26.34', '0.00', '24.20', '2019-01-09 11:44:35', 1, 1),
(50, 50, '573.90', '0.00', '45.03', '2019-01-09 15:29:31', 1, 1),
(51, 51, '26.00', '0.00', '20.00', '2019-01-09 15:40:14', 1, 1),
(52, 52, '97.00', '0.00', '60.00', '2019-01-09 15:52:40', 1, 1),
(53, 53, '141.00', '0.00', '65.10', '2019-01-09 15:54:18', 1, 1),
(54, 54, '467.26', '0.00', '43.40', '2019-01-09 17:22:59', 1, 1),
(55, 55, '3.00', '0.00', '0.80', '2019-01-09 17:25:30', 1, 1),
(56, 56, '3.54', '0.00', '0.80', '2019-01-09 17:26:03', 1, 1),
(57, 57, '3.00', '0.00', '0.80', '2019-01-09 17:26:33', 1, 1),
(58, 58, '526.90', '0.00', '23.33', '2019-01-09 17:32:47', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_descuento_adelanto`
--

CREATE TABLE `tb_descuento_adelanto` (
  `id` int(11) NOT NULL,
  `idpersonal` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `monto` decimal(12,2) NOT NULL,
  `tipo` tinyint(1) NOT NULL COMMENT '1 Descuento/2 Adelanto',
  `motivo` text CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `idtip` int(11) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tb_descuento_adelanto`
--

INSERT INTO `tb_descuento_adelanto` (`id`, `idpersonal`, `fecha`, `monto`, `tipo`, `motivo`, `idtip`, `estado`, `created_at`, `updated_at`) VALUES
(3, 1, '2019-01-03', '1.00', 2, '', 1, 1, '2019-01-03 11:18:52', '2019-01-03 11:38:57');

--
-- Disparadores `tb_descuento_adelanto`
--
DELIMITER $$
CREATE TRIGGER `adelanto_personal_caja` AFTER INSERT ON `tb_descuento_adelanto` FOR EACH ROW BEGIN
 	DECLARE _idcaja integer;
    #Traemos el idcaja
    IF NEW.tipo=2 THEN
    	SELECT get_idcaja_actual() INTO _idcaja;
        INSERT INTO detalle_caja (idcaja,tipo_entrada,tipo_documento,nom_doc,num_doc,monto,observacion,desc_entrada,idadel_personal)
        VALUES (_idcaja, 2, 8, 'OTROS', '000', NEW.monto, NEW.motivo,3,NEW.id);
    END IF;
  END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `upda_adelanto_personal_caja` AFTER UPDATE ON `tb_descuento_adelanto` FOR EACH ROW BEGIN
 	IF NEW.estado=0 OR NEW.estado=1 THEN
    	IF NEW.tipo=2 THEN
        	UPDATE detalle_caja SET desc_entrada=3,monto = NEW.monto,observacion=NEW.motivo,estado=NEW.estado  
            WHERE idadel_personal = OLD.id;
        ELSEIF NEW.tipo=1 THEN
        	UPDATE detalle_caja SET estado=0  
            WHERE idadel_personal = OLD.id;
        END IF;
    END IF;
  END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_detalle_cuota`
--

CREATE TABLE `tb_detalle_cuota` (
  `id` int(11) NOT NULL,
  `idccuota` int(11) NOT NULL,
  `fecha_pago` date NOT NULL,
  `monto` decimal(12,7) NOT NULL,
  `montopagado` decimal(12,7) DEFAULT '0.0000000',
  `montointeres` decimal(12,7) DEFAULT '0.0000000',
  `codigounico` varchar(20) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `estado` tinyint(4) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tb_detalle_cuota`
--

INSERT INTO `tb_detalle_cuota` (`id`, `idccuota`, `fecha_pago`, `monto`, `montopagado`, `montointeres`, `codigounico`, `estado`) VALUES
(3, 2, '2019-02-07', '15.0000000', '20.0000000', '5.0000000', '1', 1),
(4, 2, '2019-02-08', '20.7500000', '0.0000000', '0.0000000', '125489', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_marca`
--

CREATE TABLE `tb_marca` (
  `idm` int(11) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `est` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_marca`
--

INSERT INTO `tb_marca` (`idm`, `nom`, `est`) VALUES
(1, 'REYPLAST', 1),
(2, 'BASA', 1),
(3, 'DURAPLAST', 1),
(4, 'REY', 1),
(5, 'SAONSA', 1),
(6, 'PARIS PLAST', 1),
(7, 'MPLAST', 1),
(8, 'Q PLAST', 1),
(9, 'POLIN PLAST', 1),
(10, 'M & R', 1),
(11, 'ROYAL PLAST', 1),
(12, 'FORTIPLAST', 1),
(13, 'SUMAC', 1),
(14, 'M & M', 1),
(15, 'NAYELY', 1),
(16, 'LIONS', 1),
(17, 'RATAN', 1),
(18, 'GENESIS', 1),
(19, 'JUMBO', 1),
(20, 'SAPO', 1),
(21, 'MOISES', 1),
(22, 'TORTUGA', 1),
(23, 'ABEJA', 1),
(24, 'MAMUT', 1),
(25, 'GATO', 1),
(26, 'PLANO', 1),
(27, 'ADULTO', 1),
(28, 'BARCA', 1),
(29, 'BOTE', 1),
(30, 'PLASTIMEL', 1),
(31, 'CHELITA', 1),
(32, 'TWIST', 1),
(33, 'KUSY', 1),
(34, 'ANITA', 1),
(35, 'JUNIOR', 1),
(36, 'PRINCESA', 1),
(37, 'COMERCIAL', 1),
(38, 'ACANALADO', 1),
(39, 'BOTECITO', 1),
(40, 'MEDIDORA', 1),
(41, 'TERESITA', 1),
(42, 'MIRHEL', 1),
(43, 'VICTORIA', 1),
(44, 'CHINO', 1),
(45, 'SANSON', 1),
(46, 'FORCE', 1),
(47, 'COLADA', 1),
(48, 'KING', 1),
(49, 'JAI PLAST', 1),
(50, 'MINI', 1),
(51, 'POWER', 1),
(52, 'SUPER', 1),
(53, 'ANATÓMICO', 1),
(54, 'REAL', 1),
(55, 'TUINA', 1),
(56, 'URPI', 1),
(57, 'HUDE', 1),
(58, 'CONTENTA', 1),
(59, 'DODECAGONO', 1),
(60, 'DIEKAT', 1),
(61, 'TOP LIZ', 1),
(62, 'KORY', 1),
(63, 'MUNDO PLAST', 1),
(64, 'COCO', 1),
(65, 'QUESEL', 1),
(66, 'JABONERA', 1),
(67, 'ROBUSTA', 1),
(68, 'BATIADERA', 1),
(69, 'MADRID', 1),
(70, 'FRUTADA', 1),
(71, 'LIZ', 1),
(72, 'QELLA', 1),
(73, 'PLASTICO', 1),
(74, 'BEBE', 1),
(75, 'LESLY', 1),
(76, 'BALLERINA', 1),
(77, 'HERBAL', 1),
(78, 'LAVANDA', 1),
(79, 'ORION', 1),
(80, 'YOMAR', 1),
(81, 'JIREH', 1),
(82, 'CHIQUILIN', 1),
(83, 'CLORO', 1),
(84, 'DIDE PLAST', 1),
(85, 'YULLYPLAST', 1),
(86, 'MARINEX', 1),
(87, 'SELETTA', 1),
(88, 'NADIR', 1),
(89, 'CRISTAR', 1),
(90, 'PELDAR', 1),
(91, 'ROSE', 1),
(92, 'SLAYER', 1),
(93, 'TULIPAN', 1),
(94, 'CRYSAN', 1),
(95, 'ASYA', 1),
(96, 'NEVADA', 1),
(97, 'ENVISAC', 1),
(98, 'SAVIC', 1),
(99, 'UNION', 1),
(100, 'ICHIMATSU', 1),
(101, 'PASABACHE', 1),
(102, 'SUNFLOWER', 1),
(103, 'T.PERU', 1),
(104, 'FACUSA', 1),
(105, 'VINOD', 1),
(106, 'RIMAX', 1),
(107, 'CHECHIPLAST', 1),
(108, 'JEC PLAST S.A.C', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_oferta`
--

CREATE TABLE `tb_oferta` (
  `id` int(11) NOT NULL,
  `catalogo_id` int(11) NOT NULL,
  `puntaje_id` int(11) NOT NULL,
  `total` int(11) DEFAULT NULL,
  `gastar` int(11) DEFAULT NULL,
  `est` tinyint(4) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_oferta`
--

INSERT INTO `tb_oferta` (`id`, `catalogo_id`, `puntaje_id`, `total`, `gastar`, `est`, `created_at`, `updated_at`) VALUES
(1, 48, 1, 55, 45, 1, '2018-11-23 09:57:24', '2018-11-23 09:57:24'),
(2, 659, 6, 89, 80, 1, '2019-01-07 16:52:48', '2019-01-07 16:52:48'),
(3, 659, 3, 520, 500, 1, '2019-01-07 16:53:23', '2019-01-07 16:53:23');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_permiso_personal`
--

CREATE TABLE `tb_permiso_personal` (
  `id` int(11) NOT NULL,
  `idpersonal` int(11) NOT NULL,
  `fecha_inicio` datetime NOT NULL,
  `fecha_fin` datetime DEFAULT NULL,
  `n_dias` int(11) DEFAULT NULL,
  `observacion` text CHARACTER SET utf8 COLLATE utf8_spanish_ci,
  `idtip` int(11) DEFAULT NULL,
  `estado` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_personal`
--

CREATE TABLE `tb_personal` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `dni` varchar(10) NOT NULL,
  `direccion` varchar(150) DEFAULT NULL,
  `cel` varchar(10) DEFAULT NULL,
  `sueldo` decimal(12,2) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tb_personal`
--

INSERT INTO `tb_personal` (`id`, `nombre`, `dni`, `direccion`, `cel`, `sueldo`, `estado`, `created_at`, `updated_at`) VALUES
(1, 'Maria caceres Necesup', '85214796', 'Juan Juglivan', '963258741', '930.00', 1, '2018-12-19 15:33:55', '2018-12-19 15:33:55');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_precio`
--

CREATE TABLE `tb_precio` (
  `idpre` int(11) NOT NULL,
  `idct` int(11) NOT NULL,
  `compra` decimal(12,7) NOT NULL,
  `especial` decimal(12,2) NOT NULL,
  `normal` decimal(12,2) NOT NULL COMMENT 'rename Mayorista/Particular',
  `mayorista` decimal(12,2) NOT NULL,
  `minorista` decimal(12,2) NOT NULL,
  `oferta` decimal(12,2) NOT NULL,
  `remate` decimal(12,2) NOT NULL,
  `est` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_precio`
--

INSERT INTO `tb_precio` (`idpre`, `idct`, `compra`, `especial`, `normal`, `mayorista`, `minorista`, `oferta`, `remate`, `est`) VALUES
(1, 1, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 0),
(2, 2, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(3, 3, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 0),
(4, 4, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(5, 5, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(6, 6, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(7, 7, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(8, 8, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(9, 9, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(10, 10, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(11, 11, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(12, 12, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(13, 13, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(14, 14, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(15, 15, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(16, 16, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 0),
(17, 17, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(18, 18, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(19, 19, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(20, 20, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(21, 21, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(22, 22, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(23, 23, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(24, 24, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(25, 25, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(26, 26, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(27, 27, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(28, 28, '50.0000000', '100.00', '100.00', '100.00', '100.20', '100.00', '100.00', 1),
(29, 29, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(30, 33, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(31, 35, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(32, 38, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(33, 39, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(34, 40, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(35, 41, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(36, 42, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(37, 43, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(38, 44, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(39, 45, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(40, 46, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(41, 47, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(42, 48, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 0),
(43, 49, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 0),
(44, 50, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(45, 51, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(46, 52, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(47, 53, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(48, 54, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(49, 55, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(50, 56, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(51, 57, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(52, 58, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(53, 59, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(54, 60, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(55, 61, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(56, 62, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(57, 63, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(58, 64, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(59, 65, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(60, 66, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(61, 67, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(62, 68, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(63, 69, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(64, 70, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(65, 71, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(66, 72, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(67, 73, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(68, 74, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(69, 75, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(70, 76, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 0),
(71, 77, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(72, 78, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(73, 79, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(74, 80, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(75, 81, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(76, 82, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(77, 83, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(78, 84, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 0),
(79, 85, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(80, 86, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(81, 87, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(82, 88, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(83, 89, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(84, 90, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(85, 91, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(86, 92, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(87, 93, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 0),
(88, 95, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(89, 96, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(90, 97, '25.3000000', '45.00', '47.00', '45.63', '50.00', '40.00', '35.00', 1),
(91, 98, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(92, 99, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(93, 100, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(94, 101, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 0),
(95, 102, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(96, 103, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(97, 104, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(98, 105, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(99, 106, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(100, 107, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(101, 108, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(102, 109, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(103, 110, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(104, 111, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 0),
(105, 112, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(106, 113, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(107, 114, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(108, 115, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(109, 116, '150.9900000', '141.00', '144.30', '140.00', '145.30', '140.00', '130.00', 1),
(110, 117, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(111, 118, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(112, 119, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(113, 120, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(114, 121, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(115, 122, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(116, 123, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(117, 124, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(118, 125, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(119, 126, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(120, 127, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(121, 128, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(122, 129, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(123, 130, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(124, 131, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(125, 132, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(126, 133, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(127, 134, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(128, 135, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(129, 136, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(130, 137, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(131, 138, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(132, 139, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(133, 140, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(134, 141, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(135, 142, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(136, 144, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(137, 145, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(138, 146, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(139, 147, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(140, 148, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(141, 149, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(142, 151, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(143, 153, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(144, 154, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(145, 155, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(146, 156, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(147, 157, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(148, 158, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(149, 159, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(150, 160, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(151, 162, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(152, 163, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(153, 164, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(154, 165, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(155, 166, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(156, 167, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(157, 168, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(158, 169, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(159, 170, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(160, 171, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(161, 173, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(162, 174, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(163, 175, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(164, 176, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(165, 177, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(166, 178, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(167, 179, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(168, 180, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(169, 181, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(170, 182, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(171, 184, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(172, 185, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(173, 186, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(174, 187, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(175, 188, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(176, 189, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(177, 190, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(178, 191, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(179, 192, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(180, 193, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(181, 194, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(182, 195, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(183, 196, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(184, 197, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(185, 198, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(186, 199, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(187, 201, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(188, 202, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(189, 203, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(190, 204, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(191, 205, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(192, 206, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(193, 207, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(194, 208, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(195, 209, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(196, 210, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(197, 211, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(198, 212, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(199, 213, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(200, 214, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(201, 215, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(202, 216, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(203, 217, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(204, 218, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(205, 219, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(206, 221, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(207, 223, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(208, 224, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(209, 225, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(210, 226, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(211, 227, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(212, 228, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(213, 229, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(214, 230, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(215, 231, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(216, 232, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(217, 233, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(218, 234, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(219, 235, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(220, 236, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(221, 237, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(222, 238, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(223, 239, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(224, 240, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(225, 241, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(226, 242, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(227, 243, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(228, 244, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(229, 245, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(230, 246, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(231, 247, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(232, 248, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(233, 249, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(234, 250, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(235, 251, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(236, 252, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(237, 253, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(238, 254, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(239, 255, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(240, 256, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(241, 257, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(242, 258, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(243, 259, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(244, 260, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(245, 261, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(246, 262, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(247, 263, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(248, 264, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(249, 265, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(250, 266, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(251, 268, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(252, 269, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(253, 270, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(254, 271, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(255, 272, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(256, 273, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(257, 274, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(258, 275, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(259, 276, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(260, 277, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(261, 278, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(262, 279, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(263, 281, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(264, 282, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(265, 283, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(266, 284, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(267, 285, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(268, 286, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(269, 287, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(270, 288, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(271, 289, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(272, 290, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(273, 291, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(274, 292, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(275, 293, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(276, 294, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(277, 295, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(278, 296, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(279, 297, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 0),
(280, 298, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(281, 299, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(282, 300, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(283, 301, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(284, 302, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(285, 303, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(286, 304, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(287, 305, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(288, 306, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(289, 307, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(290, 308, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(291, 310, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(292, 311, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(293, 312, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(294, 313, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(295, 314, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(296, 315, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(297, 316, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(298, 317, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(299, 318, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(300, 319, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(301, 320, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(302, 321, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(303, 322, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(304, 323, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(305, 324, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(306, 325, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(307, 326, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(308, 327, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(309, 328, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(310, 329, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(311, 330, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(312, 331, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(313, 334, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(314, 335, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(315, 336, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(316, 337, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(317, 338, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(318, 339, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(319, 340, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(320, 342, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(321, 343, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(322, 344, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(323, 345, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(324, 346, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(325, 347, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(326, 348, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(327, 349, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 0),
(328, 350, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(329, 352, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(330, 353, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(331, 354, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(332, 355, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(333, 356, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(334, 357, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(335, 358, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(336, 359, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(337, 360, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(338, 362, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(339, 363, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(340, 364, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(341, 365, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(342, 366, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(343, 367, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(344, 368, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(345, 369, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(346, 370, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(347, 371, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(348, 372, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(349, 373, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(350, 374, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(351, 375, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(352, 376, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(353, 377, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(354, 378, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(355, 379, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(356, 380, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(357, 381, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(358, 382, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(359, 383, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(360, 384, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(361, 385, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(362, 386, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(363, 387, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(364, 388, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(365, 389, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(366, 390, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(367, 391, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(368, 392, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(369, 393, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(370, 394, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(371, 395, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(372, 396, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(373, 397, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(374, 398, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(375, 399, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(376, 400, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(377, 401, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(378, 402, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(379, 403, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(380, 404, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(381, 406, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(382, 407, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(383, 408, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(384, 409, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(385, 410, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(386, 411, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(387, 412, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(388, 413, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(389, 414, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(390, 415, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(391, 416, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(392, 417, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(393, 418, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(394, 419, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(395, 420, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(396, 421, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(397, 422, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(398, 423, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(399, 424, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(400, 425, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(401, 426, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(402, 427, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(403, 428, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(404, 429, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(405, 430, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(406, 431, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(407, 432, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(408, 433, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(409, 434, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(410, 435, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(411, 436, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(412, 437, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(413, 438, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 0),
(414, 439, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(415, 440, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(416, 441, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(417, 443, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(418, 444, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(419, 445, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(420, 446, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(421, 447, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(422, 448, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(423, 450, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(424, 451, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(425, 452, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(426, 453, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(427, 454, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(428, 455, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(429, 456, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(430, 457, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(431, 458, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(432, 459, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(433, 460, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(434, 461, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(435, 462, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(436, 463, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(437, 464, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(438, 465, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(439, 466, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(440, 467, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(441, 468, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(442, 469, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(443, 470, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(444, 471, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(445, 472, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(446, 473, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(447, 474, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(448, 475, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(449, 476, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(450, 477, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(451, 478, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(452, 479, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(453, 480, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(454, 481, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(455, 482, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(456, 483, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(457, 484, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(458, 485, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(459, 486, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(460, 487, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(461, 488, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(462, 489, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(463, 490, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(464, 491, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(465, 492, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(466, 493, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(467, 494, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(468, 495, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(469, 496, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(470, 497, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(471, 498, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(472, 499, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(473, 500, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(474, 501, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(475, 502, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(476, 503, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(477, 505, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(478, 506, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(479, 507, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 0),
(480, 508, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(481, 509, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(482, 510, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(483, 511, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(484, 512, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(485, 513, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(486, 514, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(487, 515, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(488, 516, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(489, 517, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(490, 518, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(491, 519, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(492, 520, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(493, 521, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(494, 522, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(495, 523, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(496, 524, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(497, 525, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(498, 526, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(499, 527, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(500, 528, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(501, 529, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(502, 530, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(503, 531, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(504, 532, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(505, 533, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(506, 534, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(507, 535, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(508, 536, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(509, 537, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(510, 538, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(511, 539, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(512, 540, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(513, 541, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(514, 542, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(515, 543, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(516, 544, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(517, 545, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(518, 546, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(519, 547, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(520, 548, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(521, 549, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(522, 550, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(523, 551, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(524, 552, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(525, 553, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(526, 554, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(527, 555, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(528, 556, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(529, 557, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(530, 558, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(531, 559, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(532, 560, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(533, 561, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(534, 562, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(535, 563, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(536, 564, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(537, 565, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(538, 566, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(539, 567, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(540, 568, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(541, 569, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(542, 570, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(543, 571, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(544, 572, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(545, 573, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(546, 574, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(547, 575, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(548, 576, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(549, 577, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(550, 578, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(551, 580, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(552, 581, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(553, 582, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(554, 583, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(555, 584, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(556, 585, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(557, 586, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(558, 587, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(559, 588, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(560, 589, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(561, 590, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(562, 591, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(563, 592, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(564, 594, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(565, 595, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(566, 596, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(567, 597, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(568, 598, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(569, 599, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(570, 600, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(571, 601, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 0),
(572, 602, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(573, 603, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(574, 604, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(575, 605, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(576, 606, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(577, 607, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(578, 608, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(579, 609, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(580, 610, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(581, 611, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(582, 612, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(583, 613, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(584, 614, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(585, 615, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(586, 616, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(587, 617, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(588, 618, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(589, 48, '1.5000000', '2.20', '2.50', '2.10', '2.30', '2.90', '2.00', 1),
(590, 507, '2.2000000', '2.80', '3.00', '2.00', '2.20', '2.00', '2.00', 0),
(591, 111, '6.1000000', '11.00', '15.00', '10.00', '13.00', '10.00', '9.00', 1),
(592, 76, '28.4300000', '33.00', '35.00', '30.00', '34.00', '29.50', '30.00', 1),
(593, 1, '2.1000000', '5.00', '6.00', '4.80', '5.50', '4.00', '3.50', 1),
(594, 93, '34.8100000', '44.00', '45.00', '40.00', '43.50', '39.00', '37.00', 1),
(595, 619, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(596, 620, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(597, 621, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(598, 622, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(599, 623, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(600, 624, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(601, 625, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(602, 626, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(603, 627, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(604, 628, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(605, 629, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(606, 630, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(607, 631, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(608, 632, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(609, 633, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(610, 634, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(611, 636, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(612, 637, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(613, 638, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(614, 639, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(615, 640, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(616, 641, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(617, 642, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(618, 643, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(619, 644, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(620, 645, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(621, 646, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(622, 647, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(623, 648, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 0),
(624, 650, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(625, 651, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(626, 652, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(627, 653, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(628, 654, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(629, 655, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(630, 656, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(631, 657, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(632, 658, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(633, 648, '10.5000000', '23.00', '25.00', '20.00', '22.00', '18.50', '16.00', 1),
(634, 349, '7.8000000', '17.00', '18.00', '15.00', '17.50', '12.00', '10.00', 1),
(635, 84, '1.1000000', '0.00', '10.00', '0.00', '0.00', '0.00', '0.00', 0),
(636, 49, '1.2000000', '7.00', '8.00', '0.00', '0.00', '0.00', '0.00', 0),
(637, 438, '2.5000000', '8.50', '10.00', '0.00', '0.00', '0.00', '0.00', 1),
(638, 84, '1.0000000', '0.00', '10.00', '0.00', '0.00', '0.00', '0.00', 0),
(639, 84, '10.0000000', '0.00', '10.00', '0.00', '0.00', '0.00', '0.00', 1),
(640, 659, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 0),
(641, 660, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(642, 661, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(643, 662, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(644, 663, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(645, 664, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(646, 665, '2.3000000', '20.00', '18.00', '15.00', '10.00', '10.00', '20.00', 0),
(647, 666, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(648, 667, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(649, 668, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(650, 669, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(651, 670, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(652, 671, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(653, 672, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(654, 673, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(655, 674, '2.3000000', '25.99', '27.85', '28.76', '29.99', '23.00', '20.00', 1),
(656, 675, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(657, 676, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(658, 677, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(659, 678, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(660, 679, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(661, 680, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(662, 681, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(663, 682, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(664, 683, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(665, 684, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(666, 685, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(667, 686, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(668, 687, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(669, 688, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(670, 689, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(671, 690, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(672, 691, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(673, 692, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(674, 693, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(675, 694, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1);
INSERT INTO `tb_precio` (`idpre`, `idct`, `compra`, `especial`, `normal`, `mayorista`, `minorista`, `oferta`, `remate`, `est`) VALUES
(676, 695, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(677, 696, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(678, 697, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(679, 698, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(680, 699, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(681, 700, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(682, 701, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(683, 702, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(684, 703, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(685, 704, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(686, 705, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(687, 706, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(688, 707, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(689, 708, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(690, 709, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(691, 710, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(692, 711, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(693, 712, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(694, 713, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(695, 714, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(696, 715, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(697, 716, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(698, 717, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(699, 718, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(700, 719, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(701, 720, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(702, 721, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(703, 722, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(704, 723, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(705, 724, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(706, 725, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(707, 726, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(708, 727, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(709, 728, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(710, 729, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(711, 730, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(712, 731, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(713, 732, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(714, 733, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(715, 734, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(716, 735, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(717, 736, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(718, 737, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(719, 738, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(720, 739, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(721, 740, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(722, 741, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(723, 742, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(724, 743, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(725, 744, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(726, 745, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(727, 746, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(728, 747, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(729, 748, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(730, 749, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(731, 750, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(732, 751, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(733, 752, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(734, 753, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(735, 754, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(736, 755, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(737, 756, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(738, 757, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(739, 758, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(740, 759, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(741, 760, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(742, 761, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(743, 762, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(744, 763, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(745, 764, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(746, 765, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(747, 766, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(748, 767, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(749, 768, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(750, 769, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(751, 770, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(752, 771, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(753, 772, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(754, 773, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(755, 774, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(756, 775, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(757, 776, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(758, 777, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(759, 778, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(760, 779, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(761, 780, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(762, 781, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(763, 782, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(764, 783, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(765, 784, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(766, 785, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(767, 786, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(768, 787, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(769, 788, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(770, 789, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(771, 790, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(772, 791, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(773, 792, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(774, 793, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(775, 794, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(776, 795, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(777, 796, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(778, 797, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(779, 798, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(780, 799, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(781, 800, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(782, 801, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(783, 802, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(784, 803, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(785, 804, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(786, 805, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(787, 806, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(788, 807, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(789, 808, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(790, 809, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(791, 810, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(792, 811, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(793, 812, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(794, 813, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(795, 814, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(796, 815, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(797, 816, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(798, 817, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(799, 818, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(800, 819, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(801, 820, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(802, 821, '10.2000000', '6.00', '6.50', '7.00', '8.00', '5.50', '5.00', 1),
(803, 822, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(804, 823, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(805, 824, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(806, 825, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(807, 826, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(808, 827, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(809, 828, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(810, 829, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(811, 830, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(812, 831, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(813, 832, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(814, 833, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(815, 834, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(816, 835, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(817, 836, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(818, 837, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(819, 838, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(820, 839, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(821, 840, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(822, 841, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(823, 842, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(824, 843, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(825, 844, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(826, 845, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(827, 846, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(828, 847, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(829, 848, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(830, 849, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(831, 850, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(832, 851, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(833, 852, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(834, 853, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(835, 854, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(836, 855, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(837, 856, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(838, 857, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(839, 858, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(840, 859, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(841, 860, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(842, 861, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(843, 862, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(844, 863, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(845, 864, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(846, 865, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(847, 866, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(848, 867, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(849, 868, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(850, 869, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(851, 870, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(852, 871, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(853, 872, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(854, 873, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(855, 874, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(856, 875, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(857, 876, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(858, 877, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(859, 878, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(860, 879, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(861, 880, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(862, 881, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(863, 882, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(864, 883, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(865, 884, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(866, 885, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(867, 886, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(868, 887, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(869, 888, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(870, 889, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(871, 890, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(872, 891, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(873, 892, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(874, 893, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(875, 894, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(876, 895, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(877, 896, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(878, 897, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(879, 898, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(880, 899, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(881, 900, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(882, 901, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(883, 902, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(884, 903, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(885, 904, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(886, 905, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(887, 906, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(888, 907, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(889, 908, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(890, 909, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(891, 910, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(892, 911, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(893, 912, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(894, 913, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(895, 914, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(896, 915, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(897, 916, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(898, 917, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(899, 918, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(900, 920, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(901, 921, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(902, 922, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(903, 923, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(904, 924, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(905, 925, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(906, 926, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(907, 927, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(908, 928, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(909, 929, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(910, 930, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(911, 3, '2.2000000', '0.00', '5.00', '0.00', '8.00', '0.00', '0.00', 1),
(912, 49, '4.0000000', '7.00', '8.00', '0.00', '0.00', '0.00', '0.00', 1),
(913, 665, '3.6000000', '20.00', '18.00', '15.00', '10.00', '10.00', '20.00', 1),
(914, 659, '6.3200000', '60.00', '71.00', '70.00', '73.00', '55.00', '50.00', 1),
(915, 931, '0.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(916, 507, '10.0000000', '2.80', '3.00', '2.00', '2.20', '2.00', '2.00', 0),
(917, 601, '10.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 0),
(918, 601, '146.7000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 0),
(919, 601, '45.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 0),
(920, 507, '6.0000000', '2.80', '3.00', '2.00', '2.20', '2.00', '2.00', 0),
(921, 601, '50.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(922, 297, '10.0000000', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1),
(923, 101, '5.0000000', '0.00', '0.00', '0.00', '8.00', '0.00', '0.00', 0),
(924, 101, '6.0000000', '0.00', '0.00', '0.00', '8.00', '0.00', '0.00', 1),
(925, 507, '3.2500000', '2.80', '3.00', '2.00', '2.20', '2.00', '2.00', 1),
(926, 16, '8.0000000', '0.00', '0.00', '136.00', '15.00', '0.00', '0.00', 1);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `tb_productos`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `tb_productos` (
`idct` int(11)
,`nom` varchar(120)
,`timg` varchar(120)
,`unid` enum('UNIDAD','DOCENA','BOLSA','SET','JUEGO')
,`stk` int(11)
,`stk_min` int(11)
,`ida` int(11)
,`nomta` varchar(120)
,`idg` int(11)
,`nomtc` varchar(100)
,`idm` int(11)
,`nomtm` varchar(100)
,`ids` int(11)
,`nomts` varchar(100)
,`normal` decimal(12,2)
,`est` tinyint(1)
,`idpre` int(11)
,`compra` decimal(12,7)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `tb_producto_stock`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `tb_producto_stock` (
`idct` int(11)
,`nom` varchar(120)
,`timg` varchar(120)
,`unid` enum('UNIDAD','DOCENA','BOLSA','SET','JUEGO')
,`stk` int(11)
,`stk_min` int(11)
,`ida` int(11)
,`nomta` varchar(120)
,`idg` int(11)
,`nomtc` varchar(100)
,`idm` int(11)
,`nomtm` varchar(100)
,`ids` int(11)
,`nomts` varchar(100)
,`normal` decimal(12,2)
,`est` tinyint(1)
,`idpre` int(11)
,`compra` decimal(12,7)
,`id_stock` int(11)
,`sum(s.ct_nuevo)` decimal(32,0)
,`sum(s.ct_averiado)` decimal(32,0)
,`sum(s.ct_roto)` decimal(32,0)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_proveedor`
--

CREATE TABLE `tb_proveedor` (
  `idr` int(11) NOT NULL,
  `nom` varchar(120) NOT NULL,
  `ruc` char(12) NOT NULL,
  `dir` varchar(120) DEFAULT 'S/N',
  `cell` char(9) DEFAULT '000000000',
  `depart` char(16) DEFAULT 'LAMBAYEQUE',
  `dist` varchar(100) DEFAULT 'CHICLAYO',
  `prov` varchar(100) DEFAULT 'CHICLAYO',
  `est` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_proveedor`
--

INSERT INTO `tb_proveedor` (`idr`, `nom`, `ruc`, `dir`, `cell`, `depart`, `dist`, `prov`, `est`) VALUES
(1, 'SOCEDAD INDUSTRIAL ANDINA S.A', '20112347985', 'CALLE EGIDIO VALENTIN N° 645 - SAN PABLO - LA VICTORIA - LIMA - PERU', '5823', 'LAMBAYEQUE', 'CHICLAYO', 'CHICLAYO', 1),
(2, 'XIMESA S.A.C ', '20125508716', 'AV. NICOLAS AYLLON 2480 SANTA ANGELICA- LIMA- LIMA-PERU', '2055000', 'LAMBAYEQUE', 'CHICLAYO', 'CHICLAYO', 1),
(3, 'JORPLAST SRLTDA', '20206106621', 'CAL. LOS  CIPRESES MZA. H LOTE. 1 URB. SEMIRUSTICA LIMA- LIMA', '5008284', 'LAMBAYEQUE', 'CHICLAYO', 'CHICLAYO', 1),
(4, 'DIDE PLAST', '10067989444', 'CAL. CARLOS AUGUSTO SALAVERRY N° 3544 DPTO 201 URB. PANAMERICANA NORTE LIMA-LIMA-PERU', '5272665', 'LAMBAYEQUE', 'CHICLAYO', 'CHICLAYO', 1),
(5, 'INDUSTRIAS DUCKE S.A.C', '20547980086', 'AV. LOS EUCALIPTOS MZA.C LOTE 17-B INT. 2 URB. CANTO BELLO LIMA-LIMA-SAN JUAN DE LURIGANCHO', '946022124', 'LAMBAYEQUE', 'CHICLAYO', 'CHICLAYO', 1),
(6, 'PLASTICOS SANTA CRUZ E.I.R.L', '20392994964', 'AV. EL BOSQUE N°210 - URB. CANTO GRANDE - SAN JUAN DE LURIGANCHO - LIMA - LIMA', '990509822', 'LAMBAYEQUE', 'CHICLAYO', 'CHICLAYO', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_puntaje`
--

CREATE TABLE `tb_puntaje` (
  `id` int(11) NOT NULL,
  `cliente_id` int(11) NOT NULL,
  `puntaje_ini` int(11) NOT NULL,
  `puntaje_fin` int(11) NOT NULL,
  `est` tinyint(4) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_puntaje`
--

INSERT INTO `tb_puntaje` (`id`, `cliente_id`, `puntaje_ini`, `puntaje_fin`, `est`, `created_at`, `updated_at`) VALUES
(1, 2, 5, 1358, 1, '2018-11-23 09:43:24', '2018-11-23 09:43:24'),
(2, 3, 20, 3741, 1, '2018-11-23 11:44:38', '2018-11-23 11:44:38'),
(3, 4, 10, 1126, 1, '2018-11-23 11:58:55', '2018-11-23 11:58:55'),
(4, 5, 10, 983, 1, '2019-01-05 11:47:10', '2019-01-05 11:47:10'),
(6, 7, 5, 9, 1, '2019-01-07 09:57:43', '2019-01-07 09:57:43'),
(7, 8, 0, 1162, 1, '2019-01-08 09:19:48', '2019-01-08 09:19:48');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_sale`
--

CREATE TABLE `tb_sale` (
  `idv` int(11) NOT NULL,
  `nom` varchar(120) NOT NULL,
  `dir` varchar(120) DEFAULT 'S/N',
  `cell` char(9) DEFAULT NULL,
  `idti` int(11) NOT NULL,
  `usuario` char(30) NOT NULL,
  `clave` char(30) NOT NULL,
  `ida` int(11) NOT NULL,
  `est` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tb_sale`
--

INSERT INTO `tb_sale` (`idv`, `nom`, `dir`, `cell`, `idti`, `usuario`, `clave`, `ida`, `est`) VALUES
(1, 'ADMINISTRADOR', '', '123456', 1, 'admin', 'Ú ìÆ¬1Ì@‡½ªµ', 1, 1),
(2, 'USER', '', '1234567', 2, 'user', 'Ú ìÆ¬1Ì@‡½ªµ', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_serie`
--

CREATE TABLE `tb_serie` (
  `idse` int(11) NOT NULL,
  `nom` char(20) NOT NULL,
  `est` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_serie`
--

INSERT INTO `tb_serie` (`idse`, `nom`, `est`) VALUES
(1, '0001', 1),
(2, '0002', 1),
(3, '0003', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_stand`
--

CREATE TABLE `tb_stand` (
  `ids` int(11) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `est` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_stand`
--

INSERT INTO `tb_stand` (`ids`, `nom`, `est`) VALUES
(1, 'A', 1),
(2, 'B', 1),
(3, 'C', 1),
(4, 'D', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_stock`
--

CREATE TABLE `tb_stock` (
  `id_stock` int(11) NOT NULL,
  `idct` int(11) NOT NULL,
  `id_alm` int(11) NOT NULL,
  `ct_nuevo` int(11) NOT NULL,
  `ct_averiado` int(11) NOT NULL,
  `ct_roto` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  `est` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_stock`
--

INSERT INTO `tb_stock` (`id_stock`, `idct`, `id_alm`, `ct_nuevo`, `ct_averiado`, `ct_roto`, `fecha`, `est`) VALUES
(1, 665, 1, 98, 5, 1, '2019-01-03 15:44:49', 1),
(2, 659, 1, 0, 2, 5, '2019-01-03 15:45:16', 1),
(3, 821, 1, 7, 0, 10, '2019-01-04 00:00:00', 1),
(4, 507, 1, 51, 0, 0, '2019-01-04 00:00:00', 1),
(5, 1, 1, 0, 0, 0, '2019-01-04 00:00:00', 1),
(6, 674, 1, 5, 0, 0, '2019-01-07 00:00:00', 1),
(7, 28, 1, 185, 0, 0, '2019-01-07 00:00:00', 1),
(8, 116, 1, 274, 0, 0, '2019-01-07 00:00:00', 1),
(9, 97, 1, 466, 0, 14, '2019-01-07 00:00:00', 1),
(10, 357, 1, 290, 0, 8, '2019-01-09 00:00:00', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_tardanza_personal`
--

CREATE TABLE `tb_tardanza_personal` (
  `id` int(11) NOT NULL,
  `idpersonal` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `hora_llegada` varchar(7) NOT NULL,
  `monto_desc` decimal(12,2) DEFAULT NULL,
  `observacion` text NOT NULL,
  `tiempo_tardo` varchar(15) NOT NULL,
  `idtip` int(11) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_tip`
--

CREATE TABLE `tb_tip` (
  `idti` int(11) NOT NULL,
  `nom` char(20) NOT NULL,
  `est` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_tip`
--

INSERT INTO `tb_tip` (`idti`, `nom`, `est`) VALUES
(1, 'ADMIN', 1),
(2, 'VENDEDOR', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_tipo`
--

CREATE TABLE `tb_tipo` (
  `idtip` int(11) NOT NULL,
  `nom` char(20) NOT NULL,
  `est` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_tipo`
--

INSERT INTO `tb_tipo` (`idtip`, `nom`, `est`) VALUES
(1, 'BOLETA', 1),
(2, 'FACTURA', 1),
(3, 'PROFORMA', 1),
(4, 'CHATARRA', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_venta`
--

CREATE TABLE `tb_venta` (
  `idventa` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  `num_doc` char(12) NOT NULL,
  `idtip` int(11) NOT NULL,
  `idc` int(11) NOT NULL,
  `idv` int(11) NOT NULL,
  `total` decimal(12,2) NOT NULL,
  `est` tinyint(1) NOT NULL,
  `tipoventa` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_venta`
--

INSERT INTO `tb_venta` (`idventa`, `fecha`, `num_doc`, `idtip`, `idc`, `idv`, `total`, `est`, `tipoventa`) VALUES
(1, '2019-01-03 11:27:46', '003-65654554', 1, 4, 1, '180.00', 1, NULL),
(2, '2019-01-03 12:33:27', '003-002352', 1, 2, 1, '270.00', 1, NULL),
(3, '2019-01-04 10:25:14', '003-6564', 2, 1, 1, '254.88', 1, NULL),
(4, '2019-01-04 17:27:20', '003-655', 1, 2, 1, '6.00', 1, NULL),
(5, '2019-01-04 17:29:27', '003-6565', 1, 1, 1, '6.00', 1, NULL),
(6, '2019-01-04 17:30:38', '001-2425', 1, 1, 1, '6.00', 1, NULL),
(7, '2019-01-04 17:43:33', '002-68565', 1, 1, 1, '6.00', 1, NULL),
(8, '2019-01-04 17:44:55', '002', 1, 1, 1, '6.00', 1, NULL),
(9, '2019-01-04 17:45:43', '002-3655', 1, 1, 1, '6.00', 1, NULL),
(10, '2019-01-04 17:46:18', '03-565', 1, 1, 1, '3.00', 1, NULL),
(11, '2019-01-04 17:46:53', '002-3353', 1, 1, 1, '9.00', 1, NULL),
(12, '2019-01-04 17:47:44', '014-21424', 1, 1, 1, '6.50', 1, NULL),
(13, '2019-01-04 17:48:12', '002-353', 1, 1, 1, '6.50', 1, NULL),
(14, '2019-01-04 17:48:50', '001-3636', 1, 1, 1, '6.50', 1, NULL),
(15, '2019-01-04 17:50:04', '003-5665', 1, 1, 1, '3.00', 1, NULL),
(16, '2019-01-04 17:50:50', '03-5665', 1, 1, 1, '6.50', 1, NULL),
(17, '2019-01-04 17:51:36', '003-45654', 1, 1, 1, '3.00', 1, NULL),
(18, '2019-01-04 17:52:25', '003-5656', 1, 1, 1, '9.50', 1, NULL),
(19, '2019-01-04 18:04:47', '001-656', 1, 1, 1, '15.50', 1, NULL),
(20, '2019-01-04 18:10:19', '005-6565', 1, 1, 1, '9.00', 1, NULL),
(21, '2019-01-04 18:11:50', '002-5665', 1, 4, 1, '6.50', 1, NULL),
(22, '2019-01-05 12:23:04', '003-223', 1, 5, 1, '360.00', 1, NULL),
(23, '2019-01-05 12:25:20', '003-2256', 1, 1, 1, '18.00', 1, NULL),
(24, '2019-01-05 12:33:40', '001-6635', 1, 1, 1, '18.00', 1, NULL),
(25, '2019-01-05 12:57:50', '008-5665', 1, 1, 1, '18.00', 1, NULL),
(26, '2019-01-07 11:07:18', '0010-5553', 1, 7, 1, '39.60', 1, NULL),
(28, '2019-01-07 11:53:51', '005-1254', 1, 1, 1, '2.20', 1, NULL),
(29, '2019-01-07 15:21:14', '002-522', 2, 5, 1, '164.32', 1, NULL),
(30, '2019-01-07 15:28:23', '004-854', 1, 5, 1, '3.00', 1, NULL),
(31, '2019-01-07 15:31:40', '002-8963', 1, 2, 1, '3.00', 1, NULL),
(32, '2019-01-07 15:35:32', '006-652', 1, 5, 1, '3.00', 1, NULL),
(33, '2019-01-07 15:39:03', '003-5652', 1, 4, 1, '159.75', 1, NULL),
(34, '2019-01-07 15:55:24', '010-5221', 1, 1, 1, '2283.37', 1, NULL),
(35, '2019-01-07 18:14:34', '005-6522', 1, 3, 1, '1850.69', 1, NULL),
(36, '2019-01-07 19:27:02', '0010-214', 2, 1, 1, '590.00', 1, NULL),
(37, '2019-01-08 09:21:49', '007-1452', 1, 8, 1, '252.29', 1, NULL),
(38, '2019-01-08 09:39:59', '009-2412', 1, 1, 1, '146.00', 1, NULL),
(39, '2019-01-08 09:48:32', '0010-5532', 1, 1, 1, '89.00', 1, NULL),
(40, '2019-01-08 09:56:48', '0011-3250', 1, 8, 1, '301.79', 1, NULL),
(41, '2019-01-08 11:07:40', '0018-3521', 1, 1, 1, '188.00', 1, 1),
(42, '2019-01-08 11:09:04', '000-6233', 1, 5, 1, '188.00', 1, 1),
(48, '2019-01-09 11:30:09', '001-1111', 4, 5, 1, '188.40', 1, 3),
(49, '2019-01-09 11:44:35', '003-0263', 4, 8, 1, '26.34', 1, 3),
(50, '2019-01-09 15:29:31', '012-2241', 1, 2, 1, '573.90', 1, 1),
(51, '2019-01-09 15:40:14', '0012-3695', 4, 4, 1, '26.00', 1, 3),
(52, '2019-01-09 15:52:40', '003-1111', 4, 5, 1, '97.00', 1, 3),
(53, '2019-01-09 15:54:18', '0013-24242', 1, 1, 1, '141.00', 1, 1),
(54, '2019-01-09 17:22:59', '0018-0125', 2, 1, 1, '467.26', 1, 1),
(55, '2019-01-09 17:25:30', '001-0035', 1, 1, 1, '3.00', 1, 1),
(56, '2019-01-09 17:26:03', '1111-21212', 2, 1, 1, '3.54', 1, 1),
(57, '2019-01-09 17:26:33', '0000051', 3, 1, 1, '3.00', 1, 1),
(58, '2019-01-09 17:32:47', '0000052', 3, 4, 1, '526.90', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_cambio`
--

CREATE TABLE `tipo_cambio` (
  `id` int(11) NOT NULL,
  `idmoneda` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `cambio` decimal(12,2) NOT NULL,
  `estado` tinyint(1) NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tipo_cambio`
--

INSERT INTO `tipo_cambio` (`id`, `idmoneda`, `fecha`, `cambio`, `estado`, `updated_at`) VALUES
(1, 2, '2018-12-28', '3.25', 1, '2018-12-29 09:22:53'),
(2, 2, '2019-02-02', '3.26', 1, '2019-02-02 12:18:18'),
(3, 2, '2019-02-07', '3.25', 1, '2019-02-07 10:04:14');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_moneda`
--

CREATE TABLE `tipo_moneda` (
  `id` int(11) NOT NULL,
  `descripcion` varchar(25) NOT NULL,
  `signo` varchar(5) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tipo_moneda`
--

INSERT INTO `tipo_moneda` (`id`, `descripcion`, `signo`, `estado`, `created_at`, `updated_at`) VALUES
(1, 'SOLES', 'S/', 1, '2018-12-21 16:01:13', '2018-12-21 16:01:13'),
(2, 'DOLAR', '$/', 1, '2018-12-21 16:01:13', '2018-12-21 16:01:13');

-- --------------------------------------------------------

--
-- Estructura para la vista `tb_productos`
--
DROP TABLE IF EXISTS `tb_productos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `tb_productos`  AS  select `tb`.`idct` AS `idct`,cast(`tb`.`nom` as char(120) charset utf8) AS `nom`,cast(`tb`.`imagen` as char(120) charset utf8) AS `timg`,`tb`.`unid` AS `unid`,`tb`.`stk` AS `stk`,`tb`.`stk_min` AS `stk_min`,`ta`.`ida` AS `ida`,`ta`.`nom` AS `nomta`,`tc`.`idg` AS `idg`,`tc`.`nom` AS `nomtc`,`tm`.`idm` AS `idm`,`tm`.`nom` AS `nomtm`,`ts`.`ids` AS `ids`,`ts`.`nom` AS `nomts`,`tpr`.`minorista` AS `normal`,`tb`.`est` AS `est`,`tpr`.`idpre` AS `idpre`,`tpr`.`compra` AS `compra` from (((((`tb_catalogo` `tb` join `tb_almacen` `ta` on((`ta`.`ida` = `tb`.`ida`))) join `tb_categ` `tc` on((`tc`.`idg` = `tb`.`idg`))) join `tb_marca` `tm` on((`tm`.`idm` = `tb`.`idm`))) join `tb_stand` `ts` on((`ts`.`ids` = `tb`.`ids`))) join `tb_precio` `tpr` on(((`tpr`.`idct` = `tb`.`idct`) and (`tpr`.`est` = 1)))) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `tb_producto_stock`
--
DROP TABLE IF EXISTS `tb_producto_stock`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `tb_producto_stock`  AS  select `tb`.`idct` AS `idct`,cast(`tb`.`nom` as char(120) charset utf8) AS `nom`,cast(`tb`.`imagen` as char(120) charset utf8) AS `timg`,`tb`.`unid` AS `unid`,`tb`.`stk` AS `stk`,`tb`.`stk_min` AS `stk_min`,`ta`.`ida` AS `ida`,`ta`.`nom` AS `nomta`,`tc`.`idg` AS `idg`,`tc`.`nom` AS `nomtc`,`tm`.`idm` AS `idm`,`tm`.`nom` AS `nomtm`,`ts`.`ids` AS `ids`,`ts`.`nom` AS `nomts`,`tpr`.`normal` AS `normal`,`tb`.`est` AS `est`,`tpr`.`idpre` AS `idpre`,`tpr`.`compra` AS `compra`,`s`.`id_stock` AS `id_stock`,sum(`s`.`ct_nuevo`) AS `sum(s.ct_nuevo)`,sum(`s`.`ct_averiado`) AS `sum(s.ct_averiado)`,sum(`s`.`ct_roto`) AS `sum(s.ct_roto)` from ((((((`tb_catalogo` `tb` join `tb_almacen` `ta` on((`ta`.`ida` = `tb`.`ida`))) join `tb_categ` `tc` on((`tc`.`idg` = `tb`.`idg`))) join `tb_marca` `tm` on((`tm`.`idm` = `tb`.`idm`))) join `tb_stand` `ts` on((`ts`.`ids` = `tb`.`ids`))) join `tb_precio` `tpr` on((`tpr`.`idct` = `tb`.`idct`))) join `tb_stock` `s` on(((`tb`.`idct` = `s`.`idct`) and (`tpr`.`est` = 1)))) group by `tb`.`idct` ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `caja_chica`
--
ALTER TABLE `caja_chica`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cierre_caja`
--
ALTER TABLE `cierre_caja`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `detalle_caja`
--
ALTER TABLE `detalle_caja`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tb_detalle_caja_idcaja` (`idcaja`);

--
-- Indices de la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  ADD PRIMARY KEY (`iddcompra`),
  ADD KEY `fk_detalle_compra_idcompra` (`idcompra`),
  ADD KEY `fk_detalle_compra_idct` (`idct`);

--
-- Indices de la tabla `detalle_puntaje`
--
ALTER TABLE `detalle_puntaje`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_detalle_puntaje_puntaje_id` (`puntaje_id`);

--
-- Indices de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD PRIMARY KEY (`iddetalle`),
  ADD KEY `fk_detalle_venta_idventa` (`idventa`),
  ADD KEY `fk_detalle_venta_idprd` (`idct`);

--
-- Indices de la tabla `restricciones`
--
ALTER TABLE `restricciones`
  ADD PRIMARY KEY (`idrestri`),
  ADD KEY `fk_resticciones_idtip` (`idtip`);

--
-- Indices de la tabla `subrestricciones`
--
ALTER TABLE `subrestricciones`
  ADD PRIMARY KEY (`idsubrestri`),
  ADD KEY `fk_subrestricciones_idtip` (`idtip`);

--
-- Indices de la tabla `tb_almacen`
--
ALTER TABLE `tb_almacen`
  ADD PRIMARY KEY (`ida`),
  ADD UNIQUE KEY `uq_tb_almacen_nom` (`nom`);

--
-- Indices de la tabla `tb_catalogo`
--
ALTER TABLE `tb_catalogo`
  ADD PRIMARY KEY (`idct`),
  ADD UNIQUE KEY `uq_tb_catalogo_nom` (`nom`),
  ADD KEY `fk_tb_catalogo_ida` (`ida`),
  ADD KEY `fk_tb_catalogo_idg` (`idg`),
  ADD KEY `fk_tb_catalogo_idm` (`idm`),
  ADD KEY `fk_tb_catalogo_ids` (`ids`);

--
-- Indices de la tabla `tb_categ`
--
ALTER TABLE `tb_categ`
  ADD PRIMARY KEY (`idg`),
  ADD UNIQUE KEY `uq_tb_categ_nom` (`nom`);

--
-- Indices de la tabla `tb_ccompras`
--
ALTER TABLE `tb_ccompras`
  ADD PRIMARY KEY (`idpago`),
  ADD KEY `fk_tb_ccompras_idcompra` (`idcompra`),
  ADD KEY `fk_tb_ccompras_idv` (`idv`);

--
-- Indices de la tabla `tb_cliente`
--
ALTER TABLE `tb_cliente`
  ADD PRIMARY KEY (`idc`),
  ADD UNIQUE KEY `uq_tb_cliente_ruc` (`ruc`);

--
-- Indices de la tabla `tb_compra`
--
ALTER TABLE `tb_compra`
  ADD PRIMARY KEY (`idcompra`),
  ADD UNIQUE KEY `uq_tb_compra_num_doc` (`num_doc`),
  ADD KEY `fk_tb_compra_idtip` (`idtip`),
  ADD KEY `fk_tb_compra_idr` (`idr`),
  ADD KEY `fk_tb_compra_idv` (`idv`),
  ADD KEY `idtipomoneda` (`idtipomoneda`);

--
-- Indices de la tabla `tb_compracuotas`
--
ALTER TABLE `tb_compracuotas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tb_compracuota_idpago` (`idpago`);

--
-- Indices de la tabla `tb_cventa`
--
ALTER TABLE `tb_cventa`
  ADD PRIMARY KEY (`idcc`),
  ADD KEY `fk_tb_cventa_idventa` (`idventa`),
  ADD KEY `fk_tb_cventa_idv` (`idv`);

--
-- Indices de la tabla `tb_descuento_adelanto`
--
ALTER TABLE `tb_descuento_adelanto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tb_descuento_idpersonal` (`idpersonal`),
  ADD KEY `fk_tb_descuento_idtip` (`idtip`);

--
-- Indices de la tabla `tb_detalle_cuota`
--
ALTER TABLE `tb_detalle_cuota`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tb_detalle_cuota_idccuota` (`idccuota`);

--
-- Indices de la tabla `tb_marca`
--
ALTER TABLE `tb_marca`
  ADD PRIMARY KEY (`idm`),
  ADD UNIQUE KEY `uq_tb_marca_nom` (`nom`);

--
-- Indices de la tabla `tb_oferta`
--
ALTER TABLE `tb_oferta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `puntaje_id` (`puntaje_id`),
  ADD KEY `catalogo_id` (`catalogo_id`);

--
-- Indices de la tabla `tb_permiso_personal`
--
ALTER TABLE `tb_permiso_personal`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tb_permiso_idpersonal` (`idpersonal`),
  ADD KEY `fk_tb_permiso_idtip` (`idtip`);

--
-- Indices de la tabla `tb_personal`
--
ALTER TABLE `tb_personal`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tb_precio`
--
ALTER TABLE `tb_precio`
  ADD PRIMARY KEY (`idpre`),
  ADD KEY `fk_tb_precio_idct` (`idct`);

--
-- Indices de la tabla `tb_proveedor`
--
ALTER TABLE `tb_proveedor`
  ADD PRIMARY KEY (`idr`),
  ADD UNIQUE KEY `uq_tb_proveedor_nom` (`nom`),
  ADD UNIQUE KEY `uq_tb_proveedor_ruc` (`ruc`);

--
-- Indices de la tabla `tb_puntaje`
--
ALTER TABLE `tb_puntaje`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cliente_id` (`cliente_id`);

--
-- Indices de la tabla `tb_sale`
--
ALTER TABLE `tb_sale`
  ADD PRIMARY KEY (`idv`),
  ADD UNIQUE KEY `uq_tb_sale_nom` (`nom`),
  ADD KEY `fk_tb_sale_ida` (`ida`),
  ADD KEY `fk_tb_sale_tip` (`idti`);

--
-- Indices de la tabla `tb_serie`
--
ALTER TABLE `tb_serie`
  ADD PRIMARY KEY (`idse`),
  ADD UNIQUE KEY `uq_tb_serie_nom` (`nom`);

--
-- Indices de la tabla `tb_stand`
--
ALTER TABLE `tb_stand`
  ADD PRIMARY KEY (`ids`),
  ADD UNIQUE KEY `uq_tb_stand_nom` (`nom`);

--
-- Indices de la tabla `tb_stock`
--
ALTER TABLE `tb_stock`
  ADD PRIMARY KEY (`id_stock`),
  ADD KEY `fk_tb_stock_idct` (`idct`);

--
-- Indices de la tabla `tb_tardanza_personal`
--
ALTER TABLE `tb_tardanza_personal`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tb_tardanza_idpersonal` (`idpersonal`),
  ADD KEY `fk_tb_tardanza_idtip` (`idtip`);

--
-- Indices de la tabla `tb_tip`
--
ALTER TABLE `tb_tip`
  ADD PRIMARY KEY (`idti`),
  ADD UNIQUE KEY `uq_tb_tip_nom` (`nom`);

--
-- Indices de la tabla `tb_tipo`
--
ALTER TABLE `tb_tipo`
  ADD PRIMARY KEY (`idtip`),
  ADD UNIQUE KEY `uq_tb_tipo_nom` (`nom`);

--
-- Indices de la tabla `tb_venta`
--
ALTER TABLE `tb_venta`
  ADD PRIMARY KEY (`idventa`),
  ADD UNIQUE KEY `uq_tb_venta_num_doc` (`num_doc`),
  ADD KEY `fk_venta_idtip` (`idtip`),
  ADD KEY `fk_venta_id_cli` (`idc`),
  ADD KEY `fk_venta_idsale` (`idv`);

--
-- Indices de la tabla `tipo_cambio`
--
ALTER TABLE `tipo_cambio`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tipocambio_idmoneda` (`idmoneda`);

--
-- Indices de la tabla `tipo_moneda`
--
ALTER TABLE `tipo_moneda`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `caja_chica`
--
ALTER TABLE `caja_chica`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `cierre_caja`
--
ALTER TABLE `cierre_caja`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_caja`
--
ALTER TABLE `detalle_caja`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT de la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  MODIFY `iddcompra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `detalle_puntaje`
--
ALTER TABLE `detalle_puntaje`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  MODIFY `iddetalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=109;

--
-- AUTO_INCREMENT de la tabla `restricciones`
--
ALTER TABLE `restricciones`
  MODIFY `idrestri` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `subrestricciones`
--
ALTER TABLE `subrestricciones`
  MODIFY `idsubrestri` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `tb_almacen`
--
ALTER TABLE `tb_almacen`
  MODIFY `ida` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tb_catalogo`
--
ALTER TABLE `tb_catalogo`
  MODIFY `idct` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=932;

--
-- AUTO_INCREMENT de la tabla `tb_categ`
--
ALTER TABLE `tb_categ`
  MODIFY `idg` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=132;

--
-- AUTO_INCREMENT de la tabla `tb_ccompras`
--
ALTER TABLE `tb_ccompras`
  MODIFY `idpago` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `tb_cliente`
--
ALTER TABLE `tb_cliente`
  MODIFY `idc` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `tb_compra`
--
ALTER TABLE `tb_compra`
  MODIFY `idcompra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `tb_compracuotas`
--
ALTER TABLE `tb_compracuotas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tb_cventa`
--
ALTER TABLE `tb_cventa`
  MODIFY `idcc` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT de la tabla `tb_descuento_adelanto`
--
ALTER TABLE `tb_descuento_adelanto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tb_detalle_cuota`
--
ALTER TABLE `tb_detalle_cuota`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tb_marca`
--
ALTER TABLE `tb_marca`
  MODIFY `idm` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=109;

--
-- AUTO_INCREMENT de la tabla `tb_oferta`
--
ALTER TABLE `tb_oferta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tb_permiso_personal`
--
ALTER TABLE `tb_permiso_personal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tb_personal`
--
ALTER TABLE `tb_personal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tb_precio`
--
ALTER TABLE `tb_precio`
  MODIFY `idpre` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=927;

--
-- AUTO_INCREMENT de la tabla `tb_proveedor`
--
ALTER TABLE `tb_proveedor`
  MODIFY `idr` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `tb_puntaje`
--
ALTER TABLE `tb_puntaje`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `tb_sale`
--
ALTER TABLE `tb_sale`
  MODIFY `idv` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tb_serie`
--
ALTER TABLE `tb_serie`
  MODIFY `idse` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tb_stand`
--
ALTER TABLE `tb_stand`
  MODIFY `ids` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tb_stock`
--
ALTER TABLE `tb_stock`
  MODIFY `id_stock` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `tb_tardanza_personal`
--
ALTER TABLE `tb_tardanza_personal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tb_tip`
--
ALTER TABLE `tb_tip`
  MODIFY `idti` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tb_tipo`
--
ALTER TABLE `tb_tipo`
  MODIFY `idtip` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tb_venta`
--
ALTER TABLE `tb_venta`
  MODIFY `idventa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT de la tabla `tipo_cambio`
--
ALTER TABLE `tipo_cambio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tipo_moneda`
--
ALTER TABLE `tipo_moneda`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalle_caja`
--
ALTER TABLE `detalle_caja`
  ADD CONSTRAINT `fk_tb_detalle_caja_idcaja` FOREIGN KEY (`idcaja`) REFERENCES `caja_chica` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  ADD CONSTRAINT `fk_detalle_compra_idcompra` FOREIGN KEY (`idcompra`) REFERENCES `tb_compra` (`idcompra`),
  ADD CONSTRAINT `fk_detalle_compra_idct` FOREIGN KEY (`idct`) REFERENCES `tb_catalogo` (`idct`);

--
-- Filtros para la tabla `detalle_puntaje`
--
ALTER TABLE `detalle_puntaje`
  ADD CONSTRAINT `fk_detalle_puntaje_puntaje_id` FOREIGN KEY (`puntaje_id`) REFERENCES `tb_puntaje` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD CONSTRAINT `fk_detalle_venta_idprd` FOREIGN KEY (`idct`) REFERENCES `tb_catalogo` (`idct`),
  ADD CONSTRAINT `fk_detalle_venta_idventa` FOREIGN KEY (`idventa`) REFERENCES `tb_venta` (`idventa`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `restricciones`
--
ALTER TABLE `restricciones`
  ADD CONSTRAINT `fk_resticciones_idtip` FOREIGN KEY (`idtip`) REFERENCES `tb_tipo` (`idtip`);

--
-- Filtros para la tabla `subrestricciones`
--
ALTER TABLE `subrestricciones`
  ADD CONSTRAINT `fk_subrestricciones_idtip` FOREIGN KEY (`idtip`) REFERENCES `tb_tipo` (`idtip`);

--
-- Filtros para la tabla `tb_catalogo`
--
ALTER TABLE `tb_catalogo`
  ADD CONSTRAINT `fk_tb_catalogo_ida` FOREIGN KEY (`ida`) REFERENCES `tb_almacen` (`ida`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_tb_catalogo_idg` FOREIGN KEY (`idg`) REFERENCES `tb_categ` (`idg`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_tb_catalogo_idm` FOREIGN KEY (`idm`) REFERENCES `tb_marca` (`idm`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_tb_catalogo_ids` FOREIGN KEY (`ids`) REFERENCES `tb_stand` (`ids`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `tb_ccompras`
--
ALTER TABLE `tb_ccompras`
  ADD CONSTRAINT `fk_tb_ccompras_idcompra` FOREIGN KEY (`idcompra`) REFERENCES `tb_compra` (`idcompra`),
  ADD CONSTRAINT `fk_tb_ccompras_idv` FOREIGN KEY (`idv`) REFERENCES `tb_sale` (`idv`);

--
-- Filtros para la tabla `tb_compra`
--
ALTER TABLE `tb_compra`
  ADD CONSTRAINT `fk_tb_compra_idr` FOREIGN KEY (`idr`) REFERENCES `tb_proveedor` (`idr`),
  ADD CONSTRAINT `fk_tb_compra_idtip` FOREIGN KEY (`idtip`) REFERENCES `tb_tipo` (`idtip`),
  ADD CONSTRAINT `fk_tb_compra_idv` FOREIGN KEY (`idv`) REFERENCES `tb_sale` (`idv`),
  ADD CONSTRAINT `tb_compra_ibfk_1` FOREIGN KEY (`idtipomoneda`) REFERENCES `tipo_moneda` (`id`);

--
-- Filtros para la tabla `tb_compracuotas`
--
ALTER TABLE `tb_compracuotas`
  ADD CONSTRAINT `fk_tb_compracuota_idpago` FOREIGN KEY (`idpago`) REFERENCES `tb_compra` (`idcompra`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `tb_cventa`
--
ALTER TABLE `tb_cventa`
  ADD CONSTRAINT `fk_tb_cventa_idv` FOREIGN KEY (`idv`) REFERENCES `tb_sale` (`idv`),
  ADD CONSTRAINT `fk_tb_cventa_idventa` FOREIGN KEY (`idventa`) REFERENCES `tb_venta` (`idventa`);

--
-- Filtros para la tabla `tb_descuento_adelanto`
--
ALTER TABLE `tb_descuento_adelanto`
  ADD CONSTRAINT `fk_tb_descuento_idpersonal` FOREIGN KEY (`idpersonal`) REFERENCES `tb_personal` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tb_descuento_idtip` FOREIGN KEY (`idtip`) REFERENCES `tb_tip` (`idti`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_detalle_cuota`
--
ALTER TABLE `tb_detalle_cuota`
  ADD CONSTRAINT `fk_tb_detalle_cuota_idccuota` FOREIGN KEY (`idccuota`) REFERENCES `tb_compracuotas` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `tb_oferta`
--
ALTER TABLE `tb_oferta`
  ADD CONSTRAINT `tb_oferta_ibfk_1` FOREIGN KEY (`puntaje_id`) REFERENCES `tb_puntaje` (`id`),
  ADD CONSTRAINT `tb_oferta_ibfk_2` FOREIGN KEY (`catalogo_id`) REFERENCES `tb_catalogo` (`idct`);

--
-- Filtros para la tabla `tb_permiso_personal`
--
ALTER TABLE `tb_permiso_personal`
  ADD CONSTRAINT `fk_tb_permiso_idpersonal` FOREIGN KEY (`idpersonal`) REFERENCES `tb_personal` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tb_permiso_idtip` FOREIGN KEY (`idtip`) REFERENCES `tb_tip` (`idti`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_precio`
--
ALTER TABLE `tb_precio`
  ADD CONSTRAINT `fk_tb_precio_idct` FOREIGN KEY (`idct`) REFERENCES `tb_catalogo` (`idct`);

--
-- Filtros para la tabla `tb_puntaje`
--
ALTER TABLE `tb_puntaje`
  ADD CONSTRAINT `tb_puntaje_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `tb_cliente` (`idc`);

--
-- Filtros para la tabla `tb_sale`
--
ALTER TABLE `tb_sale`
  ADD CONSTRAINT `fk_tb_sale_ida` FOREIGN KEY (`ida`) REFERENCES `tb_almacen` (`ida`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_tb_sale_tip` FOREIGN KEY (`idti`) REFERENCES `tb_tip` (`idti`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `tb_stock`
--
ALTER TABLE `tb_stock`
  ADD CONSTRAINT `fk_tb_stock_idct` FOREIGN KEY (`idct`) REFERENCES `tb_catalogo` (`idct`);

--
-- Filtros para la tabla `tb_tardanza_personal`
--
ALTER TABLE `tb_tardanza_personal`
  ADD CONSTRAINT `fk_tb_tardanza_idpersonal` FOREIGN KEY (`idpersonal`) REFERENCES `tb_personal` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tb_tardanza_idtip` FOREIGN KEY (`idtip`) REFERENCES `tb_tip` (`idti`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_venta`
--
ALTER TABLE `tb_venta`
  ADD CONSTRAINT `fk_tb_venta_idc` FOREIGN KEY (`idc`) REFERENCES `tb_cliente` (`idc`),
  ADD CONSTRAINT `fk_tb_venta_ids` FOREIGN KEY (`idv`) REFERENCES `tb_sale` (`idv`),
  ADD CONSTRAINT `fk_tb_venta_idtip` FOREIGN KEY (`idtip`) REFERENCES `tb_tipo` (`idtip`);

--
-- Filtros para la tabla `tipo_cambio`
--
ALTER TABLE `tipo_cambio`
  ADD CONSTRAINT `fk_tipocambio_idmoneda` FOREIGN KEY (`idmoneda`) REFERENCES `tipo_moneda` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
