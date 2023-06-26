package com.AcmeCorporation.TestingApp.RestController.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.time.Instant;
import java.time.LocalDate;

@Getter
@Setter
@AllArgsConstructor
public class UserRspDTO {


        private Integer codigo;
        private Integer dniUser;
        private String estado;
        private String mensaje;
        private Instant fecha;


}
