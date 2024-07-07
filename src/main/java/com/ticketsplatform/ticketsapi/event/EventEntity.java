package com.ticketsplatform.ticketsapi.event;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name = "events")
public class EventEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "event_id")
    private Long id;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "date", nullable = false)
    private LocalDateTime date;

    @Column(name = "organizer", nullable = false)
    private String organizer;

    @Column(name = "street", nullable = false)
    private String street;

    @Column(name = "streetNumber", nullable = false)
    private String streetNumber;

    @Column(name = "zipCode", nullable = false)
    private String zipCode;

    @Column(name = "city", nullable = false)
    private String city;

    @Column(name = "state", nullable = false)
    private String state;

    @Column(name = "country", nullable = false)
    private String country;

    @Column(name = "latitude", nullable = true)
    private String latitude;

    @Column(name = "longitude", nullable = true)
    private String longitude;

    @Column(name = "description", nullable = false)
    private String description;
}
