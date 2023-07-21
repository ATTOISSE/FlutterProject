<?php 
$host = 'localhost';
$dbName = 'id20655786_tp_flutter';
$user = 'id20655786_flutter';
$password = 'kRTza@LkdfDkz29';

try {
    $db = new PDO("mysql:host=$host; dbname=$dbName",$user,$password);
    echo 'connexion reussie';
} catch (\Throwable $th) {
    echo "Erreur :".$th->getMessage();
}
?>