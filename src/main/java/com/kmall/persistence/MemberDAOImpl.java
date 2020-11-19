package com.kmall.persistence;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kmall.domain.MemberVO;

import java.util.List;
import java.util.Map;

@Repository
public class MemberDAOImpl implements MemberDAO {

    private static final String MAPPER_PATH = "com.kmall.mapper.MemberMapper.";

    @Autowired
    private SqlSession session;

    @Override
    public MemberVO login(MemberVO member) {
        return session.selectOne(MAPPER_PATH + "login", member);
    }

    @Override
    public void lastLogin(String uid) {
        session.update(MAPPER_PATH + "updateLastLogin", uid);
    }

    @Override
    public String getPasswd(String uid) {
        return session.selectOne(MAPPER_PATH + "getPasswd", uid);
    }

    @Override
    public void addMember(MemberVO member) {
        session.insert(MAPPER_PATH + "addMember", member);
    }

    @Override
    public MemberVO checkSelf(String uid) {
        MemberVO member = session.selectOne(MAPPER_PATH + "check", uid);
        return member;
    }

    @Override
    public MemberVO getMember(String uid) {
        MemberVO member = session.selectOne(MAPPER_PATH + "getMember", uid);
        return member;
    }

    @Override
    public void updateMember(MemberVO member) {
        session.update(MAPPER_PATH + "updateMember", member);
    }

    @Override
    public void quitMember(String uid) {
        session.delete(MAPPER_PATH + "quit", uid);
    }

    @Override
    public List<MemberVO> getMembers() {
        return session.selectList(MAPPER_PATH + "getMembers");
    }

    @Override
    public int isIdDuplicated(String uid) {
        return session.selectOne(MAPPER_PATH + "isIdDuplicated", uid);
    }

    @Override
    public int isNickDuplicated(String nickname) {
        return session.selectOne(MAPPER_PATH + "isNickDuplicated", nickname);
    }
}
