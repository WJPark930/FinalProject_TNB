package community.model;

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
        RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
        return sqlSessionTemplate.selectList(namespace + ".getBoardList", map, rowBounds);
    }

    public int getArticleCount(Map<String, String> map) {
        return sqlSessionTemplate.selectOne(namespace + ".getArticleCount", map);
    }

    public BoardBean getArticle(int num) {
        sqlSessionTemplate.update(namespace + ".updateReadCount", num);
        return sqlSessionTemplate.selectOne(namespace + ".getArticle", num);
    }

    public int insertArticle(BoardBean board) {
        return sqlSessionTemplate.insert(namespace + ".insertArticle", board);
    }

    public int updateBoard(int bid, String passwd, BoardBean board) {
        String pw = sqlSessionTemplate.selectOne(namespace + ".getPasswd", bid);
        if (passwd.equals(pw)) {
            return sqlSessionTemplate.update(namespace + ".updateBoard", board);
        } else {
            return 0;
        }
    }

    public int deleteArticle(int bid, String passwd) {
        String pw = sqlSessionTemplate.selectOne(namespace + ".getPasswd", bid);
        if (passwd.equals(pw)) {
            return sqlSessionTemplate.delete(namespace + ".deleteArticle", bid);
        } else {
            return 0;
        }
    }

    public int getCategoryArticleCount(Map<String, Object> map) {
        return sqlSessionTemplate.selectOne(namespace + ".getCategoryArticleCount", map);
    }

    public List<BoardBean> getBoardsByCategory(Map<String, Object> map, BoardPaging pageInfo) {
        RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
        return sqlSessionTemplate.selectList(namespace + ".getBoardsByCategoryWithMap", map, rowBounds);
    }

    public int getBoardUserId(int bid) {
        return sqlSessionTemplate.selectOne(namespace + ".getBoardUserId", bid);
    }

    public List<BoardBean> getTopReadCountBoards() {
        return sqlSessionTemplate.selectList(namespace + ".getTopReadCountBoards");
    }
}
