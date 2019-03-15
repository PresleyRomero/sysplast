<?php 
/**
* Derechos Diseño y Programación - ultratec.com.pe.pe
* Bajo Pena de Uso Indebido y/o/ Copias
* @copyright © 2017
*
*/


//session_start();

date_default_timezone_set("America/Lima");

if(isset($_SESSION["caja_estado"]) && is_numeric($_SESSION["caja_estado"])){
	$estado = $_SESSION["caja_estado"];
	if($estado==0){
		header("Location: ../gui/iniciar_caja.php");
	}
}

?>