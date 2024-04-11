package com.ticketsplatform.ticketsapi.event;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ticketsplatform.ticketsapi.event.dtos.EventDTO;
import com.ticketsplatform.ticketsapi.event.dtos.EventRequestDTO;

import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RestController
@RequestMapping("/event")
@CrossOrigin("*")
public class EventController {
  @Autowired
  private final EventService eventService;

  @GetMapping("/{id}")
  public ResponseEntity<EventDTO> getById(@PathVariable Long id) {
    try {
      return ResponseEntity.ok(eventService.getById(id));
    } catch (EntityNotFoundException e) {
      return ResponseEntity.status(404).build();
    }
  }

  @GetMapping
  public ResponseEntity<List<EventDTO>> findAll() {
    try {
      return ResponseEntity.ok(eventService.findAll());
    } catch (Exception e) {
      return ResponseEntity.status(400).build();
    }
  }

  @PostMapping
  public ResponseEntity<Long> create(@RequestBody EventRequestDTO request) {
    try {
      return ResponseEntity.ok(eventService.create(request));
    } catch (Exception e) {
      return ResponseEntity.status(400).build();
    }
  }

  @PutMapping("/{id}")
  public ResponseEntity<Long> update(@PathVariable Long id, @RequestBody EventRequestDTO request) {
    try {
      return ResponseEntity.ok(eventService.update(id, request));
    } catch (Exception e) {
      return ResponseEntity.status(400).build();
    }
  }

  @PatchMapping("/{id}")
  public ResponseEntity<Long> updatePartial(@PathVariable Long id, @RequestBody Map<String, Object> request) {
    try {
      return ResponseEntity.ok(eventService.patch(id, request));
    } catch (Exception e) {
      return ResponseEntity.status(400).build();
    }
  }

  @DeleteMapping("/{id}")
  public ResponseEntity<Long> delete(@PathVariable Long id) {
    try {
      return ResponseEntity.ok(eventService.delete(id));
    } catch (Exception e) {
      return ResponseEntity.status(400).build();
    }
  }

}
