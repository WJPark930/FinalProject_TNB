package community.model;

import java.util.Date;

public class CommentBean {
	private int id;
	private int board_id;
	private int user_id;
	private String user_email;
	private String content;
	private Date created_at;
	private Date updated_at;

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getBoard_id() {
		return board_id;
	}
	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getCreated_at() {
		return created_at;
	}
	public void setCreated_at(Date created_at) {
		this.created_at = created_at;
	}
	public Date getUpdated_at() {
		return updated_at;
	}
	public void setUpdated_at(Date updated_at) {
		this.updated_at = updated_at;
	}
	
	public CommentBean(int id, int board_id, int user_id, String user_email, String content, Date created_at,
			Date updated_at) {
		super();
		this.id = id;
		this.board_id = board_id;
		this.user_id = user_id;
		this.user_email = user_email;
		this.content = content;
		this.created_at = created_at;
		this.updated_at = updated_at;
	}
	public CommentBean() {
		super();
	}
	

}
