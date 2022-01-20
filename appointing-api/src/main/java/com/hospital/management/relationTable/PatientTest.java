package com.hospital.management.relationTable;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.hospital.management.compositeKey.PatientTestId;
import com.hospital.management.model.Patient;
import com.hospital.management.model.Test;

@Entity
@Table(name = "patient_test")
public class PatientTest {
	@EmbeddedId
	private PatientTestId patientTestId = new PatientTestId();

	@ManyToOne
	@MapsId("patientId")
	@JoinColumn(name = "patient_id")
	@JsonIgnoreProperties({ "patientTest", "appointment" })
	private Patient patient;

	@ManyToOne
	@MapsId("testId")
	@JoinColumn(name = "test_id")
	private Test test;

	private String date;
	private String time;
	private boolean state;

	public PatientTest() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Patient getPatient() {
		return patient;
	}

	public void setPatient(Patient patient) {
		this.patient = patient;
	}

	public Test getTest() {
		return test;
	}

	public void setTest(Test test) {
		this.test = test;
	}

	public PatientTestId getPatientTestId() {
		return patientTestId;
	}

	public void setPatientTestId(PatientTestId patientTestId) {
		this.patientTestId = patientTestId;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public boolean isState() {
		return state;
	}

	public void setState(boolean state) {
		this.state = state;
	}

}
