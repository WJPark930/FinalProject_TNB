package community.model;

public class Nested_Comment_RecommendBean {
	private int id;
	private int user_id;
	private int nested_comment_id;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public int getNested_comment_id() {
		return nested_comment_id;
	}
	public void setNested_comment_id(int nested_comment_id) {
		this.nested_comment_id = nested_comment_id;
	}
	public Nested_Comment_RecommendBean(int user_id, int nested_comment_id) {
		super();
		this.user_id = user_id;
		this.nested_comment_id = nested_comment_id;
	}
	public Nested_Comment_RecommendBean() {
		super();
	}
	
	
}
