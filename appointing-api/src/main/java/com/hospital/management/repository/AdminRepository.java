package com.hospital.management.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.hospital.management.model.Admin;

@Repository
public interface AdminRepository extends JpaRepository<Admin, Integer> {

}
