package com.ticketsplatform.ticketsapi;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@EnableJpaRepositories
public class TicketsApiApplication {

	public static void main(String[] args) {
		SpringApplication.run(TicketsApiApplication.class, args);
	}

}
