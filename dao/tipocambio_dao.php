<?php 
require_once $_SERVER["DOCUMENT_ROOT"]."/SysPlast/info/link.php";

Class Tipocambio_dao{
	private $db;

	public function __construct(){
		$this->db=Conectar::conexion();
	}

	public function proc_tipocambio_dao($arr){
		foreach ($arr as $key => $value) {
			$qry="CALL proc_tipocambio('".implode("', '", $value)."')";
		}
		$res = $this->db->query($qry);
		if($res){
			$key = $res->fetch_row()[0];
			$this->db->close();
			return $key;
		}else{
			//$this->db->error;
			$this->db->close();
			return false;
		}
	}

	public function rows_tipocambio_dao(){
		$qry = "CALL rows_tipo_cambio()";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function get_tipocambio_dao($dt){
		$qry = "CALL get_tipo_cambio(".$dt.")";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function get_cambiodolar_actual_dao(){
		$qry = "CALL get_cambiodolar_curdate()";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

}

?>