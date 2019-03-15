<?php 
/**
* Derechos Diseño y Programación - ultratec.com.pe
* Bajo Pena de Uso Indebido y/o/ Copias
* @copyright © 2017
*
*/

require_once $_SERVER["DOCUMENT_ROOT"]."/SysPlast/dao/prov_dao.php";

Class Prov_ctrl{
	public function get_prov_ctrl($dt){
		$prov_dao = new Prov_dao();
		$res = $prov_dao->get_prov_dao($dt);
		$fila=[];
		while($rows = $res->fetch_row()){
			$fila[] = $rows;
		}
		return $fila;
	}

	public function rows_prov_ctrl(){
		$prov_dao = new Prov_dao();
		$res=$prov_dao->rows_prov_dao();
		$fila=[];
		while ($rows = $res->fetch_row()) {
			$fila[] = $rows;
		}

		return $fila;
	}

	public function rest_prov_ctrl(){
		$prov_dao = new Prov_dao();
		$res=$prov_dao->rest_prov_dao();
		$fila=[];
		while ($rows = $res->fetch_row()) {
			$fila[] = $rows;
		}

		return $fila;
	}

	public function proc_prov_ctrl($arr){
		$prov_dao = new Prov_dao();
		$res = $prov_dao->proc_prov_dao($arr);
		return $res;
	}

	public function look_prov_ctrl($dt){
		$prov_dao = new Prov_dao();
		$res=$prov_dao->look_prov_dao($dt);
		$fila=[];
		while ($rows=$res->fetch_row()) {
			$fila[]=$rows;
		}
		return $fila;
	}
}
?>