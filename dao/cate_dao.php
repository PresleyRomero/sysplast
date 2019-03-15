<?php 
require_once $_SERVER["DOCUMENT_ROOT"]."/SysPlast/info/link.php";

Class Cate_dao{
	private $db;

	public function __construct(){
		$this->db=Conectar::conexion();
	}

	public function get_cate_dao($dt){
		$qry = "CALL get_cate(".$dt.")";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function rows_cate_dao(){
		$qry = "CALL rows_cate()";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}
 
	public function proc_cate_dao($data){
		foreach ($data as $key => $value) {
		$qry = "CALL proc_cate('".implode("', '", $value)."')";
		}
		$res = $this->db->query($qry) or die($this->db->error);
		$key = $res->fetch_row()[0];
		$this->db->close();
		return $key;
	}
	public function rest_cate_dao(){
		$qry = "CALL rest_cate()";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}
}

?>