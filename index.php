<?php
    $servername = "localhost";
    $username = "stechzeit_nutzer";
    $password = "blabla";
    $dbname = "stechzeiten";
    
// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$sql  = 'SELECT * FROM `stechzeiten`';
$result = $conn->query($sql);
if ($result->num_rows > 0) {
    echo '<head><link rel="stylesheet" href="styles.css"></head><body><br><table class="container"><tr><th><h1>Tag</h1></th><th><h1>Uhrzeit</h1></th><th><h1>Status</h1></th></tr>';
    // output data of each row
    while($row = $result->fetch_assoc()) {
        echo "<tr><td>". $row["Datum"]. "</td><td>". $row["Uhrzeit"]. "</td><td>" . $row["Status"] . "</td></tr>";
    }
    echo "</table><br></body>";
} else {
    echo "0 results";
}


$conn->close();
?>
