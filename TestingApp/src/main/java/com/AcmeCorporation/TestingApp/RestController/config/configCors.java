package com.AcmeCorporation.TestingApp.RestController.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class configCors implements WebMvcConfigurer {

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")
                .allowedOrigins("*") // Permitir solicitudes desde cualquier origen
                .allowedMethods("*") // Permitir todos los métodos HTTP (GET, POST, PUT, DELETE, etc.)
                .allowedHeaders("*"); // Permitir todos los encabezados HTTP
    }
}
