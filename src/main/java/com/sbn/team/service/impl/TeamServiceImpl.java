package com.sbn.team.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbn.team.dto.TeamDto;
import com.sbn.team.mapper.TeamMapper;
import com.sbn.team.service.TeamService;

@Service
public class TeamServiceImpl implements TeamService {
	
	@Autowired
	private TeamMapper teamMapper;
	
	/* 팀 목록 조회 */
	public List<TeamDto> getTeamList(String keyword) {
		return teamMapper.selectTeamList(keyword);
	}

}
