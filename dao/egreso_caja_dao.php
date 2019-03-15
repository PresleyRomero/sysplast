<?php 
require_once $_SERVER["DOCUMENT_ROOT"]."/SysPlast/info/link.php";

Class Egreso_caja_dao{
	private $db;

	public function __construct(){
		$this->db=Conectar::conexion();
	}

	public function proc_egreso_caja_dao($arr){
		foreach ($arr as $key => $value) {
			$qry="CALL proc_mov_caja('".implode("', '", $value)."')";
		}
		$res = $this->db->query($qry) or die($this->db->error);
		$key = $res->fetch_row()[0];
		$this->db->close();
		return $key;
	}

	public function rows_egreso_caja_dao(){
		$qry = "CALL rows_egreso_caja()";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}


}

?>