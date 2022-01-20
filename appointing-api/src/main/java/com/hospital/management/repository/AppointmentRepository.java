package com.hospital.management.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.hospital.management.compositeKey.AppointmentId;
import com.hospital.management.relationTable.Appointment;

@Repository
public interface AppointmentRepository extends JpaRepository<Appointment, AppointmentId> {

}
