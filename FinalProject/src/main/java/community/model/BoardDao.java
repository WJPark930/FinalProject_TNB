package community.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import utility.BoardPaging;

@Component
public class BoardDao {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	private String namespace = "community.model.Board";

	public List<BoardBean> getBoardList(Map<String, String> map, BoardPaging pageInfo) {
		List<BoardBean> lists = new ArrayList<BoardBean>();
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		lists = sqlSessionTemplate.selectList(namespace + ".getBoardList", map, rowBounds);
		System.out.println("list°¹¼ö : " + lists.size());
		return lists;
	}

	public int getArticleCount(Map<String, String> map) {
		int cnt = -1;
		cnt = sqlSessionTemplate.selectOne(namespace + ".getArticleCount", map);
//		System.out.println("totalCount : " + cnt);
		return cnt;
	}

	public BoardBean getArticle(int num) {
		sqlSessionTemplate.update(namespace + ".updateReadCount", num);
		return sqlSessionTemplate.selectOne(namespace + ".getArticle", num);
	}

	public int insertArticle(BoardBean board) {
		int cnt = -1;
		cnt = sqlSessionTemplate.insert(namespace + ".insertArticle", board);
		return cnt;
	}

	public int updateBoard(int bid, String passwd, BoardBean board) {
		String pw = sqlSessionTemplate.selectOne(namespace + ".getPasswd", bid);
		if(passwd.equals(pw)) {
			return sqlSessionTemplate.update(namespace + ".updateBoard", board);
		}else {
			return 0;
		}
	}

	public int deleteArticle(int bid, String passwd) {
		String pw = sqlSessionTemplate.selectOne(namespace + ".getPasswd", bid);
		if(passwd.equals(pw)) {
			return sqlSessionTemplate.delete(namespace + ".deleteArticle", bid);
		}else {
			return 0;
		}
	}

	public List<BoardBean> getBoardsByCategory(int cateId) {
		return sqlSessionTemplate.selectList(namespace + ".getBoardsByCategory", cateId);
	}

	public List<BoardBean> getBoardsByCategory(int cateId, BoardPaging pageInfo) {
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		return sqlSessionTemplate.selectList(namespace + ".getBoardsByCategory", cateId, rowBounds);
	}

	public int getCategoryArticleCount(int cateId) {
		return sqlSessionTemplate.selectOne(namespace + ".getCategoryArticleCount", cateId);
	}

	public int getBoardUserId(int bid) {
		return sqlSessionTemplate.selectOne(namespace + ".getBoardUserId", bid);
	}



}