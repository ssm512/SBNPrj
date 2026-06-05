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

    // ===================== TEAM =====================

    /* 팀 목록 조회 (페이징) */
    @Override
    public List<TeamDto> getTeamList(HashMap<String, Object> map) {
        return teamMapper.getTeamList(map);
    }

    /* 팀 전체 건수 조회 (페이징용) */
    @Override
    public int getTeamCount(HashMap<String, Object> map) {
        return teamMapper.getTeamCount(map);
    }

    /* 팀 상세 정보 조회 */
    @Override
    public TeamDto getTeamInfo(int team_idx) {
        return teamMapper.getTeamInfo(team_idx);
    }

    /* 팀 생성 - 시퀀스로 생성된 team_idx 반환 */
    @Override
    public int insertTeam(HashMap<String, Object> map) {
        teamMapper.insertTeam(map);
        return Integer.parseInt(map.get("team_idx").toString());
    }
    

    /* 팀 이름 중복 확인 */
    @Override
    public int getTeamNameCount(String team_name) {
        return teamMapper.getTeamNameCount(team_name);
    }
    
    /* 팀 로고 추가 */
	@Override
	public void insertTeamLogo(HashMap<String, Object> saveLogoMap) {
		teamMapper.insertTeamLogo(saveLogoMap);
	}
    
    /* 팀 로고 수정 */
	@Override
	public void updateTeamLogo(HashMap<String, Object> logoMap) {
		teamMapper.updateTeamLogo(logoMap);
	}

    // ===================== TEAM_LEAGUE =====================

    /* 소속 리그 목록 조회 */
    @Override
    public List<String> getTeamLeague(int team_idx) {
        return teamMapper.getTeamLeague(team_idx);
    }


    // ===================== MEMBER_TEAM =====================

    /* 소속 선수 목록 조회 */
    @Override
    public List<MemberTeamDto> getMemberTeamList(int team_idx, String keyword) {
        return teamMapper.getMemberTeamList(team_idx, keyword);
    }

    /* 팀 생성자 MEMBER_TEAM 자동 등록 */
    @Override
    public void insertMemberTeam(HashMap<String, Object> map) {
        teamMapper.insertMemberTeam(map);
    }

    /* 선수 포지션 / 배번 수정 */
    @Override
    public void updateMemberTeam(HashMap<String, Object> map) {
        teamMapper.updateMemberTeam(map);
    }

    /* 팀원 삭제 (방출 / 가입 거절) */
    @Override
    public void deleteMemberTeam(HashMap<String, Object> map) {
        teamMapper.deleteMemberTeam(map);
    }


    // ===================== 가입 신청 =====================

    /* 가입 신청 상태 조회 */
    @Override
    public Integer getJoinStatus(HashMap<String, Object> map) {
        return teamMapper.getJoinStatus(map);
    }

    /* 가입 신청 목록 조회 (JOIN_STATUS = 0) */
    @Override
    public List<MemberTeamDto> getMemberJoinRequestList(int team_idx) {
        return teamMapper.getMemberJoinRequestList(team_idx);
    }

    /* 가입 신청 INSERT */
    @Override
    public void joinTeam(HashMap<String, Object> map) {
        teamMapper.insertJoinRequest(map);
    }

    /* 가입 승인 (JOIN_STATUS = 1) */
    @Override
    public void updateJoinStatus(HashMap<String, Object> map) {
        teamMapper.updateJoinStatus(map);
    }

    // ===================== 구단 해체 =====================

	/* 팀 로고 파일명 목록 조회 (디스크 삭제용) */
	@Override
	public List<String> getFileNamesByTeamIdx(int team_idx) {
	    return teamMapper.selectFileNameByTeamIdx(team_idx);
	}
	
	/* 팀 해체 - 조건 체크 후 MEMBER_TEAM 탈퇴 / FILES 삭제 / TEAM 비활성화 */
	@Override
	public String dissolveTeam(HashMap<String, Object> map) {
	
	    // 본인 제외 활성 팀원이 있으면 해체 불가
	    if (teamMapper.selectMemberCountExceptManager(map) > 0) return "has_members";
	
	    // MEMBER_TEAM 본인 탈퇴 (기존 메서드 재사용)
	    teamMapper.deleteMemberTeam(map);
	
	    // FILES 테이블에서 팀 로고 삭제
	    teamMapper.deleteFilesByTeamIdx(Integer.parseInt(map.get("team_idx").toString()) );
	
	    // TEAM IS_ACTIVE = 'N' / CONTENT 업데이트
	    teamMapper.deactivateTeam(Integer.parseInt(map.get("team_idx").toString()) );
	
	    return "ok";
	}



}