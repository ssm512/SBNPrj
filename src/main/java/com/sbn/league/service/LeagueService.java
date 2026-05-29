package com.sbn.league.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sbn.game.dto.GameDto;
import com.sbn.league.dto.LeagueDto;

public interface LeagueService {

	List<LeagueDto> getLeagueList(HashMap<String, Object> map);

	int count(HashMap<String, Object> map);

	LeagueDto getLeague(HashMap<String, Object> map);

	List<Map<String, Object>> getGameList(HashMap<String, Object> map);

	List<Map<String, Object>> getTeamList(HashMap<String, Object> map);

	List<Map<String, Object>> getSignTeamList(HashMap<String, Object> map);

	void approveTeam(HashMap<String, Object> map);

	void rejectTeam(HashMap<String, Object> map);

	void updateLeague(HashMap<String, Object> map);

	List<Map<String, Object>> getTeamsByManager(HashMap<String, Object> paramMap);

	int checkDuplicateApply(HashMap<String, Object> map);

	void applyLeague(HashMap<String, Object> map);

}
