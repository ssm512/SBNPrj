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

}
