package com.capgemini.wsb.persistence.dao;

import com.capgemini.wsb.persistence.entity.PatientEntity;

import java.util.Collection;
import java.util.List;

public interface PatientDao extends Dao<PatientEntity, Long> {

    List<PatientEntity> findAllPatientsWithMoreVisitsThan(int minNumberOfVisits);

    List<PatientEntity> findPatientsOlderThan(int age);

    List<PatientEntity> findPatientsYoungerThan(int age);

    Collection<Object> findByLastName(String lastName);
}