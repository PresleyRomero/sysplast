<?php 
/**
* Derechos Diseño y Programación - ultratec.com.pe
* Bajo Pena de Uso Indebido y/o/ Copias
* @copyright © 2017
*
*/

require_once $_SERVER["DOCUMENT_ROOT"]."/SysPlast/dao/tipo_dao.php";

Class Tipo_ctrl{
	public function get_tipo_ctrl($dt){
		$tipo_dao = new Tipo_dao();
		$res = $tipo_dao->get_tipo_dao($dt);
		$fila=[];
		while ($rows = $res->fetch_row()) {
			$fila[] = $rows;
		}
 
		return $fila;
	}
	public function proc_tipo_ctrl($data){
		$tipo_dao = new Tipo_dao();
		$res = $tipo_dao->proc_tipo_dao($data);
		return $res;
	}

	public function rows_tipo_ctrl(){
		$tipo_dao = new Tipo_dao();
		$res=$tipo_dao->rows_tipo_dao();
		$fila=[];
		while ($rows = $res->fetch_row()) {
			$fila[] = $rows;
		}

		return $fila;
	}

	public function rest_tipo_ctrl(){
		$tipo_dao = new Tipo_dao();
		$res=$tipo_dao->rest_tipo_dao();
		$fila=[];
		while ($rows = $res->fetch_row()) {
			$fila[] = $rows;
		}

		return $fila;
	}

	//para restricciones
	public function proc_restricciones_ctrl($data){
		$tipo_dao = new Tipo_dao();
		$res = $tipo_dao->proc_restricciones_dao($data);
		return $res;
	}
	
	public function proc_subrestricciones_ctrl($arr){
		$tipo_dao = new Tipo_dao();
		$res = $tipo_dao->proc_subrestricciones_dao($arr);
		return $res;
	}

	public function Show_restriccion_ctrl($key){
		$tipo_dao = new Tipo_dao();
		$res=$tipo_dao->Show_restriccion_Dao($key);
		$fila=[];
		while($rows=$res->fetch_row()){
			$fila[] = $rows;
		}
		return $fila;
	}

	public function Show_subrestriccion_ctrl($key, $dt){
		$tipo_dao = new Tipo_dao();
		$res=$tipo_dao->Show_subrestriccion_Dao($key, $dt);
		$fila=[];
		while($rows=$res->fetch_row()){
			$fila[] = $rows;
		}
		return $fila;
	}
}

?>