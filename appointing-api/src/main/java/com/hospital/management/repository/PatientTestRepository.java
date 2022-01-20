package com.hospital.management.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.hospital.management.compositeKey.PatientTestId;
import com.hospital.management.relationTable.PatientTest;

@Repository
public interface PatientTestRepository extends JpaRepository<PatientTest, PatientTestId> {

}
