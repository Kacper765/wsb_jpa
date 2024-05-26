package com.capgemini.wsb.persistance.dao;

import com.capgemini.wsb.persistence.dao.PatientDao;
import com.capgemini.wsb.persistence.entity.PatientEntity;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.Collection;
import java.util.List;

@SpringBootTest
@Transactional
public class PatientDaoTest {

    @Autowired
    private PatientDao patientDao;

    @Transactional
    @Test
    public void testFindAllPatientsWithMoreVisitsThan() {
        // given
        int minNumberOfVisits = 2;

        // when
        List<PatientEntity> listOfVisits = patientDao.findAllPatientsWithMoreVisitsThan(minNumberOfVisits);

        // then
        Assertions.assertNotNull(listOfVisits);
        Assertions.assertTrue(listOfVisits.stream().allMatch(patient -> patient.getVisits().size() > minNumberOfVisits));
    }

    @Transactional
    @Test
    public void testFindAllPatientsOlderThan() {
        // given
        int age = 20;

        // when
        List<PatientEntity> listOfPatients = patientDao.findPatientsOlderThan(age);

        // then
        Assertions.assertNotNull(listOfPatients);
        Assertions.assertTrue(listOfPatients.stream().allMatch(patient -> {
            LocalDate currentDate = LocalDate.now();
            LocalDate birthDateThreshold = currentDate.minusYears(age);
            return patient.getDateOfBirth().isBefore(birthDateThreshold);
        }));
    }

    @Transactional
    @Test
    public void testFindAllPatientsYoungerThan() {
        // given
        int age = 20;

        // when
        List<PatientEntity> listOfPatients = patientDao.findPatientsYoungerThan(age);

        // then
        Assertions.assertNotNull(listOfPatients);
        Assertions.assertTrue(listOfPatients.stream().allMatch(patient -> {
            LocalDate currentDate = LocalDate.now();
            LocalDate birthDateThreshold = currentDate.minusYears(age);
            return patient.getDateOfBirth().isAfter(birthDateThreshold);
        }));
    }

    @Transactional
    @Test
    public void testFindPatientByLastName() {
        // given
        PatientEntity patientEntity1 = new PatientEntity();
        patientEntity1.setFirstName("Marek");
        patientEntity1.setLastName("Kret");
        patientEntity1.setTelephoneNumber("123456789");
        patientEntity1.setEmail("marek.kret@example.com");
        patientEntity1.setPatientNumber("P001");
        patientEntity1.setDateOfBirth(LocalDate.of(1975, 7, 25));
        patientEntity1.setHasInsurance(true);

        PatientEntity patientEntity2 = new PatientEntity();
        patientEntity2.setFirstName("Anna");
        patientEntity2.setLastName("Kret");
        patientEntity2.setTelephoneNumber("987654321");
        patientEntity2.setEmail("anna.kret@example.com");
        patientEntity2.setPatientNumber("P002");
        patientEntity2.setDateOfBirth(LocalDate.of(1992, 8, 20));
        patientEntity2.setHasInsurance(false);

        int patientListInitSize = patientDao.findAll().size();
        int patientListSizeStartsOnLastName = patientDao.findByLastName("Kret").size();

        // when
        patientDao.save(patientEntity1);
        patientDao.save(patientEntity2);
        Collection<Object> patients = patientDao.findByLastName("Kret");

        // then
        Assertions.assertEquals(patientListInitSize + 2, patientDao.findAll().size());
        Assertions.assertEquals(patientListSizeStartsOnLastName + 2, patients.size());
    }

}