package member.model;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import payment.model.PaymentBean;
import utility.Paging;



@Component("MemberDao")
public class MemberDao {

	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	private String namespace="member.model.Member";

	public MemberBean getMemberByEmail(String user_email) {
		// TODO Auto-generated method stub
		MemberBean member = null;
		member = sqlSessionTemplate.selectOne(namespace + ".getMemberByEmail", user_email);
		return member;
	}

	public int insertBusinessMember(MemberBean member) {
		int cnt = -1;
		System.out.println("MemberDao : " + member.getUser_birth());
		cnt = sqlSessionTemplate.insert(namespace+".insertBusinessMember",member);
		return cnt;
	}

	public int insertMember(MemberBean member) {
		int cnt = -1;
		System.out.println("MemberDao : " + member.getUser_birth());
		cnt = sqlSessionTemplate.insert(namespace+".insertMember",member);
		return cnt;
	}//insertMember

	public int getTotalCount(Map<String, String> map) {
		int cnt = sqlSessionTemplate.selectOne(namespace+".getTotalCount", map);
		return cnt;
	}

	public List<MemberBean> getMemberList(Map<String, String> map, Paging pageInfo) {
		List<MemberBean> list = new ArrayList<MemberBean>();
		RowBounds rowbounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		list = sqlSessionTemplate.selectList(namespace+".getMemberList", map, rowbounds);
		return list;

	}

	public MemberBean getMemberByUser_id(int user_id) {
		// TODO Auto-generated method stub
		MemberBean mb = null;
		mb = sqlSessionTemplate.selectOne(namespace + ".getMemberByUser_id", user_id);
		return mb;
	}

	public int getPoint(MemberBean mb) {
		// TODO Auto-generated method stub
		int cnt = -1;
		cnt = sqlSessionTemplate.update(namespace + ".getPoint", mb);
		return cnt;
	}

	public int decreasePoint(PaymentBean pb) {
		// TODO Auto-generated method stub
		int cnt = -1;
		cnt = sqlSessionTemplate.update(namespace + ".decreasePoint", pb);
		return cnt;
	}



}





	







