package com.sbn.team.service;

import java.util.HashMap;
import java.util.List;

import com.sbn.team.dto.MemberTeamDto;
import com.sbn.team.dto.TeamDto;

public interface TeamService {

    // ===================== TEAM =====================

    List<TeamDto> getTeamList(HashMap<String, Object> map);     // 팀 목록 조회 (페이징)

    int getTeamCount(HashMap<String, Object> map);              // 팀 전체 건수 (페이징용)

    TeamDto getTeamInfo(int team_idx);                          // 팀 상세 조회

    int insertTeam(HashMap<String, Object> map);                // 팀 생성

    int getTeamNameCount(String team_name);  					// 팀 이름 중복 확인
    
	void updateTeamLogo(HashMap<String, Object> logoMap);       // 팀 로고 수정

	void insertTeamLogo(HashMap<String, Object> saveLogoMap);   // 팀 로고 추가

    // ===================== TEAM_LEAGUE =====================

    List<String> getTeamLeague(int team_idx);                   // 소속 리그 조회


    // ===================== MEMBER_TEAM =====================

    List<MemberTeamDto> getMemberTeamList(int team_idx, String keyword); // 소속 선수 목록 조회

    void insertMemberTeam(HashMap<String, Object> map);         // 팀 생성자 자동 등록

    void updateMemberTeam(HashMap<String, Object> map);         // 선수 포지션 / 배번 수정

    void deleteMemberTeam(HashMap<String, Object> map);         // 팀원 삭제 (방출 / 가입 거절)


    // ===================== 가입 신청 =====================

    Integer getJoinStatus(HashMap<String, Object> map);                   // 가입 신청 상태 조회

    List<MemberTeamDto> getMemberJoinRequestList(int team_idx);           // 가입 신청 목록 조회

    void joinTeam(HashMap<String, Object> map);                           // 가입 신청 INSERT

    void updateJoinStatus(HashMap<String, Object> map);                   // 가입 승인 (JOIN_STATUS = 1)



}