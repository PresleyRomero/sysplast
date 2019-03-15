<?php 
require_once $_SERVER["DOCUMENT_ROOT"]."/SysPlast/info/link.php";

Class Personal_dao{
	private $db;

	public function __construct(){
		$this->db=Conectar::conexion();
	}

	public function proc_personal_dao($arr){
		foreach ($arr as $key => $value) {
			$qry="CALL proc_personal('".implode("', '", $value)."')";
		}
		$res = $this->db->query($qry) or die($this->db->error);
		$key = $res->fetch_row()[0];
		$this->db->close();
		return $key;
	}

	public function rows_personal_dao(){
		$qry = "CALL rows_personal()";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function get_personal_dao($dt){
		$qry = "CALL get_personal(".$dt.")";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function get_personalxnombredni_dao($dt){
		$qry = "CALL get_personalxnom_dni('".$dt."')";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}
}

?>