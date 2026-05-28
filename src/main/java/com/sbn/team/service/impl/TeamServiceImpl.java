package com.sbn.team.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbn.team.dto.MemberTeamDto;
import com.sbn.team.dto.TeamDto;
import com.sbn.team.mapper.TeamMapper;
import com.sbn.team.service.TeamService;

@Service
public class TeamServiceImpl implements TeamService {

    @Autowired
    private TeamMapper teamMapper;

    /* 팀 목록 조회 */
    @Override
    public List<TeamDto> getTeamList(String keyword) {
        return teamMapper.selectTeamList(keyword);
    }

    @Override
    public TeamDto getTeamInfo(int team_idx) {
        return teamMapper.selectTeamInfo(team_idx);
    }
    
    @Override
    public List<String> getTeamLeague(int team_idx) {
        return teamMapper.selectTeamLeague(team_idx);
    }
    
    @Override
    public List<MemberTeamDto> getMemberTeamList(int team_idx, String keyword) {
        return teamMapper.selectMemberTeamList(team_idx, keyword);
    }


}