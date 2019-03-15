<?php 
require_once $_SERVER["DOCUMENT_ROOT"]."/SysPlast/dao/stand_dao.php";

Class Stand_ctrl
{
	public function get_stand_ctrl($dt){
		$stand_dao = new Stand_dao();
		$res = $stand_dao->get_stand_dao($dt);
		$fila=[];
		while ($rows = $res->fetch_row()) {
			$fila[] = $rows;
		}

		return $fila;
	}

	public function rows_stand_ctrl(){
		$stand_dao = new Stand_dao();
		$res=$stand_dao->rows_stand_dao();
		$fila=[];
		while ($rows = $res->fetch_row()) {
			$fila[] = $rows;
		}

		return $fila;
	}

	public function proc_stand_ctrl($data){
		$stand_dao = new Stand_dao();
		$res = $stand_dao->proc_stand_dao($data);
		return $res;
	}

	public function rest_stand_ctrl(){
		$stand_dao = new Stand_dao();
		$res=$stand_dao->rest_stand_dao();
		$fila=[];
		while ($rows = $res->fetch_row()) {
			$fila[] = $rows;
		}
		return $fila;
	}
}
?>