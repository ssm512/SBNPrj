package com.sbn.member.mapper;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.sbn.member.dto.MemberDto;

@Mapper
public interface MemberMapper {

	MemberDto getLogin(HashMap<String, Object> map);

}
