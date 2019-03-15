<?php 
require_once $_SERVER["DOCUMENT_ROOT"]."/SysPlast/info/link.php";

Class Catalogo_Dao{
	private $db;

	public function __construct(){
		$this->db=Conectar::conexion();
	}
	/* CJBM */
	public function searchProductosRotos_Dao($search)
	{
		$Qry = "SELECT * from tb_producto_stock s 
				WHERE CONCAT(s.nomtc, ' ',s.nom, ' ', s.nomtm) like CONCAT('%','$search','%');";
        $res = $this->db->query($Qry) or die($this->db->error);
        $this->db->close();
        return $res;
	}
    public function updateStockDistribuido_dao($array) {
        foreach ($array as $key => $value) {
            $Qry="CALL sp_stock_update('".implode("', '", $value)."')";
        }
        $res=$this->db->query($Qry) or die($this->db->error);
        $key=$res->fetch_row()[0];
        $this->db->close();
        return $key;
    }
    public function getStockDistribuido_dao($idCompra) {
        $Qry = "select ca.nom, ca.unid, dc.cant, ca.idct, dc.iddcompra,
                s.ct_nuevo, s.ct_averiado, s.ct_roto
                from tb_compra co
                inner join detalle_compra dc on co.idcompra=dc.idcompra
                inner join tb_catalogo ca on dc.idct=ca.idct
                inner join tb_stock s on s.iddcompra=dc.iddcompra
                where co.idcompra=$idCompra";
        $res = $this->db->query($Qry) or die($this->db->error);
        $this->db->close();
        return $res;
    }
	public function checkStockParaModificar_dao($idCompra){
		// $Qry = "select count(s.id_stock) as checkStock from 
		// 		tb_compra c inner join detalle_compra dt 
		// 		on c.idcompra=dt.idcompra
		// 		inner join tb_stock s 
		// 		on dt.iddcompra=s.iddcompra
		// 		where c.idcompra=$idCompra";
		$Qry = "select * from tb_compra c 
				inner join detalle_compra dt on c.idcompra=dt.idcompra
				where c.idcompra=$idCompra";
		$res = $this->db->query($Qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}
	/* CJBM */
	function rows_catalogo_dao(){
		$Qry="SELECT * FROM tb_productos LIMIT 40";
		$res=$this->db->query($Qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	function sumar_stock_xcatalogo_dao($id){
		$Qry=$this->db->query("CALL sp_sumar_stock_xidcata(".$id.", @sums)") or die ($this->db->error);
		$key=$this->db->query("SELECT @sums as sumas");
		$res=$key->fetch_row()[0];
		$this->db->close();
		return $res;
	}

	public function sesion_prod_dao($dt){
		$qry = "CALL get_prod_x_sesion(".$dt.")";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	function filtro_catalogo_dao($dt, $dt1, $dt2, $dt3){
		$Qry="CALL filtro_prod('".$dt."', '".$dt1."', '".$dt2."',".$dt3.")";
			$res=$this->db->query($Qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function get_prod_dao($dt){
		$Qry="CALL get_prod(".$dt.")";
		$res = $this->db->query($Qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function get_prod_ajus_dao($dt){
		$Qry="CALL get_prod_stockA(".$dt.")";
		$res = $this->db->query($Qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function get_prexidprd_dao($dt){
		$qry = "CALL get_precxidprod(".$dt.")";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function reg_venta_dao($arr){
		foreach ($arr as $key => $value) {
			$Qry="CALL sp_reg_venta('".implode("', '", $value)."')";
		}
		$res=$this->db->query($Qry) or die($this->db->error);
		$key=$res->fetch_row()[0];
		$this->db->close();
		return $key;
	}

	public function gets_deta_venta_dao($dt){
		$qry = "CALL get_detaventa(".$dt.")";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function gets_deta_compra_dao($dt){
		$qry = "CALL get_detacompra(".$dt.")";
		$res = $this->db->query($qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function back_deta_venta_dao($arry){
		foreach ($arry as $key => $value) {
			$Qry="CALL return_cataventa('".implode("', '", $value)."')";
		}
		$res=$this->db->query($Qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	/* Registro Compra */
	public function reg_compra_dao($arr){
		foreach ($arr as $key => $value) {
			$Qry="CALL sp_reg_compra('".implode("', '", $value)."')";
		}
		$res=$this->db->query($Qry) or die($this->db->error);
		$key=$res->fetch_row()[0];
		$this->db->close();
		return $key;
	}

	public function reg_deta_venta_dao($arry){
		foreach ($arry as $key => $value) {
		$Qry="CALL sp_reg_detaventa('".implode("', '", $value)."')";
		}
		$res=$this->db->query($Qry) or die($this->db->error);
		$key=$res->fetch_row()[0];
		$this->db->close();
		return $key;
	}

	public function Lista_RptCompras_dao($ini, $fin, $ids){
		$con = "CALL sp_get_compras_x_idsale('".$ini."', '".$fin."', ".$ids.")";
		$res = $this->db->query($con) or die ($this->db->error);
		$this->db->close();
		return $res;
	}

	/* CJBM */

	public function lista_products_not_dist_dao(){
		$con = "CALL sp_get_products_not_dist";
		$res = $this->db->query($con) or die ($this->db->error);
		$this->db->close();
		return $res;
	}

	public function searchDataTable_dao($sql='')
	{
		return $this->db->query($sql);		
	}
	
	public function getProductXIdXDis_Dao($id)
	{
		$con = "CALL sp_getProductXIdXDis($id)";
		$res = $this->db->query($con) or die ($this->db->error);
		$this->db->close();
		return $res;
	}
	public function regStockProductSinCompra_dao($array)
	{
		foreach ($array as $key => $value) {
			$Qry="CALL sp_stock_product_p('".implode("', '", $value)."')";
		}
		$res=$this->db->query($Qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}
	/* END CJBM */

	public function Get_Buys_xid_Dao($key){
		$Qry = "CALL sp_getbuys_xid(".$key.")";
		$res = $this->db->query($Qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function Get_DtBuys_xid_Dao($key){
		$Qry = "CALL sp_getdtbuys_xid(".$key.")";
		$res = $this->db->query($Qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function Rpt_Compra_x_idDetalle_dao($ids){
		$con = "CALL sp_det_compra_xid(".$ids.")";
		$res = $this->db->query($con) or die ($this->db->error);
		$this->db->close();
		return $res;
	}

	public function Rpt_Compra_x_idDetalle_x_Distribuir_dao($ids, $opc){
		$Qry=$this->db->query("CALL sp_idetalle_distribuir(".$ids.",@nums, $opc)") or die($this->db->error);
		if ($opc == 1) {
			$res = $this->db->query("SELECT @nums as numes");
			$key=$res->fetch_row()[0];
		}else{
			$key=[];
			while($row = $Qry->fetch_row()){
				$key[] = $row;
			}
		}				
		$this->db->close();
		return $key;
	}


	
	public function Reg_Stock_xct_Dao($arry){
		foreach ($arry as $key => $value) {
			$res=$this->db->query("CALL sp_proc_stock_2('".implode("', '", $value)."')") or die($this->db->error);
		}

		//$dtcompra = $this->db->query("SELECT @dtcompra as dtcompra");
		$key=$res->fetch_row()[0];		
		$this->db->close();
		return $key;
	}

	public function Ver_Prec_xprd_Dao($dt, $dt1){
		$Qry="CALL sp_verif_precxprd1('".$dt."', ".$dt1.")";
		$res=$this->db->query($Qry) or die($this->db->error);
		$key=$res->fetch_row()[0];
		$this->db->close();
		return $key;
	}

	public function Deles_Prod_xidCompra_Dao($id){
		$Qry=$this->db->query("CALL sp_del_prd_xidcompra(".$id.",@sms)") or die($this->db->error);
		$res=$this->db->query("SELECT @sms as ids");
		$key=$res->fetch_row()[0];
		$this->db->close();
		return $key;
	}

	/* Registro Detalle Compra */
	public function reg_deta_compra_dao($arry){
		foreach ($arry as $key => $value) {
		$Qry="CALL sp_reg_detacompra('".implode("', '", $value)."')";
		}
		$res=$this->db->query($Qry) or die($this->db->error);
		$key=$res->fetch_row()[0];
		$this->db->close();
		return $key;
	}


	public function Pay_venta_dao($dta){
		foreach ($dta as $key => $value) {
			$Qry="CALL sp_reg_payventa('".implode("', '", $value)."')";
		}
		$res=$this->db->query($Qry) or die($this->db->error);
		$key=$res->fetch_row()[0];
		$this->db->close();
		return $key;
	}

	public function Reg_compra_pay_dao($arrs){
		foreach ($arrs as $key => $value) {
			$Qry="CALL sp_reg_buypay('".implode("', '", $value)."')";
		}
		$res=$this->db->query($Qry) or die($this->db->error);
		$key=$res->fetch_row()[0];
		$this->db->close();
		return $key;
	}
	/*Junior*/
	public function Reg_ccuotas_dao($idpago,$cuotas,$monto,$idv){
		$key=0;
		$Qry="INSERT INTO tb_compracuotas(idpago, n_cuotas, total, idv, estado) values ($idpago,$cuotas,$monto,$idv,0)";
		$res=$this->db->query($Qry) or die($this->db->error);
		$key=$this->db->insert_id;

		
		$this->db->close();
		return $key;
	}
	/*Junior*/
	public function get_pago_dao($id){
		$Qry = "SELECT cv.idpago, td.nom, com.num_doc,cv.fecha,cv.pendiente,p.nom,p.ruc,(com.total_soles-cv.pendiente), cv.pendiente, cv.idcompra, com.total_soles FROM tb_ccompras cv INNER JOIN tb_compra com on cv.idcompra=com.idcompra INNER JOIN tb_tipo td on com.idtip=td.idtip INNER JOIN tb_proveedor p on com.idr=p.idr WHERE com.idcompra=$id";
		$res=$this->db->query($Qry) or die($this->db->error);
		//$key=$res->fetch_row();
		$this->db->close();
		return $res;
	}
	/*Junior*/
	public function get_cuota_pago_dao($id){
		$Qry = "select cc.id,cc.n_cuotas,cc.total,cc.estado,dc.id as iddc,dc.fecha_pago,dc.monto,dc.codigounico,dc.estado,dc.montopagado,dc.montointeres from tb_compracuotas cc INNER JOIN tb_detalle_cuota dc on cc.id=dc.idccuota where cc.idpago=$id";
		$res=$this->db->query($Qry) or die($this->db->error);
		//$key=$res->fetch_row();
		$this->db->close();
		return $res;
	}

	/*Junior*/
	public function get_ccobro_pago_dao($id){
		$Qry = "SELECT cv.idpago, t.nom as nmt, v.num_doc, c.nom, (v.total_soles-cv.pendiente), cv.pendiente, date_format(cv.fecha,'%Y-%m-%d %H:%i:%s %p'), cv.idcompra, v.total_soles,ccuota.id FROM tb_ccompras cv INNER JOIN tb_compra v ON v.idcompra = cv.idcompra INNER JOIN tb_proveedor c ON c.idr = v.idr INNER JOIN tb_tipo t ON t.idtip = v.idtip LEFT JOIN tb_compracuotas ccuota ON v.idcompra=ccuota.idpago WHERE cv.pendiente != 0 AND cv.est=1 AND cv.idcompra=$id GROUP BY cv.idpago";
		$res=$this->db->query($Qry) or die($this->db->error);
		//$key=$res->fetch_row();
		$this->db->close();
		return $res;
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
		$this->db->close();
		
	}

	public function Pay_compra_dao($dta){
		foreach ($dta as $key => $value) {
			$Qry="CALL sp_reg_paycompra('".implode("', '", $value)."')";
		}
		$res=$this->db->query($Qry) or die($this->db->error);
		$key=$res->fetch_row()[0];
		$this->db->close();
		return $key;
	}

	function Reg_Cata_dao($array){
		foreach ($array as $key => $value) {
			$q="CALL sp_reg_catalogo('".implode("', '", $value)."')";
		}
		$res = $this->db->query($q) or die($this->db->error);
		$key = $res->fetch_row()[0];
		$this->db->close();
		return $key;
	}

	function Reg_pre_dao($arr){
		foreach ($arr as $key => $value) {
			$q="CALL sp_reg_precio('".implode("', '", $value)."')";
		}
		$res = $this->db->query($q) or die($this->db->error);
		$key = $res->fetch_row()[0];
		$this->db->close();
		return $key;
	}

	public function get_code_dao(){
		$Qry = "CALL sp_Gen_venta(@p_codigo_sec)";
		$res = $this->db->query($Qry) or die($this->db->error);
		$get = $this->db->query("SELECT @p_codigo_sec as codis");
		$key = $get->fetch_row()[0];
		$this->db->close();
		return $key;
	}

	public function get_unidad_dao($dt1){
		$sql="SHOW COLUMNS FROM tb_productos LIKE '$dt1'";
		$res = $this->db->query($sql) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function Get_Sales_xid_Dao($key){
		$Qry = "CALL sp_getsales_xid(".$key.")";
		$res = $this->db->query($Qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}
	public function vendedores($key)
	{
		$Qry = "select idpedido from tb_venta where idventa=$key";
		$res = $this->db->query($Qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}
	public function vendedorVendedor($id)
	{
		$Qry = "SELECT s.nom FROM tb_pedido p
		inner JOIN tb_sale s on p.idv=s.idv
		where p.idpedido=$id";
		$res = $this->db->query($Qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function Get_MontosCobros_Dao($key){
		$Qry = "CALL sp_getmontoscobros_xid(".$key.")";
		$res = $this->db->query($Qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function Get_DtSales_xid_Dao($key, $id){
		$Qry = "CALL sp_getdtsales_xid(".$key.",".$id.")";
		$res = $this->db->query($Qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function Get_DtSales_xid_ticket_Dao($id){
		$Qry = "SELECT tbp.nomtc, tbp.nom, tbp.nomtm, tbp.unid, c.cant, c.precio, c.total, tbp.idct, 
		c.costo, tbp.nomtm
				FROM detalle_venta c
				INNER JOIN tb_productos tbp ON tbp.idct=c.idct
				WHERE c.idventa=".$id;
		$res = $this->db->query($Qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}


	public function Cobros_pends_dao(){
		$Qry = "CALL sp_cobro_pend()";
		$res = $this->db->query($Qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function Pagos_pends_dao(){
		$Qry = "CALL sp_pago_pend()";
		$res = $this->db->query($Qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function Lista_RptVentas_dao($ini, $fin, $ids){
		$con = "CALL sp_get_ventas_x_idsale('".$ini."','".$fin."', ".$ids.")";
		$res = $this->db->query($con) or die ($this->db->error);
		$this->db->close();
		return $res;
	}

	public function Lista_RptVentas_chatarra_dao(){
		$con = "SELECT v.idventa,  t.nom, v.num_doc, date_format(v.fecha,'%d-%m-%Y %H:%i:%s %p') fchar, c.nom nmcli, v.total, v.est, t.idtip
				FROM tb_venta v
				INNER JOIN tb_tipo t ON t.idtip=v.idtip
				INNER JOIN tb_cliente c ON c.idc=v.idc 
				WHERE V.tipoventa=3";
		$res = $this->db->query($con) or die ($this->db->error);
		$this->db->close();
		return $res;
	}

	public function get_tipo_venta_dao($id){
		$con = "SELECT v.tipoventa FROM tb_venta v WHERE idventa=".$id;
		$res = $this->db->query($con) or die ($this->db->error);
		$this->db->close();
		return $res;
	}

	/* Get Detalle Venta */
	public function Rpt_Venta_x_Detalle_dao($dta){
		$con = "CALL sp_det_venta_xid(".$dta.")";
		$res = $this->db->query($con) or die ($this->db->error);
		$this->db->close();
		return $res;
	}

	//* Del From Detalleventa */
	public function Deles_Prod_xidVenta_Dao($id){
		$Qry=$this->db->query("CALL sp_del_prd_xidventa(".$id.",@sms)") or die($this->db->error);
		$res=$this->db->query("SELECT @sms as ids");
		$key=$res->fetch_row()[0];
		$this->db->close();
		return $key;
	}

	/* Caja Chica */
	public function Lista_Caja_Ventas_Dao($ini, $fin, $ids){
		$con = "CALL sp_caja_venta('".$ini."','".$fin."', ".$ids.")";
		$res = $this->db->query($con) or die ($this->db->error);
		$this->db->close();
		return $res;
	}

	public function Lista_Monto_Caja_Ventas_Dao($ini, $fin, $ids){
		$con = "CALL sp_monto_venta('".$ini."','".$fin."', ".$ids.")";
		$res = $this->db->query($con) or die ($this->db->error);
		$this->db->close();
		return $res;
	}

	public function Lista_Caja_Compras_Dao($ini, $fin, $ids){
		$con = "CALL sp_caja_compras('".$ini."','".$fin."', ".$ids.")";
		$res = $this->db->query($con) or die ($this->db->error);
		$this->db->close();
		return $res;
	}

	public function Lista_Monto_Caja_Compras_Dao($ini, $fin, $ids){
		$con = "CALL sp_monto_compra('".$ini."','".$fin."', ".$ids.")";
		$res = $this->db->query($con) or die ($this->db->error);
		$this->db->close();
		return $res;
	}

	public function Get_Stk_x_idProd_dao($id, $dt){
		$Qry="CALL sp_get_precioxprd(".$id.",".$dt.")";
		$res=$this->db->query($Qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	/* Contables */

	public function Lista_RptContablev_Dao($ini, $fin, $ids){
		$con = "CALL sp_get_ventas_contable('".$ini."','".$fin."', ".$ids.")";
		$res = $this->db->query($con) or die ($this->db->error);
		$this->db->close();
		return $res;
	}

	public function Lista_RptContablec_Dao($ini, $fin, $ids){
		$con="CALL sp_get_compras_contable('".$ini."', '".$fin."', ".$ids.")";
		$res=$this->db->query($con) or die ($this->db->error);
		$this->db->close();
		return $res;
	}

	public function Rows_ventas_Dao($keu){
		$Qry = "CALL sp_rows_ventas(".$keu.")";
		$res = $this->db->query($Qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}

	public function Rows_compras_Dao($keu){
		$Qry="CALL sp_rows_compras(".$keu.")";
		$res=$this->db->query($Qry) or die($this->db->error);
		$this->db->close();
		return $res;
	}
}
?>