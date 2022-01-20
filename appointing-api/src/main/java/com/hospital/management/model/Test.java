package com.hospital.management.model;

import java.util.ArrayList;
import java.util.Collection;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.hospital.management.relationTable.PatientTest;

@Entity
@Table(name = "test")
public class Test {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer testId;
	private String name;
	private String fee;
	private String description;

	@OneToMany(mappedBy = "test", cascade = CascadeType.ALL)
	@JsonIgnore
	private Collection<PatientTest> patientTest = new ArrayList<>();

	public Test() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Integer getTestId() {
		return testId;
	}

	public void setTestId(Integer testId) {
		this.testId = testId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getFee() {
		return fee;
	}

	public void setFee(String fee) {
		this.fee = fee;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Collection<PatientTest> getPatientTest() {
		return patientTest;
	}

	public void setPatientTest(Collection<PatientTest> patientTest) {
		this.patientTest = patientTest;
	}

}