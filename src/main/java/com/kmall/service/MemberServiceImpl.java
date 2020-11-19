package com.kmall.service;

import com.kmall.domain.MemberVO;
import com.kmall.persistence.MemberDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDAO dao;
	
	@Autowired
	private BCryptPasswordEncoder encoder;
	
	public void addMember(MemberVO member) {
		
		String encrypted = encoder.encode(member.getMem_passwd());
		member.setMem_passwd(encrypted);
		
		dao.addMember(member);
	}
	
	@Transactional
	@Override
	public MemberVO login(MemberVO member) {
		MemberVO fromDB = dao.login(member);
		if(fromDB != null) {
			if(encoder.matches(member.getMem_passwd(), fromDB.getMem_passwd())) {
				dao.lastLogin(member.getMem_id());
				return fromDB;
			} else {
				return null;
			}
		} else {
			return null;
		}
	}

	@Override
	public boolean verifyPasswd(String uid, String passwd) {

		String passwdFromDB = dao.getPasswd(uid);

		if(encoder.matches(passwd, passwdFromDB)) {
			return true;
		} else {
			return false;
		}
	}

	public MemberVO getMember (String uid) {
		MemberVO member = dao.getMember(uid);
		return member;
	}
	
	public MemberVO updateMember (MemberVO member) {

		String encPass = encoder.encode(member.getMem_passwd());

		member.setMem_passwd(encPass);

		dao.updateMember(member);

		return member;
	}

	@Override
	public void quitMember(String uid) {
		dao.quitMember(uid);
	}

	@Override
	public List<MemberVO> getMembers() {
		return dao.getMembers();
	}

	@Override
	public void updateMemberByAdmin(MemberVO member) {
		dao.updateMember(member);
	}

	@Override
	public boolean isIdDuplicated(String uid) {
		boolean result = false;
		
		if(dao.isIdDuplicated(uid) != 0) {
			result = false;
		} else {
			result = true;
		}
		
		return result;
	}

	@Override
	public boolean isNickDuplicated(String nickname) {
		boolean result = false;
		
		if(dao.isNickDuplicated(nickname) != 0) {
			result = false;
		} else {
			result = true;
		}
		
		return result;
	}
}
