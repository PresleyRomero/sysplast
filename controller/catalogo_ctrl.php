<?php 
/**
* Derechos Diseño y Programación - ultratec.com.pe
* Bajo Pena de Uso Indebido y/o/ Copias
* @copyright © 2017
*
*/

require_once $_SERVER["DOCUMENT_ROOT"]."/SysPlast/dao/catalogo_dao.php";

Class Catalogo_Ctrl{

	/*  CJBM */

	public function searchProductosRotos_Ctrl($search)
	{
		$compra_dao = new Catalogo_Dao();
        $res=$compra_dao->searchProductosRotos_Dao($search);
        $fila=[];
		while ($rows=$res->fetch_row()) {
			$fila[]=$rows;
		}
		return $fila;
	}

    public function updateStockDistribuido_ctrl($array) {
        $compra_dao = new Catalogo_Dao();
        $res=$compra_dao->updateStockDistribuido_dao($array);
        return $res;
    }
    public function getStockDistribuido_ctrl($idCompra) 
    {
        $cata_dao=new Catalogo_Dao();
        $res=$cata_dao->getStockDistribuido_dao($idCompra);
        $fila=[];
        while ($rows=$res->fetch_assoc()) {
            $fila[]=$rows;
        }
        return $fila;
    }
    public function checkStockParaModificar_ctrl($idCompra)
    {
		$cata_dao=new Catalogo_Dao();
		$res=$cata_dao->checkStockParaModificar_dao($idCompra);
		return $res->fetch_row()[0]['checkStock'];
	}

	/* CJBM*/
	function rows_catalogo_ctrl(){
		$cata_dao=new Catalogo_Dao();
		$res=$cata_dao->rows_catalogo_dao();
		$fila=[];
		while ($rows=$res->fetch_row()) {
			$fila[]=$rows;
		}
		return $fila;
	}

	function sumar_stock_xcatalogo_ctrl($id){
		$cata_dao=new Catalogo_Dao();
		$res=$cata_dao->sumar_stock_xcatalogo_dao($id);
		return $res;
	}

	public function sesion_prod_ctrl($dt){
		$prod_dao = new Catalogo_Dao();
		$res = $prod_dao->sesion_prod_dao($dt);
		$fila=[];
		while ($rows = $res->fetch_row()){
			$fila[] = $rows;
		}
		return $fila;
	}

	function filtro_catalogo_ctrl($dt, $dt1, $dt2, $dt3){
		$cata_dao=new Catalogo_Dao();
		$res=$cata_dao->filtro_catalogo_dao($dt, $dt1, $dt2, $dt3);
		$fila=[];
		while ($rows=$res->fetch_row()){
			$fila[]=$rows;
		}
		return $fila;
	}

	public function get_prod_ctrl($dt){
		$prod_dao = new Catalogo_Dao();
		$res=$prod_dao->get_prod_dao($dt);
		$fila=$res->fetch_row();
		return $fila;
	}

	public function get_prod_Ajus_ctrl($dt){
		$prod_dao = new Catalogo_Dao();
		$res=$prod_dao->get_prod_ajus_dao($dt);
		$fila=$res->fetch_row();
		return $fila;
	}

	public function get_prexidprd_ctrl($dt){
		$prod_dao = new Catalogo_Dao();
		$res=$prod_dao->get_prexidprd_dao($dt);
		$fila=$res->fetch_row();
		return $fila;
	}

	public function reg_venta_ctrl($arr){
		$prod_dao=new Catalogo_Dao();
		$res=$prod_dao->reg_venta_dao($arr);
		return $res;
	}

	public function gets_deta_venta_ctrl($dt){
		$prod_dao=new Catalogo_Dao();
		$res=$prod_dao->gets_deta_venta_dao($dt);
		$fila=[];
		while ($rows=$res->fetch_row()){
			$fila[]=$rows;
		}
		return $fila;
	}

	public function gets_deta_compra_ctrl($dt){
		$prod_dao=new Catalogo_Dao();
		$res=$prod_dao->gets_deta_compra_dao($dt);
		$fila=[];
		while ($rows=$res->fetch_row()){
			$fila[]=$rows;
		}
		return $fila;
	}

	public function back_deta_venta_ctrl($arry){
		$prod_dao=new Catalogo_Dao();
		$res=$prod_dao->back_deta_venta_dao($arry);
		return $res;
	}

	/* Registro Compra */
	public function reg_compra_ctrl($arr){
		$prod_dao=new Catalogo_Dao();
		$res=$prod_dao->reg_compra_dao($arr);
		return $res;
	}

	public function reg_deta_venta_ctrl($arry){
		$prod_dao=new Catalogo_Dao();
		$res=$prod_dao->reg_deta_venta_dao($arry);
		return $res;
	}

	/* Registro Detalle Compra */
	public function reg_deta_compra_ctrl($arry){
		$prod_dao=new Catalogo_Dao();
		$res=$prod_dao->reg_deta_compra_dao($arry);
		return $res;
	}

	public function Pay_venta_ctrl($dta){
		$prod_dao=new Catalogo_Dao();
		$res=$prod_dao->Pay_venta_dao($dta);
		return $res;
	}

	function Reg_compra_pay_ctrl($dat){
		$compra_dao = new Catalogo_Dao();
		$res=$compra_dao->Reg_compra_pay_dao($dat);
		return $res;
	}
	/*Junior*/
	function Reg_ccuotas_ctrl($idpago,$cuotas,$monto,$idv){
		$compra_dao = new Catalogo_Dao();
		$res=$compra_dao->Reg_ccuotas_dao($idpago,$cuotas,$monto,$idv);
		return $res;
	}
	/*Junior*/
	function insertar_detalle_cuota_ctrl($idcuota,$cod,$fecha,$monto){
		$compra_dao = new Catalogo_Dao();
		$res=$compra_dao->Reg_detalle_cuota_dao($idcuota,$cod,$fecha,$monto);
		return $res;
	}

	/*Junior*/
	function get_pago_ctrl($idpago){
		$compra_dao = new Catalogo_Dao();
		$res=$compra_dao->get_pago_dao($idpago);
		$fila=[];
		while ($rows = $res->fetch_row()) {
			$fila[] = $rows;
		}
		return $fila;
	}

	/*Junior*/
	function get_cuota_pago_ctrl($idpago){
		$compra_dao = new Catalogo_Dao();
		$res=$compra_dao->get_cuota_pago_dao($idpago);
		$fila=[];
		while ($rows = $res->fetch_row()) {
			$fila[] = $rows;
		}
		return $fila;
	}

	/*Junior*/
	function get_ccobro_pago_ctrl($idcompra){
		$compra_dao = new Catalogo_Dao();
		$res=$compra_dao->get_ccobro_pago_dao($idcompra);
		$fila=[];
		while ($rows = $res->fetch_row()) {
			$fila[] = $rows;
		}
		return $fila;
	}

	public function Pay_compra_ctrl($dta){
		$prod_dao=new Catalogo_Dao();
		$res=$prod_dao->Pay_compra_dao($dta);
		return $res;
	}

	public function Reg_Cata_ctrl($array){
		$prod_dao=new Catalogo_Dao();
		$res=$prod_dao->Reg_Cata_dao($array);
		return $res;
	}

	public function Reg_pre_ctrl($arr){
		$prod_dao=new Catalogo_Dao();
		$res=$prod_dao->Reg_pre_dao($arr);
		return $res;
	}

	public function get_code_ctrl(){
		$venta_dao = new Catalogo_Dao();
		$res = $venta_dao->get_code_dao();
		return $res;
	}

	public function get_unidad_ctrl($dt1){
   		$prod_dao=new Catalogo_Dao();
		$res=$prod_dao->get_unidad_dao($dt1);
      	$row=$res->fetch_row();
      	preg_match_all("/(?:(?!:[\(\,])')(.+?)(?:'(?:[\)\,]))/",$row[1],$enums);
      	return $enums[1];
    }

    function Get_Sales_xid_Ctrl($key){
		$venta_dao = new Catalogo_Dao();
		$res=$venta_dao->Get_Sales_xid_Dao($key);
		return $res;
	}
	public function vendedores($key)
	{
		$venta_dao = new Catalogo_Dao();
		$res=$venta_dao->vendedores($key);
		return $res->fetch_array()['idpedido'];
	}
	public function vendedorVendedor($id)
	{
		$venta_dao = new Catalogo_Dao();
		$res=$venta_dao->vendedorVendedor($id);
		return $res->fetch_array()['nom'];
	}

	function Get_MontosCobros_Ctrl($key){
		$venta_dao = new Catalogo_Dao();
		$res=$venta_dao->Get_MontosCobros_Dao($key);
		return $res;
	}

	function Get_DtSales_xid_Ctrl($key, $id){
		$venta_dao = new Catalogo_Dao();
		$res=$venta_dao->Get_DtSales_xid_Dao($key, $id);
		return $res;
	}

	function Get_DtSales_xid_ticket_Ctrl($id){
		$venta_dao = new Catalogo_Dao();
		$res=$venta_dao->Get_DtSales_xid_ticket_Dao($id);
		return $res;
	}

    public function Cobros_pends_ctrl(){
		$venta_dao = new Catalogo_Dao();
		$res = $venta_dao->Cobros_pends_dao();
		$fila=[];
		while($rows=$res->fetch_row()){
			$fila[] = $rows;
		}
		return $fila;
	}

	public function Pagos_pends_ctrl(){
		$venta_dao = new Catalogo_Dao();
		$res = $venta_dao->Pagos_pends_dao();
		$fila=[];
		while($rows=$res->fetch_row()){
			$fila[] = $rows;
		}
		return $fila;
	}

	public function Lista_RptVentas_Ctrl($ini, $fin, $ids){
		$venta_dao = new Catalogo_Dao();
		$res = $venta_dao->Lista_RptVentas_dao($ini, $fin, $ids);
		$lista=[];
		while($row = $res->fetch_row()){
			$lista[] = $row;
		}
		return $lista;
	}

	public function Lista_RptVentas_chatarra_Ctrl(){
		$venta_dao = new Catalogo_Dao();
		$res = $venta_dao->Lista_RptVentas_chatarra_dao();
		$lista=[];
		while($row = $res->fetch_row()){
			$lista[] = $row;
		}
		return $lista;
	}

	public function get_tipo_venta_ctrl($id){
		$venta_dao = new Catalogo_Dao();
		$res = $venta_dao->get_tipo_venta_dao($id);
		$lista=[];
		while($row = $res->fetch_row()){
			$lista[] = $row;
		}
		return $lista;
	}

	/* Get Detalle Venta */
	public function Rpt_Venta_x_Detalle_ctrl($dta){
		$venta_dao = new Catalogo_Dao();
		$res = $venta_dao->Rpt_Venta_x_Detalle_dao($dta);
		$lista=[];
		while($row = $res->fetch_row()){
			$lista[] = $row;
		}
		return $lista;
	}


	public function Lista_RptCompras_Ctrl($ini, $fin, $ids){
		$compras_dao = new Catalogo_Dao();
		$res = $compras_dao->Lista_RptCompras_dao($ini, $fin, $ids);
		$lista=[];
		while($row = $res->fetch_row()){
			$lista[] = $row;
		}
		return $lista;
	}
	/* CJBM */
	public function listaProductsNotDist_Ctrl(){
		$compras_dao = new Catalogo_Dao();
		$res = $compras_dao->lista_products_not_dist_dao();
		$lista=[];
		while($row = $res->fetch_row()){
			$lista[] = $row;
		}
		return $lista;
	}	

	public function datatable_ProductsNotDist_Ctrl2($columns, $params)
	{
        $catalogo_model = new Catalogo_dao;
        $totalRecords = $data = array();		

        $where_condition = $sqlRec = "";
        /* script que se cambia dependiendo lo que se mostrará */
        $sql_query="select concat(tg.nom , ' ', cast(tc.nom AS CHAR (120) CHARSET UTF8)) as nombre,
					  tc.unid, tc.stk, ta.nom as almacen, tc.idct
					  from tb_catalogo tc
					  inner join tb_categ tg on tg.idg=tc.idg
					  inner join  tb_almacen ta on ta.ida=tc.ida";
        $sqlRec .=$sql_query;
        if (isset($params['search']['value']) and !empty($params['search']['value'])) {
                $where_condition.=" WHERE ( ";
                $c=count($columns);
                for ($i=0; $i < $c ; $i++) { 
                        if ($i == $c-1) {	
                                $where_condition.=$columns[$i]. " LIKE '%" .$params['search']['value']. "%'";
                        }else{
                                $where_condition.=$columns[$i]. " LIKE '%" .$params['search']['value']. "%' OR ";
                        }
                }
                $where_condition.=" ) AND tc.stk_min=1";
                $sql_query.=$where_condition;
                $sqlRec.=$where_condition;
        }else{
        	$sql_query.=" WHERE tc.stk_min=1";
        	$sqlRec=$sql_query;
        }		
        $queryTot=$catalogo_model->searchDataTable_dao($sql_query);
        $totalRecords=$queryTot->num_rows;

        $sqlRec.=" ORDER BY " .$columns[$params['order'][0]['column']] . "  " . $params['order'][0]['dir']. " LIMIT ". $params['start']. " ," . $params['length']. " ";


        $queryRecords=$catalogo_model->searchDataTable_dao($sqlRec);
        while ($row = $queryRecords->fetch_object()) {			
                $data[]=$row;
        }
        $result= array(
            'draw' => $params['draw'],
            'totalRecords' => $totalRecords,
            'data' => $data
        );
        return json_encode($result);
	}

	public function getProductXIdXDis_Ctrl($id)
	{
		$compras_dao = new Catalogo_Dao();
		$res = $compras_dao->getProductXIdXDis_Dao($id);
		$lista=[];
		while($row = $res->fetch_row()){
			$lista[] = $row;
		}
		return $lista;
	}
	public function regStockProductSinCompra_Ctrl($array)
	{
		$venta_dao = new Catalogo_Dao();
		$res = $venta_dao->regStockProductSinCompra_dao($array);
		return $res;
	}
	/* END CJBM*/
	function Get_Buys_xid_Ctrl($key){
		$compra_dao = new Catalogo_Dao();
		$res=$compra_dao->Get_Buys_xid_Dao($key);
		return $res;
	}

	function Get_DtBuys_xid_Ctrl($key){
		$compra_dao = new Catalogo_Dao();
		$res=$compra_dao->Get_DtBuys_xid_Dao($key);
		return $res;
	}

	public function Rpt_Compra_x_idDetalle_ctrl($ids){
		$compras_dao = new Catalogo_Dao();
		$res = $compras_dao->Rpt_Compra_x_idDetalle_dao($ids);
		$lista=[];
		while($row = $res->fetch_row()){
			$lista[] = $row;
		}
		return $lista;
	}
	public function Rpt_Compra_x_idDetalle_x_Distribuir_ctrl($ids, $opc){
		$compras_dao = new Catalogo_Dao();
		$res = $compras_dao->Rpt_Compra_x_idDetalle_x_Distribuir_dao($ids, $opc);
		return $res;
	}

	public function Reg_Stock_xct_Ctrl($array){
		$compra_dao = new Catalogo_Dao();
		$res=$compra_dao->Reg_Stock_xct_Dao($array);
		return $res;
	}

	public function Ver_Prec_xprd_Ctrl($dt, $dt1){
		$compra_dao = new Catalogo_Dao();
		$res=$compra_dao->Ver_Prec_xprd_Dao($dt, $dt1);
		return $res;
	}


	public function Deles_Prod_xidCompra_Ctrl($id){
		$compra_dao = new Catalogo_Dao();
		$res=$compra_dao->Deles_Prod_xidCompra_Dao($id);
		return $res;
	}

	//* Del Prod From Detalle Venta */ 
	public function Deles_Prod_xidVenta_Ctrl($id){
		$venta_dao = new Catalogo_Dao();
		$res=$venta_dao->Deles_Prod_xidVenta_Dao($id);
		return $res;
	}

	/* Caja Chica */
	public function Lista_Caja_Ventas_Ctrl($ini, $fin, $ids){
		$venta_dao = new Catalogo_Dao();
		$res = $venta_dao->Lista_Caja_Ventas_Dao($ini, $fin, $ids);
		$lista=[];
		while($row = $res->fetch_row()){
			$lista[] = $row;
		}
		return $lista;
	}

	public function Lista_Monto_Caja_Ventas_Ctrl($ini, $fin, $ids){
		$venta_dao = new Catalogo_Dao();
		$res = $venta_dao->Lista_Monto_Caja_Ventas_Dao($ini, $fin, $ids);
		$fila = $res->fetch_row();
		return $fila;
	}

	public function Lista_Caja_Compras_Ctrl($ini, $fin, $ids){
		$venta_dao = new Catalogo_Dao();
		$res = $venta_dao->Lista_Caja_Compras_Dao($ini, $fin, $ids);
		$lista=[];
		while($row = $res->fetch_row()){
			$lista[] = $row;
		}
		return $lista;
	}

	public function Lista_Monto_Caja_Compras_Ctrl($ini, $fin, $ids){
		$venta_dao = new Catalogo_Dao();
		$res = $venta_dao->Lista_Monto_Caja_Compras_Dao($ini, $fin, $ids);
		$fila = $res->fetch_row();
		return $fila;
	}

	/* Obtener Stock */

	public function Get_Stk_x_idProd_ctrl($id, $dt){
		$catalogo_dao = new Catalogo_Dao();
		$res= $catalogo_dao->Get_Stk_x_idProd_dao($id, $dt);
		$fila= $res->fetch_row();
		return $fila;
	}


	/* Contables */

	public function Lista_RptContablev_Ctrl($ini, $fin, $ids){
		$venta_dao = new Catalogo_Dao();
		$res = $venta_dao->Lista_RptContablev_Dao($ini, $fin, $ids);
		$lista=[];
		while($row = $res->fetch_row()){
			$lista[] = $row;
		}
		return $lista;
	}

	public function Lista_RptContablec_Ctrl($ini, $fin, $ids){
		$venta_dao = new Catalogo_Dao();
		$res = $venta_dao->Lista_RptContablec_Dao($ini, $fin, $ids);
		$lista=[];
		while($row = $res->fetch_row()){
			$lista[] = $row;
		}
		return $lista;
	}

	/* Anular */

	public function Rows_ventas_ctrl($keu){
		$venta_dao = new Catalogo_Dao();
		$res = $venta_dao->Rows_ventas_Dao($keu);
		$fila=[];
		while ($rows = $res->fetch_row()) {
			$fila[] = $rows;
		}
		return $fila;
	}

	public function Rows_compras_ctrl($keu){
		$compras_dao = new Catalogo_Dao();
		$res = $compras_dao->Rows_compras_Dao($keu);
		$fila=[];
		while ($rows = $res->fetch_row()) {
			$fila[] = $rows;
		}
		return $fila;
	}
}
?>