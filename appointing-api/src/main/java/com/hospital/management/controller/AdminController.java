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

import com.hospital.management.model.Admin;
import com.hospital.management.service.AdminService;

@RestController
public class AdminController {

	@Autowired
	private AdminService adminService;

	@GetMapping("/admin")
	public List<Admin> getAll() {
		return adminService.getAll();
	}

	@GetMapping("/admin/{id}")
	public Admin getOne(@PathVariable Integer id) {
		return adminService.getOne(id);
	}

	@PostMapping("/admin")
	public List<Admin> addNew(@RequestBody Admin adminObject) {
		adminService.addNew(adminObject);
		return adminService.getAll();
	}

	@PutMapping("/admin/{id}")
	public List<Admin> update(@RequestBody Admin adminObject, @PathVariable Integer id) {
		Admin existingAdmin = adminService.getOne(id);
		existingAdmin.setId(adminObject.getId());
		existingAdmin.setEmail(adminObject.getEmail());
		existingAdmin.setPassword(adminObject.getPassword());
		adminService.update(existingAdmin);
		return adminService.getAll();

	}

	@DeleteMapping("/admin/{id}")
	public List<Admin> delete(@PathVariable Integer id) {
		Admin existingAdmin = adminService.getOne(id);
		adminService.delete(existingAdmin);
		return adminService.getAll();
	}

}
