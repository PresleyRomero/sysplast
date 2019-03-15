 <?php 
/**
* Derechos Diseño y Programación - ultratec.com.pe
* Bajo Pena de Uso Indebido y/o/ Copias
* @copyright © 2017
* 
*/

require_once $_SERVER["DOCUMENT_ROOT"]."/SysPlast/dao/puntaje_dao.php";

Class Puntaje_Ctrl{
	public function searchCliente_Ctrl($search){
		$pc = new Puntaje_Dao();
		$res = $pc->searchCliente_Dao($search);
		$fila=[];
		while ($rows = $res->fetch_row()) {
			$fila[] = $rows;
		}
		return $fila;
	}

	public function registerPuntaje_Ctrl($datos)
	{
		$pc= new Puntaje_Dao();
		$res = $pc->registerPuntaje_Dao($datos);
		return $res;
	}

	public function searchProducto_Ctrl($search)
	{
		$pc = new Puntaje_Dao();
		$res = $pc->searchProducto_Dao($search);
		$fila=[];
		while ($rows = $res->fetch_row()) {
			$fila[] = $rows;
		}
		return $fila;
	}

	public function initPuntaje_Ctrl($datos)
	{
		$pc= new Puntaje_Dao();
		$res = $pc->initPuntaje_Dao($datos);
		return $res;
	}
	public function getPuntajesOfClientes_Ctrl()
	{
		$data= array();
		$pc= new Puntaje_Dao();
		$res = $pc->getPuntajesOfClientes_Dao();
		while($row= $res->fetch_row()){
			$data[]=$row;
		}
		return $data;
	}

	public function getPuntajesOfClientesXSearch_Ctrl($search)
	{
		$data=array();
		$pc= new Puntaje_Dao();
		$res = $pc->getPuntajesOfClientesXSearch_Dao($search);
		while($row= $res->fetch_row()){
			$data[]=$row;
		}
		return $data;
	}

	public function addPuntos_Ctrl($datos)
	{
		$pc= new Puntaje_Dao();
		$res = $pc->addPuntos_Dao($datos);
		return $res;
	}
	public function showDetailScore_Ctrl($id)
	{
		$data=array();
		$pc= new Puntaje_Dao();
		$res = $pc->showDetailScore_Dao($id);
		while($row= $res->fetch_row()){
			$data[]=$row;
		}
		return $data;
	}

	public function verificarPuntaje_Ctrl($id, $gastar)
	{
		$pc= new Puntaje_Dao();
		$res = $pc->verificarPuntaje_Dao($id, $gastar);
		return $res->fetch_row()[0];
	}

	public function disminuirPuntaje_Ctrl($id)
	{
		$pc= new Puntaje_Dao();
		$res = $pc->disminuirPuntaje_Dao($id);
		while($row= $res->fetch_row()){
			$data[]=$row;
		}
		return $data;
	}

	public function darBajaPuntaje_Ctrl($id, $puntaje, $status)
	{
		$pc= new Puntaje_Dao();
		$res = $pc->darBajaPuntaje_Dao($id, $puntaje, $status);
		return $res;
	}

	public function nuevoPuntajes_Ctrl($id, $puntos, $opc)
	{
		$pc= new Puntaje_Dao();
		$res = $pc->nuevoPuntajes_Dao($id, $puntos, $opc);
		return $res;
	}

	public function disminuirStockNuevo_Ctrl($id, $disminuir, $opc)
	{
		$pc= new Puntaje_Dao();
		$res = $pc->disminuirStockNuevo_Dao($id,  $disminuir, $opc);
		return $res;
	}

	public function registerOferta_Ctrl($datos)
	{
		$pc= new Puntaje_Dao();
		$res = $pc->registerOferta_Dao($datos);
		return $res;
	}

}
?>