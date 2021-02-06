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
        <h1>Patient Screen</h1>
        <form class="row g-3" action="${pageContext.request.contextPath}/PatientServlet" method="POST" >
            <input type="hidden" name="patientId" value="${patient.patientId}" />
            <input type="hidden" name="addressId" value="${patient.addressId}" />
            <input type="hidden" name="selectedGender" value="${selectedGender}" />
            <input type="hidden" name="selectedMaritalstatus" value="${patient.maritalstatus}" />
            <input type="hidden" name="selectedEmploymentstatus" value="${patient.employmentstatus}" />
                <div class="col-md-4">
                    <input type="text" name="first_name"  value="${patient.first_name}" required placeholder="Enter first name" class="form-control">
                </div>

                <div class="col-md-4">
                    <input type="text" name="last_name" value="${patient.last_name}" required placeholder="Enter last name" class="form-control">
                </div>

                <div class="col-md-4">
                    <input type="text" name="accountnumber" value="${patient.accountnumber}" maxlength="12" required placeholder="Enter account number" class="form-control">
                </div>

                <div class="col-md-4">
                    <input type="text" name="phonenumber" value="${patient.phonenumber}" placeholder="Enter your phone number" class="form-control">
                </div>

                <div class="col-md-4">
                    <input type="text" name="email" value="${patient.email}" placeholder="Enter email" class="form-control">
                </div>

                <div class="col-md-4">
                    <input type="text" name="ssn" value="${patient.ssn}" placeholder="Enter your social security number" class="form-control">
                </div>


            <div class="col-md-4">

               DOB <input type="date" name="dob" value="${patient.dob}" placeholder="Enter date of birth" class="form-control">
            </div>
            <div class="col-md-4">
                <!--  <label>Select Patient</label> -->
                GENDER<select id="genderSelect" name="gender"  placeholder="Select Gender" class="form-control">
                    <option value='' disabled selected>Select Gender</option>
                    <option value="F" ${selectedGender == 'F' ? 'selected' : ''} >Female</option>
                    <option value="M" ${selectedGender == 'M' ? 'selected' : ''}>Male</option>
                </select>
            </div>

            <div class="col-md-4"></div>

            <div class="col-md-4">
                <input type="text" name="height" value="${patient.height}" placeholder="Enter height in cm" class="form-control"/>
            </div>
            <div class="col-md-4">
                <input type="text" name="weight" value="${patient.weight}" placeholder="Enter weight in pounds" class="form-control"/>
            </div>
            <div class="col-md-4">

            </div>

            <div class="col-md-4">
                <input type="text" name="address1" value="${address.address1}" placeholder="Enter Address1" class="form-control">
            </div>
            <div class="col-md-4">
                <input type="text" name="address2" value="${address.address2}" placeholder="Enter Address2" class="form-control">
            </div>
            <div class="col-md-4">
                <input type="text" name="district" value="${address.district}" placeholder="Enter District" class="form-control">
            </div>

            <div class="col-md-4">
                <input type="text" name="city" value="${address.city}" placeholder="Enter City" class="form-control">
            </div>
            <div class="col-md-4">
                <input type="text" name="country" value="${address.country}" placeholder="Enter Country" class="form-control">
            </div>
            <div class="col-md-4">
                <input type="text" name="postalcode" value="${address.postalcode}" placeholder="Enter Postal Code" class="form-control">
            </div>

            <div class="col-md-4">
                Marital Status<select id="maritalStatusSelect" name="maritalstatus" value ="${patient.maritalstatus}"  placeholder="Select Marital Status" class="form-control">
                    <option value="" disabled selected>Select Marital Status</option>
                    <option value="Married" ${patient.maritalstatus == 'Married' ? 'selected' : ''}>Married</option>
                    <option value="Single" ${patient.maritalstatus == 'Single' ? 'selected' : ''}>Single</option>
                    <option value="Divorced" ${patient.maritalstatus == 'Divorced' ? 'selected' : ''}>Divorced</option>
                    <option value="Widowed" ${patient.maritalstatus == 'Widowed' ? 'selected' : ''}>Widowed</option>
                </select>
            </div>
            <div class="col-md-4">
                Employment Status<select id="employmentstatusSelect" name="employmentstatus"  placeholder="Select Employment Status" class="form-control">
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
                <input type="text" name="emergencyname" value="${patient.emergencyname}" placeholder="Enter emergency name" class="form-control"/>
            </div>
            <div class="col-md-4">
                <input type="text" name="emergencycontact" value="${patient.emergencycontact}" placeholder="Enter emergency contact" class="form-control"/>
            </div>
            <div class="col-md-4">

            </div>

            <div class="col-md-4">
                <textarea name="medicalhistory" rows="3"  placeholder="Enter medical history" class="form-control">${patient.medicalhistory}</textarea><br/>
            </div>

            <div class="col-md-4">
                <textarea name="allergies" rows="3"  placeholder="Enter allergies" class="form-control">${patient.allergies}</textarea><br/>
            </div>

            <div class="col-md-4">
                <textarea name="medicines" rows="3"  placeholder="Enter Medicines" class="form-control">${patient.medicines}</textarea><br/>
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