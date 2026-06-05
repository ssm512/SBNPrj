package com.sbn.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class HomeController {
	
	// 192.168.0.240:8080
	@RequestMapping("/")
	public  String  home( ) {
		return  "home";
	}
	

	@RequestMapping("/terms")
	public String terms() {
		return "terms/terms";
	}

	@RequestMapping("/privacy")
	public String privacy() {
		return "terms/privacy";
	}

	@RequestMapping("/test")
	@ResponseBody
	public  String  test() {
		return  "<h2>Test 입니다</h2><br>"
				+ "<a href=\"/\">돌아가기</a>";
	}
	
	
	
}






