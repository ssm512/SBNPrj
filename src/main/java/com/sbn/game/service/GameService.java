package com.sbn.game.service;

import java.util.HashMap;

import com.sbn.game.dto.GameDto;

public interface GameService {

	void insertGame(HashMap<String, Object> map);

	GameDto getGameResult(String game_idx);

}
