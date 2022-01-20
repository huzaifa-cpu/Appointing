package com.hospital.management.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.hospital.management.model.Patient;
import com.hospital.management.relationTable.Appointment;
import com.hospital.management.repository.AppointmentRepository;
import com.hospital.management.service.PatientService;

@RestController
public class AppointmentController {

	@Autowired
	private AppointmentRepository appointmentRepository;

	@GetMapping("/appointment")
	public ResponseEntity<List<Appointment>> getAll() {
		return ResponseEntity.ok(appointmentRepository.findAll());
	}

	@Autowired
	private PatientService patientService;

	@PostMapping("/appointment")
	public void insertAppointment(@RequestBody Patient patientObject) {
		ResponseEntity.ok(patientService.insertAppointment(patientObject));
	}

	@PutMapping("/appointment/{id}")
	public void updateAppointment(@RequestBody Patient patientObject, @PathVariable String id) {
		ResponseEntity.ok(patientService.updateAppointment(patientObject, id));
	}

	// MARKED as done
	@PutMapping("/appointmentStatus/{patientId}/{doctorId}")
	public void updateAppointmentStatus(@RequestBody Appointment appointment, @PathVariable String patientId,
			@PathVariable Integer doctorId) {
		ResponseEntity.ok(patientService.updateAppointmentStatus(appointment, patientId, doctorId));

	}

}
