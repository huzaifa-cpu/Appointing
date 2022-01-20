package com.hospital.management.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hospital.management.model.Test;
import com.hospital.management.repository.TestRepository;

@Service
public class TestService {

	@Autowired
	private TestRepository testRepository;

	public List<Test> getAll() {
		return testRepository.findAll();
	}

	public Test getOne(Integer id) {
		return testRepository.findById(id).orElse(null);
	}

	public List<Test> addNew(Test testObject) {
		testRepository.save(testObject);
		return testRepository.findAll();
	}

	public List<Test> update(Test testObject) {
		testRepository.save(testObject);
		return testRepository.findAll();
	}

	public List<Test> delete(Test testObject) {
		testRepository.delete(testObject);
		return testRepository.findAll();

	}
}