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

import com.hospital.management.model.Doctor;
import com.hospital.management.service.DoctorService;

@RestController
public class DoctorController {

	@Autowired
	private DoctorService doctorService;

	@GetMapping("/doctor")
	public List<Doctor> getAll() {
		return doctorService.getAll();
	}

	@GetMapping("/doctor/{id}")
	public Doctor getOne(@PathVariable Integer id) {
		return doctorService.getOne(id);
	}

	@PostMapping("/doctor")
	public List<Doctor> addNew(@RequestBody Doctor DoctorObject) {
		doctorService.addNew(DoctorObject);
		return doctorService.getAll();
	}

	@PutMapping("/doctor/{id}")
	public List<Doctor> update(@RequestBody Doctor doctorObject, @PathVariable Integer id) {
		Doctor existingDoctor = doctorService.getOne(id);
		existingDoctor.setDoctorId(doctorObject.getDoctorId());
		existingDoctor.setName(doctorObject.getName());
		existingDoctor.setSpecialization(doctorObject.getSpecialization());
		existingDoctor.setOpd(doctorObject.getOpd());
		existingDoctor.setFee(doctorObject.getFee());
		existingDoctor.setImage(doctorObject.getImage());
		doctorService.update(existingDoctor);
		return doctorService.getAll();

	}

	@DeleteMapping("/doctor/{id}")
	public List<Doctor> delete(@PathVariable Integer id) {
		Doctor existingDoctor = doctorService.getOne(id);
		doctorService.delete(existingDoctor);
		return doctorService.getAll();
	}
}
