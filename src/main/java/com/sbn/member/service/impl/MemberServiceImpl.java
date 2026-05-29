package com.sbn.member.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.sbn.member.dto.MemberDto;
import com.sbn.member.mapper.MemberMapper;
import com.sbn.member.service.MemberService;
import com.sbn.team.dto.TeamDto;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private  MemberMapper  memberMapper;
	
    @Autowired
    private BCryptPasswordEncoder encoder;
	
	@Override
	public List<MemberDto> getMemberList(HashMap<String, Object> map) {
		List<MemberDto> memberList  = memberMapper.getMemberList(map); 
		return memberList;
	}

	@Override
	public MemberDto login(HashMap<String, Object> map) {
        String rawPw = map.get("password").toString();

        MemberDto member = memberMapper.getMemberById(map);

        if (member == null) return null;                                // 아이디 없음
        if (!encoder.matches(rawPw, member.getPassword())) return null; // 비번 틀림

        member.setPassword(null); // 세션에 담기 전 password 제거
        return member;
	}

	@Override
	public MemberDto getMemberById(HashMap<String, Object> map) {
		MemberDto  member  = memberMapper.getMemberById(map);
		member.setPassword(null); // 세션에 담기 전 password 제거
		return  member;
	}
	
	@Override
	public void signin(HashMap<String, Object> map) {
        String rawPw = map.get("password").toString();
        map.put("password", encoder.encode(rawPw)); // 암호화 후 덮어씌우기
        memberMapper.insertMember(map);
	}

	@Override
	public List<TeamDto> getMyTeamList(int member_idx) {
		List<TeamDto> teamList = memberMapper.getMyTeamList(member_idx);
		return teamList;
	}
	
	@Override
	public MemberDto getIdDupCheck(String member_id) {
		MemberDto	member		=	memberMapper.getIdDupCheck(member_id);
		return member;
	}

	@Override
	public void updateMember(HashMap<String, Object> map) {
		memberMapper.updateMember(map);
	}

	@Override
	public MemberDto getPhoneDupCheck(String phone_num) {
		MemberDto	member		=	memberMapper.getPhoneDupCheck(phone_num);
		return member;
	}

	@Override
	public MemberDto getEmailDupCheck(String email) {
		MemberDto	member		=	memberMapper.getEmailDupCheck(email);
		return member;
	}



}
