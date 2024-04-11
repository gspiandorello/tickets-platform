package com.ticketsplatform.ticketsapi.event;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import com.ticketsplatform.ticketsapi.event.dtos.EventDTO;
import com.ticketsplatform.ticketsapi.event.dtos.EventRequestDTO;

@Mapper(componentModel = "spring")
public interface EventMapper {
  EventDTO map(EventEntity eventEntity);

  EventRequestDTO mapToRequest(EventDTO eventDTO);

  EventEntity map(EventDTO eventDTO);

  @Mapping(target = "id", ignore = true)
  EventEntity map(EventRequestDTO eventRequestDTO);
}
