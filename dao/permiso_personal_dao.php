<?php 
require_once $_SERVER["DOCUMENT_ROOT"]."/SysPlast/info/link.php";

Class Permiso_personal_dao{
	private $db;

	public function __construct(){
		$this->db=Conectar::conexion();
	}

	public function proc_permiso_personal_dao($arr){
		foreach ($arr as $key => $value) {
			$qry="CALL proc_permiso_personal('".implode("', '", $value)."')";
		}
		$res = $this->db->query($qry) or die($this->db->error);
		$key = $res->fetch_row()[0];
		$this->db->close();
		return $key;
	}

	public function rows_permiso_personal_dao(){
		$qry = "CALL rows_permiso_personal()";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function get_permiso_personal_dao($dt){
		$qry = "CALL get_permiso_personal(".$dt.")";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}
}

?>