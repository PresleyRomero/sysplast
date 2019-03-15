<?php 
/**
* Derechos Diseño y Programación - ultratec.com.pe.pe
* Bajo Pena de Uso Indebido y/o/ Copias
* @copyright © 2017
*
*/

require_once $_SERVER["DOCUMENT_ROOT"]."/SysPlast/info/link.php";

Class Tiposd_dao{
	private $db;

	public function __construct(){
		$this->db=Conectar::conexion();
	}

	public function get_tiposd_dao($dt){
		$qry = "CALL get_tiposd(".$dt.")";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function rows_tiposd_dao(){
		$qry = "CALL rows_tiposd()";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function rest_tiposd_dao(){
		$qry = "CALL rest_tiposd()";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}
}

?>