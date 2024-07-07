package com.ticketsplatform.ticketsapi.event;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ticketsplatform.ticketsapi.event.dtos.EventDTO;
import com.ticketsplatform.ticketsapi.event.dtos.EventRequestDTO;

import jakarta.persistence.EntityNotFoundException;
import lombok.AllArgsConstructor;

@AllArgsConstructor
@Service
public class EventService {
  @Autowired
  private final EventRepository eventRepository;

  @Autowired
  private final EventMapper eventMapper;

  public EventDTO getById(Long id) {
    return eventRepository.findById(id).map(eventMapper::map).orElseThrow(EntityNotFoundException::new);
  }

  public List<EventDTO> findAll() {
    return eventRepository.findAll().stream().map(eventMapper::map).toList();
  }

  public Long create(EventRequestDTO request) {
    EventEntity eventEntity = eventMapper.map(request);
    eventRepository.save(eventEntity);
    return eventEntity.getId();
  }

  public Long update(Long id, EventRequestDTO eventRequestDTO) {
    EventEntity eventEntity = eventRepository.findById(id).orElseThrow(EntityNotFoundException::new);
    eventEntity.setCity(eventRequestDTO.city());
    eventEntity.setState(eventRequestDTO.state());
    eventEntity.setCountry(eventRequestDTO.country());
    eventEntity.setDate(eventRequestDTO.date());
    eventEntity.setDescription(eventRequestDTO.description());
    eventEntity.setLatitude(eventRequestDTO.latitude());
    eventEntity.setLongitude(eventRequestDTO.longitude());
    eventEntity.setName(eventRequestDTO.name());
    eventEntity.setOrganizer(eventRequestDTO.organizer());
    eventEntity.setStreet(eventRequestDTO.street());
    eventEntity.setStreetNumber(eventRequestDTO.streetNumber());
    eventEntity.setZipCode(eventRequestDTO.zipCode());
    eventRepository.save(eventEntity);

    return eventEntity.getId();
  }

  public Long patch(Long id, Map<String, Object> fields) {
    EventRequestDTO eventRequestDTO = eventMapper.mapToRequest(this.getById(id));

    EventRequestDTO updatedDTO = new EventRequestDTO(
        (String) fields.getOrDefault("name", eventRequestDTO.name()),
        fields.containsKey("date") ? LocalDateTime.parse((String) fields.get("date")) : eventRequestDTO.date(),
        (String) fields.getOrDefault("organizer", eventRequestDTO.organizer()),
        (String) fields.getOrDefault("street", eventRequestDTO.street()),
        (String) fields.getOrDefault("streetNumber", eventRequestDTO.streetNumber()),
        (String) fields.getOrDefault("zipCode", eventRequestDTO.zipCode()),
        (String) fields.getOrDefault("city", eventRequestDTO.city()),
        (String) fields.getOrDefault("state", eventRequestDTO.state()),
        (String) fields.getOrDefault("country", eventRequestDTO.country()),
        (String) fields.getOrDefault("latitude", eventRequestDTO.latitude()),
        (String) fields.getOrDefault("longitude", eventRequestDTO.longitude()),
        (String) fields.getOrDefault("description", eventRequestDTO.description()));

    return this.update(id, updatedDTO);
  }

  public Long delete(Long id) {
    eventRepository.deleteById(id);
    return id;
  }
}
