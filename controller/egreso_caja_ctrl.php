<?php 
/**
* Derechos Diseño y Programación - ultratec.com.pe
* Bajo Pena de Uso Indebido y/o/ Copias
* @copyright © 2017
*
*/

require_once $_SERVER["DOCUMENT_ROOT"]."/SysPlast/dao/egreso_caja_dao.php";

Class Egreso_caja_ctrl{

	public function proc_egreso_caja_ctrl($arr){
		$egreso_caja_dao = new Egreso_caja_dao();
		$res = $egreso_caja_dao->proc_egreso_caja_dao($arr);
		return $res;
	}

	public function rows_egreso_caja_ctrl(){
		$egreso_dao = new Egreso_caja_dao();
		$res=$egreso_dao->rows_egreso_caja_dao();
		$fila=[];
		while ($rows = $res->fetch_row()) {
			$fila[] = $rows;
		}

		return $fila;
	}

}
?>