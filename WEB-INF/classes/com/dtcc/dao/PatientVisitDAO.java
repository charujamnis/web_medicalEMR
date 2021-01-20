package com.dtcc.dao;

import com.dtcc.model.PatientHistoryInformation;
import com.dtcc.model.Procedure;

import java.util.List;

public interface PatientVisitDAO {
    List<PatientHistoryInformation> getPatientHistory(int patientId);
    boolean save(PatientHistoryInformation patientHistoryInformation);
    boolean delete(PatientHistoryInformation patientHistoryInformation);
}
