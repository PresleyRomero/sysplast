<?php 
require_once $_SERVER["DOCUMENT_ROOT"]."/SysPlast/info/link.php";

Class Puntaje_Dao{ 
	private $db;
 
	public function __construct(){
		$this->db=Conectar::conexion();
	}

	public function registerPuntaje_Dao($datos)
	{
		foreach ($datos as $key => $value) {
			$qry = "CALL sp_register_puntaje('".implode("', '", $value). "')";			
		}
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function searchCliente_Dao($search){
		$qry = "CALL sp_search_cliente('" . $search . "')";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function searchProducto_Dao($search)
	{
		$qry = "CALL sp_search_product('" . $search . "')";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}
	public function initPuntaje_Dao($datos)
	{
		foreach ($datos as $key => $value) {
			$qry = "CALL sp_init_puntaje('".implode("', '", $value). "')";			
		}
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function getPuntajesOfClientes_Dao()
	{
		$query="call sp_show_puntajes";
		$result = $this->db->query($query) or die($this->db->error);
		$this->db->close();
		return $result;
	}

	public function getPuntajesOfClientesXSearch_Dao($search)
	{
		$query="call sp_show_puntajes_filter('". $search ."')";
		$result = $this->db->query($query) or die($this->db->error);
		$this->db->close();
		return $result;	
	}
	public function addPuntos_Dao($datos)
	{
		foreach ($datos as $key => $value) {
			$qry = "CALL sp_add_score('".implode("', '", $value). "')";			
		}
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}
	public function showDetailScore_Dao($id)
	{
		$query="call sp_show_detail_score('". $id ."')";
		$result = $this->db->query($query) or die($this->db->error);
		$this->db->close();
		return $result;	
	}

	public function verificarPuntaje_Dao($id, $gastar)
	{
		$query="call sp_verificar_puntaje($id, '".$gastar."')";
		$result = $this->db->query($query) or die($this->db->error);
		$this->db->close();
		return $result;
	}

	public function disminuirPuntaje_Dao($id)
	{
		$query="select puntaje, id from detalle_puntaje where puntaje_id=$id and est=1 order by created_at desc";
		$result = $this->db->query($query) or die($this->db->error);
		$this->db->close();
		return $result;
	}
	public function darBajaPuntaje_Dao($id, $puntaje, $status)
	{
		$query="update detalle_puntaje set puntaje='".$puntaje."', est=$status where id=$id";
		$result = $this->db->query($query) or die($this->db->error);
		$this->db->close();
		return $result;	
	}

	public function nuevoPuntajes_Dao($id, $puntos, $opc)
	{
		$query="call sp_reestableciendo_puntaje($id, $puntos, $opc)";
		
		$result = $this->db->query($query) or die($this->db->error);
		$this->db->close();
		return $result;	
	}

	public function disminuirStockNuevo_Dao($id, $disminuir, $opc)
	{
		$query="call sp_disminuir_stock_nuevo($id, $disminuir, $opc)";		
		$result = $this->db->query($query) or die($this->db->error);
		$this->db->close();
		return $result;	
	}

	public function registerOferta_Dao($datos)
	{
		foreach ($datos as $value) {
			//$qry = "CALL sp_init_puntaje('".implode("', '", $value). "')";	
			$query = "call sp_register_oferta('". implode("','", $value) ."')";
		}
		$result = $this->db->query($query) or die($this->db->error);
		$this->db->close();
		return $result;	
	}
}
?>