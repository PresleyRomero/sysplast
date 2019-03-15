<?php 
require_once $_SERVER["DOCUMENT_ROOT"]."/SysPlast/model/function.php";
Class Conectar{
	static function conexion(){
		$dbhost='localhost';
		$dbuser='root';
		$dbpass='';
		$db='db_plast';

		$conex=new mysqli($dbhost, $dbuser, $dbpass, $db) or die(mysqli_errno());
		$conex->query("SET NAMES 'utf8'");
		if(mysqli_connect_errno()){
			printf("Error Conexion BD:<br>%s\n", mysqli_connect_error());
			exit();
		}
		return $conex;
	}
}
?>