<!DOCTYPE html>
<html lang="en">
<head>
  <title>Medical EMR</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="${pageContext.request.contextPath}/resources/main.css" rel="stylesheet"></link>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
</head>
<body>

<div class="header">
  <h1>MedicalEMR</h1>
</div>

<div class="topnav">
  <a href="${pageContext.request.contextPath}/index.jsp">Home</a>
  <a href="#">Patient</a>
  <a href="${pageContext.request.contextPath}/ProcedureServlet?action=LIST">Procedure</a>
  <a href="${pageContext.request.contextPath}/PatientVisitServlet?select=NO">Patient Visit</a>
</div>

<div class="row">
  <div class="column side">
  </div>

  <div class="column middle">
    <h4>EMR Portal</h4>
    <h5>Overview</h5>
    <p>MedicalEMR portal helps dentists to keep all the information about their patients. It allows to add new CPT codes introduced by American Dental Association.
    Being web based, it allows you to access your patients' records anytime with mobile devices with internet access. </p>
    <h5>Access to Dental Records</h5>
    <p>The software helps the dental office to access the dental records of patients at a single glance. It may help the dentist to know which dental procedures have been done before on the patients.</p>
    Also, it allows to access the medical history of patients. This is very vital for performing certain dental procedures.
    For instance, if a patient is a cardiac and taking anti-coagulant medication, you may advise them to stop taking it for a couple of days before they come for tooth extraction,etc. </p>
    <h5>Appointment Scheduling</h5>
    <p>It allows to schedule future appointments for your patients.</p>

  </div>

  <div class="column side">

  </div>
</div>

<div class="footer">
  <p> All Rights Reserved. Copyright &copy; 2021</p>
</div>

</body>
</html>
