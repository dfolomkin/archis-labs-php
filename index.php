<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>index.php</title>
	<link href="public/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<?php
		require('app/config.php');
	?>
	<div class="container">
		<div class="row">
			<div class="col-sm-2">
			</div>
			<div class="col-sm-8">
				<h1>Клиенты</h1>
				<table class="table table-hover">
					<thead>
						<tr>
							<td>Номер</td>
							<td>Имя</td>
							<td>Фамилия</td>
							<td></td>
						</tr>
					</thead>
					<tbody>
						<?php
							//извлечение данных из базы и запись в таблицу построчно
							$sql = mysqli_query($link, "SELECT client_id, client_fname, client_sname FROM client");
							while ($result = mysqli_fetch_array($sql)) {
								echo '<tr><td>'.$result['client_id'].'</td><td>'.$result['client_fname'].'</td><td>'.$result['client_sname'].'</td><td><a href="?del='.$result['client_id'].'">Удалить</a></td></tr>';
							}
						?>
					</tbody>
				</table>
			</div>
			<div class="col-sm-2">
			</div>
		</div>
		<div class="row">
			<div class="col-sm-3">
			</div>
			<div class="col-sm-6">
				<form role="form" action="" method="post">
					<div class="form-group">
						<label for="id">Номер</label>
						<input type="text" name="c_id" class="form-control" id="id" placeholder="Номер">
					</div>
					<div class="form-group">
						<label for="fname">Имя</label>
						<input type="text" name="c_fname" class="form-control" id="fname" placeholder="Имя">
					</div>
					<div class="form-group">
						<label for="sname">Фамилия</label>
						<input type="text" name="c_sname" class="form-control" id="sname" placeholder="Фамилия">
					</div>
					
					<button type="submit" class="btn btn-default">Отправить</button>
				</form>

				<?php
					//отправка данных с формы в базу методом POST
					$id = filter_input(INPUT_POST, 'c_id');
					$fname = filter_input(INPUT_POST, 'c_fname');
					$sname = filter_input(INPUT_POST, 'c_sname');
					
					if (isset($fname) && isset($sname)) {
						if (!empty($id)) {
							$sql = mysqli_query($link, "INSERT INTO client (client_id, client_fname, client_sname) VALUES ('$id', '$fname', '$sname')");
						}
						else {
							$sql = mysqli_query($link, "INSERT INTO client (client_fname, client_sname) VALUES ('$fname', '$sname')");
						}

						if ($sql) {
							echo '<div class="alert alert-success">Данные успешно добавлены в таблицу.</div>';
						} else {
							echo '<div class="alert alert-danger">Произошла ошибка.</div>';
						}
						
						header('location:'.$_SERVER['HTTP_REFERER']);
						//header('Location: '.Url::$url);
						//header('Location: http://'.$_SERVER['SERVER_NAME'].'/'.$_SERVER['REQUEST_URI']);
						//header('Location: http://'.$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'].'?success'); exit();
					}
				?>

				<?php
					//перехват значения 'del' массива $_GET и запрос на удаление соответствующей строки
					$del = filter_input(INPUT_GET, 'del');

					if (isset($del)) {
						$sql = mysqli_query($link, "DELETE FROM client WHERE client_id = '$del'");
						if ($sql) {
							echo '<div class="alert alert-success">Строка успешно удалена.</div>';
						} else {
							echo '<div class="alert alert-danger">Произошла ошибка.</div>';
						}
						
						header('location:'.$_SERVER['HTTP_REFERER']);
					}
				?>
			</div>
			<div class="col-sm-3">
			</div>
		</div>
    </div>

    <script src="public/js/jquery-3.1.0.min.js"></script>
    <script src="public/js/bootstrap.min.js"></script>
</body>
</html>