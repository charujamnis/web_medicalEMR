package com.dtcc.dao;

import com.dtcc.model.Address;
import com.dtcc.model.Patient;
import com.dtcc.model.Procedure;
import com.dtcc.util.DBConnectionUtil;

import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;

public class PatientDAOImpl implements PatientDAO {
    Connection connection =null;
    Statement statement=null;
    ResultSet resultSet=null;
    PreparedStatement psDeletePatient = null;
    PreparedStatement psUpdatePatient = null;
    PreparedStatement psAddPatient = null;
    PreparedStatement psAddAddress=null;
    PreparedStatement psUpdateAddress=null;

    @Override
    public List<Patient> get() {
        List<Patient> patientList=null;
        Patient patient =null;

        try{

            patientList=new ArrayList<Patient>(); //procedure list
            String sql="select * from patient where logicalDelete=0";  //sql statement
            connection= DBConnectionUtil.getConnection();	//get the database connection
            statement=connection.createStatement();	//create statement
            resultSet=statement.executeQuery(sql); 	//execute the query.

            while(resultSet.next()){

                patient=new Patient();
                patient.setPatientId(resultSet.getInt("patientId"));
                patient.setAccountnumber(resultSet.getInt("accountnumber"));
                patient.setFirst_name(resultSet.getString("first_name"));
                patient.setLast_name(resultSet.getString("last_name"));
                patient.setDob(resultSet.getDate("dob"));
                patient.setGender(resultSet.getString("gender").charAt(0));
                patient.setEmail(resultSet.getString("email"));
                patient.setPhonenumber(resultSet.getString("phonenumber"));
                patient.setMaritalstatus(resultSet.getString("maritalstatus"));
                patient.setEmergencyname(resultSet.getString("Emergencyname"));
                patient.setEmergencycontact(resultSet.getString("Emergencycontact"));
                patient.setEmploymentstatus(resultSet.getString("Employmentstatus"));
                //System.out.println("The First name is "+resultSet.getString("first_name"));
                patientList.add(patient);		//add patient object to the patient List.
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return patientList;
    }

   // @Override
   // public Address getPatientAddress(int addressId) {
     //   return null;
   // }

   // @Override //edit patient
    public boolean update(Patient patient,Address address) {
        boolean flag=false;
        try{
            int addressID=0;

            connection = DBConnectionUtil.getConnection();
            String getAddressIdSql="select addressId from Patient where patientId=?";
            PreparedStatement ps=connection.prepareStatement(getAddressIdSql);
            ps.setInt(1,patient.getPatientId());
            ResultSet rs=ps.executeQuery();

            while(rs.next()){
                addressID=rs.getInt("addressId");
            }

            String updateAddressSql = "update address set address1=?, address2=?,district=?,city=?,postalcode=?,country=? where addressId=?";
            psUpdateAddress=connection.prepareStatement(updateAddressSql);
            psUpdateAddress.setString(1, address.getAddress1());
            psUpdateAddress.setString(2, address.getAddress2());
            psUpdateAddress.setString(3, address.getDistrict());
            psUpdateAddress.setString(4, address.getCity());
            psUpdateAddress.setString(5, address.getPostalcode());
            psUpdateAddress.setString(6, address.getCountry());
            psUpdateAddress.setInt(7, addressID);
            psUpdateAddress.executeUpdate();

            String updatePatientSql = "Update patient set accountnumber=?, first_name=?, last_name=?,dob=?, gender=?,height=?, weight=?, email =?," +
                    "phonenumber=?,maritalstatus=?,ssn=?,emergencyname=?, emergencycontact=?,employmentstatus=?,medicalhistory=?, allergies=?," +
                    "medicines=?,createddate=? where patientId=?";
            psUpdatePatient=connection.prepareStatement(updatePatientSql);
            //psUpdatePatient.setInt(1, patient.getPatientId());
            psUpdatePatient.setInt(1, patient.getAccountnumber());
            //psUpdatePatient.setInt(2, patient.getAddressId());
            psUpdatePatient.setString(2, patient.getFirst_name());
            psUpdatePatient.setString(3, patient.getLast_name());
            if(patient.getDob()==null){psUpdatePatient.setDate(4,null);}
            else{  psUpdatePatient.setDate(4, new java.sql.Date(patient.getDob().getTime()));}
            psUpdatePatient.setString(5, patient.getGender()+"");
            psUpdatePatient.setDouble(6, patient.getHeight());
            psUpdatePatient.setDouble(7, patient.getWeight());
            psUpdatePatient.setString(8, patient.getEmail());
            psUpdatePatient.setString(9, patient.getPhonenumber());
            psUpdatePatient.setString(10, patient.getMaritalstatus());
            psUpdatePatient.setLong(11, patient.getSsn());
            psUpdatePatient.setString(12, patient.getEmergencyname());
            psUpdatePatient.setString(13, patient.getEmergencycontact());
            psUpdatePatient.setString(14, patient.getEmploymentstatus());
            psUpdatePatient.setString(15, patient.getMedicalhistory());
            psUpdatePatient.setString(16, patient.getAllergies());
            psUpdatePatient.setString(17, patient.getMedicines());
            Date utilDate = new Date();
            java.sql.Date date = new java.sql.Date(utilDate.getTime());
            psUpdatePatient.setDate(18, date);
            psUpdatePatient.setInt(19, patient.getPatientId());
            psUpdatePatient.executeUpdate();
            flag=true;
        }catch(SQLException e){
            e.printStackTrace();
        }
        return flag;
    }

    @Override
    public boolean save(Patient patient,Address address) {
        boolean flag=false;
        try{
            int addressID = 0;

            connection=DBConnectionUtil.getConnection();

            String addAddressSql = "insert into Address values(?,?,?,?,?,?,?,?)";
            psAddAddress = connection.prepareStatement(addAddressSql);
            psAddAddress.setInt(1, 0);
            psAddAddress.setString(2, address.getAddress1());
            psAddAddress.setString(3, address.getAddress2());
            psAddAddress.setString(4, address.getDistrict());
            psAddAddress.setString(5, address.getCity());
            psAddAddress.setString(6, address.getPostalcode());
            psAddAddress.setString(7, address.getCountry());
            psAddAddress.setInt(8, 0);
            psAddAddress.execute();

            String getAddressIdSql = "select max(addressId) as count from address";
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery(getAddressIdSql);

            while (rs.next()) {
                addressID = rs.getInt("count");
            }

            String addPatientSql = "insert into patient values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

            psAddPatient = connection.prepareStatement(addPatientSql);
            psAddPatient.setInt(1, 0);
            psAddPatient.setInt(2, patient.getAccountnumber());
            psAddPatient.setInt(3, addressID);
            psAddPatient.setString(4, patient.getFirst_name());
            psAddPatient.setString(5, patient.getLast_name());
            if(patient.getDob()==null){
                psAddPatient.setDate(6,null);
            }else{
                psAddPatient.setDate(6, (new java.sql.Date(patient.getDob().getTime())));
            }

            psAddPatient.setString(7, patient.getGender()+"");
            psAddPatient.setDouble(8, patient.getHeight());
            psAddPatient.setDouble(9, patient.getWeight());
            psAddPatient.setString(10, patient.getEmail());
            psAddPatient.setString(11, patient.getPhonenumber());
            psAddPatient.setString(12, patient.getMaritalstatus());
            psAddPatient.setLong(13, patient.getSsn());
            psAddPatient.setString(14, patient.getEmergencyname());
            psAddPatient.setString(15, patient.getEmergencycontact());
            psAddPatient.setString(16, patient.getEmploymentstatus());
            psAddPatient.setString(17, patient.getMedicalhistory());
            psAddPatient.setString(18, patient.getAllergies());
            psAddPatient.setString(19, patient.getMedicines());
            Date utilDate = new Date();
            java.sql.Date date = new java.sql.Date(utilDate.getTime());
            psAddPatient.setDate(20, date);
            psAddPatient.setInt(21, 0);
            psAddPatient.execute();
            flag=true;
            }catch(SQLException e){
                e.printStackTrace();
            }
                return flag;
    }

    @Override
    public Patient get(int patientId) {
        Patient patient = null;

        int addressID=0;
        try {
            patient = new Patient();

            connection = DBConnectionUtil.getConnection();

            String sql = "select * from patient where patientId=" + patientId;
            statement = connection.createStatement();
            resultSet = statement.executeQuery(sql);
            while (resultSet.next()) {
                addressID=resultSet.getInt("addressId");
                patient.setPatientId(resultSet.getInt("patientId"));
                patient.setAccountnumber(resultSet.getInt("accountnumber"));
                patient.setAddressId(resultSet.getInt("addressId"));
                patient.setFirst_name(resultSet.getString("first_name"));
                patient.setLast_name(resultSet.getString("last_name"));
                patient.setDob(resultSet.getDate("dob"));
                patient.setGender(resultSet.getString("gender").charAt(0));
                patient.setHeight(resultSet.getDouble("height"));
                patient.setWeight(resultSet.getDouble("weight"));
                patient.setEmail(resultSet.getString("email"));
                patient.setPhonenumber(resultSet.getString("phonenumber"));
                patient.setMaritalstatus(resultSet.getString("maritalstatus"));
                patient.setSsn(resultSet.getLong("ssn"));
                patient.setEmergencyname(resultSet.getString("emergencyname"));
                patient.setEmergencycontact(resultSet.getString("emergencycontact"));
                patient.setEmploymentstatus(resultSet.getString("employmentstatus"));
                patient.setMedicalhistory(resultSet.getString("medicalhistory"));
                patient.setAllergies(resultSet.getString("allergies"));
                patient.setMedicines(resultSet.getString("medicines"));
            }



        } catch (SQLException e) {
            e.printStackTrace();
        }
        return patient;
    }

    @Override
    public Address getPatientAddress(int addressId) {
        Address address=null;
        try{
            address=new Address();
            connection = DBConnectionUtil.getConnection();
            String addressSql="select * from address where addressId="+addressId;
            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(addressSql);
            while (rs.next()) {
                address.setAddressId(rs.getInt("addressId"));
                address.setAddress1(rs.getString("address1"));
                address.setAddress2(rs.getString("address2"));
                address.setCity(rs.getString("city"));
                address.setDistrict(rs.getString("district"));
                address.setPostalcode(rs.getString("postalcode"));
                address.setCountry(rs.getString("country"));

            }
        }catch(SQLException e){
            e.printStackTrace();
        }
        return address;
    }

    @Override
    public boolean delete(int patientId) {
        boolean flag=false;
        try{

            connection= DBConnectionUtil.getConnection();
            String sql = "Update Patient set logicalDelete=1 where patientId=?";
            psDeletePatient = connection.prepareStatement(sql);
            psDeletePatient.setInt(1, patientId);
            psDeletePatient.executeUpdate();
            flag=true;
        }
        catch(SQLException e){
            e.printStackTrace();
        }
        return flag;
    }
}
