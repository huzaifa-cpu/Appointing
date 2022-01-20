package com.hospital.management.relationTable;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.hospital.management.compositeKey.AppointmentId;
import com.hospital.management.model.Doctor;
import com.hospital.management.model.Patient;

@Entity
@Table(name = "appointment")
public class Appointment {
	@EmbeddedId
	private AppointmentId appointmentId = new AppointmentId();

	@ManyToOne
	@MapsId("patientId")
	@JoinColumn(name = "patient_id")
	@JsonIgnoreProperties({ "patientTest", "appointment" })
	private Patient patient;

	@ManyToOne
	@MapsId("doctorId")
	@JoinColumn(name = "doctor_id")
	private Doctor doctor;

	private String date;
	private String time;
	private boolean state;

	public Appointment() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Patient getPatient() {
		return patient;
	}

	public void setPatient(Patient patient) {
		this.patient = patient;
	}

	public Doctor getDoctor() {
		return doctor;
	}

	public void setDoctor(Doctor doctor) {
		this.doctor = doctor;
	}

	public AppointmentId getAppointmentId() {
		return appointmentId;
	}

	public void setAppointmentId(AppointmentId AppointmentId) {
		this.appointmentId = AppointmentId;
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
