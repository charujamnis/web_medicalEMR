package com.dtcc.dao;

import com.dtcc.model.PatientHistoryInformation;
import com.dtcc.util.DBConnectionUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PatientVisitDAOImpl implements PatientVisitDAO {
    Connection connection =null;
    PreparedStatement ps=null;
    PreparedStatement psDeleteHistory=null;
    ResultSet resultSet=null;


    @Override
    public List<PatientHistoryInformation> getPatientHistory(int patientId) {
        PatientHistoryInformation patientHistoryInformation = null;
        List<PatientHistoryInformation> patientHistoryList=null;

        try {
            patientHistoryList=new ArrayList<PatientHistoryInformation>();
            connection = DBConnectionUtil.getConnection();
            String sql = "select p.patientId, p.accountnumber,p.first_name,p.last_name,pro.procedureId, pro.cpt,pro.description,pro.cost,ph.purpose, ph.dateOfvisit, ph.nextappointment " +
                    "from patientHistory ph " +
                    "join patient p on ph.patientId=p.patientId " +
                    "join procedures pro on ph.procedureId=pro.procedureId " +
                    "where ph.logicalDelete=0 and p.patientId =?";
            ps = connection.prepareStatement(sql);
            ps.setInt(1,patientId);

            resultSet =ps.executeQuery();
            while (resultSet.next()) {
                patientHistoryInformation = new PatientHistoryInformation();
                patientHistoryInformation.setPatientId(resultSet.getInt("patientId"));

                patientHistoryInformation.setProcedureId(resultSet.getInt("procedureId"));

                patientHistoryInformation.setAccountNumber(resultSet.getInt("accountnumber"));

                patientHistoryInformation.setFirstName(resultSet.getString("first_name"));

                patientHistoryInformation.setLastName(resultSet.getString("last_name"));

                patientHistoryInformation.setCpt(resultSet.getString("cpt"));

                patientHistoryInformation.setDesc(resultSet.getString("description"));

                patientHistoryInformation.setCost(resultSet.getDouble("cost"));

                patientHistoryInformation.setPurpose(resultSet.getString("purpose"));

                if(resultSet.getDate("dateOfvisit") !=null){
                    patientHistoryInformation.setDateOfVisit(resultSet.getDate("dateOfvisit"));
                }
                else {
                    patientHistoryInformation.setDateOfVisit(null);
                }

                if(resultSet.getDate("nextappointment") !=null){
                    patientHistoryInformation.setNextAppointment(resultSet.getDate("nextappointment"));
                }
                else{
                    patientHistoryInformation.setNextAppointment(null);
                }

                patientHistoryList.add(patientHistoryInformation);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return patientHistoryList;
    }

    @Override
    public boolean save(PatientHistoryInformation pInformation) {
        boolean flag=false;
        try{
            connection = DBConnectionUtil.getConnection();
            String patientHistorySql = "insert into patienthistory values(?,?,?,?,?,?)";
            PreparedStatement ps = connection.prepareStatement(patientHistorySql);
            ps.setInt(1, pInformation.getPatientId());
            ps.setInt(2, pInformation.getProcedureId());
            ps.setString(3, pInformation.getPurpose());
            java.sql.Date today = new java.sql.Date(new java.util.Date().getTime());
            ps.setDate(4, today);

            if(pInformation.getNextAppointment()==null){ps.setDate(5,null);}
            else{ ps.setDate(5,new java.sql.Date(pInformation.getNextAppointment().getTime()));}
            ps.setInt(6, 0);
            ps.execute();
            flag=true;
        }catch(SQLException e){
            e.printStackTrace();
        }
         return flag;
    }

    @Override
    public boolean delete(PatientHistoryInformation pInformation) {
        boolean flag=false;
        try{
            connection = DBConnectionUtil.getConnection();
            String sql = "Update Patienthistory set logicalDelete=1 where patientId=? and procedureId=? and purpose=? and dateofvisit=?";
            psDeleteHistory = connection.prepareStatement(sql);
            psDeleteHistory.setInt(1,pInformation.getPatientId());
            psDeleteHistory.setInt(2,pInformation.getProcedureId());
            psDeleteHistory.setString(3,pInformation.getPurpose());
            psDeleteHistory.setDate(4,new java.sql.Date(pInformation.getDateOfVisit().getTime()));
            //System.out.println("the next app========= "+pInformation.getNextAppointment());
           // if(pInformation.getNextAppointment()==null){psDeleteHistory.setDate(5,null);}
           // else{psDeleteHistory.setDate(5,new java.sql.Date(pInformation.getNextAppointment().getTime()));}
            psDeleteHistory.executeUpdate();
            flag=true;
        }catch(SQLException e){
            e.printStackTrace();
        }

        return flag;
    }
}
