<?php 
/**
* Derechos Diseño y Programación - ultratec.com.pe
* Bajo Pena de Uso Indebido y/o/ Copias
* @copyright © 2017
*
*/

require_once $_SERVER["DOCUMENT_ROOT"]."/SysPlast/dao/tipocambio_dao.php";

Class Tipocambio_ctrl{

	public function proc_tipocambio_ctrl($arr){
		$tipocambio_dao = new Tipocambio_dao();
		$res = $tipocambio_dao->proc_tipocambio_dao($arr);
		return $res;
	}

	public function rows_tipocambio_ctrl(){
		$tipocambio_dao = new Tipocambio_dao();
		$res=$tipocambio_dao->rows_tipocambio_dao();
		$fila=[];
		while ($rows = $res->fetch_row()) {
			$fila[] = $rows;
		}

		return $fila;
	}

	public function get_tipocambio_ctrl($dt){
		$tipocambio_dao = new Tipocambio_dao();
		$res = $tipocambio_dao->get_tipocambio_dao($dt);
		$fila=[];
		while($rows = $res->fetch_row()){
			$fila[] = $rows;
		}
		return $fila;
	}

	public function get_cambiodolar_actual_ctrl(){
		$tipocambio_dao = new Tipocambio_dao();
		$res = $tipocambio_dao->get_cambiodolar_actual_dao();
		$fila=[];
		while($rows = $res->fetch_row()){
			$fila[] = $rows;
		}
		return $fila;
	}

}
?>