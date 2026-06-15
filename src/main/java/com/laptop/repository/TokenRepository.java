package com.laptop.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.laptop.model.RegistrationToken;

public interface TokenRepository extends JpaRepository<RegistrationToken, Integer> {
	Optional<RegistrationToken> findByTokenAndUsed(String token, boolean used);

}
