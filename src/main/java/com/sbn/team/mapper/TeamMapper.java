package com.sbn.team.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbn.team.dto.MemberTeamDto;
import com.sbn.team.dto.TeamDto;

@Mapper
public interface TeamMapper {

    List<TeamDto> selectTeamList(String keyword);

    TeamDto selectTeamInfo(@Param("team_idx") int team_idx);
    
    List<String> selectTeamLeague(int team_idx);
    
    List<MemberTeamDto> selectMemberTeamList(@Param("team_idx") int team_idx,
            @Param("keyword")  String keyword);
    
    
    
}




