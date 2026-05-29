package com.sbn.league.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sbn.game.dto.GameDto;
import com.sbn.league.dto.LeagueDto;

@Mapper
public interface LeagueMapper {

	List<LeagueDto> getLeagueList(HashMap<String, Object> map);

	int count(HashMap<String, Object> map);

	LeagueDto getLeague(HashMap<String, Object> map);

	List<Map<String, Object>> getGameList(HashMap<String, Object> map);

	List<Map<String, Object>> getTeamList(HashMap<String, Object> map);

	List<Map<String, Object>> getSignTeamList(HashMap<String, Object> map);

	void approveTeam(HashMap<String, Object> map);

	void rejectTeam(HashMap<String, Object> map);

	void updateLeague(HashMap<String, Object> map);

	List<Map<String, Object>> getTeamsByManager(HashMap<String, Object> map);

	int checkDuplicateApply(HashMap<String, Object> map);

	void applyLeague(HashMap<String, Object> map);

}
