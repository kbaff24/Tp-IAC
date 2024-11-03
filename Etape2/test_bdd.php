<?php
// test_bdd.php

$servername = "data"; // Nom du conteneur de base de données
$username = "root";
$password = "rootpassword";
$dbname = "testdb";

// Créer la connexion
$conn = new mysqli($servername, $username, $password, $dbname);

// Vérifier la connexion
if ($conn->connect_error) {
    die("Erreur de connexion: " . $conn->connect_error);
}

// Créer une table si elle n'existe pas
$sql = "CREATE TABLE IF NOT EXISTS test_table (id INT(11) AUTO_INCREMENT PRIMARY KEY, name VARCHAR(255) NOT NULL)";
$conn->query($sql);

// Effectuer une insertion
$sql = "INSERT INTO test_table (name) VALUES ('Nom " . rand(1, 100) . "')";
$conn->query($sql);

// Lire des données
$sql = "SELECT * FROM test_table";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    echo "<h1>Données de la table:</h1><ul>";
    while($row = $result->fetch_assoc()) {
        echo "<li>ID: " . $row["id"] . " - Nom: " . $row["name"] . "</li>";
    }
    echo "</ul>";
} else {
    echo "Aucune donnée trouvée.";
}

// Fermer la connexion
$conn->close();
?>
