package com.AcmeCorporation.TestingApp.Model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;


@Getter
@Entity
@Setter
@NoArgsConstructor
@Table(name ="form")
public class UserModel {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    protected Long id;
    private Integer dni;
    private String name;
    private String lastname;
    private String email;
    private String details;



}
