package com.sbn.game.service.impl;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbn.game.dto.GameDto;
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
		GameDto	gameinfo		=	gameMapper.getGameResult(game_idx);
		return gameinfo;
	}

	@Override
	public String getLeagueName(String league_idx) {
		String	getLeagueName	=	gameMapper.getLeagueName(league_idx);
		return getLeagueName;
	}

}
