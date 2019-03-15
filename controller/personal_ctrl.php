<?php 
/**
* Derechos Diseño y Programación - ultratec.com.pe
* Bajo Pena de Uso Indebido y/o/ Copias
* @copyright © 2017
*
*/

require_once $_SERVER["DOCUMENT_ROOT"]."/SysPlast/dao/personal_dao.php";

Class Personal_ctrl{

	public function get_personal_ctrl($dt){
		$personal_dao = new Personal_dao();
		$res = $personal_dao->get_personal_dao($dt);
		$fila=[];
		while($rows = $res->fetch_row()){
			$fila[] = $rows;
		}
		return $fila;
	}

	public function proc_personal_ctrl($arr){
		$personal_dao = new Personal_dao();
		$res = $personal_dao->proc_personal_dao($arr);
		return $res;
	}

	public function rows_personal_ctrl(){
		$personal_dao = new Personal_dao();
		$res=$personal_dao->rows_personal_dao();
		$fila=[];
		while ($rows = $res->fetch_row()) {
			$fila[] = $rows;
		}

		return $fila;
	}

	public function get_personalxnombre_dni_ctrl($dt){
		$personal_dao = new Personal_dao();
		$res = $personal_dao->get_personalxnombredni_dao($dt);
		$fila=[];
		while($rows = $res->fetch_row()){

			$fila[] = ['value' => $rows[1] . ' ('.$rows[2].')', 
			'id' => $rows[0]];
		}
		return $fila;
	}

}
?>