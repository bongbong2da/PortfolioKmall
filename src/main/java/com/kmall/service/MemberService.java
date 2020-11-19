package com.kmall.service;

import com.kmall.domain.MemberVO;

import java.util.List;

public interface MemberService {
	
	public void addMember(MemberVO member);
	
	public MemberVO login(MemberVO member);

	public boolean verifyPasswd(String uid, String passwd);
	
	public boolean isIdDuplicated(String uid);
	
	public boolean isNickDuplicated(String nickname);
	
	public MemberVO getMember (String uid);
	
	public MemberVO updateMember (MemberVO member);

	public void quitMember(String uid);

	public List<MemberVO> getMembers();

	public void updateMemberByAdmin(MemberVO member);
}
