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

import com.hospital.management.model.Test;
import com.hospital.management.service.TestService;

@RestController
public class TestController {

	@Autowired
	private TestService testService;

	@GetMapping("/test")
	public List<Test> getAll() {
		return testService.getAll();
	}

	@GetMapping("/test/{id}")
	public Test getOne(@PathVariable Integer id) {
		return testService.getOne(id);
	}

	@PostMapping("/test")
	public List<Test> addNew(@RequestBody Test testObject) {
		testService.addNew(testObject);
		return testService.getAll();
	}

	@PutMapping("/test/{id}")
	public List<Test> update(@RequestBody Test testObject, @PathVariable Integer id) {
		Test existingtest = testService.getOne(id);
		existingtest.setTestId(testObject.getTestId());
		existingtest.setName(testObject.getName());
		existingtest.setFee(testObject.getFee());
		existingtest.setDescription(testObject.getDescription());
		testService.update(existingtest);
		return testService.getAll();

	}

	@DeleteMapping("/test/{id}")
	public List<Test> delete(@PathVariable Integer id) {
		Test existingtest = testService.getOne(id);
		testService.delete(existingtest);
		return testService.getAll();
	}
}
