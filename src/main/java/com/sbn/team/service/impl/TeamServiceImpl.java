package com.sbn.team.service.impl;

import java.util.HashMap;
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

    /* 팀 목록 조회 (페이징) */
    @Override
    public List<TeamDto> getTeamList(HashMap<String, Object> map) {
        return teamMapper.selectTeamList(map);
    }

    /* 팀 전체 건수 조회 (페이징용) */
    @Override
    public int getTeamCount(HashMap<String, Object> map) {
        return teamMapper.selectTeamCount(map);
    }

    /* 팀 상세 정보 조회 */
    @Override
    public TeamDto getTeamInfo(int team_idx) {
        return teamMapper.selectTeamInfo(team_idx);
    }

    /* 팀 소속 리그 목록 조회 */
    @Override
    public List<String> getTeamLeague(int team_idx) {
        return teamMapper.selectTeamLeague(team_idx);
    }

    /* 팀 소속 선수 목록 조회 */
    @Override
    public List<MemberTeamDto> getMemberTeamList(int team_idx, String keyword) {
        return teamMapper.selectMemberTeamList(team_idx, keyword);
    }

    /* 팀 생성 - 시퀀스로 생성된 team_idx 반환 */
    @Override
    public int insertTeam(HashMap<String, Object> map) {
        teamMapper.insertTeam(map);
        return Integer.parseInt(map.get("team_idx").toString());
    }

    /* 팀 생성자 MEMBER_TEAM 자동 등록 */
    @Override
    public void insertMemberTeam(HashMap<String, Object> map) {
        teamMapper.insertMemberTeam(map);
    }

    /* 가입 신청 목록 조회 (JOIN_STATUS = 0) */
    @Override
    public List<MemberTeamDto> getMemberJoinRequestList(int team_idx) {
        return teamMapper.selectJoinRequestList(team_idx);
    }

    /* 선수 포지션 / 배번 수정 */
    @Override
    public void updateMemberTeam(HashMap<String, Object> map) {
        teamMapper.updateMemberTeam(map);
    }

    /* 가입 상태 변경 */
    @Override
    public void updateJoinStatus(HashMap<String, Object> map) {
        teamMapper.updateJoinStatus(map);
    }
    
	/* 가입 신청 상태 조회 */
    @Override
    public Integer getJoinStatus(HashMap<String, Object> map) {
    	return teamMapper.selectJoinStatus(map);
    }

	/* 가입 신청 INSERT */
    @Override
    public void joinTeam(HashMap<String, Object> map) {
    	teamMapper.insertJoinRequest(map);
    }
}