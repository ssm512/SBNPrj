package com.sbn.team.service;

import java.util.HashMap;
import java.util.List;

import com.sbn.team.dto.MemberTeamDto;
import com.sbn.team.dto.TeamDto;

public interface TeamService {

	List<TeamDto> getTeamList(HashMap<String, Object> map);     // String keyword → HashMap으로 변경

	int getTeamCount(HashMap<String, Object> map);              // 추가

    TeamDto getTeamInfo(int team_idx);

    List<String> getTeamLeague(int team_idx);

    List<MemberTeamDto> getMemberTeamList(int team_idx, String keyword);
    
    int insertTeam(HashMap<String, Object> map);
    
    void insertMemberTeam(HashMap<String, Object> map);
    
    List<MemberTeamDto> getMemberJoinRequestList(int team_idx);
    
    void updateMemberTeam(HashMap<String, Object> map);
    
    void updateJoinStatus(HashMap<String, Object> map);
    
    Integer getJoinStatus(HashMap<String, Object> map);
    
    void joinTeam(HashMap<String, Object> map);
}