<?php
$host = "localhost"; 
$user = "root"; 
$password = ""; 
$dbname = "appstore_db"; 
$method = $_SERVER['REQUEST_METHOD'];

  if (isset($_SERVER['HTTP_ORIGIN'])) {
        header("Access-Control-Allow-Origin: {$_SERVER['HTTP_ORIGIN']}");
        header('Access-Control-Allow-Credentials: true');
        header('Access-Control-Max-Age: 86400');
    }

    // Access-Control headers are received during OPTIONS requests
    if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {

        if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_METHOD']))
            header("Access-Control-Allow-Methods: GET, POST, OPTIONS");         

        if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']))
            header("Access-Control-Allow-Headers: {$_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']}");
        exit(0);
    }
	
$con = mysqli_connect($host, $user, $password,$dbname); 
$con->set_charset("utf8");

if (!$con) {
  die("Connection failed: " . mysqli_connect_error());
}

switch ($method) {
    case 'GET':
	  $cliente_id = $_GET['cliente_id'];
      $sql = "SELECT modulo.id,nome,categoria.titulo AS categoria,cor_bg AS cor,categoria.cor AS cor_cat,icone,preco,cliente_modulo.ativo AS status FROM modulo LEFT JOIN cliente_modulo ON modulo.id = cliente_modulo.Modulo_id AND cliente_modulo.Cliente_id = ". $cliente_id . " LEFT JOIN categoria ON Categoria_id = categoria.id ORDER BY modulo.id";
	break;
	case 'POST':
		$request =    $_REQUEST['request'];
		$modulo_id  = $_REQUEST['modulo_id'];
		$cliente_id = $_REQUEST['cliente_id'];
		$ativo      = $_REQUEST['ativo'];
			if($request == 1){
				$sql = "UPDATE `cliente_modulo` SET `ativo` = ".$ativo." WHERE `cliente_modulo`.`Cliente_id` = " .$cliente_id . " AND `cliente_modulo`.`Modulo_id` = ". $modulo_id . "; " ;
			}elseif($request == 2){
				$sql = "INSERT INTO `cliente_modulo` (`Cliente_id`, `Modulo_id`, `ativo`) VALUES ('".$cliente_id."','" .$modulo_id."','".$ativo."');";
			}
    break;
}	

// run SQL statement
$result = mysqli_query($con,$sql);

if($method == 'GET'){
	if (!$result) {
		http_response_code(404);
		die(mysqli_error($con));
	}
$return = "[";
	for ($i=0 ; $i<mysqli_num_rows($result) ; $i++) {
	  $encode = utf8_decode(json_encode(mysqli_fetch_object($result)));
	  if($encode){
		$return = $return . ($i>0?',':'') . $encode ;
	  }
	}
	$return = $return . ']';
	
	str_replace("null","",$return);
	
	header("Content-type: application/json");
	echo $return;
}

$con->close();