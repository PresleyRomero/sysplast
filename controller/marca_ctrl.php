<?php 
/**
* Derechos Diseño y Programación - ultratec.com.pe.pe
* Bajo Pena de Uso Indebido y/o/ Copias
* @copyright © 2017
*
*/

require_once $_SERVER["DOCUMENT_ROOT"]."/SysPlast/dao/marca_dao.php";

Class Marca_ctrl{
	public function get_marca_ctrl($dt){
		$marca_dao = new Marca_dao();
		$res = $marca_dao->get_marca_dao($dt);
		$fila=[];
		while ($rows = $res->fetch_row()) {
			$fila[] = $rows;
		}

		return $fila;
	}

	public function rows_marca_ctrl(){
		$marca_dao = new Marca_dao();
		$res=$marca_dao->rows_marca_dao();
		$fila=[];
		while ($rows = $res->fetch_row()) {
			$fila[] = $rows;
		}

		return $fila;
	}

	public function proc_marca_ctrl($data){
		$marca_dao = new Marca_dao();
		$res = $marca_dao->proc_marca_dao($data);
		return $res;
	}
	public function rest_marca_ctrl(){
		$marca_dao = new Marca_dao();
		$res=$marca_dao->rest_marca_dao();
		$fila=[];
		while ($rows = $res->fetch_row()) {
			$fila[] = $rows;
		}
		return $fila;
	}
}
?>