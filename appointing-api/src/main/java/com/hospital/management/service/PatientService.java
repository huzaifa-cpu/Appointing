package com.hospital.management.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hospital.management.compositeKey.AppointmentId;
import com.hospital.management.compositeKey.PatientTestId;
import com.hospital.management.model.Doctor;
import com.hospital.management.model.Patient;
import com.hospital.management.model.Test;
import com.hospital.management.relationTable.Appointment;
import com.hospital.management.relationTable.PatientTest;
import com.hospital.management.repository.AppointmentRepository;
import com.hospital.management.repository.PatientRepository;
import com.hospital.management.repository.PatientTestRepository;

@Service
public class PatientService {

	@Autowired
	private PatientRepository patientRepository;

	public List<Patient> getAll() {
		return patientRepository.findAll();
	}

	public Patient getOne(String id) {
		return patientRepository.findById(id).orElse(null);
	}

	public List<Patient> addNew(Patient patientObject) {
		patientRepository.save(patientObject);
		return patientRepository.findAll();
	}

	public List<Patient> update(Patient patientObject) {
		patientRepository.save(patientObject);
		return patientRepository.findAll();
	}

	public List<Patient> delete(Patient patientObject) {
		patientRepository.delete(patientObject);
		return patientRepository.findAll();

	}
	// FOR PATIENT-TEST

	@Autowired
	private TestService testService;

	public Patient insertPatientTest(Patient patient) {
		Patient newPatient = new Patient();
		newPatient.setPatientId(patient.getPatientId());
		newPatient.setPhoneNumber(patient.getPhoneNumber());
		newPatient.setName(patient.getName());
		newPatient.setAge(patient.getAge());
		newPatient.setGender(patient.getGender());
		newPatient.setImage(patient.getImage());
		newPatient.setAppointment(patient.getAppointment());
		newPatient.getPatientTest().addAll((patient.getPatientTest().stream().map(patientTest -> {
			Test test = testService.getOne(patientTest.getTest().getTestId());
			PatientTest newpatientTest = new PatientTest();
			newpatientTest.setTest(test);
			newpatientTest.setPatient(newPatient);
			newpatientTest.setDate(patientTest.getDate());
			newpatientTest.setTime(patientTest.getTime());
			newpatientTest.setState(patientTest.isState());
			return newpatientTest;
		}).collect(Collectors.toList())));
		return patientRepository.save(newPatient);
	}

	public Patient updatePatientTest(Patient patient, String id) {
		Patient newPatient = getOne(id);
		newPatient.setPatientId(patient.getPatientId());
		newPatient.setPhoneNumber(patient.getPhoneNumber());
		newPatient.setName(patient.getName());
		newPatient.setAge(patient.getAge());
		newPatient.setGender(patient.getGender());
		newPatient.setImage(patient.getImage());
		newPatient.setAppointment(patient.getAppointment());
		newPatient.getPatientTest().addAll((patient.getPatientTest().stream().map(patientTest -> {
			Test test = testService.getOne(patientTest.getTest().getTestId());
			PatientTest newpatientTest = new PatientTest();
			newpatientTest.setTest(test);
			newpatientTest.setPatient(newPatient);
			newpatientTest.setDate(patientTest.getDate());
			newpatientTest.setTime(patientTest.getTime());
			newpatientTest.setState(patientTest.isState());
			return newpatientTest;
		}).collect(Collectors.toList())));
		return patientRepository.save(newPatient);
	}

	// FOR STATUS
	@Autowired
	private PatientTestRepository patientTestRepository;

	@Autowired
	private PatientService patientService;

	public PatientTest updatePatientTestStatus(PatientTest patientTest, String patientId, Integer TestId) {
		Patient existingPatient = patientService.getOne(patientId);
		Test existingTest = testService.getOne(TestId);
		PatientTest newPatientTest = new PatientTest();
		PatientTestId id = new PatientTestId();
		id.setTestId(TestId);
		id.setPatientId(patientId);
		newPatientTest.setPatientTestId(id);
		newPatientTest.setTest(existingTest);
		newPatientTest.setPatient(existingPatient);
		newPatientTest.setDate(patientTest.getDate());
		newPatientTest.setTime(patientTest.getTime());
		newPatientTest.setState(patientTest.isState());
		return patientTestRepository.save(newPatientTest);
	}

	// FOR APPOINTMEMT

	@Autowired
	private DoctorService doctorService;

	public Patient insertAppointment(Patient patient) {
		Patient newPatient = new Patient();
		newPatient.setPatientId(patient.getPatientId());
		newPatient.setPhoneNumber(patient.getPhoneNumber());
		newPatient.setName(patient.getName());
		newPatient.setAge(patient.getAge());
		newPatient.setGender(patient.getGender());
		newPatient.setImage(patient.getImage());
		newPatient.setPatientTest(patient.getPatientTest());
		newPatient.getAppointment().addAll((patient.getAppointment().stream().map(appointment -> {
			Doctor doctor = doctorService.getOne(appointment.getDoctor().getDoctorId());
			Appointment newAppointment = new Appointment();
			newAppointment.setDoctor(doctor);
			newAppointment.setPatient(newPatient);
			newAppointment.setDate(appointment.getDate());
			newAppointment.setTime(appointment.getTime());
			newAppointment.setState(appointment.isState());
			return newAppointment;
		}).collect(Collectors.toList())));
		return patientRepository.save(newPatient);
	}

	public Patient updateAppointment(Patient patient, String id) {
		Patient newPatient = getOne(id);
		newPatient.setPatientId(patient.getPatientId());
		newPatient.setPhoneNumber(patient.getPhoneNumber());
		newPatient.setName(patient.getName());
		newPatient.setAge(patient.getAge());
		newPatient.setGender(patient.getGender());
		newPatient.setImage(patient.getImage());
		newPatient.setPatientTest(patient.getPatientTest());
		newPatient.getAppointment().addAll((patient.getAppointment().stream().map(appointment -> {
			Doctor doctor = doctorService.getOne(appointment.getDoctor().getDoctorId());
			Appointment newAppointment = new Appointment();
			newAppointment.setDoctor(doctor);
			newAppointment.setPatient(newPatient);
			newAppointment.setDate(appointment.getDate());
			newAppointment.setTime(appointment.getTime());
			newAppointment.setState(appointment.isState());
			return newAppointment;
		}).collect(Collectors.toList())));
		return patientRepository.save(newPatient);
	}

	// FOR STATUS
	@Autowired
	private AppointmentRepository appointmentRepository;

	public Appointment updateAppointmentStatus(Appointment appointment, String patientId, Integer doctorId) {
		Patient existingPatient = patientService.getOne(patientId);
		Doctor existingDoctor = doctorService.getOne(doctorId);
		Appointment newAppointment = new Appointment();
		AppointmentId id = new AppointmentId();
		id.setDoctorId(doctorId);
		id.setPatientId(patientId);
		newAppointment.setAppointmentId(id);
		newAppointment.setDoctor(existingDoctor);
		newAppointment.setPatient(existingPatient);
		newAppointment.setDate(appointment.getDate());
		newAppointment.setTime(appointment.getTime());
		newAppointment.setState(appointment.isState());
		return appointmentRepository.save(newAppointment);
	}

}