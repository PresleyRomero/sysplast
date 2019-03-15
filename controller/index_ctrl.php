<?php 
/**
* Derechos Diseño y Programación - ultratec.com.pe
* Bajo Pena de Uso Indebido y/o/ Copias
* @copyright © 2017
*
*/

require_once $_SERVER["DOCUMENT_ROOT"]."/SysPlast/dao/index_dao.php";

Class Index_ctrl{
	public function Login_Ctrl(){
		$user = $_POST["txtUser"];
		$pass = $_POST["txtClave"];

		$index_dao = new Index_Dao();
		$con = $index_dao->Login_Dao($user, $pass);
		$res = $con->fetch_row();
		return $res;
	}

	public function Verifica_Ctrl($id){
		$index_dao = new Index_Dao();
		$con = $index_dao->Verifica_Dao($id);
		$res = $con->fetch_row();
		return $res;
	}
}

?>