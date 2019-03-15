<?php 
require_once $_SERVER["DOCUMENT_ROOT"]."/SysPlast/info/link.php";

Class Marca_dao{
	private $db;

	public function __construct(){
		$this->db=Conectar::conexion();
	}

	public function get_marca_dao($dt){
		$qry = "CALL get_marca(".$dt.")";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function rows_marca_dao(){
		$qry = "CALL rows_marca()";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function proc_marca_dao($data){
		foreach ($data as $key => $value) {
		$qry = "CALL proc_marca('".implode("', '", $value)."')";
		}
		$res = $this->db->query($qry) or die($this->db->error);
		$key = $res->fetch_row()[0];
		$this->db->close();
		return $key;
	}
	public function rest_marca_dao(){
		$qry = "CALL rest_marca()";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}
}

?>