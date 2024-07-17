package member.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Component;

import utility.BoardPaging;

@Component("MemberDao")
public class MemberDao {

	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	private String namespace="member.model.Member";
	

	public int insertMember(MemberBean member) {
		int cnt = -1;
		System.out.println(member.getUser_birth());
		
		cnt = sqlSessionTemplate.insert(namespace+".insertMember",member);

		/*
		 * try { cnt = sqlSessionTemplate.insert(namespace+".insertMember",member);
		 * }catch(DuplicateKeyException e) { System.out.println("아이디 중복"); cnt= -3; }
		 */
		return cnt;
	}//insertMember
 

	public int getTotalCount(Map<String, String> map) {
		int cnt = sqlSessionTemplate.selectOne(namespace+".getTotalCount", map);
		System.out.println("여기");
		return cnt;
	}//getTotalCount
	
	public List<MemberBean> getMemberList(Map<String,String> map, BoardPaging pageInfo) {
		List<MemberBean> list = new ArrayList<MemberBean>();
		RowBounds rowbounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		list = sqlSessionTemplate.selectList(namespace+".getMemberList", map, rowbounds);
		return list;
	}//getMemberList


	public int updateReadCount(int user_id) {
int cnt =-1;
cnt = sqlSessionTemplate.update(namespace + ".UpdateReadCount", user_id);
return cnt;
	}


	public MemberBean detailMember(int user_id) {
		MemberBean member=null;
		member = sqlSessionTemplate.selectOne(namespace+".detailMember",user_id);
		return member;
	}


	public MemberBean getMember(int user_id) {
		MemberBean member= null;
		member= sqlSessionTemplate.selectOne(namespace+".getMember",user_id);
		return member;
	}


	public int updateMember(MemberBean mb) {
		int cnt = -1;

		cnt = sqlSessionTemplate.update(namespace+".updateMember",mb);

		return cnt;

	}//updateMember


	public int deleteMember(int user_id) {
		
int cnt = sqlSessionTemplate.delete(namespace+".deleteMember",user_id);
		
		return cnt; 
	}//deleteMember


	public int insertBusinessMember(MemberBean member) {
		int cnt = -1;
		System.out.println(member.getUser_birth());
		
		cnt = sqlSessionTemplate.insert(namespace+".insertBusinessMember",member);
		return cnt;
	}


	public int updateBusinessMember(MemberBean mb) {
		int cnt = -1;

		cnt = sqlSessionTemplate.update(namespace+".updateBusinessMember",mb);

		return cnt;

	}//updateMember


	public MemberBean getMemberByEmail(String user_email) {
		// TODO Auto-generated method stub
		MemberBean member = null;
		member = sqlSessionTemplate.selectOne(namespace + ".getMemberByEmail", user_email);
		return member;
	}





	






}
