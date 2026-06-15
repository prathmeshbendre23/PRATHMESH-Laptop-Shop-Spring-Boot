package com.laptop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.laptop.model.Customer;

@Repository
public interface CustomerRepository extends JpaRepository<Customer, Integer> {

    @Query("SELECT c FROM Customer c WHERE c.User_Name = :username")
    Customer findByUsernameCustom(@Param("username") String username);

     @Query("SELECT c FROM Customer c WHERE c.User_Name = :username AND c.Email_Id = :email")
    Customer findByUsernameAndEmail(@Param("username") String username, @Param("email") String email);
     long countByRole(String role);
     
}