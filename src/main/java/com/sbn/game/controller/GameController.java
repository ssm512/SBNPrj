package com.sbn.game.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.sbn.game.mapper.GameMapper;
import com.sbn.game.service.GameService;

@Controller
@RequestMapping("/Game")
public class GameController {
	
	@Autowired
	private GameMapper gameMapper;
	
	@Autowired
	private GameService gameService;
	
	@RequestMapping("AddGameForm")
	public ModelAndView addGameForm ( @RequestParam HashMap<String, Object> map) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/game/addgame");
		mv.addObject("map", map);
		return mv;
	}
	
	
}
