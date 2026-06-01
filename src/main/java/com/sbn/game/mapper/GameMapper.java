package com.sbn.game.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbn.game.dto.GameDto;
import com.sbn.game.dto.GameResultDto;

@Mapper
public interface GameMapper {

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

	void insertGameResultList(@Param("list") ArrayList<GameResultDto> resultList);

	ArrayList<GameResultDto> getGameResultList(int game_idx);


}
