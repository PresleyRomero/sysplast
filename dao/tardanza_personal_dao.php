<?php 
require_once $_SERVER["DOCUMENT_ROOT"]."/SysPlast/info/link.php";

Class Tardanza_personal_dao{
	private $db;

	public function __construct(){
		$this->db=Conectar::conexion();
	}

	public function proc_tardanza_personal_dao($arr){
		foreach ($arr as $key => $value) {
			$qry="CALL proc_tardanza_personal('".implode("', '", $value)."')";
		}
		$res = $this->db->query($qry) or die($this->db->error);
		$key = $res->fetch_row()[0];
		$this->db->close();
		return $key;
	}

	public function rows_tardanza_personal_dao(){
		$qry = "CALL rows_tardanza_personal()";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function rows_tardanza_liquidados_personal_dao(){
		$qry = "CALL rows_tardanza_liquidados_personal()";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function get_tardanza_personal_dao($dt){
		$qry = "CALL get_tardanza_personal(".$dt.")";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function calcular_tardanzaxpersonal_dao($ini,$fin,$id){
		$qry = "CALL sp_calcular_tardanzaxpersonal('".$ini."','".$fin."', ".$id.")";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function monto_tardanzaxpersonal_dao($ini, $fin, $id){
		$con = "CALL sp_monto_tardanzaxpersonal('".$ini."','".$fin."', ".$id.")";
		$res = $this->db->query($con) or die ($this->db->error);
		$this->db->close();
		return $res;
	}
}

?>