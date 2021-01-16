package com.dtcc.dao;

import java.sql.*;

import com.dtcc.model.Procedure;
import com.dtcc.util.*;
import java.util.*;
import com.dtcc.model.*;
import com.dtcc.util.*;


public class ProcedureDAOImpl implements ProcedureDAO{

	Connection connection =null;
	Statement statement=null;
	ResultSet resultSet=null;
	PreparedStatement psAddProcedure=null;
	PreparedStatement psUpdateProcedure=null;
	PreparedStatement psDeleteProcedure=null;

	@Override
	public List <Procedure> get(){

		List<Procedure> procedureList=null;
		Procedure procedure =null;

		try{

			procedureList=new ArrayList<Procedure>(); //procedure list
			String sql="select * from procedures where logicalDelete=0"; //sql statement
			connection=DBConnectionUtil.getConnection();	//get the database connection
			statement=connection.createStatement();	//create statement
			resultSet=statement.executeQuery(sql); 	//execute the query.

			while(resultSet.next()){

				procedure=new Procedure();
				procedure.setProcedureId(resultSet.getInt("procedureId"));
				procedure.setCpt(resultSet.getString("cpt"));
				procedure.setDescription(resultSet.getString("description"));
				procedure.setName(resultSet.getString("name"));
				procedure.setCost(resultSet.getDouble("cost"));

				//System.out.println("The cpt is "+resultSet.getString("cpt"));
				procedureList.add(procedure);		//add procedure object to the procedure List.
			}
		}catch(Exception e){
			e.printStackTrace();
		}	
		return procedureList;
	}

	@Override //add Procedure
	public boolean save(Procedure procedure) {
		boolean flag=false;

		try{
			String addProcedureSql = "insert into procedures values(?,?,?,?,?,?)";
			connection=DBConnectionUtil.getConnection();
			psAddProcedure = connection.prepareStatement(addProcedureSql);
			psAddProcedure.setInt(1, 0);
			psAddProcedure.setString(2, procedure.getCpt());
			psAddProcedure.setString(3, procedure.getDescription());
			psAddProcedure.setString(4, procedure.getName());
			psAddProcedure.setDouble(5, procedure.getCost());
			psAddProcedure.setInt(6, 0);
			psAddProcedure.execute();
			flag=true;
		}catch(SQLException e){
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public Procedure get(int procedureId) {
		Procedure procedure = null;

		try {
			procedure = new Procedure();
			String sql = "select * from procedures where procedureId=" + procedureId;
			connection = DBConnectionUtil.getConnection();
			statement = connection.createStatement();
			resultSet = statement.executeQuery(sql);
			while (resultSet.next()) {
				procedure.setProcedureId(resultSet.getInt("procedureId"));
				procedure.setCpt(resultSet.getString("cpt"));
				procedure.setDescription(resultSet.getString("description"));
				procedure.setName(resultSet.getString("name"));
				procedure.setCost(resultSet.getDouble("cost"));

			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return procedure;
	}

	@Override //edit procedure
	public boolean update(Procedure procedure) {
		boolean flag=false;
		try{
			connection = DBConnectionUtil.getConnection();
			String updateProcedureSql = "update procedures set cpt=?, description=?,name=?, cost=? where procedureId=?";
			psUpdateProcedure=connection.prepareStatement(updateProcedureSql);
			psUpdateProcedure.setString(1, procedure.getCpt());
			psUpdateProcedure.setString(2, procedure.getDescription());
			psUpdateProcedure.setString(3, procedure.getName());
			psUpdateProcedure.setDouble(4, procedure.getCost());
			psUpdateProcedure.setInt(5, procedure.getProcedureId());
			psUpdateProcedure.executeUpdate();
			flag=true;
		}catch(SQLException e){
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public boolean delete(int procedureId) {
		boolean flag=false;
		try{

			connection= DBConnectionUtil.getConnection();
			String sql = "Update Procedures set logicalDelete=1 where procedureId=?";
			psDeleteProcedure = connection.prepareStatement(sql);
			psDeleteProcedure.setInt(1, procedureId);
			psDeleteProcedure.executeUpdate();
			flag=true;
		}
		catch(SQLException e){
			e.printStackTrace();
		}
		return flag;
	}
}