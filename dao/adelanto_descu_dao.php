<?php 
require_once $_SERVER["DOCUMENT_ROOT"]."/SysPlast/info/link.php";

Class Adelanto_descu_dao{
	private $db;

	public function __construct(){
		$this->db=Conectar::conexion();
	}

	public function proc_adelanto_descuento_dao($arr){
		foreach ($arr as $key => $value) {
			$qry="CALL proc_adelanto_descuento('".implode("', '", $value)."')";
		}
		$res = $this->db->query($qry) or die($this->db->error);
		$key = $res->fetch_row()[0];
		$this->db->close();
		return $key;
	}

	public function rows_descuento_adela_dao(){
		$qry = "CALL rows_descuento_adela()";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function rows_descuento_adela_liquidados_dao(){
		$qry = "CALL rows_descuento_adela_liquidados()";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function get_descuento_adelanto_dao($dt){
		$qry = "CALL get_descuento_adelanto(".$dt.")";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function calcular_descuentoxpersonal_dao($ini,$fin,$id){
		$qry = "CALL sp_calcular_descuentoxpersonal('".$ini."','".$fin."', ".$id.")";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}


	public function adelantos_caja_dao($ini,$fin,$ids){
		$qry = "CALL sp_adelantos_caja('".$ini."','".$fin."', ".$ids.")";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function monto_caja_descuento_dao($ini, $fin, $id){
		$con = "CALL sp_monto_adelantos_caja('".$ini."','".$fin."', ".$id.")";
		$res = $this->db->query($con) or die ($this->db->error);
		$this->db->close();
		return $res;
	}

	public function monto_descuentoxpersonal_dao($ini, $fin, $id){
		$con = "CALL sp_monto_descuentoxpersonal('".$ini."','".$fin."', ".$id.")";
		$res = $this->db->query($con) or die ($this->db->error);
		$this->db->close();
		return $res;
	}

	public function liquidar_descuento_tardanzaxpersonal_dao($ini,$fin,$id){
		$qry = "CALL sp_liquidar_descuentoxpersonal('".$ini."','".$fin."', ".$id.");";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}
}

?>