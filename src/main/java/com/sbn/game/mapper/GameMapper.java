package com.sbn.game.mapper;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.sbn.game.dto.GameDto;

@Mapper
public interface GameMapper {

	void insertGame(HashMap<String, Object> map);

	GameDto getGameResult(String game_idx);

}
