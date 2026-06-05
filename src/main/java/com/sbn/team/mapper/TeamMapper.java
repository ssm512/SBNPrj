package com.sbn.team.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbn.team.dto.MemberTeamDto;
import com.sbn.team.dto.TeamDto;

@Mapper
public interface TeamMapper {

    // ===================== TEAM =====================

    List<TeamDto> getTeamList(HashMap<String, Object> map);      // 팀 목록 조회 (페이징)

    int getTeamCount(HashMap<String, Object> map);               // 팀 전체 건수 (페이징용)

    TeamDto getTeamInfo(@Param("team_idx") int team_idx);        // 팀 상세 조회

    void insertTeam(HashMap<String, Object> map);                // 팀 생성

    int getTeamNameCount(String team_name);  				     // 팀 이름 중복 확인
    
    void insertTeamLogo(HashMap<String, Object> saveLogoMap);    // 구단 로고 추가

    void updateTeamLogo(HashMap<String, Object> logoMap);        // 구단 로고 수정

    // ===================== TEAM_LEAGUE =====================

    List<String> getTeamLeague(@Param("team_idx") int team_idx); // 소속 리그 조회


    // ===================== MEMBER_TEAM =====================

    List<MemberTeamDto> getMemberTeamList(@Param("team_idx") int team_idx,
                                             @Param("keyword")  String keyword); // 소속 선수 목록 조회

    void insertMemberTeam(HashMap<String, Object> map);             // 팀 생성자 자동 등록

    void updateMemberTeam(HashMap<String, Object> map);             // 선수 포지션 / 배번 수정

    void deleteMemberTeam(HashMap<String, Object> map);             // 팀원 삭제 (방출 / 가입 거절)


    // ===================== 가입 신청 =====================

    Integer getJoinStatus(HashMap<String, Object> map);              // 가입 신청 상태 조회

    List<MemberTeamDto> getMemberJoinRequestList(@Param("team_idx") int team_idx); // 가입 신청 목록 조회

    void insertJoinRequest(HashMap<String, Object> map);                // 가입 신청 INSERT

    void updateJoinStatus(HashMap<String, Object> map);                 // 가입 승인 (JOIN_STATUS = 1)

    
    // ===================== 구단 해체 =====================
    
    int selectMemberCountExceptManager(HashMap<String, Object> map); // 본인 제외 활성 팀원 수 조회 (해체 조건 체크)

    List<String> selectFileNameByTeamIdx(int team_idx);              // 팀 로고 파일명 목록 조회 (디스크 삭제용)

    void deleteFilesByTeamIdx(int team_idx);                         // FILES 테이블 팀 로고 삭제

    void deactivateTeam(int team_idx);                               // 팀 비활성화 (IS_ACTIVE = 'N', CONTENT 업데이트)

}