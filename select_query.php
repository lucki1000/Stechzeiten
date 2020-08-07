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

$sql  = 'SELECT * FROM `stechzeiten` ORDER BY Datum ASC, Uhrzeit DESC';
$result = $conn->query($sql);
if ($result->num_rows > 0) {
    // output data of each row
    while($row = $result->fetch_assoc()) {
        echo "<tr><td>". $row["ID"]. "</td><td>". $row["Datum"]. "</td><td>". $row["Uhrzeit"]. "</td><td>" . $row["Status"] . "</td></tr>";
    }
} else {
    echo "0 results";
}
$conn->close();
?>