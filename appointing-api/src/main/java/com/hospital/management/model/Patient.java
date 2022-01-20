package com.hospital.management.model;

import java.util.ArrayList;
import java.util.Collection;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.hospital.management.relationTable.Appointment;
import com.hospital.management.relationTable.PatientTest;

@Entity
@Table(name = "patient")
public class Patient {

	@Id
	private String patientId;
	private String phoneNumber;
	private String name;
	private String age;
	private String gender;
	@Lob
	private String image;

	@OneToMany(mappedBy = "patient", cascade = CascadeType.ALL)
	private Collection<PatientTest> patientTest = new ArrayList<>();

	@OneToMany(mappedBy = "patient", cascade = CascadeType.ALL)
	private Collection<Appointment> appointment = new ArrayList<>();

	public Patient() {
		super();
		// TODO Auto-generated constructor stub
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getPatientId() {
		return patientId;
	}

	public void setPatientId(String patientId) {
		this.patientId = patientId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public Collection<PatientTest> getPatientTest() {
		return patientTest;
	}

	public void setPatientTest(Collection<PatientTest> patientTest) {
		this.patientTest = patientTest;
	}

	public Collection<Appointment> getAppointment() {
		return appointment;
	}

	public void setAppointment(Collection<Appointment> appointment) {
		this.appointment = appointment;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

}