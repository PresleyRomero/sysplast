<?php 
require_once $_SERVER["DOCUMENT_ROOT"]."/SysPlast/info/link.php";

Class Prov_dao{
	private $db;

	public function __construct(){
		$this->db=Conectar::conexion();
	}

	public function get_prov_dao($dt){
		$qry = "CALL get_prov(".$dt.")";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function rows_prov_dao(){
		$qry = "CALL rows_prov()";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function rest_prov_dao(){
		$qry = "CALL rows_prov()";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function proc_prov_dao($arr){
		foreach ($arr as $key => $value) {
			$qry="CALL proc_prov('".implode("', '", $value)."')";
		}
		$res = $this->db->query($qry) or die($this->db->error);
		$key = $res->fetch_row()[0];
		$this->db->close();
		return $key;
	}

	public function look_prov_dao($dt){
		$Qry = "CALL sp_look_provee('".$dt."')";
		$res=$this->db->query($Qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}
}

?>