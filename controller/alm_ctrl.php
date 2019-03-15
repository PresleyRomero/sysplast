<?php 
/**
* Derechos Diseño y Programación - ultratec.com.pe
* Bajo Pena de Uso Indebido y/o/ Copias
* @copyright © 2017
* 
*/

require_once $_SERVER["DOCUMENT_ROOT"]."/SysPlast/dao/alm_dao.php";

Class Alm_ctrl{
	public function get_alm_ctrl($dt){
		$alm_dao = new Alm_dao();
		$res = $alm_dao->get_alm_dao($dt);
		$fila=[];
		while ($rows = $res->fetch_row()) {
			$fila[] = $rows;
		}
		return $fila;
	}

	public function rows_alm_ctrl(){
		$alm_dao = new Alm_dao();
		$res=$alm_dao->rows_alm_dao();
		$fila=[];
		while ($rows = $res->fetch_row()) {
			$fila[] = $rows;
		}
		return $fila;
	}

	public function rest_alm_ctrl(){
		$alm_dao = new Alm_dao();
		$res=$alm_dao->rest_alm_dao();
		$fila=[];
		while ($rows = $res->fetch_row()) {
			$fila[] = $rows;
		}
		return $fila;
	}
	public function get_rest_alm_ctrl($id){
		$alm_dao = new Alm_dao();
		$res=$alm_dao->get_rest_alm_dao($id);
		$fila=[];
		while ($rows = $res->fetch_row()) {
			$fila[] = $rows;
		}
		return $fila;
	}

	public function proc_alm_ctrl($arr){
		$alm_dao = new Alm_dao();
		$res = $alm_dao->proc_alm_dao($arr);
		return $res;
	}
	public function Stock_alm_Ctrl($ids){
		$alm_dao = new Alm_dao();
		$res = $alm_dao->stock_alm_Dao($ids);
		$fila=[];
		while ($rows = $res->fetch_row()) {
			$fila[] = $rows;
		}
		return $fila;
	}
}
?>