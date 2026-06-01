package com.sbn.game.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.sbn.game.dto.GameDto;
import com.sbn.game.dto.GameResultDto;

public interface GameService {

	void insertGame(HashMap<String, Object> map);

	GameDto getGameResult(String game_idx);

	String getLeagueName(String league_idx);

	HashMap<String, Object> getTopScoreBoard(String game_idx);

	HashMap<String, Object> getBottomScoreBoard(String game_idx);

	HashMap<String, Object> getGameTeamNames(String game_idx);

	ArrayList<HashMap<String, Object>> getAwayRecord(String game_idx);

	ArrayList<HashMap<String, Object>> getHomeRecord(String game_idx);

	ArrayList<HashMap<String, Object>> getAwayPRecord(String game_idx);

	ArrayList<HashMap<String, Object>> getHomePRecord(String game_idx);

	void updateGameStat(GameDto gameDto);
	
	GameDto getGameInfo(int game_idx);

	void insertGameResult(GameResultDto gameResultDto);

	void insertGameResultList(ArrayList<GameResultDto> resultList);

	ArrayList<GameResultDto> getGameResultList(GameResultDto gameResultDto);


}
