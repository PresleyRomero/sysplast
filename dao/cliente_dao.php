<?php 
require_once $_SERVER["DOCUMENT_ROOT"]."/SysPlast/info/link.php";

Class Cliente_dao{
	private $db;

	public function __construct(){
		$this->db=Conectar::conexion();
	}

	public function get_cliente_dao($dt){
		$qry = "CALL get_cliente(".$dt.")";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function rows_cliente_dao(){
		$qry = "CALL rows_cliente()";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function rest_cliente_dao(){
		$qry = "CALL rest_cliente()";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function list_depart_dao(){
		$qry = "CALL sp_gets_depart()";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function proc_cliente_dao($arr){
		foreach ($arr as $key => $value) {
			$qry = "CALL proc_cliente('".implode("', '", $value)."')";
		}
		$res = $this->db->query($qry) or die($this->db->error);
		$key = $res->fetch_row()[0];
		$this->db->close();
		return $key;
	}

	public function look_cliente_dao($dt){
		$Qry = "CALL sp_look_cliente('".$dt."')";
		$res=$this->db->query($Qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function look_puntaje_cliente_dao($dt){
		$Qry = "CALL sp_look_puntaje_cliente('".$dt."')";
		$res=$this->db->query($Qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}
}

?>