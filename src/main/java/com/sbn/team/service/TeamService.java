package com.sbn.team.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;                     
import com.sbn.team.mapper.TeamMapper;     
import com.sbn.team.dto.TeamDto;

@Service
public class TeamService {
	
	@Autowired
	private TeamMapper teamMapper;
	
	/* 팀 목록 조회 */
	public List<TeamDto> getTeamList(String keyword) {
		return teamMapper.selectTeamList(keyword);
	}

}
