<?php 
require_once $_SERVER["DOCUMENT_ROOT"]."/SysPlast/info/link.php";

Class Procedimientos_dao{

	private $db;

	public function __construct()
	{
		$this->db=Conectar::conexion();
	}

	public function getConexion()
	{
		return $this->db;
	}

	/*Junior*/
	public function Reg_ccuotas_dao($idpago,$cuotas,$monto,$idv){
		$key=0;
		$Qry="INSERT INTO tb_compracuotas(idpago, n_cuotas, total, idv, estado) values ($idpago,$cuotas,$monto,$idv,0)";
		$res=$this->db->query($Qry) or die($this->db->error);
		$key=$this->db->insert_id;
		//$this->db->close();
		return $key;
	}

	/*Junior*/
	public function Reg_detalle_cuota_dao($idcuota,$cod,$fecha,$monto){
		$key=0;
		$Qry = "INSERT INTO tb_detalle_cuota(idccuota, fecha_pago, monto, codigounico, estado) VALUES ($idcuota,'$fecha', $monto, '$cod', 0)";
		$res=$this->db->query($Qry) or die($this->db->error);
		if($res){
			$key = $this->db->insert_id;
			return $key;
		}else{
			 return false;
		}
		//$this->db->close();
		
	}

	public function searchDataTable_dao($sql='')
	{
		return $this->db->query($sql);		
	}

	/*Junior*/
	public function Reg_inicio_caja_dao($fecha,$monto,$idv){

		$qry = "CALL sp_iniciar_caja(".$idv.",'".$fecha."', ".$monto.");";
		$res = $this->db->query($qry);
		if($res){
			$key = $res->fetch_row()[0];
			$this->db->close();
			return $key;
		}else{
			$this->db->close();
			//Mostrar errores
			//$error1 = $this->db->error;
			//die($this->db->error)
			return false;
		}
	}

	/*Junior*/
	public function get_caja_date(){
		$key=0;
		$qry = "SELECT fecha FROM caja_chica WHERE estado!=2;";
		$res = $this->db->query($qry);
		if($res){
			$key = $res->fetch_row();
			$this->db->close();
			return $key;
		}else{
			//Mostrar errores
			//$error1 = $this->db->error;
			//die($this->db->error);
			//$this->db->close();
			return true;
		}
		
	}

	public function get_venta_tipodoc($idv){
		$key=0;
		$qry = "SELECT * FROM tb_venta WHERE idventa=$idv;";
		$res = $this->db->query($qry);
		if($res){
			$key = $res->fetch_row();
			$res->close();
			//$this->db->close();
			return $key;
		}else{
			//Mostrar errores
			//$error1 = $this->db->error;
			//die($this->db->error);
			//$this->db->close();
			return false;
		}
		
	}

	// registrar pedido
	public function reg_pedido_proce_dao($arr)
	{
		foreach ($arr as $key => $value) {
			$Qry="CALL sp_reg_pedido('".implode("', '", $value)."');";
		}
		$res=$this->db->query($Qry) or die($this->db->error);
		$key=$res->fetch_row()[0];
		// Free result set
		$res->close();
		//$this->db->close();
		return $key;
	}
	//registrar detalle pedido
	public function reg_deta_pedido_proce_dao($arry)
	{
		foreach ($arry as $key => $value) {
			$Qry="CALL sp_reg_detapedido('".implode("', '", $value)."');";
			}
			$res=$this->db->query($Qry) or die($this->db->error);
			$key=$res->fetch_row()[0];
			$res->close();
			//$this->db->close();
			return $key;
	}

	public function listarPedidosPorVendedor($id)
	{
		// $Qry = "SELECT * from tb_pedido where idv=$id and est=1";
		$Qry="SELECT p.idpedido, p.fecha, c.nom, p.total
		from tb_pedido p
		inner join tb_cliente c on c.idc=p.idc
		where p.idv=".$id." and p.est=1 GROUP by p.idpedido";
		$res=$this->db->query($Qry) or die($this->db->error);
		
		// Free result set
		// $res->close();
		//$this->db->close();
		return $res;
	}

	public function getPedido($id)
	{
		$Qry="SELECT p.idpedido, p.idc, p.fecha, c.nom, p.total
		from tb_pedido p
		inner join tb_cliente c on c.idc=p.idc
		where p.idpedido=".$id." and p.est=1 GROUP by p.idpedido";
		$res=$this->db->query($Qry) or die($this->db->error);
		
		// Free result set
		// $res->close();
		//$this->db->close();
		return $res;
	}
	public function totales($id)
	{
		$Qry="SELECT p.idpedido, p.idc, p.fecha, c.nom, p.total
		from tb_pedido p inner join detalle_pedido d on p.idpedido=d.idpedido
		inner join tb_cliente c on c.idc=p.idc
		where p.idpedido=".$id." and p.est=1 GROUP by p.idpedido";
		$res=$this->db->query($Qry) or die($this->db->error);
		
		// Free result set
		// $res->close();
		//$this->db->close();
		return $res;
	}
	public function getDetallePedido($id)
	{
		$Qry="SELECT dp.iddpedido, dp.idct, dp.cant, ca.nom as nombreCategoria, 
		c.nom, dp.precio, dp.total, dp.costo  FROM detalle_pedido dp 
		inner JOIN tb_catalogo c on c.idct=dp.idct
        inner join tb_categ ca on ca.idg=c.idg
		where dp.idpedido=$id";
		$res=$this->db->query($Qry) or die($this->db->error);
		
		// Free result set
		// $res->close();
		//$this->db->close();
		return $res;
	}
	public function agregarCarritoPedido($idpedido, $idproducto, $cantidad, 
	$precio, $importe1, $importe2, $importe3, $importe4)
	{
		$Qry="insert into detalle_pedido(idpedido, idct, cant, precio, costo, subtotal, igv,total, est) 
		values($idpedido, $idproducto, $cantidad, $precio, $importe1, $importe2, $importe3, $importe4, 1)";
		$res=$this->db->query($Qry) or die($this->db->error);

		$qry1="update tb_pedido set total=total+$importe4 where idpedido=$idpedido;";
		$res=$this->db->query($qry1) or die($this->db->error);
		// Free result set
		// $res->close();
		//$this->db->close();
		return $res;
	}

	public function obtenerStockPedidoCarrito($idpedido, $idproducto)
	{
		$qry1="select sum(cant) as cantidad from detalle_pedido where idpedido=$idpedido and idct=$idproducto";
		$res=$this->db->query($qry1) or die($this->db->error);
		// Free result set
		// $res->close();
		//$this->db->close();
		return $res->fetch_array()['cantidad'];
	}
	public function eliminarCarritoPedido($id)
	{
		$Qry="CALL sp_eliminar_detalle_pedido_carrito(".$id.");";
		$res=$this->db->query($Qry) or die($this->db->error);
		
		// Free result set
		// $res->close();
		//$this->db->close();
		return $res;
	}
	public function eliminarPedido($id)
	{
		$Qry="CALL sp_eliminar_pedido_venta(".$id.");";
		$res=$this->db->query($Qry) or die($this->db->error);
		
		// Free result set
		// $res->close();
		//$this->db->close();
		return $res;
	}

	public function bajaPedido($id)
	{
		$Qry="update tb_pedido set est=2 where idpedido=$id";
		$res=$this->db->query($Qry) or die($this->db->error);
		
		// Free result set
		// $res->close();
		//$this->db->close();
		return $res;
	}

	//<!--Compra-->
	/*Junior*/
	public function get_xidcaja_date(){
		//$key=0;
		$Qry = "SELECT id FROM caja_chica WHERE estado!=2 limit 1;";
		$res=$this->db->query($Qry) or die($this->db->error);
		$key=$res->fetch_row()[0];
		// Free result set
		$res->close();
		//$this->db->close();
		return $key;
		
	}

	/* Registro Compra */
	public function reg_compra_proce_dao($arr){
		foreach ($arr as $key => $value) {
			$Qry="CALL sp_reg_compra('".implode("', '", $value)."');";
		}
		$res=$this->db->query($Qry) or die($this->db->error);
		$key=$res->fetch_row()[0];
		// Free result set
		$res->close();
		//$this->db->close();
		return $key;
	}

	/* Registro Detalle Compra */
	public function reg_deta_compra_proce_dao($arry){
		foreach ($arry as $key => $value) {
		$Qry="CALL sp_reg_detacompra('".implode("', '", $value)."');";
		}
		$res=$this->db->query($Qry) or die($this->db->error);
		$key=$res->fetch_row()[0];
		$res->close();
		//$this->db->close();
		return $key;
	}

	function Reg_Cata_proce_dao($array){
		foreach ($array as $key => $value) {
			$q="CALL sp_reg_catalogo('".implode("', '", $value)."');";
		}
		$res = $this->db->query($q) or die($this->db->error);
		$key = $res->fetch_row()[0];
		$res->close();
		//$this->db->close();
		return $key;
	}

	function Reg_pre_proce_dao($arr){
		$key=0;
		foreach ($arr as $key => $value) {
			$q="CALL sp_reg_precio('".implode("', '", $value)."');";
		}
		$res = $this->db->query($q) or die($this->db->error);
		if($res){
			$key = $res->fetch_row()[0];
			$res->close();
		}
		//$this->db->close();
		return $key;
	}

	public function Pay_compra_proce_dao($dta){
		foreach ($dta as $key => $value) {
			$Qry="CALL sp_reg_paycompra('".implode("', '", $value)."');";
		}
		$res=$this->db->query($Qry) or die($this->db->error);
		$key=$res->fetch_row()[0];
		$res->close();
		//$this->db->close();
		return $key;
	}

	public function mov_caja_dao($dta){
		foreach ($dta as $key => $value) {
			$Qry="CALL proc_mov_caja('".implode("', '", $value)."');";
		}
		$res=$this->db->query($Qry) or die($this->db->error);
		$key=$res->fetch_row()[0];
		$res->close();
		//$this->db->close();
		return $key;
	}

	//<!--Compra-->
	//
	//<!--Venta-->
	public function reg_venta_proce_dao($arr){
		foreach ($arr as $key => $value) {
			$Qry="CALL sp_reg_venta('".implode("', '", $value)."');";
		}
		$res=$this->db->query($Qry) or die($this->db->error);
		$key=$res->fetch_row()[0];
		$res->close();
		//$this->db->close();
		return $key;
	}

	public function reg_deta_venta_proce_dao($arry){
		foreach ($arry as $key => $value) {
		$Qry="CALL sp_reg_detaventa('".implode("', '", $value)."');";
		}
		$res=$this->db->query($Qry) or die($this->db->error);
		$key=$res->fetch_row()[0];
		$res->close();
		//$this->db->close();
		return $key;
	}
	public function validarStock($id)
	{
		$Qry="select ct_nuevo from tb_stock where idct=$id";
		$res=$this->db->query($Qry) or die($this->db->error);
		$key=$res->fetch_array()['ct_nuevo'];
		$res->close();
		//$this->db->close();
		return $key;
	}

	public function Pay_venta_proce_dao($dta){
		foreach ($dta as $key => $value) {
			$Qry="CALL sp_reg_payventa('".implode("', '", $value)."');";
		}
		$res=$this->db->query($Qry) or die($this->db->error);
		$key=$res->fetch_row()[0];
		$res->close();
		//$this->db->close();
		return $key;
	}
	//<!--fin venta-->

	public function get_egreso_caja_dao($dt){
		$qry = "CALL get_egreso_caja(".$dt.")";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function carga_caja_xdate_dao($dt,$dt2){
		$qry = "CALL carga_caja_xdate('".$dt."','".$dt2."')";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}
	//CAJA ACTUAL
	public function carga_caja_actual_dao(){
		$qry = "SELECT * FROM caja_chica WHERE estado=1 LIMIT 1;";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function carga_detallecaja_xidcaja_dao($dt){
		$qry = "CALL carga_detallecaja_xidcaja(".$dt.")";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function carga_detallecaja_xfecha_dao($ini,$fin){
		$qry = "CALL carga_detallecaja_xfecha('".$ini."','".$fin."')";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function cierre_caja_dao($fecha){
		$qry = "CALL sp_cierre_caja('".$fecha."')";
		$res = $this->db->query($qry) or die($this->db->error);
		$key=$res->fetch_row()[0];
		$this->db->close();
		return $key;
	}

	public function cierre_caja1_dao($fecha){
		$qry = "CALL sp_cierre_caja1('".$fecha."')";
		$res = $this->db->query($qry) or die($this->db->error);
		$key=$res->fetch_row()[0];
		$this->db->close();
		return $key;
	}

	public function Reg_compra_pay_proce_dao($arrs){
		foreach ($arrs as $key => $value) {
			$Qry="CALL sp_reg_buypay('".implode("', '", $value)."');";
		}
		$res=$this->db->query($Qry) or die($this->db->error);
		$key=$res->fetch_row()[0];
		$res->close();
		//$this->db->close();
		return $key;
	}

	public function get_cambiodolar_actual_proce_dao(){
		$qry = "CALL get_cambiodolar_curdate()";
		$res = $this->db->query($qry) or die($this->db->error);
		$key=$res->fetch_row()[0];
		$res->close();
		return $key;
	}

	public function update_nstock_pro_dao($idpro,$nstock){
		$key=0;
		$Qry="UPDATE tb_catalogo SET stk=$nstock, stk_min=1, opcdistri=2 where idct=$idpro;";
		$res=$this->db->query($Qry) or die($this->db->error);
		//$res->close();
		//$this->db->close();
		return $res;
	}

	public function add_stock_pro_dao($idpro,$nstock){
		$key=0;
		$qry = "CALL sp_stock_addcatalogo($idpro,$nstock)";
		$res=$this->db->query($qry) or die($this->db->error);
		//$key = $res->close();
		//$this->db->close();
		return $res;
	}

	public function disminuir_stock_pro_dao($idpro,$nstock){
		$key=0;
		$qry = "CALL sp_stock_discatalogo($idpro,$nstock)";
		$res=$this->db->query($qry) or die($this->db->error);
		//$key = $res->close();
		//$this->db->close();
		return $res;
	}

	/*Puntaje*/
	public function proc_cliente_proce_dao($arr){
		foreach ($arr as $key => $value) {
			$qry = "CALL proc_cliente('".implode("', '", $value)."');";
		}
		$res = $this->db->query($qry) or die($this->db->error);
		$key = $res->fetch_row()[0];
		$res->close();
		//$this->db->close();
		return $key;
	}

	public function registerPuntaje_proce_Dao($datos)
	{
		foreach ($datos as $key => $value) {
			$qry = "CALL sp_register_puntaje('".implode("', '", $value). "');";			
		}
		$res = $this->db->query($qry) or die($this->db->error);
		//$res->close();
		//$this->db->close();
		return $res;
	}
	/* fin de puntaje*/

	public function addPuntos_venta_proce_Dao($datos)
	{
		foreach ($datos as $key => $value) {
			$qry = "CALL sp_add_score_venta('".implode("', '", $value). "');";			
		}
		$res = $this->db->query($qry) or die($this->db->error);
		//$this->db->close();
		return $res;
	}

	//anulacion
	public function gets_compras_xanular($id)
	{
		$con = "CALL sp_compra_x_anular(".$id.")";
		$res = $this->db->query($con) or die ($this->db->error);
		
		return $res;
	}
	
	public function anulacompra_anula($id)
	{
		$con = "CALL sp_anulacompra_anula(".$id.")";
		$res = $this->db->query($con) or die ($this->db->error);
		
		return $res;
	}
	
	public function anularCompra($id)
	{
		$con = "CALL sp_anula_compra(".$id.")";
		$res = $this->db->query($con) or die ($this->db->error);
		
		return $res;
	}
	//anula venta 
	public function gets_ventas_xanular($id)
	{
		$con = "CALL sp_venta_x_anular(".$id.")";
		$res = $this->db->query($con) or die ($this->db->error);
		
		return $res;
	}
	
	public function returnstockventa_anula($dt1, $dt2)
	{
		$con = "CALL sp_returnstockventa_anula(".$dt1.", ".$dt2.")";
		$res = $this->db->query($con) or die ($this->db->error);
		return $res;
	}
	public function anulaventa_anula($id)
	{
		$con = "CALL sp_anulaventa_anula(".$id.")";
		$res = $this->db->query($con) or die ($this->db->error);
		
		return $res;
	}
	public function anula_cascadeventa($id)
	{
		$con = "CALL sp_anula_venta(".$id.")";
		$res = $this->db->query($con) or die ($this->db->error);
		
		return $res;
	}
}

?>