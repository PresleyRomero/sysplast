<?php 
/**
* Derechos Diseño y Programación - ultratec.com.pe
* Bajo Pena de Uso Indebido y/o/ Copias
* @copyright © 2017
*
*/

require_once $_SERVER["DOCUMENT_ROOT"]."/SysPlast/dao/cate_dao.php";

Class Cate_ctrl{
	public function get_cate_ctrl($dt){
		$cate_dao = new Cate_dao();
		$res = $cate_dao->get_cate_dao($dt);
		$fila=[];
		while ($rows = $res->fetch_row()) {
			$fila[] = $rows;
		}

		return $fila;
	}

	public function rows_cate_ctrl(){
		$cate_dao = new Cate_dao();
		$res=$cate_dao->rows_cate_dao();
		$fila=[];
		while ($rows = $res->fetch_row()) {
			$fila[] = $rows;
		}

		return $fila;
	}

	public function proc_cate_ctrl($data){
		$cate_dao = new Cate_dao();
		$res = $cate_dao->proc_cate_dao($data);
		return $res;
	}

	public function rest_cate_ctrl(){
		$cate_dao = new Cate_dao();
		$res=$cate_dao->rest_cate_dao();
		$fila=[];
		while ($rows = $res->fetch_row()) {
			$fila[] = $rows;
		}
		return $fila;
	}


}
?>