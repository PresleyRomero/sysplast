<?php 
/**
* Derechos Diseño y Programación - ultratec.com.pe.pe
* Bajo Pena de Uso Indebido y/o/ Copias
* @copyright © 2017
*
*/

require $_SERVER["DOCUMENT_ROOT"]."/SysPlast/controller/index_ctrl.php";
session_start();

date_default_timezone_set("America/Lima");

if(!isset($_SESSION["MM_id"])){
	session_destroy();
	header("Location: ../index.php");
}else{
	$id = $_SESSION["MM_id"];
	if(isset($id) && is_numeric($id)){
		$verif = new Index_Ctrl();
		$log=$verif->Verifica_Ctrl($id);
		if(count($log) >= 1){
		   $user_id = $_SESSION["MM_id"];
	       $user_nom = $_SESSION["MM_nom"];
	       $user_alm = $_SESSION["MM_alm"];
	       $user_tip = $_SESSION["MM_tipo"];
	       /*if(isset($_SESSION["caja_estado"]) && is_numeric($_SESSION["caja_estado"])){
	       	$estado = $_SESSION["caja_estado"];
	       	if($estado==0){
	       		header("Location: ../gui/iniciar_caja.php");
	       	}
	       }*/
	    }else{
			session_destroy();
			header("Location: ../index.php");
		}
	}else{
		session_destroy();
		header("Location: ../index.php");
	}
}
?>