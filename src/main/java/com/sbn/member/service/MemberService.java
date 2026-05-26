package com.sbn.member.service;

import java.util.HashMap;
import java.util.List;

import com.sbn.member.dto.MemberDto;

public interface MemberService {

	List<MemberDto> getMemberList(HashMap<String, Object> map);

}
