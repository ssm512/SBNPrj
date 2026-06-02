package com.sbn.game.service.impl;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbn.game.dto.GameDto;
import com.sbn.game.dto.GameResultDto;
import com.sbn.game.mapper.GameMapper;
import com.sbn.game.service.GameService;

@Service
public class GameServiceImpl implements GameService {
	
	@Autowired
	private GameMapper gameMapper;
	
	@Override
	public void insertGame(HashMap<String, Object> map) {
		gameMapper.insertGame(map);
		
	}

	@Override
	public GameDto getGameResult(String game_idx) {
		GameDto					gameinfo			=	gameMapper.getGameResult(game_idx);
		return gameinfo;
	}

	@Override
	public String getLeagueName(String league_idx) {
		String					getLeagueName		=	gameMapper.getLeagueName(league_idx);
		return getLeagueName;
	}

	@Override
	public HashMap<String, Object> getTopScoreBoard(String game_idx) {
		HashMap<String, Object> topScoreBoard		=	gameMapper.getTopScoreBoard(game_idx);
		return topScoreBoard;
	}

	@Override
	public HashMap<String, Object> getBottomScoreBoard(String game_idx) {
		HashMap<String, Object> bottomScoreBoard	=	gameMapper.getBottomScoreBoard(game_idx);
		return bottomScoreBoard;
	}

	@Override
	public HashMap<String, Object> getGameTeamNames(String game_idx) {
		HashMap<String, Object>	teamNames			=	gameMapper.getGameTeamNames(game_idx);
		return teamNames;
	}

	@Override
	public ArrayList<HashMap<String, Object>> getAwayRecord(String game_idx) {
		ArrayList<HashMap<String, Object>> awayRecord	=	gameMapper.getAwayRecord(game_idx);
		return awayRecord;
	}

	@Override
	public ArrayList<HashMap<String, Object>> getHomeRecord(String game_idx) {
		ArrayList<HashMap<String, Object>> homeRecord	=	gameMapper.getHomeRecord(game_idx);
		return homeRecord;
	}

	@Override
	public ArrayList<HashMap<String, Object>> getAwayPRecord(String game_idx) {
		ArrayList<HashMap<String, Object>> awayPRecord	=	gameMapper.getAwayPRecord(game_idx);
		return awayPRecord;
	}

	@Override
	public ArrayList<HashMap<String, Object>> getHomePRecord(String game_idx) {
		ArrayList<HashMap<String, Object>> homePRecord	=	gameMapper.getHomePRecord(game_idx);
		return homePRecord;
	}

	@Override
	public void updateGameStat(GameDto gameDto) {
		gameMapper.updateGameStat(gameDto);		
	}

	@Override
	public GameDto getGameInfo(HashMap<String, Object> map) {
		GameDto gameDto = new GameDto();

	    gameDto.setGame_idx(Integer.parseInt(map.get("game_idx").toString()));
	    gameDto.setGame_status(Integer.parseInt(map.get("game_status").toString()));
	    gameDto.setWinner(Integer.parseInt(map.get("winner").toString()));

	    gameDto.setWin_pitcher(map.get("win_pitcher").toString());
	    gameDto.setLose_pitcher(map.get("lose_pitcher").toString());
	    gameDto.setSave_pitcher(map.get("save_pitcher").toString());
	    gameDto.setHold_pitcher(map.get("hold_pitcher").toString());

	    gameMapper.updateGameStat(gameDto);
		return gameDto;
	}

	@Override
	public void insertGameResult(GameResultDto gameResultDto) {
		gameMapper.insertGameResult(gameResultDto);
		
	}

	@Override
	public void insertGameResultList(GameResultDto result, int game_idx) {
		gameMapper.insertGameResultList(result, game_idx);
		
	}

	@Override
	public ArrayList<GameResultDto> getGameResultList(GameResultDto gameResultDto) {
		ArrayList<GameResultDto>	resultList		=	gameMapper.getGameResultList(gameResultDto.getGame_idx());
		return resultList;
	}

	@Override
	public void updateGameResult(GameResultDto gameResultDto) {
		gameMapper.updateGameResult(gameResultDto);
		
	}

	@Override
	public void deleteGameResult(int record_num) {
		gameMapper.deleteGameResult(record_num);
		
	}


}
