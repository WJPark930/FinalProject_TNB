package community.model;

public class Board_RecommendBean {
	private int id;
	private int user_id;
	private int bid;
	
	public int getBid() {
		return bid;
	}
	public void setBid(int bid) {
		this.bid = bid;
	}
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
	public Board_RecommendBean(int user_id, int bid) {
		super();
		this.user_id = user_id;
		this.bid = bid;
	}
	public Board_RecommendBean() {
		super();
	}

	
}
