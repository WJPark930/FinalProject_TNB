package community.model;

public class Comu_CategoryBean {
	private int id;
	private String comu_cate;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getComu_cate() {
		return comu_cate;
	}
	public void setComu_cate(String comu_cate) {
		this.comu_cate = comu_cate;
	}
	public Comu_CategoryBean(int id, String comu_cate) {
		super();
		this.id = id;
		this.comu_cate = comu_cate;
	}
	public Comu_CategoryBean() {
		super();
	}
	
}
