package com.kmall.persistence;

import com.kmall.domain.MemberVO;

import java.util.List;

public interface MemberDAO {

	public MemberVO login(MemberVO member);

	public void lastLogin(String uid);

	public String getPasswd(String uid);
	
	public void addMember(MemberVO member);
	
	public MemberVO checkSelf(String uid);
	
	public int isIdDuplicated(String uid);
	
	public int isNickDuplicated(String nickname);
	
	public MemberVO getMember(String uid);
	
	public void updateMember(MemberVO member);

	public void quitMember(String uid);

	public List<MemberVO> getMembers();

}
