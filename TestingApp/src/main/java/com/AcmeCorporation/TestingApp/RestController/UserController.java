package com.AcmeCorporation.TestingApp.RestController;


import com.AcmeCorporation.TestingApp.Model.UserModel;
import com.AcmeCorporation.TestingApp.Repository.UserRepository;
import com.AcmeCorporation.TestingApp.RestController.dto.UserRequestDTO;
import com.AcmeCorporation.TestingApp.RestController.dto.UserRspDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.Optional;

@RequestMapping("/user")
@CrossOrigin(origins = "http://localhost")
@RestController
public class UserController {

    private static final Logger logger = LoggerFactory.getLogger(UserController.class);

    private final UserRepository userRepository;
    private String resultError = "Error";
    private String resultExito = "Exito";

    public UserController(UserRepository userRepository) {
        this.userRepository = userRepository;
    }


    @GetMapping("/list")
    public Iterable<UserModel> getUser() {
        return userRepository.findAll();
    }

    @GetMapping("/listby/{dni}")
    public Optional<UserModel> filteBy(@PathVariable Long dni){
      return userRepository.findById(dni);
    }

    @PostMapping("/save")
    public UserRspDTO saveUser(@RequestBody UserRequestDTO userModel){

        UserModel us = new UserModel();
        us.setName(userModel.getName());
        us.setLastname(userModel.getLastname());
        us.setEmail(userModel.getEmail());
        us.setDetails(userModel.getDetails());
        us.setDni(userModel.getDni());
        userRepository.save(us);

        return new UserRspDTO(HttpStatus.OK.value(),us.getDni(),resultExito,"Se registro con Exitosa", LocalDateTime.now().toInstant(ZoneOffset.UTC));
    }


    @PutMapping("/update/{id}")
    public UserRspDTO update(@PathVariable UserModel us, @PathVariable Long id){
        try {
            UserModel user = new UserModel();
            if (userRepository.findById(id).isPresent()){
                user.setDni(us.getDni());
                user.setName(us.getName());
                user.setLastname(us.getLastname());
                user.setEmail(us.getEmail());
                userRepository.save(user);
                logger.info("Se actualizo al usuario con exito");
            }else {
                logger.error("El usaurio no existe");
            }
        }catch (Exception e){
            return new UserRspDTO(HttpStatus.INTERNAL_SERVER_ERROR.value(),us.getDni(),resultError,e.getMessage(), LocalDateTime.now().toInstant(ZoneOffset.UTC));
        }
        return new UserRspDTO(HttpStatus.OK.value(),us.getDni(),resultExito,"Actualizacion Exitosa",LocalDateTime.now().toInstant(ZoneOffset.UTC));
    }
}
