package community.model;

public class Comment_RecommendBean {
	private int id;
	private int comment_id;
	private int user_id;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getComment_id() {
		return comment_id;
	}
	public void setComment_id(int comment_id) {
		this.comment_id = comment_id;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public Comment_RecommendBean(int comment_id, int user_id) {
		super();
		this.comment_id = comment_id;
		this.user_id = user_id;
	}
	public Comment_RecommendBean() {
		super();
	}

	
}
