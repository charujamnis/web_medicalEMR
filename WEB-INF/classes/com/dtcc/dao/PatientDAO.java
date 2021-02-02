package com.dtcc.dao;
import com.dtcc.model.Address;
import com.dtcc.model.Patient;
import com.dtcc.model.Procedure;
import java.util.List;

public interface PatientDAO {
    List<Patient> get(); //Get all the patients
    Address getPatientAddress(int addressId);   //Get Patient Address by providing addressId
    boolean delete(int patientId);
    boolean update(Patient patient);
    boolean save(Patient patient);
    Patient get(int patientId);

}

