package member.model;

import java.util.ArrayList;
import java.util.HashMap;
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
	

    public int insertMember(MemberBean member) {
        try {
            return sqlSessionTemplate.insert(namespace + ".insertMember", member);
        } catch (Exception e) {
            // DuplicateKeyException 등의 예외 처리 필요
            e.printStackTrace();
            return -1;
        }
    }//insertMember
 

	public int getTotalCount(Map<String, String> map) {
		int cnt = sqlSessionTemplate.selectOne(namespace+".getTotalCount", map);
		System.out.println("여기");
		return cnt;
	}//getTotalCount
	
	public List<MemberBean> getMemberList(Map<String,String> map, Paging pageInfo) {
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


	public int updateMemberStatus(int userId, String status) {   

		 int cnt = -1;
	        // 파라미터를 Map에 담아서 전달
	        Map<String, Object> params = new HashMap<String, Object>();
	        params.put("user_id", userId);
	        params.put("user_status", status);
	        
	        cnt = sqlSessionTemplate.update(namespace + ".updateStatusMember", params);
	        return cnt;
	    }

//이메일중복체크
	public boolean checkDuplicateEmail(String user_email) {
	    Integer count = sqlSessionTemplate.selectOne(namespace + ".checkDuplicateEmail", user_email);
	    return count != null && count > 0;
	}
//닉네임중복체크
	public boolean checkDuplicateNickname(String user_nickname) {
	    Integer count = sqlSessionTemplate.selectOne(namespace +".checkDuplicateNickname", user_nickname);
	    return count != null && count > 0;
	}


	  public String findEmail(String userName, String userPhone) {
	        Map<String, Object> params = new HashMap<String, Object>();
	        params.put("user_name", userName);
	        params.put("user_phone", userPhone);
	        
	        return sqlSessionTemplate.selectOne(namespace + ".findEmail", params);
	    }
	  
	  
	  public String findPassword(String userEmail, String userPhone) {
	        Map<String, Object> params = new HashMap<String, Object>();
	        params.put("user_email", userEmail);
	        params.put("user_phone", userPhone);
	        
	        return sqlSessionTemplate.selectOne(namespace + ".findPassword", params);
	    }
	  
	  
	  public MemberBean findByEmail(String userEmail) {
		  MemberBean mb = null;
		  mb = sqlSessionTemplate.selectOne(namespace + ".FindByEmail", userEmail);
		  return mb;
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

	      
	      public int decreasePoint(PaymentBean pb) { // TODO Auto-generated method stub
	         int cnt = -1; cnt = sqlSessionTemplate.update(namespace + ".decreasePoint",pb); 
	         return cnt; 
	      }

	  
	}





	







