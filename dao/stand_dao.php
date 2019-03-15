<?php 
require_once $_SERVER["DOCUMENT_ROOT"]."/SysPlast/info/link.php";

Class Stand_dao{
	private $db;
	public function __construct(){
		$this->db=Conectar::conexion();
	}

	public function get_stand_dao($dt){
		$qry = "CALL get_stand(".$dt.")";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function rows_stand_dao(){
		$qry = "CALL rows_stand()";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function proc_stand_dao($data){
		foreach ($data as $key => $value) {
		$qry = "CALL proc_stand('".implode("', '", $value)."')";
		}
		$res = $this->db->query($qry) or die($this->db->error);
		$key = $res->fetch_row()[0];
		$this->db->close();
		return $key;
	}
	public function rest_stand_dao(){
		$qry = "CALL rest_stand()";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}
}

?>