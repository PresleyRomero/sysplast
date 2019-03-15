<?php 
/**
* Derechos Diseño y Programación - ultratec.com.pe
* Bajo Pena de Uso Indebido y/o/ Copias
* @copyright © 2017
*
*/

require_once $_SERVER["DOCUMENT_ROOT"]."/SysPlast/info/link.php";

Class Index_dao{
	private $db;

	public function __construct(){
		$this->db=Conectar::conexion();
	}

	public function Login_Dao($user, $pass){
		// $query="CALL sp_login('".$user."','".$pass."')";
		$query="SELECT s.idv, s.nom, s.ida, s.usuario, s.clave AS clave, t.idti, s.est
		FROM tb_sale s
		INNER JOIN tb_tip t ON t.idti=s.idti where usuario='".$user."' and clave='".$pass."'";
		$res = $this->db->query($query) or die($this->db->error);
		return $res;
	}

	public function Verifica_Dao($id){
		$cod = $this->db->real_escape_string($id);
		$query="CALL sp_verifica('".$cod."')";
		$res = $this->db->query($query) or die($this->db->error);
		return $res;
	}
}

?>