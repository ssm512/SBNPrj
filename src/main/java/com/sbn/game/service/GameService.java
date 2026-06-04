package com.sbn.game.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.sbn.game.dto.GameDto;
import com.sbn.game.dto.GameResultDto;
import com.sbn.paging.SearchDto;

public interface GameService {

	/* Game Add */
	void insertGame(HashMap<String, Object> map);
	
	// 게임정보 검색
	GameDto getGameResult(String game_idx);
	// 리그이름 검색
	String getLeagueName(String league_idx);
	// 이닝초 GameResult 검색
	HashMap<String, Object> getTopScoreBoard(String game_idx);
	// 이닝후 GameResult 검색 
	HashMap<String, Object> getBottomScoreBoard(String game_idx);
	// Game참여 TeamName 검색
	HashMap<String, Object> getGameTeamNames(String game_idx);
	// AwayTeam Hitter Record 검색, ArrayList로 받음 
	ArrayList<HashMap<String, Object>> getAwayRecord(String game_idx);
	// HomeTeam Hitter Record 검색, ArrayList로 받음
	ArrayList<HashMap<String, Object>> getHomeRecord(String game_idx);
	// AwayTeam Pitcher Record 검색, ArrayList로 받음
	ArrayList<HashMap<String, Object>> getAwayPRecord(String game_idx);
	// HomeTeam Pitcher Record 검색, ArrayList로 받음
	ArrayList<HashMap<String, Object>> getHomePRecord(String game_idx);
	// 게임정보 수정
	void updateGameStat(GameDto gameDto);
	
	GameDto getGameInfo(HashMap<String, Object> map);

	void insertGameResult(GameResultDto gameResultDto);

	void insertGameResultList(GameResultDto result, int game_idx);

	ArrayList<GameResultDto> getGameResultList(GameResultDto gameResultDto);

	void updateGameResult(GameResultDto gameResultDto);

	void deleteGameResult(int record_num);
	// updateresult부분 pagination을 위한 game별 MaxInning 
	int getMaxInning(int game_idx);
	// updateresult부분 inning별 GameResultList
	ArrayList<GameResultDto> getGameResultListByInning(int game_idx, SearchDto searchDto);


}
