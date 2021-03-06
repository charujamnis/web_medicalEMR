<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/main.css">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
	<title>Medical EMR</title>
	<script>
		function updateProcedure(){
			//window.location.href='ProcedureServlet';
		}

		function deleteProcedure(procedureID){
			const result = confirm("Are you sure, you want to delete the procedure?");
			if(result){
				window.location.href='${pageContext.request.contextPath}/ProcedureServlet?action=DELETE&procedureId='+procedureID;
			}
		}
	</script>
</head>
<body>
<div class="container-fluid">
	<div class="header">
		<h1>MedicalEMR</h1>
	</div>

	<div class="topnav">
		<a href="${pageContext.request.contextPath}/index.jsp">Home</a>
		<a href="PatientServlet?action=LIST">Patient</a>
		<a href="ProcedureServlet?action=LIST">Procedure</a>
		<a href="PatientVisitServlet?select=NO">Patient Visit</a>
	</div>

	<section>

		<main>

	<p>${message}</p>
	<button class="btn btn-primary" onclick="window.location.href='procedure/add_procedure.jsp'">Add Procedure</button>
	<table class="table table-striped table-hover table-bordered">
		<tr>
			<th>CPT</th>
			<th>Description</th>
			<th>Name</th>
			<th>Cost </th>
			<th>Update</th>
			<th>Delete</th>
		</tr>

		 <%--@elvariable id="procedureList" type="java.util.List"--%>
		 <c:forEach items="${list}" var="procedure">
			<tr>
				<td>${procedure.cpt}</td>
				<td>${procedure.description}</td>
				<td>${procedure.name}</td>
				<td>${procedure.cost}</td>
				<td><input type="button" name="update" value="Update" onclick="window.location.href='${pageContext.request.contextPath}/ProcedureServlet?action=EDIT&procedureId=${procedure.procedureId}'"/></td>
				<td><input type="button" name="delete" value="Delete" onclick='deleteProcedure(${procedure.procedureId})'/></td>
			</tr>
		</c:forEach>
	</table>
		</main>
	</section>
</div>
</body>
</html>