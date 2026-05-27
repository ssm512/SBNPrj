package com.sbn.league.service;

import java.util.HashMap;
import java.util.List;

import com.sbn.league.dto.LeagueDto;

public interface LeagueService {

	List<LeagueDto> getLeagueList(HashMap<String, Object> map);

}
