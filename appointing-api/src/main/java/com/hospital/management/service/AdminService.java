package com.hospital.management.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hospital.management.model.Admin;
import com.hospital.management.repository.AdminRepository;

@Service
public class AdminService {

	@Autowired
	private AdminRepository adminRepository;

	public List<Admin> getAll() {
		return adminRepository.findAll();
	}

	public Admin getOne(Integer id) {
		return adminRepository.findById(id).orElse(null);
	}

	public List<Admin> addNew(Admin adminObject) {
		adminRepository.save(adminObject);
		return adminRepository.findAll();
	}

	public List<Admin> update(Admin adminObject) {
		adminRepository.save(adminObject);
		return adminRepository.findAll();
	}

	public List<Admin> delete(Admin adminObject) {
		adminRepository.delete(adminObject);
		return adminRepository.findAll();

	}

}
