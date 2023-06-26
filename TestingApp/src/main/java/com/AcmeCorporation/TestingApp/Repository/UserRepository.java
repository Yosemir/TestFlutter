package com.AcmeCorporation.TestingApp.Repository;

import com.AcmeCorporation.TestingApp.Model.UserModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;



@Repository
public interface UserRepository extends JpaRepository<UserModel, Long> {


}
