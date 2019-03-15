<?php 
/**
* Derechos Diseño y Programación - ultratec.com.pe
* Bajo Pena de Uso Indebido y/o/ Copias
* @copyright © 2017
*
*/

require_once $_SERVER["DOCUMENT_ROOT"]."/SysPlast/dao/tardanza_personal_dao.php";

Class Tardanza_personal_ctrl{

	public function get_tardanza_personal_ctrl($dt){
		$tardanza_dao = new Tardanza_personal_dao();
		$res = $tardanza_dao->get_tardanza_personal_dao($dt);
		$fila=[];
		while($rows = $res->fetch_row()){
			$fila[] = $rows;
		}
		return $fila;
	}

	public function proc_tardanza_personal_ctrl($arr){
		$tardanza_dao = new Tardanza_personal_dao();
		$res = $tardanza_dao->proc_tardanza_personal_dao($arr);
		return $res;
	}

	public function rows_tardanza_personal_ctrl(){
		$tardanza_dao = new Tardanza_personal_dao();
		$res=$tardanza_dao->rows_tardanza_personal_dao();
		$fila=[];
		while ($rows = $res->fetch_row()) {
			$fila[] = $rows;
		}

		return $fila;
	}

	public function rows_tardanza_liquidados_personal_ctrl(){
		$tardanza_dao = new Tardanza_personal_dao();
		$res=$tardanza_dao->rows_tardanza_liquidados_personal_dao();
		$fila=[];
		while ($rows = $res->fetch_row()) {
			$fila[] = $rows;
		}

		return $fila;
	}

	public function calcular_tardanzaxpersonal_ctrl($ini,$fin,$id){
		$tardanza_dao = new Tardanza_personal_dao();
		$res = $tardanza_dao->calcular_tardanzaxpersonal_dao($ini,$fin,$id);
		$fila=[];
		while($rows = $res->fetch_row()){
			$fila[] = $rows;
		}
		return $fila;
	}

	public function monto_tardanzaxpersonal_ctrl($ini, $fin, $id){
		$tardanza_dao = new Tardanza_personal_dao();
		$res = $tardanza_dao->monto_tardanzaxpersonal_dao($ini, $fin, $id);
		$fila = $res->fetch_row();
		return $fila;
	}

}
?>