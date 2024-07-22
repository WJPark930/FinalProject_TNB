package faq.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import utility.Paging;

@Component("FaqDao")
public class FaqDao {

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	private String namespace = "faq.model.Faq";
	
	public List<FaqBean> getFaqList(Map<String,String> map, Paging pageInfo){
		
		List<FaqBean> list = new ArrayList<FaqBean>();
		list = sqlSessionTemplate.selectList(namespace + ".getFaqList", map);
		return list;
	}
	
	public int getTotalCount(Map<String,String> map) {
		int cnt = sqlSessionTemplate.selectOne(namespace + ".getTotalCount", map);
		return cnt;
	}
	
	public int insertFaq(FaqBean faq) {
		int cnt = -1;
		cnt = sqlSessionTemplate.insert(namespace + ".insertFaq", faq);
		return cnt;
	}
	
	public FaqBean getFaq(int faq_id) {
		FaqBean faq = null;
		faq = sqlSessionTemplate.selectOne(namespace + ".getFaq", faq_id);
		return faq;
	}
	
	public int updateFaq(FaqBean faq) {
		int cnt = -1;
		cnt = sqlSessionTemplate.update(namespace + ".updateFaq", faq);
		return cnt;
	}
	
	public int deleteFaq(int faq_id) {
		int cnt = -1;
		cnt = sqlSessionTemplate.delete(namespace + ".deleteFaq", faq_id);
		return cnt;
	}
	
	public List<String> getCategoryList() {
        return sqlSessionTemplate.selectList(namespace + ".getCategoryList");
    }
}
