<!-- Done by Suhaeni Cici  -->
<?php
     include_once 'dbh.inc.php';
?>

<!DOCTYPE html>
<html lang="en">
<head>
     <title>Prism</title>
     <link rel="stylesheet" href="/css/bootstrap.css">
</head>
<body>

<?php
     include_once 'nav.php';
?>

<!-- 데이터베이스에 가서 데이터를 찾아서 보여주기 -->
<?php
     $sql = "SELECT events.*, games.name AS games_name, sports.name AS sports_name FROM events INNER JOIN games ON games.id = events.games_id INNER JOIN sports ON sports.id = events.sport_id";
     $result = mysqli_query($conn, $sql);
     $resultCheck = mysqli_num_rows($result);

     if($resultCheck > 0){
          echo "<table class = \"table  table-bordered\" border = \"1\">";

          echo "<thead class=\"thead-dark\">";
          echo "<th scope=\"col\">id</th>";
          echo "<th scope=\"col\">name</th>";
          echo "<th scope=\"col\">game's id</th>";
          echo "<th scope=\"col\">sport's id</th>";
          echo "</thead>";

          while($row = mysqli_fetch_assoc($result)){
               echo "<tr>" . "<td>" . $row['id'] . "</td>". "<td>" . $row['name'] . "</td>". "<td>" . $row['games_id'] . "</td>" . "<td>" . $row['sport_id'] . "</td>". "<br>" . "</tr>";
          }
          echo "</table>";
     }
?>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> 
<script type="text/javascript" src="/js/bootstrap.js"></script>

</body>
</html>