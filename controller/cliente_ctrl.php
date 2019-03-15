<?php 
/**
* Derechos Diseño y Programación - ultratec.com.pe
* Bajo Pena de Uso Indebido y/o/ Copias
* @copyright © 2017
*
*/

require_once $_SERVER["DOCUMENT_ROOT"]."/SysPlast/dao/cliente_dao.php";

Class Cliente_ctrl{
	public function get_cliente_ctrl($dt) 
	{
		$cliente_dao = new Cliente_dao();
		$res = $cliente_dao->get_cliente_dao($dt);
		$fila=[];
		while($rows = $res->fetch_row()){
			$fila[] = $rows;
		}
		return $fila;
	}

	public function rows_cliente_ctrl(){
		$cliente_dao = new Cliente_dao();
		$res=$cliente_dao->rows_cliente_dao();
		$fila=[];
		while ($rows = $res->fetch_row()) {
			$fila[] = $rows;
		}
		return $fila;
	}

	public function rest_cliente_ctrl(){
		$tipo_dao = new Cliente_dao();
		$res=$tipo_dao->rest_cliente_dao();
		$fila=[];
		while ($rows = $res->fetch_row()) {
			$fila[] = $rows;
		}
		return $fila;
	}

	public function list_depart_ctrl(){
		$tipo_dao = new Cliente_dao();
		$res=$tipo_dao->list_depart_dao();
		$fila=[];
		while ($rows = $res->fetch_row()) {
			$fila[] = $rows;
		}

		return $fila;
	}

	public function proc_cliente_ctrl($arr){
		$cate_dao = new Cliente_dao();
		$res = $cate_dao->proc_cliente_dao($arr);
		return $res;
	}

	function look_cliente_ctrl($dt){
		$cata_dao=new Cliente_dao();
		$res=$cata_dao->look_cliente_dao($dt);
		$fila=[];
		while ($rows=$res->fetch_row()) {
			$fila[]=$rows;
		}
		return $fila;
	}
	public function look_puntaje_cliente_ctrl($dt){
		$cata_dao=new Cliente_dao();
		$res=$cata_dao->look_puntaje_cliente_dao($dt);
		$fila=[];
		while ($rows=$res->fetch_row()) {
			$fila[]=$rows;
		}
		return $fila;
	}
}
?>