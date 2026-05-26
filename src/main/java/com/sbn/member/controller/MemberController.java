package com.sbn.member.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.sbn.member.dto.MemberDto;
import com.sbn.member.mapper.MemberMapper;
import com.sbn.member.service.MemberService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/Member")
public class MemberController {

	@Autowired
	private  MemberService  memberService;
	
	@Autowired
	private  MemberMapper   memberMapper;


	
	
	@RequestMapping("/LoginForm")
	public  ModelAndView  loginForm() {
		ModelAndView  mv  = new ModelAndView();
		mv.setViewName("member/login");
		return  mv;
	}
	
	@RequestMapping("/Login")
	public  String  login( @RequestParam HashMap<String, Object> map, 
			HttpServletRequest request, Model model) {
		
		MemberDto     member  = memberMapper.getLogin(map);
		HttpSession   session =  request.getSession();

	    if (member == null) {
	        model.addAttribute("msg", "아이디 또는 비밀번호가 틀렸습니다.");
	        return "member/login"; // 로그인 폼으로 다시
	    }
	    
		session.setAttribute("login", member);
		
		String  loc  = "";
		if(session.getAttribute("loc") == null)
			loc = "redirect:/";
		else {
			loc = "redirect:" + session.getAttribute("loc").toString();
			session.removeAttribute("loc");
		}
		

		return  loc;
	}
	
	@RequestMapping("/Logout")
	public  String  logout( HttpServletRequest request ) {
		HttpSession  session  = request.getSession();
		session.invalidate();
		return  "redirect:/";
	}
	
	
	@RequestMapping("/SigninForm")
	public  ModelAndView  signinForm() {
		ModelAndView  mv  = new ModelAndView();
		mv.setViewName("member/signin");
		return  mv;
	}
	
	
	
	
}
