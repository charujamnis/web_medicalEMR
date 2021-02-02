<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<title>Add / Edit Patient</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/main.css">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
	<script>
		function validation(){

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
	<h1>Patient Screen</h1>
	<div class=""row>
		<div class="col-md-4">
			<form action="${pageContext.request.contextPath}/PatientServlet" class="form-horizontal" method="POST">
				<div class="form-group">
					<input type="hidden" name="patientId" value="${patient.patientId}" class="form-control"/>
				</div>
				<div>
					<input type="text" name="accountnumber" value="${patient.accountnumber}" maxlength="12" required placeholder="Enter account number" class="form-control"/><br/>
				</div>
				<div>
					<input type="hidden" name="addressId" value="${patient.addressId}" maxlength="12" required placeholder="Enter address Id" class="form-control"/><br/>
				</div>
				<div>
					<textarea name="first_name" rows="1" required placeholder="Enter first name" class="form-control">${patient.first_name}</textarea><br/>
				</div>
				<div>
					<textarea name="last_name" rows="1" required placeholder="Enter last name" class="form-control">${patient.last_name}</textarea><br/>
				</div>
				<div>
					<input type="date" name="dob" value="${patient.dob}" placeholder="Enter date of birth" class="form-control"/><br/>
				</div>
				<div class="form-group">
					<!--  <label>Select Patient</label> -->
					<select id="genderSelect" name="gender" required placeholder="Select Gender" class="form-control" onchange="sendPatientIdToServlet();">
						<option value="" disabled selected>Select Gender</option>
						<option value="F" ${patient.gender == selectedGender ? 'selected' : ''}>Female</option>
						<option value="M" ${patient.gender == selectedGender ? 'selected' : ''}>Male</option>
					</select>
				</div></br>

<%--				<div>--%>
<%--					<input type="text" name="gender" value="${patient.gender}" placeholder="Enter your gender" class="form-control"/><br/>--%>
<%--				</div>--%>
				<div>
					<input type="text" name="height" value="${patient.height}" placeholder="Enter height in cm" class="form-control"/><br/>
				</div>
				<div>
					<input type="text" name="weight" value="${patient.weight}" placeholder="Enter weight in pounds" class="form-control"/><br/>
				</div>
				<div>
					<input type="text" name="email" value="${patient.email}" placeholder="Enter email" class="form-control"/><br/>
				</div>
				<div>
					<input type="text" name="phonenumber" value="${patient.phonenumber}" placeholder="Enter your phone number" class="form-control"/><br/>
				</div>
				<div class="form-group">
					<!--  <label>Select Patient</label> -->
					<select id="maritalStatusSelect" name="maritalstatus" required placeholder="Select Marital Status" class="form-control" onchange="sendPatientIdToServlet();">
						<option value="" disabled selected>Select Marital Status</option>
						<option value="Married" ${patient.maritalstatus == selectedMaritalstatus ? 'selected' : ''}>Married</option>
						<option value="Single" ${patient.maritalstatus == selectedMaritalstatus ? 'selected' : ''}>Single</option>
						<option value="Divorced" ${patient.maritalstatus == selectedMaritalstatus ? 'selected' : ''}>Divorced</option>
						<option value="Widowed" ${patient.maritalstatus == selectedMaritalstatus ? 'selected' : ''}>Widowed</option>
					</select>
				</div></br>
<%--				<div>--%>
<%--					<input type="text" name="maritalstatus" value="${patient.maritalstatus}" placeholder="Enter marital status" class="form-control"/><br/>--%>
<%--				</div>--%>
				<div>
					<input type="text" name="ssn" value="${patient.ssn}" placeholder="Enter your social security number" class="form-control"/><br/>
				</div>
				<div>
					<input type="text" name="emergencyname" value="${patient.emergencyname}" placeholder="Enter emergency name" class="form-control"/><br/>
				</div>
				<div>
					<input type="text" name="emergencycontact" value="${patient.emergencycontact}" placeholder="Enter emergency contact" class="form-control"/><br/>
				</div>
				<div class="form-group">
					<!--  <label>Select Patient</label> -->
					<select id="employmentstatusSelect" name="employmentstatus" required placeholder="Select Employment Status" class="form-control" onchange="sendPatientIdToServlet();">
						<option value="" disabled selected>Select Employment Status</option>
						<option value="Full Time" ${patient.employmentstatus == selectedEmploymentstatus ? 'selected' : ''}>Full Time</option>
						<option value="Part Time" ${patient.employmentstatus == selectedEmploymentstatus ? 'selected' : ''}>Part Time</option>
						<option value="Umemployed" ${patient.employmentstatus == selectedEmploymentstatus ? 'selected' : ''}>Unemployed</option>
						<option value="Retired" ${patient.employmentstatus == selectedEmploymentstatus ? 'selected' : ''}>Retired</option>
						<option value="Student" ${patient.employmentstatus == selectedEmploymentstatus ? 'selected' : ''}>Student</option>
						<option value="Self Employed" ${patient.employmentstatus == selectedEmploymentstatus ? 'selected' : ''}>Self Employed</option>
					</select>
				</div></br>
<%--				<div>--%>
<%--					<input type="text" name="employmentstatus" value="${patient.employmentstatus}" placeholder="Enter employment status" class="form-control"/><br/>--%>
<%--				</div>--%>
				<div>
					<input type="text" name="medicalhistory" value="${patient.medicalhistory}" placeholder="Enter medical history" class="form-control"/><br/>
				</div>
				<div>
					<input type="text" name="allergies" value="${patient.allergies}" placeholder="Enter allergies" class="form-control"/><br/>
				</div>
				<div>
					<input type="text" name="medicines" value="${patient.medicines}" placeholder="Enter medicines" class="form-control"/><br/>
				</div>
				<button class="btn btn-primary" type="submit" onclick="return validation()">Save Patient</button>
			</form>
		</div>
	</div>
</div>
