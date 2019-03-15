<?php 
/**
* Derechos Diseño y Programación - ultratec.com.pe.pe
* Bajo Pena de Uso Indebido y/o/ Copias
* @copyright © 2017
*
*/

session_start();

unset($_SESSION["MM_id"]);
unset($_SESSION["MM_nom"]);
unset($_SESSION["MM_alm"]);
unset($_SESSION["MM_tipo"]);

if(session_destroy())
{
	header("Location: ../index.php");
}

?>