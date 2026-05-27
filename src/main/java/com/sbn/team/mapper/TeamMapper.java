package com.sbn.team.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sbn.team.dto.TeamDto;

@Mapper
public interface TeamMapper {

    List<TeamDto> selectTeamList(String keyword);

}