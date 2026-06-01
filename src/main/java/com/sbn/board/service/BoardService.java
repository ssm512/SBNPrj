package com.sbn.board.service;

import java.util.HashMap;
import java.util.List;

import com.sbn.board.dto.BoardDto;

public interface BoardService {

	List<BoardDto> getBoardList(HashMap<String, Object> map);

	int count(HashMap<String, Object> map);

	BoardDto getBoard(HashMap<String, Object> map);

	void setCountUpdate(HashMap<String, Object> map);

}
