<?php 
/**
* Derechos Diseño y Programación - ultratec.com.pe.pe
* Bajo Pena de Uso Indebido y/o/ Copias
* @copyright © 2017
*
*/

require_once $_SERVER["DOCUMENT_ROOT"]."/SysPlast/dao/tiposd_dao.php";

Class Tiposd_ctrl{
	public function get_tiposd_ctrl($dt){
		$tiposd_dao = new Tiposd_dao();
		$res = $tiposd_dao->get_tiposd_dao($dt);
		$fila=[];
		while ($rows = $res->fetch_row()) {
			$fila[] = $rows;
		}
		return $fila;
	}

	public function rows_tiposd_ctrl(){
		$tiposd_dao = new Tiposd_dao();
		$res=$tiposd_dao->rows_tiposd_dao();
		$fila=[];
		while ($rows = $res->fetch_row()) {
			$fila[] = $rows;
		}
		return $fila;
	}

	public function rest_tipo_ctrl(){
		$tiposd_dao = new Tiposd_dao();
		$res=$tiposd_dao->rest_tiposd_dao();
		$fila=[];
		while ($rows = $res->fetch_row()) {
			$fila[] = $rows;
		}
		return $fila;
	}
}
?>