package com.AcmeCorporation.TestingApp.RestController.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class UserRequestDTO {

    private Long id;
    private Integer dni;
    private String name;
    private String lastname;
    private String email;
    private String details;
}
