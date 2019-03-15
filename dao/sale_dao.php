<?php 
require_once $_SERVER["DOCUMENT_ROOT"]."/SysPlast/info/link.php";

Class Sale_dao{
	private $db;

	public function __construct(){
		$this->db=Conectar::conexion();
	}

	public function get_sale_dao($dt){
		$qry = "CALL get_sale(".$dt.")";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function rows_sale_dao(){
		$qry = "CALL rows_sale()";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function proc_sale_dao($data){
		foreach ($data as $key => $value) {
		$qry = "CALL proc_sale('".implode("', '", $value)."')";
		}
		$res = $this->db->query($qry) or die($this->db->error);
		$key = $res->fetch_row()[0];
		$this->db->close();
		return $key;
	}
	public function getUsuariosVendedor()
	{
		$qry = "select * from tb_sale where idti=2";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}
}

?>