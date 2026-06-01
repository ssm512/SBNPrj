package com.sbn.team.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbn.team.dto.MemberTeamDto;
import com.sbn.team.dto.TeamDto;

@Mapper
public interface TeamMapper {

    List<TeamDto> selectTeamList(HashMap<String, Object> map);

    int selectTeamCount(HashMap<String, Object> map); 

    TeamDto selectTeamInfo(@Param("team_idx") int team_idx);

    List<String> selectTeamLeague(@Param("team_idx") int team_idx);

    List<MemberTeamDto> selectMemberTeamList(@Param("team_idx") int team_idx,
                                              @Param("keyword")  String keyword);
    
    void insertTeam(HashMap<String, Object> map);
    
    void insertMemberTeam(HashMap<String, Object> map);
    
    List<MemberTeamDto> selectJoinRequestList(@Param("team_idx") int team_idx);
    
    void updateMemberTeam(HashMap<String, Object> map);
    
    void updateJoinStatus(HashMap<String, Object> map);
    
    Integer selectJoinStatus(HashMap<String, Object> map);
    
    void insertJoinRequest(HashMap<String, Object> map);
    
    

    
    
}




