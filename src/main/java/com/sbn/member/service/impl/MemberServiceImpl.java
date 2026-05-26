package com.sbn.member.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbn.member.dto.MemberDto;
import com.sbn.member.mapper.MemberMapper;
import com.sbn.member.service.MemberService;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private  MemberMapper  memberMapper;
	
	@Override
	public List<MemberDto> getMemberList(HashMap<String, Object> map) {
		List<MemberDto> memberList  = memberMapper.getMemberList(map); 
		return memberList;
	}


}
