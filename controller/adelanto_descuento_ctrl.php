<?php 
/**
* Derechos Diseño y Programación - ultratec.com.pe
* Bajo Pena de Uso Indebido y/o/ Copias
* @copyright © 2017
*
*/

require_once $_SERVER["DOCUMENT_ROOT"]."/SysPlast/dao/adelanto_descu_dao.php";

Class Adelanto_descuento_ctrl{

	public function get_adelanto_descu_ctrl($dt){
		$descuento_dao = new Adelanto_descu_dao();
		$res = $descuento_dao->get_descuento_adelanto_dao($dt);
		$fila=[];
		while($rows = $res->fetch_row()){
			$fila[] = $rows;
		}
		return $fila;
	}

	public function proc_adelanto_descuento_ctrl($arr){
		$descuento_dao = new Adelanto_descu_dao();
		$res = $descuento_dao->proc_adelanto_descuento_dao($arr);
		return $res;
	}

	public function rows_descuento_adela_ctrl(){
		$descuento_dao = new Adelanto_descu_dao();
		$res=$descuento_dao->rows_descuento_adela_dao();
		$fila=[];
		while ($rows = $res->fetch_row()) {
			$fila[] = $rows;
		}

		return $fila;
	}


	public function rows_descuento_adela_liquidados_ctrl(){
		$descuento_dao = new Adelanto_descu_dao();
		$res=$descuento_dao->rows_descuento_adela_liquidados_dao();
		$fila=[];
		while ($rows = $res->fetch_row()) {
			$fila[] = $rows;
		}

		return $fila;
	}

	public function calcular_descuentoxpersonal_ctrl($ini,$fin,$id){
		$descuento_dao = new Adelanto_descu_dao();
		$res = $descuento_dao->calcular_descuentoxpersonal_dao($ini,$fin,$id);
		$fila=[];
		while($rows = $res->fetch_row()){
			$fila[] = $rows;
		}
		return $fila;
	}

	public function descuento_caja_ctrl($ini,$fin,$ids){
		$descuento_dao = new Adelanto_descu_dao();
		$res = $descuento_dao->adelantos_caja_dao($ini,$fin,$ids);
		$fila=[];
		while($rows = $res->fetch_row()){
			$fila[] = $rows;
		}
		return $fila;
	}

	public function monto_descuentoxpersonal_ctrl($ini, $fin, $id){
		$descuento_dao = new Adelanto_descu_dao();
		$res = $descuento_dao->monto_descuentoxpersonal_dao($ini, $fin, $id);
		$fila = $res->fetch_row();
		return $fila;
	}


	public function monto_caja_descuento_ctrl($ini, $fin, $id){
		$descuento_dao = new Adelanto_descu_dao();
		$res = $descuento_dao->monto_caja_descuento_dao($ini, $fin, $id);
		$fila = $res->fetch_row();
		return $fila;
	}

	public function liquidar_descuento_tardanzaxpersonal_ctrl($ini, $fin, $id){
		$descuento_dao = new Adelanto_descu_dao();
		$res = $descuento_dao->liquidar_descuento_tardanzaxpersonal_dao($ini, $fin, $id);
		return $res;
	}

}
?>