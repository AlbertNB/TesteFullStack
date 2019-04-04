<?php
$host = "localhost"; 
$user = "root"; 
$password = ""; 
$dbname = "appstore_db"; 
$cliente_id = $_GET['cliente_id'];


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

$method = $_SERVER['REQUEST_METHOD'];
//$input = json_decode(file_get_contents('php://input'),true);

if (!$con) {
  die("Connection failed: " . mysqli_connect_error());
}


switch ($method) {
    case 'GET':
      $sql = "SELECT modulo.id,nome,categoria.titulo AS categoria,cor_bg AS cor,categoria.cor AS cor_cat,icone,preco,cliente_modulo.ativo AS status FROM modulo LEFT JOIN cliente_modulo ON modulo.id = cliente_modulo.Modulo_id AND cliente_modulo.Cliente_id = ". $cliente_id . " LEFT JOIN categoria ON Categoria_id = categoria.id ORDER BY modulo.id";
      break;
}

// run SQL statement
$result = mysqli_query($con,$sql);

// die if SQL statement failed
if (!$result) {
  http_response_code(404);
  die(mysqli_error($con));
}

$return = "[";
	for ($i=0 ; $i<mysqli_num_rows($result) ; $i++) {
	  $encode = json_encode(mysqli_fetch_object($result));
	  if($encode){
		$return = $return . ($i>0?',':'') . $encode ;
	  }
	}
	$return = $return . ']';
	
	str_replace("null","",$return);
	
	header("Content-type: application/json");
	echo $return;


$con->close();