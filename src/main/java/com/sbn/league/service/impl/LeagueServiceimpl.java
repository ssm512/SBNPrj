package com.sbn.league.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbn.game.dto.GameDto;
import com.sbn.league.dto.LeagueDto;
import com.sbn.league.mapper.LeagueMapper;
import com.sbn.league.service.LeagueService;

@Service
public class LeagueServiceimpl implements LeagueService {
	
	@Autowired
	private LeagueMapper leagueMapper;

	@Override
	public List<LeagueDto> getLeagueList(HashMap<String, Object> map) {
		// 만약 컨트롤러에서 map을 생성하지 않고 null로 보냈을 때를 대비한 방어 코드
	    if (map == null) {
	        map = new HashMap<>();
	    }

	    // map에 offset 정보가 없거나 null이면 기본값 0 세팅
	    if (!map.containsKey("offset") || map.get("offset") == null) {
	        map.put("offset", 0); 
	    }
	    
	    // map에 numOfRows 정보가 없거나 null이면 기본값 10 세팅 (페이지당 10개씩 노출)
	    if (!map.containsKey("numOfRows") || map.get("numOfRows") == null) {
	        map.put("numOfRows", 10); 
	    }
		List<LeagueDto> leagueList = leagueMapper.getLeagueList( map );
		return leagueList;
	}

	@Override
	public int count(HashMap<String, Object> map) {
		
		// 만약 컨트롤러에서 map 을 생성하지 않고 null 로 보냈을 때를 대비한 코드
	    if (map == null) {
	        map = new HashMap<>();
	    }
	    
	    // mapper 의 count 쿼리를 호출하여 전체 데이터 개수를 받아온 뒤 반환
	    return leagueMapper.count(map);
	}

	@Override
	public LeagueDto getLeague(HashMap<String, Object> map) {
		return leagueMapper.getLeague(map);
	}

	@Override
	public List<Map<String, Object>> getGameList(HashMap<String, Object> map) {
	    return leagueMapper.getGameList(map);
	}

	@Override
	public List<Map<String, Object>> getTeamList(HashMap<String, Object> map) {
		return leagueMapper.getTeamList(map);
	}

	@Override
	public List<Map<String, Object>> getSignTeamList(HashMap<String, Object> map) {
		return leagueMapper.getSignTeamList(map);
	}

	@Override
	public void approveTeam(HashMap<String, Object> map) {
		leagueMapper.approveTeam(map);
	}

	@Override
	public void rejectTeam(HashMap<String, Object> map) {
		leagueMapper.rejectTeam(map);
	}

	@Override
	public void updateLeague(HashMap<String, Object> map) {
		leagueMapper.updateLeague(map);
	}

	@Override
	public List<Map<String, Object>> getTeamsByManager(HashMap<String, Object> map) {
		return leagueMapper.getTeamsByManager(map);
	}

	@Override
	public int checkDuplicateApply(HashMap<String, Object> map) {
		return leagueMapper.checkDuplicateApply(map);
	}

	@Override
	public void applyLeague(HashMap<String, Object> map) {
		leagueMapper.applyLeague(map);
	}

}
