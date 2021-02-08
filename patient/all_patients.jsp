<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
		 pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/main.css">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
	<title>Medical EMR</title>
	<script>
		function updatePatient(){
			//window.location.href='ProcedureServlet';
		}

		function deletePatient(patientID){
			const result = confirm("Are you sure, you want to delete the patient?");
			if(result){
				window.location.href='${pageContext.request.contextPath}/PatientServlet?action=DELETE&patientId='+patientID;
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
		<a href="${pageContext.request.contextPath}/PatientServlet?action=LIST">Patient</a>
		<a href="${pageContext.request.contextPath}/ProcedureServlet?action=LIST">Procedure</a>
		<a href="${pageContext.request.contextPath}/PatientVisitServlet?select=NO">Patient Visit</a>
	</div>


<p>${message}</p>
<button class="btn btn-primary" onclick="window.location.href='patient/add_patient.jsp'">Add Patient</button>
	<div class="table-responsive-md text-nowrap">
<table class="table table-sm table-striped table-hover table-bordered" >
<tr>
	<th>Account</th>
	<th>Name</th>
	<th>DOB</th>
	<th>Gender</th>
	<th>Email</th>
	<th>Phone</th>
	<th>Marital Status</th>
	<th>Employment</th>
	<th>Emergency Details</th>
	<th>Update</th>
	<th>Delete</th>
</tr>

	<c:forEach items="${list}" var="patient">
	<tr>
	<td>${patient.accountnumber}</td>
		<td>${patient.first_name} ${patient.last_name}</td>
		<td>${patient.dob}</td>
		<td>${patient.gender}</td>
		<td>${patient.email}</td>
		<td>${patient.phonenumber}</td>
		<td>${patient.maritalstatus}</td>
		<td>${patient.employmentstatus}</td>
		<td>${patient.emergencyname} * ${patient.emergencycontact}</td>

		<td><input type="button" name="update" value="Update" onclick="window.location.href='${pageContext.request.contextPath}/PatientServlet?action=EDIT&patientId=${patient.patientId}'"/></td>
		<td><input type="button" name="delete" value="Delete" onclick='deletePatient(${patient.patientId})'/></td>
		</tr>
		</c:forEach>
		</table>
	</div>
    </div>
		</body>

		</html>