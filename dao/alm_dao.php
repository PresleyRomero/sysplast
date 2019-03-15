<?php 
require_once $_SERVER["DOCUMENT_ROOT"]."/SysPlast/info/link.php";

Class Alm_dao{ 
	private $db;
 
	public function __construct(){
		$this->db=Conectar::conexion();
	}

	public function get_alm_dao($dt){
		$qry = "CALL get_alm(".$dt.")";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function rows_alm_dao(){
		$qry = "CALL rows_alm()";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}
 
	public function rest_alm_dao(){
		$qry = "CALL sp_rest_alm()";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function get_rest_alm_dao($id){
		$qry = "CALL sp_getrest_alm(".$id.")";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function proc_alm_dao($arr){
		foreach ($arr as $key => $value) {
			$qry = "CALL proc_alm('".implode("', '", $value)."')";
		}
		$res = $this->db->query($qry) or die($this->db->error);
		$key = $res->fetch_row()[0];
		$this->db->close();
		return $key;
	}

	public function stock_alm_Dao($ids){
		$Qry="SELECT tbp.* FROM tb_producto_stock tbp WHERE tbp.ida=$ids";
		$res = $this->db->query($Qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}
}
?>