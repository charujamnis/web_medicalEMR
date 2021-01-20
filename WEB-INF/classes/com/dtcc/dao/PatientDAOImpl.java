package com.dtcc.dao;

import com.dtcc.model.Address;
import com.dtcc.model.Patient;
import com.dtcc.model.Procedure;
import com.dtcc.util.DBConnectionUtil;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class PatientDAOImpl implements PatientDAO {
    Connection connection =null;
    Statement statement=null;
    ResultSet resultSet=null;

    @Override
    public List<Patient> get() {
        List<Patient> patientList=null;
        Patient patient =null;

        try{

            patientList=new ArrayList<Patient>(); //procedure list
            String sql="select * from patient where logicalDelete=0"; //sql statement
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

                //System.out.println("The cpt is "+resultSet.getString("cpt"));
                patientList.add(patient);		//add procedure object to the procedure List.
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return patientList;
    }

    @Override
    public Address getPatientAddress(int addressId) {
        return null;
    }
}
