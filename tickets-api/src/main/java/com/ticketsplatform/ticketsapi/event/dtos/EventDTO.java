package com.ticketsplatform.ticketsapi.event.dtos;

import java.time.LocalDateTime;

public record EventDTO(
        Long id,
        String name,
        LocalDateTime date,
        String organizer,
        String street,
        String streetNumber,
        String zipCode,
        String city,
        String state,
        String country,
        String latitude,
        String longitude,
        String description) {
}
