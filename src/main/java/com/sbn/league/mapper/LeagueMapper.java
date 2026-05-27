package com.sbn.league.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sbn.league.dto.LeagueDto;

@Mapper
public interface LeagueMapper {

	List<LeagueDto> getLeagueList(HashMap<String, Object> map);

	int count(HashMap<String, Object> map);

}
