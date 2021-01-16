<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
		 pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
	<title>Medical EMR</title>
</head>
<body>
	<p>Patient Screen</p>
	<table>
		<tr>
			<th>CPT</th>
			<th>Description</th>
			<th>Name</th>
			<th>Cost</th>
		</tr>
		<tr>
		<c:forEach var="procedure" items="${procedureList}">

			<td>${procedure.cpt}</td>
			<td>${procedure.description}</td>
			<td>${procedure.name}</td>
			<td>${procedure.cost}</td>

		</c:forEach>
		</tr>
	</table>
</body>
</html>