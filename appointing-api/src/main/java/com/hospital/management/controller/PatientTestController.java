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
import com.hospital.management.relationTable.PatientTest;
import com.hospital.management.repository.PatientTestRepository;
import com.hospital.management.service.PatientService;

@RestController
public class PatientTestController {

	@Autowired
	private PatientTestRepository patientTestRepository;

	@GetMapping("/patientTest")
	public ResponseEntity<List<PatientTest>> getAll() {
		return ResponseEntity.ok(patientTestRepository.findAll());
	}

	@Autowired
	private PatientService patientService;

	@PostMapping("/patientTest")
	public void insertPatientTest(@RequestBody Patient patientObject) {
		ResponseEntity.ok(patientService.insertPatientTest(patientObject));
	}

	@PutMapping("/patientTest/{id}")
	public void updatePatientTest(@RequestBody Patient patientObject, @PathVariable String id) {
		ResponseEntity.ok(patientService.updatePatientTest(patientObject, id));
	}

	// MARKED as done

	@PutMapping("/patientTestStatus/{patientId}/{TestId}")
	public void updatePatientTestStatus(@RequestBody PatientTest patientTest, @PathVariable String patientId,
			@PathVariable Integer TestId) {
		ResponseEntity.ok(patientService.updatePatientTestStatus(patientTest, patientId, TestId));
	}

}
