package com.sbn.team.service;

import java.util.List;

import com.sbn.team.dto.TeamDto;

public interface TeamService {

	List<TeamDto> getTeamList(String keyword);
	
}
