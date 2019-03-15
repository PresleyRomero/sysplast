<?php 
/**
* Derechos Diseño y Programación - ultratec.com.pe.pe
* Bajo Pena de Uso Indebido y/o/ Copias
* @copyright © 2017
*
*/

require_once $_SERVER["DOCUMENT_ROOT"]."/SysPlast/dao/sale_dao.php";

Class Sale_ctrl{
	public function get_sale_ctrl($dt){
		$sale_dao = new Sale_dao();
		$res = $sale_dao->get_sale_dao($dt);
		$fila=[];
		while ($rows = $res->fetch_row()) {
			$fila[] = $rows;
		}
		return $fila;
	}

	public function rows_sale_ctrl(){
		$sale_dao = new Sale_dao();
		$res=$sale_dao->rows_sale_dao();
		$fila=[];
		while ($rows = $res->fetch_row()) {
			$fila[] = $rows;
		}
		return $fila;
	}

	public function proc_sale_ctrl($data){
		$sale_dao = new Sale_dao();
		$res = $sale_dao->proc_sale_dao($data);
		return $res;
	}

	public function getUsuariosVendedor()
	{
		$sale_dao = new Sale_dao();
		$res=$sale_dao->getUsuariosVendedor();
		$fila=[];
		while ($rows = $res->fetch_array()) {
			$fila[] = $rows;
		}
		return $fila;
	}
}
?>