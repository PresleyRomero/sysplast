<?php 
/**
* Derechos Diseño y Programación - ultratec.com.pe
* Bajo Pena de Uso Indebido y/o/ Copias
* @copyright © 2017
*
*/
require_once $_SERVER["DOCUMENT_ROOT"]."/SysPlast/dao/procedimientos_dao.php";
require_once $_SERVER["DOCUMENT_ROOT"]."/SysPlast/controller/catalogo_ctrl.php";

require_once $_SERVER["DOCUMENT_ROOT"]."/SysPlast/model/function.php";
Class Procedimientos_ctrl{

	public function insertar_cuota_all($idpago,$cuotas,$monto,$idv,$datos=array())
	{
		$response=array();
		$procedimiento_model=new Procedimientos_dao;

		try {
			$procedimiento_model->getConexion()->begin_transaction(MYSQLI_TRANS_START_WITH_CONSISTENT_SNAPSHOT);
			$procedimiento_model->getConexion()->autocommit(false);
			$keycuota = $procedimiento_model->Reg_ccuotas_dao($idpago,$cuotas,$monto,$idv);
			$cont = count($datos)/3;
			$r1=0;$r2=1;$r3=2;
			//Convalidar Monto
			$montobandera =0.00;
			for ($i = 1; $i <= $cont; $i++) {
				$montobandera=$montobandera+$datos[$r3];
				$keydetcuota = $procedimiento_model->Reg_detalle_cuota_dao($keycuota,
				$datos[$r1],$datos[$r2],$datos[$r3]);
				$r1=$r1+3;
				$r2=$r2+3;
				$r3=$r3+3;
			}
			// return round($montobandera, 7);
			$montobandera=round($montobandera, 7);
			if($montobandera>$monto){
				$procedimiento_model->getConexion()->rollback();
				$procedimiento_model->getConexion()->close();
				return false;
			}

			if($montobandera<$monto){
				$procedimiento_model->getConexion()->rollback();
				$procedimiento_model->getConexion()->close();
				return false;
			}

			if ($procedimiento_model->getConexion()->commit()) {
				$procedimiento_model->getConexion()->close();
				return true;
			}
		} catch (Exception $e) {
			die('Connection failed: ' . $e->getMessage());
			$procedimiento_model->getConexion()->rollback();
			$procedimiento_model->getConexion()->close();
			return false;
		}

	}

	public function actualizar_detallecuota_all($arr=array())
	{
		$response=array();
		$procedimiento_model=new Procedimientos_dao;

		try {
			$procedimiento_model->getConexion()->begin_transaction(MYSQLI_TRANS_START_WITH_CONSISTENT_SNAPSHOT);
			$procedimiento_model->getConexion()->autocommit(false);

			$keycuota = $procedimiento_model->Reg_compra_pay_proce_dao($arr);
			$procedimiento_model->getConexion()->next_result();

			if ($procedimiento_model->getConexion()->commit()) {
				$procedimiento_model->getConexion()->close();
				return true;
			}
		} catch (Exception $e) {
			//die('Connection failed: ' . $e->getMessage());
			$procedimiento_model->getConexion()->rollback();
			$procedimiento_model->getConexion()->close();
			return false;
		}

	}

	public function insertar_caja_all($monto,$idv)
	{
		$response=array();
		$procedimiento_model=new Procedimientos_dao;

		try {
			date_default_timezone_set("AMERICA/LIMA");
			$fecha = date('Y-m-d');
			$result = $procedimiento_model->Reg_inicio_caja_dao($fecha,$monto,$idv);
			//var_dump($result);
			if($result!=false){
				return true;
			}else{
				return false;
			}
			
		} catch (Exception $e) {
			//die('Connection failed: ' . $e->getMessage());
			return false;
		}

	}

	public function get_caja_curdate()
	{
		$response=array();
		$procedimiento_model=new Procedimientos_dao;

		try {
			$result = $procedimiento_model->get_caja_date();
			if($result!=false){
				return $result;
			}
			
		} catch (Exception $e) {
			//die('Connection failed: ' . $e->getMessage());
			return false;
		}

	}

	public function datatable_productos_ctrl($columns, $params)
	{
		$procedimiento_model = new Procedimientos_dao;
		$totalRecords = $data = array();		
		$where_condition = $sqlRec = "";

		$sql_query="SELECT * FROM tb_productos";
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
			$where_condition.=" )";
			$sql_query.=$where_condition;
			$sqlRec.=$where_condition;
		}			
		$queryTot=$procedimiento_model->searchDataTable_dao($sql_query);
		$totalRecords=$queryTot->num_rows;

		$sqlRec.=" ORDER BY " .$columns[$params['order'][0]['column']] . "  " . $params['order'][0]['dir']. " LIMIT ". $params['start']. " ," . $params['length']. " ";
		
		$queryRecords=$procedimiento_model->searchDataTable_dao($sqlRec);
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


	public function insertar_compra_all($id,$act,$est,$fchar,$arreglo=array(),
	$pago,$gttl,$numdoc,$iddoc,$idprov,$ids,$idmoneda,$incluye_igv)
	{
		$response=array();
		$procedimiento_model=new Procedimientos_dao;

		try {
			$procedimiento_model->getConexion()->begin_transaction(MYSQLI_TRANS_START_WITH_CONSISTENT_SNAPSHOT);
			$procedimiento_model->getConexion()->autocommit(false);
			$arr=[];
			$arry=[];
			$dta=[];
			$cja=[];
			$arrct=[];
			$cambio = 0.00;
			$pagos=0.0;
			if($pago > $gttl){
				$pagos = $gttl;
				$pends = 0;
			}if($pago == $gttl){
				$pagos = $gttl;
				$pends = 0;
			}if($pago < $gttl){
				$pagos = $pago;
				$pends = $gttl - $pago;
			}

			date_default_timezone_set("AMERICA/LIMA");
			$t=time();
			$date=date($fchar." "."H:i:s", $t);

			if($idmoneda>0){
				$cambio=$procedimiento_model->get_cambiodolar_actual_proce_dao();
				$procedimiento_model->getConexion()->next_result();
				$totalconver = $gttl * $cambio;
				$arr[]=['0'=> $id, '1'=> $date, '2'=> $numdoc, '3'=> $iddoc, 
				'4'=> $idprov, '5'=> $ids, '6'=> $gttl, 'dt7'=> $est, 
				'dt8'=>$act,'dt9' =>2, 'dt10' => $totalconver, 'dt11' => $incluye_igv];
			}else if($idmoneda==0){
				$arr[]=['0'=> $id, '1'=> $date, '2'=> $numdoc, '3'=> $iddoc, 
				'4'=> $idprov, '5'=> $ids, '6'=> $gttl, 'dt7'=> $est, 
				'dt8'=>$act,'dt9' =>1, 'dt10' => $gttl, 'dt11' => $incluye_igv];
				// $gttl=$gttl;
			}

			// $arr[]=['0'=> $id, '1'=> $date, '2'=> $numdoc, '3'=> $iddoc, 
			// 	'4'=> $idprov, '5'=> $ids, '6'=> $gttl, 'dt7'=> $est, 
			// 	'dt8'=>$act,'dt9' =>2, 'dt10' => $gttl, $incluye_igv];
			

			$regc=$procedimiento_model->reg_compra_proce_dao($arr);
			//var_dump($regc);
			$procedimiento_model->getConexion()->next_result();

			foreach ($arreglo as $key => $value){
				if($incluye_igv === 1){
					$importe = $value["importe"];
					$precio_subtotal = $importe/1.18;
					$igv = $importe - $precio_subtotal;
					$arry[]=[ '0' => 0,'1' => $regc,'3' => $value["idprd"],'4' => $value["cant"],
					'5' => $value["precio"], '6' => $value["descuento"], '7' => $precio_subtotal,'8' => $igv,
					'9' => $importe,'10' => 1,'11' => $value["tstk"], '12' => 1];
				}else if($incluye_igv === 0){
					$sb = $value["importe"];
					$igv = $sb*0.18;
					$precio_subtotal = $sb + $igv;
					$arry[]=[ '0' => 0,'1' => $regc,'3' => $value["idprd"],'4' => $value["cant"],
					'5' => $value["precio"], '6' => $value["descuento"],'7' => $sb,'8' => $igv,
					'9' => $precio_subtotal,'10' => 1,'11' => $value["tstk"], '12' => 1];

					// $arry[]=[ '0' => null,'1' => $regc,'3' => $value["idprd"],'4' => $value["cant"],
					// '5' => $value["precio"],'6' => $precio_subtotal,'7' => $igv,
					// '8' => $value["importe"],'9' => 1,'10' => $value["tstk"], '11' => 1];
				}
				
				
				$regdv=$procedimiento_model->reg_deta_compra_proce_dao($arry);
				$procedimiento_model->getConexion()->next_result();
			}

			//Actualizar Stock de los productos
			/*if($value["tstk"]!=0){
				foreach ($arreglo as $key => $valprd){
					$arrct[]=['0' => $valprd["idprd"],'1' => NULL,'2' => NULL,
					'3' => NULL,'4' => NULL,'5' => NULL,'6' => NULL,
					'7' => NULL,'8' => NULL,'9' => $valprd["cant"],
					'10' => NULL,'11' => $valprd["tstk"],'12' => 4 ];
					$regct = $procedimiento_model->Reg_Cata_proce_dao($arrct);
					$procedimiento_model->getConexion()->next_result();
				}
			}*/

			//Insertar o Actualizar Precios de los productos
			foreach ($arreglo as $key => $valpr) {
				
				$arrpc[]=[ '0'=>0, '1'=> $valpr["idprd"], '2'=> $valpr["ppcom"], '3'=>NULL, 
				'4'=>NULL,'5'=>NULL, '6'=>NULL, '7'=>NULL, '8'=>NULL, '9'=>NULL, '10'=>3];
				$regprc=$procedimiento_model->Reg_pre_proce_dao($arrpc); 
				$procedimiento_model->getConexion()->next_result();
				$_SESSION['comprobar']=$valpr["precio"];
			}


			if($pends!=0){
				if($idmoneda>0){
					$pends = $pends;
				}
				$dta[]=['0'=> 0,'1'=> $regc,'2' => $pagos,'3' => $pends,
				'4' => $date,'5' => $_SESSION["MM_id"],'6' => 1,'7' => 1];
			}else if($pends==0){
				$dta[]=['0'=> 0,'1'=> $regc,'2' => $pagos,'3' => $pends,
				'4' => $date,'5' => $_SESSION["MM_id"],'6' => -1,'7' => 1];
			}
			$pay=$procedimiento_model->Pay_compra_proce_dao($dta);
			$procedimiento_model->getConexion()->next_result();
			//Caja
			/*$keycaja=$procedimiento_model->get_xidcaja_date();
			$procedimiento_model->getConexion()->next_result();
			$nomdoc ='';
			switch ($iddoc) {
			    case 1:
			        $nomdoc="BOLETA";
			        break;
			    case 2:
			        $nomdoc="FACTURA";
			        break;
			    case 3:
			        $nomdoc="PROFORMA";
			        break;
			}
			if($pagos>0){
				$cja[]=['0'=> $keycaja,'1'=> 2,'2' => $iddoc,'3' => $nomdoc,'4' => $numdoc,'5' => $pagos,'6' => '','7' => 1, '8'=>1, '9'=>0];
				$keycaja=$procedimiento_model->mov_caja_dao($cja);
				$procedimiento_model->getConexion()->next_result();
			}*/


			if ($procedimiento_model->getConexion()->commit()) {
				$procedimiento_model->getConexion()->close();
				return true;
			}
		} catch (Exception $e) {
			die('Connection failed: ' . $e->getMessage());
			$procedimiento_model->getConexion()->rollback();
			$procedimiento_model->getConexion()->close();
			return false;
		}

	}

	public function insertar_venta_all($id,$act,$est,$fchar,$arreglo=array(),$cobro,$gttl,$numdoc,
	$iddoc,$idcli,$ids,$tipoven)
	{
		$response=array();
		$procedimiento_model=new Procedimientos_dao;
		$arr=[];
		$arry=[];
		$dta=[];
		$cja=[];
		$arrct=[];
		try {
			$procedimiento_model->getConexion()->begin_transaction(MYSQLI_TRANS_START_WITH_CONSISTENT_SNAPSHOT);
			$procedimiento_model->getConexion()->autocommit(false);

			date_default_timezone_set("AMERICA/LIMA");
			$t=time();
			$date=date($fchar." "."H:i:s", $t);
			if($cobro > $gttl){
				$cobros = $gttl;
				$pends = 0;
			}if($cobro == $gttl){
				$cobros = $gttl;
				$pends = 0;
			}if($cobro < $gttl){
				$cobros = $cobro;
				$pends = $gttl - $cobro;
			}

			$arr[]=['0'=> $id, '1'=> $date, '2'=> $numdoc, '3'=> $iddoc, 
			'4'=> $idcli, '5'=> $ids, '6'=> $gttl, 'dt7'=> $est, 
			'dt8'=>$act, 'dt9'=>$tipoven, 'dt10'=>null];
			$regv=$procedimiento_model->reg_venta_proce_dao($arr);
			$procedimiento_model->getConexion()->next_result();



			foreach ($arreglo as $key => $value) {
				$sb = $value["cant"] * $value["precio"];
				$igv = $sb*0.18;
				$precio_subtotal = $sb - $igv;
				$arry[]=[ '0' => 0,'1' => $regv,'3' => $value["idprd"],
				'4' => $value["cant"],'5' => $value["precio"],'6' => $value["costo"],
				'7' => $precio_subtotal,'8' => $igv,'9' => $value["importe"],
				'10' => 1,'11' => $value["tstk"], '12'=> 1];
				$regdv=$procedimiento_model->reg_deta_venta_proce_dao($arry);
				$procedimiento_model->getConexion()->next_result();
			}

			foreach ($arreglo as $key => $valcat) {
				$arrct[]=['0' => $valcat["idprd"],'1' => NULL,'2' => NULL,
				'3' => NULL,'4' => NULL,'5' => NULL,'6' => NULL,
				'7' => NULL,'8' => NULL,'9' => $valcat["cant"],'10' => NULL,
				'11' => $valcat["tstk"],'12' => 3 ];
				$regct = $procedimiento_model->Reg_Cata_proce_dao($arrct);
				$procedimiento_model->getConexion()->next_result();
			}

			$gana=0;
			foreach ($arreglo as $key => $vals) { $gana += $vals["costo"]; }

			$dta[]=['0'=> 0,'1'=> $regv,'2' => $cobros,'3' => $pends,'4' => $gana,
			'5' => $date,'6' => $ids,'7' => 1,'8' => 1];

			$pay=$procedimiento_model->Pay_venta_proce_dao($dta);
			$procedimiento_model->getConexion()->next_result();

			//Registrar puntaje del cliente 
			// $cant_puntaj=round($gttl/2);
			$cant_puntaj=$gttl/2;
			$truncar = 10**0;
    		$cant_puntaj=intval($cant_puntaj * $truncar) / $truncar;
			$puntaj[] = array('0' => $idcli, '1' => $cant_puntaj);
			$pay=$procedimiento_model->addPuntos_venta_proce_Dao($puntaj);
			$procedimiento_model->getConexion()->next_result();
			
			//Caja
			$keycaja=$procedimiento_model->get_xidcaja_date();
			$procedimiento_model->getConexion()->next_result();
			$nomdoc ='';
			switch ($iddoc) {
			    case 1:
			        $nomdoc="BOLETA";
			        break;
			    case 2:
			        $nomdoc="FACTURA";
			        break;
			    case 3:
			        $nomdoc="PROFORMA";
			        break;
			}
			if($cobros>0){
				$cja[]=['0'=> $keycaja,'1'=> 1,'2' => $iddoc,'3' => $nomdoc,'4' => $numdoc,'5' => $cobros,'6' => '','7' => 1,'8'=>1, '9'=>0, '10'=>1];
				$keycaja=$procedimiento_model->mov_caja_dao($cja);
				$procedimiento_model->getConexion()->next_result();
			}

			
			if ($procedimiento_model->getConexion()->commit()) {
				$procedimiento_model->getConexion()->close();
				return encrypt($regv);
			}
		} catch (Exception $e) {
			die('Connection failed: ' . $e->getMessage());
			$procedimiento_model->getConexion()->rollback();
			$procedimiento_model->getConexion()->close();
			return false;
		}

	}

	public function insertar_pedido_venta_all($id,$act,$est,$fchar,
	$arreglo,$cobro,$gttl,$numdoc,$iddoc,$idusuario,$idcliente,$idpedido, $tipoven)
	{
		$response=array();
		$procedimiento_model=new Procedimientos_dao;
		$arr=[];
		$arry=[];
		$dta=[];
		$cja=[];
		$arrct=[];
		try{
			$procedimiento_model->getConexion()->begin_transaction(MYSQLI_TRANS_START_WITH_CONSISTENT_SNAPSHOT);
			$procedimiento_model->getConexion()->autocommit(false);

			date_default_timezone_set("AMERICA/LIMA");
			$t=time();
			$date=date($fchar." "."H:i:s", $t);
			if($cobro > $gttl){
				$cobros = $gttl;
				$pends = 0;
			}if($cobro == $gttl){
				$cobros = $gttl;
				$pends = 0;
			}if($cobro < $gttl){
				$cobros = $cobro;
				$pends = $gttl - $cobro;
			}

			$arr[]=['0'=> $id, '1'=> $date, '2'=> $numdoc, '3'=> $iddoc, 
			'4'=> $idcliente, '5'=> $idusuario, '6'=> $gttl, 'dt7'=> $est, 
			'dt8'=>$act, 'dt9'=>$tipoven, 'dt10' => $idpedido];
			$regv=$procedimiento_model->reg_venta_proce_dao($arr);
			$procedimiento_model->getConexion()->next_result();
			$stockActual=0; $banderaStock=true;
			//registrar detalle venta
			foreach ($arreglo as $key => $value) {
				$sb = $value["cant"] * $value["precio"];
				$igv = $sb*0.18;
				$precio_subtotal = $sb - $igv;
				$stockActual=$procedimiento_model->validarStock($value['idct']);
				if($stockActual<$value['cant']){
					$banderaStock=false;
				}
				$arry[]=[ '0' => 0,'1' => $regv,'3' => $value["idct"],
				'4' => $value["cant"],'5' => $value["precio"],'6' => $value["costo"],
				'7' => $precio_subtotal,'8' => $igv,'9' => $value["total"],
				'10' => 1,'11' => 1, '12'=> 1];
				//'11' => $value["tstk"]
				if($banderaStock){
					$regdv=$procedimiento_model->reg_deta_venta_proce_dao($arry);
					$procedimiento_model->getConexion()->next_result();
				}else{
					$procedimiento_model->getConexion()->rollback();
					$procedimiento_model->getConexion()->close();
					return false;
				}
				
			}

			
			//disminucion del stock
			foreach ($arreglo as $key => $valcat) {
				$arrct[]=['0' => $valcat["idct"],'1' => NULL,'2' => NULL,
				'3' => NULL,'4' => NULL,'5' => NULL,'6' => NULL,
				'7' => NULL,'8' => NULL,'9' => $valcat["cant"],'10' => NULL,
				'11' => 1,'12' => 3 ];
				//'11' => $valcat["tstk"]
				$regct = $procedimiento_model->Reg_Cata_proce_dao($arrct);
				$procedimiento_model->getConexion()->next_result();
			}

			//ganancia
			$gana=0;
			foreach ($arreglo as $key => $vals) { 
				$gana += $vals["costo"]; 
			}

			$dta[]=['0'=> 0,'1'=> $regv,'2' => $cobros,'3' => $pends,'4' => $gana,
			'5' => $date,'6' => $idusuario,'7' => 1,'8' => 1];

			//registrar tb_cventa
			$pay=$procedimiento_model->Pay_venta_proce_dao($dta);
			$procedimiento_model->getConexion()->next_result();

			//Registrar puntaje del cliente 
			// $cant_puntaj=round($gttl/2);
			$cant_puntaj=$gttl/2;
			$truncar = 10**0;
    		$cant_puntaj=intval($cant_puntaj * $truncar) / $truncar;
			$puntaj[] = array('0' => $idcliente, '1' => $cant_puntaj);
			$pay=$procedimiento_model->addPuntos_venta_proce_Dao($puntaj);
			$procedimiento_model->getConexion()->next_result();
			
			//Caja
			$keycaja=$procedimiento_model->get_xidcaja_date();
			$procedimiento_model->getConexion()->next_result();
			$nomdoc ='';
			switch ($iddoc) {
			    case 1:
			        $nomdoc="BOLETA";
			        break;
			    case 2:
			        $nomdoc="FACTURA";
			        break;
			    case 3:
			        $nomdoc="PROFORMA";
			        break;
			}
			if($cobros>0){
				$cja[]=['0'=> $keycaja,'1'=> 1,'2' => $iddoc,'3' => $nomdoc,
				'4' => $numdoc,'5' => $cobros,'6' => '','7' => 1,
				'8'=>1, '9'=>0, '10'=>1];
				$keycaja=$procedimiento_model->mov_caja_dao($cja);
				$procedimiento_model->getConexion()->next_result();
			}

			//dar de baja el pedido

			$bja=$procedimiento_model->bajaPedido($idpedido);
			$procedimiento_model->getConexion()->next_result();
			if ($procedimiento_model->getConexion()->commit()) {
				$procedimiento_model->getConexion()->close();
				return encrypt($regv);
			}
		} catch (Exception $e) {
			die('Connection failed: ' . $e->getMessage());
			$procedimiento_model->getConexion()->rollback();
			$procedimiento_model->getConexion()->close();
			return false;
		}

	}

	//pedidos
	public function insertar_pedido_all($arreglo=array(), $idventa,$act,$est,$fchar,$cobro,
	$gttl,$numdoc,$iddoc,$idcliente,$idusuario,$tipoven)
	{
		$response=array();
		$procedimiento_model=new Procedimientos_dao;
		$arr=[];
		$arry=[];
		$dta=[];
		$cja=[];
		$arrct=[];
		try {
			$procedimiento_model->getConexion()->begin_transaction(MYSQLI_TRANS_START_WITH_CONSISTENT_SNAPSHOT);
			$procedimiento_model->getConexion()->autocommit(false);

			date_default_timezone_set("AMERICA/LIMA");
			$t=time();
			$date=date($fchar." "."H:i:s", $t);
			// if($cobro > $gttl){
			// 	$cobros = $gttl;
			// 	$pends = 0;
			// }if($cobro == $gttl){
			// 	$cobros = $gttl;
			// 	$pends = 0;
			// }if($cobro < $gttl){
			// 	$cobros = $cobro;
			// 	$pends = $gttl - $cobro;
			// }

			$arr[]=['0'=> $idventa, '1'=> $date, '2'=> $idcliente, '3'=> $idusuario, 
			'4'=> $gttl, '5'=> $gttl, '6'=> $gttl, 'dt7'=> $est, 
			'dt8'=>$tipoven, 'dt9'=>1];
			$regpedido=$procedimiento_model->reg_pedido_proce_dao($arr);
			$procedimiento_model->getConexion()->next_result();



			foreach ($arreglo as $key => $value) {
				$sb = $value["cant"] * $value["precio"];
				$igv = $sb*0.18;
				$precio_subtotal = $sb - $igv;
				$arry[]=[ '0' => 0,'1' => $regpedido,'3' => $value["idprd"],
				'4' => $value["cant"],'5' => $value["precio"],'6' => $value["costo"],
				'7' => $value['ppcom'],'8' => $igv,'9' => $value["importe"],
				'10' => 1,'11'=> 1];
				$regdv=$procedimiento_model->reg_deta_pedido_proce_dao($arry);
				$procedimiento_model->getConexion()->next_result();
			}

			// foreach ($arreglo as $key => $valcat) {
			// 	$arrct[]=['0' => $valcat["idprd"],'1' => NULL,'2' => NULL,
			// 	'3' => NULL,'4' => NULL,'5' => NULL,'6' => NULL,
			// 	'7' => NULL,'8' => NULL,'9' => $valcat["cant"],'10' => NULL,
			// 	'11' => $valcat["tstk"],'12' => 3 ];
			// 	$regct = $procedimiento_model->Reg_Cata_proce_dao($arrct);
			// 	$procedimiento_model->getConexion()->next_result();
			// }

			// $gana=0;
			// foreach ($arreglo as $key => $vals) { 
			// 	$gana += $vals["costo"]; 
			// }

			// $dta[]=['0'=> null,'1'=> $regv,'2' => $cobros,'3' => $pends,'4' => $gana,
			// '5' => $date,'6' => $ids,'7' => 1,'8' => 1];

			// $pay=$procedimiento_model->Pay_venta_proce_dao($dta);
			// $procedimiento_model->getConexion()->next_result();

			//Registrar puntaje del cliente 
			// $cant_puntaj=round($gttl/2);
			// $cant_puntaj=$gttl/2;
			// $truncar = 10**0;
    		// $cant_puntaj=intval($cant_puntaj * $truncar) / $truncar;
			// $puntaj[] = array('0' => $idcli, '1' => $cant_puntaj);
			// $pay=$procedimiento_model->addPuntos_venta_proce_Dao($puntaj);
			// $procedimiento_model->getConexion()->next_result();
			
			//Caja
			// $keycaja=$procedimiento_model->get_xidcaja_date();
			// $procedimiento_model->getConexion()->next_result();
			// $nomdoc ='';
			// switch ($iddoc) {
			//     case 1:
			//         $nomdoc="BOLETA";
			//         break;
			//     case 2:
			//         $nomdoc="FACTURA";
			//         break;
			//     case 3:
			//         $nomdoc="PROFORMA";
			//         break;
			// }
			// if($cobros>0){
			// 	$cja[]=['0'=> $keycaja,'1'=> 1,'2' => $iddoc,'3' => $nomdoc,'4' => $numdoc,'5' => $cobros,'6' => '','7' => 1,'8'=>1, '9'=>0, '10'=>1];
			// 	$keycaja=$procedimiento_model->mov_caja_dao($cja);
			// 	$procedimiento_model->getConexion()->next_result();
			// }

			
			if ($procedimiento_model->getConexion()->commit()) {
				$procedimiento_model->getConexion()->close();
				return encrypt($regpedido);
			}
		} catch (Exception $e) {
			die('Connection failed: ' . $e->getMessage());
			$procedimiento_model->getConexion()->rollback();
			$procedimiento_model->getConexion()->close();
			return false;
		}

	}

	public function listarPedidosPorVendedor($id)
	{
		$procedimiento_model=new Procedimientos_dao;
		$res=$procedimiento_model->listarPedidosPorVendedor($id);
		$fila=[];
		while ($rows = $res->fetch_array()) {
			$fila[] = $rows;
		}
		return $fila;
	}

	public function getPedido($id)
	{
		$procedimiento_model=new Procedimientos_dao;
		$res=$procedimiento_model->getPedido($id);
		
		return $res->fetch_array();
	}
	public function totales($id)
	{
		$procedimiento_model=new Procedimientos_dao;
		$res=$procedimiento_model->totales($id);
		
		return $res->fetch_array();
	}
	public function getDetallePedido($id)
	{
		$procedimiento_model=new Procedimientos_dao;
		$res=$procedimiento_model->getDetallePedido($id);
		$fila=[];
		while ($rows = $res->fetch_array()) {
			$fila[] = $rows;
		}
		return $fila;
	}

	public function agregarCarritoPedido($idpedido, $idproducto, $cantidad, 
	$precio, $importe1, $importe2, $importe3, $importe4)
	{
		$response='';
		$costo=0.0; $stockCarrito=0; $stockActual=0; $stockPedido=0;
		$procedimiento_model=new Procedimientos_dao;
		$prod_ctrl = new Catalogo_Ctrl();
		$get = $prod_ctrl->sesion_prod_ctrl($idproducto);
		foreach ($get as $key => $var) {
			//obtienes el precio de compra del producto
			$ppcom = $var[6];
		}
		//traer el producto del detalle_pedido si ya existiera 
		// y editarlo ,en caso contrario lo agregaria como nuevo producto
		// del carrito
		//obetener el stock del producto a añadir
		$stockActual=$procedimiento_model->validarStock($idproducto);
		$stockPedido=$procedimiento_model->obtenerStockPedidoCarrito($idpedido, $idproducto);
		$stockCarrito =$stockPedido+$cantidad;
		if($stockActual>= $stockCarrito){
			$costo = $precio - $ppcom;
			$gana = $costo * $cantidad;
			$res=$procedimiento_model->agregarCarritoPedido($idpedido, $idproducto, $cantidad, 
			$precio, $gana, $ppcom, $importe3, $importe4);
			$response='correcto';
		}else{
			$response='incorrecto';
		}
		
		
		return $response;
	}
	public function eliminarCarritoPedido($id)
	{
		$procedimiento_model=new Procedimientos_dao;
		$res=$procedimiento_model->eliminarCarritoPedido($id);
		
		return $res;
	}
	public function eliminarPedido($id)
	{
		$procedimiento_model=new Procedimientos_dao;
		$res=$procedimiento_model->eliminarPedido($id);
		
		return $res;
	}


	public function credictos__pendi_ventas_xcancelar($monto,$pendiente,$ids,$idv){
		$response=array();
		$procedimiento_model=new Procedimientos_dao;

		try {
			$procedimiento_model->getConexion()->begin_transaction(MYSQLI_TRANS_START_WITH_CONSISTENT_SNAPSHOT);
			$procedimiento_model->getConexion()->autocommit(false);
			$arr=[];

			date_default_timezone_set("America/Lima");
			$t=time();
			$fechar=date(date('Y-m-d')." "."H:i:s",$t);
			if($monto > $pendiente){
				$cobros = $pendiente;
				$pends = 0;
			}if($monto == $pendiente){
				$cobros = $pendiente;
				$pends = 0;
			}if($monto < $pendiente){
				$cobros = $monto;
				$pends = $pendiente - $monto;
			}

			$arr[]=['0' => $ids,'1' => $idv,'2' => $cobros,'3' => $pends,'4' => 0,
			'5' => $fechar,'6' => $_SESSION["MM_id"],'7' => 1,'8' => 2];

			$reg = $procedimiento_model->Pay_venta_proce_dao($arr);
			$procedimiento_model->getConexion()->next_result();

			$dataventa = $procedimiento_model->get_venta_tipodoc($idv);
			$procedimiento_model->getConexion()->next_result();
			//var_dump($dataventa);

			$keycaja=$procedimiento_model->get_xidcaja_date();
			$procedimiento_model->getConexion()->next_result();
			
			$nomdoc ='';
			switch ($dataventa[3]) {
			    case 1:
			        $nomdoc="BOLETA";
			        break;
			    case 2:
			        $nomdoc="FACTURA";
			        break;
			    case 3:
			        $nomdoc="PROFORMA";
			        break;
			}
			if($cobros>0){
				$cja[]=['0'=> $keycaja,'1'=> 1,'2' => 11,'3' => $nomdoc,
				'4' => $dataventa[2],'5' => $cobros,'6' => '','7' => 1, '8'=>1,'9'=>0,'10'=>4];
				$keycaja=$procedimiento_model->mov_caja_dao($cja);
				$procedimiento_model->getConexion()->next_result();
			}

			if ($procedimiento_model->getConexion()->commit()) {
				$procedimiento_model->getConexion()->close();
				return true;
			}
		} catch (Exception $e) {
			//die('Connection failed: ' . $e->getMessage());
			$procedimiento_model->getConexion()->rollback();
			$procedimiento_model->getConexion()->close();
			return false;
		}
	}

	public function insertar_egreso_caja_all($datos=array())
	{
		$response=array();
		$procedimiento_model=new Procedimientos_dao;

		try {
			$procedimiento_model->getConexion()->begin_transaction(MYSQLI_TRANS_START_WITH_CONSISTENT_SNAPSHOT);
			$procedimiento_model->getConexion()->autocommit(false);

			$keycaja=$procedimiento_model->get_xidcaja_date();
			$procedimiento_model->getConexion()->next_result();

			$nomdoc ='';
			switch ($datos[0]['dt3']) {
			    case 1:
			        $nomdoc="BOLETA";
			        break;
			    case 2:
			        $nomdoc="FACTURA";
			        break;
				case 3:
			        $nomdoc="PROFORMA";
			        break;
			    case 4:
			        $nomdoc="GUIA";
			        break;
			    case 5:
			        $nomdoc="TICKET";
			        break;
			    case 6:
			        $nomdoc="BOUCHER";
			    	break;
				case 7:
			        $nomdoc="RECIBO DE HONORARIOS";
			    	break;
			    case 8:
			        $nomdoc="OTROS";
			    	break;
			}

			$cja[]=['0'=> $keycaja,'1'=> $datos[0]['dt2'],'2' => $datos[0]['dt3'],'3' => $nomdoc,'4' => $datos[0]['dt4'],'5' => $datos[0]['dt5'],'6' => $datos[0]['dt6'],'7' => $datos[0]['dt9'], '8'=>$datos[0]['dt8'],'9'=>$datos[0]['dt10'],'10'=>2];
			$keycaja=$procedimiento_model->mov_caja_dao($cja);
			$procedimiento_model->getConexion()->next_result();
			

			if ($procedimiento_model->getConexion()->commit()) {
				$procedimiento_model->getConexion()->close();
				return true;
			}
		} catch (Exception $e) {
			die('Connection failed: ' . $e->getMessage());
			$cliente_model->getConexion()->rollback();
			$cliente_model->getConexion()->close();
			return false;
		}

	}


	public function get_egreso_caja_ctrl($dt){
		$egreso_caja_dao = new Procedimientos_dao();
		$res = $egreso_caja_dao->get_egreso_caja_dao($dt);
		$fila=[];
		while($rows = $res->fetch_row()){
			$fila[] = $rows;
		}
		return $fila;
	}

	public function carga_cajaxdate_ctrl($ini,$fin){
		$procedimiento_caja_dao = new Procedimientos_dao();
		$res = $procedimiento_caja_dao->carga_caja_xdate_dao($ini,$fin);
		$fila=[];
		while($rows = $res->fetch_row()){
			$fila[] = $rows;
		}
		return $fila;
	}

	public function carga_cajaactual_ctrl(){
		$procedimiento_caja_dao = new Procedimientos_dao();
		$res = $procedimiento_caja_dao->carga_caja_actual_dao();
		$fila=[];
		while($rows = $res->fetch_row()){
			$fila[] = $rows;
		}
		return $fila;
	}

	public function carga_detallecaja_ctrl($dt){
		$procedimiento_caja_dao = new Procedimientos_dao();
		$res = $procedimiento_caja_dao->carga_detallecaja_xidcaja_dao($dt);
		$fila=[];
		while($rows = $res->fetch_row()){
			$fila[] = $rows;
		}
		return $fila;
	}

	public function carga_detallecajaxfecha_ctrl($ini,$fin){
		$procedimiento_caja_dao = new Procedimientos_dao();
		$res = $procedimiento_caja_dao->carga_detallecaja_xfecha_dao($ini,$fin);
		$fila=[];
		while($rows = $res->fetch_row()){
			$fila[] = $rows;
		}
		return $fila;
	}

	public function cierre_caja_ctrl($fecha){
		$procedimiento_caja_dao = new Procedimientos_dao();
		$res = $procedimiento_caja_dao->cierre_caja_dao($fecha);
		return $res;
	}

	public function cierre_caja1_ctrl($id){
		$procedimiento_caja_dao = new Procedimientos_dao();
		$res = $procedimiento_caja_dao->cierre_caja1_dao($id);
		return $res;
	}

	public function update_nstockpro_all($idpro,$nstock)
	{
		$response=array();
		$procedimiento_model=new Procedimientos_dao;

		try {
			$procedimiento_model->getConexion()->begin_transaction(MYSQLI_TRANS_START_WITH_CONSISTENT_SNAPSHOT);
			$procedimiento_model->getConexion()->autocommit(false);
			
			$return = $procedimiento_model->update_nstock_pro_dao($idpro,$nstock);

			if ($procedimiento_model->getConexion()->commit()) {
				$procedimiento_model->getConexion()->close();
				return true;
			}
		} catch (Exception $e) {
			die('Connection failed: ' . $e->getMessage());
			$procedimiento_model->getConexion()->rollback();
			$procedimiento_model->getConexion()->close();
			return false;
		}

	}

	public function agregar_stockpro_all($idpro,$nstock)
	{
		$response=array();
		$procedimiento_model=new Procedimientos_dao;

		try {
			$procedimiento_model->getConexion()->begin_transaction(MYSQLI_TRANS_START_WITH_CONSISTENT_SNAPSHOT);
			$procedimiento_model->getConexion()->autocommit(false);
			
			$return = $procedimiento_model->add_stock_pro_dao($idpro,$nstock);

			if ($procedimiento_model->getConexion()->commit()) {
				$procedimiento_model->getConexion()->close();
				return true;
			}
		} catch (Exception $e) {
			die('Connection failed: ' . $e->getMessage());
			$procedimiento_model->getConexion()->rollback();
			$procedimiento_model->getConexion()->close();
			return false;
		}

	}
	public function disminuir_stockpro_all($idpro,$nstock)
	{
		$response=array();
		$procedimiento_model=new Procedimientos_dao;

		try {
			$procedimiento_model->getConexion()->begin_transaction(MYSQLI_TRANS_START_WITH_CONSISTENT_SNAPSHOT);
			$procedimiento_model->getConexion()->autocommit(false);
			
			$return = $procedimiento_model->disminuir_stock_pro_dao($idpro,$nstock);

			if ($procedimiento_model->getConexion()->commit()) {
				$procedimiento_model->getConexion()->close();
				return true;
			}
		} catch (Exception $e) {
			die('Connection failed: ' . $e->getMessage());
			$procedimiento_model->getConexion()->rollback();
			$procedimiento_model->getConexion()->close();
			return false;
		}

	}


	public function insertar_cliente_puntaje_all($cliente=array())
	{
		$response=array();
		$procedimiento_model=new Procedimientos_dao;

		try {
			$procedimiento_model->getConexion()->begin_transaction(MYSQLI_TRANS_START_WITH_CONSISTENT_SNAPSHOT);
			$procedimiento_model->getConexion()->autocommit(false);
			$punt=[];

			$keycli = $procedimiento_model->proc_cliente_proce_dao($cliente);
			$procedimiento_model->getConexion()->next_result();

			$punt[]=['0'=> $keycli, '1' => 0, '2'=> 0];
			$resp = $procedimiento_model->registerPuntaje_proce_Dao($punt);
			$procedimiento_model->getConexion()->next_result();

			if ($procedimiento_model->getConexion()->commit()) {
				$procedimiento_model->getConexion()->close();
				return true;
			}
		} catch (Exception $e) {
			die('Connection failed: ' . $e->getMessage());
			$procedimiento_model->getConexion()->rollback();
			$procedimiento_model->getConexion()->close();
			return false;
		}

	}

	//anular compra
	public function gets_compras_xanular($id)
	{
		$Compra_Dao = new Procedimientos_dao();
		$res = $Compra_Dao->gets_compras_xanular($id);
		$lista=[];
		while($row = $res->fetch_row()){
			$lista[]=$row;
		}
		return $lista;
	}
	public function anulacompra_anula($id_dc)
	{
		$response=array();
		$procedimiento_model=new Procedimientos_dao;
		$res = $procedimiento_model->anulacompra_anula($id_dc);
		return $res;
	}
	public function anularCompra($id)
	{
		$Compra_Dao = new Procedimientos_dao();
		$res = $Compra_Dao->anularCompra($id);
		return $res;
	}

	//anular venta
	public function gets_ventas_xanular($id)
	{
		$Compra_Dao = new Procedimientos_dao();
		$res = $Compra_Dao->gets_ventas_xanular($id);
		$lista=[];
		while($row = $res->fetch_row()){
			$lista[]=$row;
		}
		return $lista;
	}
	public function returnstockventa_anula($dt1, $dt2)
	{
		$Ventas_Dao = new Procedimientos_dao();
		$res = $Ventas_Dao->returnstockventa_anula($dt1, $dt2);
		return $res;
	}
	public function anulaventa_anula($id)
	{
		$response=array();
		$procedimiento_model=new Procedimientos_dao;
		$res = $procedimiento_model->anulaventa_anula($id);
		return $res;
	}
	public function anula_cascadeventa($id)
	{
		$Compra_Dao = new Procedimientos_dao();
		$res = $Compra_Dao->anula_cascadeventa($id);
		return $res;
	}
}
?>