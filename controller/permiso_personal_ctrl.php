<?php 
/**
* Derechos Diseño y Programación - ultratec.com.pe
* Bajo Pena de Uso Indebido y/o/ Copias
* @copyright © 2017
*
*/

require_once $_SERVER["DOCUMENT_ROOT"]."/SysPlast/dao/permiso_personal_dao.php";

Class Permiso_personal_ctrl{

	public function get_permiso_personal_ctrl($dt){
		$permiso_dao = new Permiso_personal_dao();
		$res = $permiso_dao->get_permiso_personal_dao($dt);
		$fila=[];
		while($rows = $res->fetch_row()){
			$fila[] = $rows;
		}
		return $fila;
	}

	public function proc_permiso_personal_ctrl($arr){
		$permiso_dao = new Permiso_personal_dao();
		$res = $permiso_dao->proc_permiso_personal_dao($arr);
		return $res;
	}

	public function rows_permiso_personal_ctrl(){
		$permiso_dao = new Permiso_personal_dao();
		$res=$permiso_dao->rows_permiso_personal_dao();
		$fila=[];
		while ($rows = $res->fetch_row()) {
			$fila[] = $rows;
		}

		return $fila;
	}

}
?>