<!-- Done by Jeongwon Eom -->
<?php
     include_once 'dbh.inc.php';
     if(isset($_POST['submit'])){
         $title=$_POST['title'];
         $content=$_POST['content'];
         $date = date("Y-m-d H:i:s");

         $sql="insert into memo(subject, memo, regdate) values ('$title','$content','$date')";
         $result = mysqli_query($conn, $sql);
         if($result){
             //echo "success";
             header('location: display_memo.php');
         }else{
             die(mysqli_error($conn));
         }
     }
?>
<?php
     include_once 'nav_MyPage_added.php';
?>
<!DOCTYPE html>
<html lang="en">
<head>
     <title>Prism</title>
     <link rel="stylesheet" href="/css/bootstrap.css">
</head>
<body>
<div class="container">
<form method="POST">
  <div class="form-group">
    <label>Title</label>
    <input type="text" class="form-control" name="title" placeholder="Enter title">
  </div>
  <div class="form-group">
    <label>Content</label>
    <input type="text" class="form-control" name="content" placeholder="Type something....">
  </div>

  <button type="submit" class="btn btn-primary" name="submit">Submit</button>
</form>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> 
<script type="text/javascript" src="/js/bootstrap.js"></script>

</body>
</html>