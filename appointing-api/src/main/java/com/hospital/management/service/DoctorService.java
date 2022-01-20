package com.hospital.management.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hospital.management.model.Doctor;
import com.hospital.management.repository.DoctorRepository;

@Service
public class DoctorService {

	@Autowired
	private DoctorRepository doctorRepository;

	public List<Doctor> getAll() {
		return doctorRepository.findAll();
	}

	public Doctor getOne(Integer id) {
		return doctorRepository.findById(id).orElse(null);
	}

	public List<Doctor> addNew(Doctor doctorObject) {
		doctorRepository.save(doctorObject);
		return doctorRepository.findAll();
	}

	public List<Doctor> update(Doctor doctorObject) {
		doctorRepository.save(doctorObject);
		return doctorRepository.findAll();
	}

	public List<Doctor> delete(Doctor doctorObject) {
		doctorRepository.delete(doctorObject);
		return doctorRepository.findAll();

	}
}