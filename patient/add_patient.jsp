<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add / Edit Patient</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/patient.css">
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
        <h5>Patient Screen</h5>
        <form class="row" action="${pageContext.request.contextPath}/PatientServlet" method="POST" >
            <input type="hidden" name="patientId" value="${patient.patientId}" />
            <input type="hidden" name="addressId" value="${patient.addressId}" />
            <input type="hidden" name="selectedGender" value="${selectedGender}" />
            <input type="hidden" name="selectedMaritalstatus" value="${patient.maritalstatus}" />
            <input type="hidden" name="selectedEmploymentstatus" value="${patient.employmentstatus}" />
                <div class="col-md-4">
                   FIRST NAME <input type="text" name="first_name"  value="${patient.first_name}" required class="form-control form-control-sm">
                </div>

                <div class="col-md-4">
                   LAST NAME <input type="text" name="last_name" id="inputsm" value="${patient.last_name}" required class="form-control form-control-sm">
                </div>

                <div class="col-md-4">
                  ACCOUNT NUMBER  <input type="text" name="accountnumber" value="${patient.accountnumber}" maxlength="7" required  class="form-control form-control-sm">
                </div>

                <div class="col-md-4">
                   PHONE NUMBER <input type="text" name="phonenumber" value="${patient.phonenumber}"  class="form-control form-control-sm">
                </div>

                <div class="col-md-4">
                    EMAIL<input type="text" name="email" value="${patient.email}"  class="form-control form-control-sm">
                </div>

                <div class="col-md-4">
                  SSN  <input type="text" name="ssn" value="${patient.ssn}" maxlength="10" class="form-control form-control-sm">
                </div>


            <div class="col-md-4">

               DOB <input type="date" name="dob" value="${patient.dob}"  class="form-control form-control-sm">
            </div>
            <div class="col-md-4">
                <!--  <label>Select Patient</label> -->
                GENDER<select id="genderSelect" name="gender"   class="form-control form-control-sm">
                    <option value='' disabled selected>Select Gender</option>
                    <option value="F" ${selectedGender == 'F' ? 'selected' : ''} >Female</option>
                    <option value="M" ${selectedGender == 'M' ? 'selected' : ''}>Male</option>
                </select>
            </div>

            <div class="col-md-4"></div>

            <div class="col-md-4">
              HEIGHT IN CMS <input type="text" name="height" value="${patient.height}"  class="form-control form-control-sm"/>
            </div>
            <div class="col-md-4">
               WEIGHT IN POUNDS <input type="text" name="weight" value="${patient.weight}"  class="form-control form-control-sm"/>
            </div>
            <div class="col-md-4">

            </div>

            <div class="col-md-4">
                ADDRESS1<input type="text" name="address1" value="${address.address1}"  class="form-control form-control-sm">
            </div>
            <div class="col-md-4">
               ADDRESS2 <input type="text" name="address2" value="${address.address2}" class="form-control form-control-sm">
            </div>
            <div class="col-md-4">
               DISTRICT <input type="text" name="district" value="${address.district}"  class="form-control form-control-sm">
            </div>

            <div class="col-md-4">
              CITY  <input type="text" name="city" value="${address.city}"  class="form-control form-control-sm">
            </div>
            <div class="col-md-4">
              COUNTRY  <input type="text" name="country" value="${address.country}"  class="form-control form-control-sm">
            </div>
            <div class="col-md-4">
               POSTAL CODE <input type="text" name="postalcode" value="${address.postalcode}"  class="form-control form-control-sm">
            </div>

            <div class="col-md-4">
                Marital Status<select id="maritalStatusSelect" name="maritalstatus" value ="${patient.maritalstatus}"  class="form-control form-control-sm">
                    <option value="" disabled selected>Select Marital Status</option>
                    <option value="Married" ${patient.maritalstatus == 'Married' ? 'selected' : ''}>Married</option>
                    <option value="Single" ${patient.maritalstatus == 'Single' ? 'selected' : ''}>Single</option>
                    <option value="Divorced" ${patient.maritalstatus == 'Divorced' ? 'selected' : ''}>Divorced</option>
                    <option value="Widowed" ${patient.maritalstatus == 'Widowed' ? 'selected' : ''}>Widowed</option>
                </select>
            </div>
            <div class="col-md-4">
                Employment Status<select id="employmentstatusSelect" name="employmentstatus"  class="form-control form-control-sm">
                    <option value="" disabled selected>Select Employment Status</option>
                    <option value="Full Time" ${patient.employmentstatus == 'Full Time' ? 'selected' : ''}>Full Time</option>
                    <option value="Part Time" ${patient.employmentstatus == 'Part Time' ? 'selected' : ''}>Part Time</option>
                    <option value="Umemployed" ${patient.employmentstatus == 'Unemployed' ? 'selected' : ''}>Unemployed</option>
                    <option value="Retired" ${patient.employmentstatus == 'Retired' ? 'selected' : ''}>Retired</option>
                    <option value="Student" ${patient.employmentstatus == 'Student' ? 'selected' : ''}>Student</option>
                    <option value="Self Employed" ${patient.employmentstatus == 'Self Employed' ? 'selected' : ''}>Self Employed</option>
                </select>
            </div>
            <div class="col-md-4">

            </div>

            <div class="col-md-4">
              EMERGENCY NAME  <input type="text" name="emergencyname" value="${patient.emergencyname}" class="form-control form-control-sm"/>
            </div>
            <div class="col-md-4">
               EMERGENCY CONTACT <input type="text" name="emergencycontact" value="${patient.emergencycontact}" class="form-control form-control-sm"/>
            </div>
            <div class="col-md-4">

            </div>

            <div class="col-md-4">
               MEDICAL HISTORY <textarea name="medicalhistory" rows="3"  class="form-control form-control-sm">${patient.medicalhistory}</textarea><br/>
            </div>

            <div class="col-md-4">
               ALLERGIES <textarea name="allergies" rows="3"  class="form-control form-control-sm">${patient.allergies}</textarea><br/>
            </div>

            <div class="col-md-4">
              MEDICINES  <textarea name="medicines" rows="3" class="form-control form-control-sm">${patient.medicines}</textarea><br/>
            </div>
            <div class="col-md-2"></div><div class="col-md-2"></div>
            <div class="col-md-2">
            <button class="btn btn-primary" type="submit" onclick="return validation()">Save Patient</button>
            </div>
            <div class="col-md-6"></div>

            <div class="col-md-12"></div>
        </form>
    </div>

    <div class="footer">
        <p> All Rights Reserved. Copyright &copy; 2021</p>
    </div>

</body>

</html>