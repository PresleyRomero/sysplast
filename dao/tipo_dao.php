<?php 
require_once $_SERVER["DOCUMENT_ROOT"]."/SysPlast/info/link.php";

Class Tipo_dao{
	private $db;
	public function __construct(){
		$this->db=Conectar::conexion();
	}
	public function proc_tipo_dao($data){
		foreach ($data as $key => $value) {
		$qry = "CALL sp_tipo_usu('".implode("', '", $value)."')";
		}
		$res = $this->db->query($qry) or die($this->db->error);
		$key = $res->fetch_row()[0];
		$this->db->close();
		return $key;
	}

	public function get_tipo_dao($dt){
		$qry = "CALL get_tipo(".$dt.")";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function rows_tipo_dao(){
		$qry = "CALL rows_tipo()";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function rest_tipo_dao(){
		$qry = "CALL rest_tipo()";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	//Restricciones
	public function proc_restricciones_dao($data){
		foreach ($data as $key => $value) {
		$qry = "CALL sp_restricciones('".implode("', '", $value)."')";
		}
		$res = $this->db->query($qry) or die($this->db->error);
		$key = $res->fetch_row()[0];
		$this->db->close();
		return $key;
	}

	public function proc_subrestricciones_dao($arr){
		foreach ($arr as $key =>$value){
		$qry=$this->db->query("CALL sp_subrestricciones('".implode("', '", $value)."')") or die($this->db->error);
		}
		$this->db->close();
		return $qry;
	}

	public function Show_restriccion_Dao($key){
		$Qrys="CALL sp_show_restric(".$key.")";
		$res=$this->db->query($Qrys) or die ($this->db->error);
		return $res;
	}

	public function Show_subrestriccion_Dao($key, $dt){
		$Qrys="CALL sp_show_subrestric(".$key.",'".$dt."')";
		$res=$this->db->query($Qrys) or die ($this->db->error);
		return $res;
	}
}
?>