package com.perkpilot.api;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.perkpilot.api")
public class PerkPilotApiApplication {

    public static void main(String[] args) {
        SpringApplication.run(PerkPilotApiApplication.class, args);
    }
}