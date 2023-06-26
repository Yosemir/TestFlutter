package com.AcmeCorporation.TestingApp.Service;

import com.AcmeCorporation.TestingApp.Model.UserModel;
import com.AcmeCorporation.TestingApp.Repository.UserRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;

@Service
public class UserService {

    private final UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }


    public List<UserModel> getAllUsers(UserModel userModel) {
        return userRepository.findAll();
    }

    public UserModel getUserById(Long id) {
        return userRepository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("User not found"));
    }

    public UserModel createUser(UserModel user) {
        return userRepository.save(user);
    }

    public UserModel updateUser(Long id, UserModel user) {
        UserModel existingUser = getUserById(id);
        existingUser.setName(user.getName());
        existingUser.setEmail(user.getEmail());
        return userRepository.save(existingUser);
    }

   /* public void deleteUser(Long id) {
        userRepository.deleteById(id);
    }*/
}
