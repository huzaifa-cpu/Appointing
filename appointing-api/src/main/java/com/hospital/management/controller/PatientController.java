package com.hospital.management.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.hospital.management.model.Patient;
import com.hospital.management.service.PatientService;

@RestController
public class PatientController {

	@Autowired
	private PatientService patientService;

	@GetMapping("/patient")
	public List<Patient> getAll() {
		return patientService.getAll();
	}

	@GetMapping("/patient/{id}")
	public Patient getOne(@PathVariable String id) {
		return patientService.getOne(id);
	}

	@PostMapping("/patient")
	public List<Patient> addNew(@RequestBody Patient patientObject) {
		patientService.addNew(patientObject);
		return patientService.getAll();
	}

	@PutMapping("/patient/{id}")
	public List<Patient> update(@RequestBody Patient patientObject, @PathVariable String id) {
		Patient existingPatient = patientService.getOne(id);
		existingPatient.setPatientId(patientObject.getPatientId());
		existingPatient.setName(patientObject.getName());
		existingPatient.setGender(patientObject.getGender());
		existingPatient.setAge(patientObject.getAge());
		existingPatient.setPhoneNumber(patientObject.getPhoneNumber());
		existingPatient.setImage(patientObject.getImage());
		existingPatient.setPatientTest(patientObject.getPatientTest());
		existingPatient.setAppointment(patientObject.getAppointment());
		patientService.update(existingPatient);
		return patientService.getAll();

	}

	@DeleteMapping("/patient/{id}")
	public List<Patient> delete(@PathVariable String id) {
		Patient existingPatient = patientService.getOne(id);
		patientService.delete(existingPatient);
		return patientService.getAll();
	}
}
