package shop.model;

public class GuideBean {
	private int guide_id;
	private int shop_id;
	private String guide_title;
	private String guide_content;
	
	
	public int getGuide_id() {
		return guide_id;
	}
	public void setGuide_id(int guide_id) {
		this.guide_id = guide_id;
	}
	public int getShop_id() {
		return shop_id;
	}
	public void setShop_id(int shop_id) {
		this.shop_id = shop_id;
	}
	public String getGuide_title() {
		return guide_title;
	}
	public void setGuide_title(String guide_title) {
		this.guide_title = guide_title;
	}
	public String getGuide_content() {
		return guide_content;
	}
	public void setGuide_content(String guide_content) {
		this.guide_content = guide_content;
	}
	
}
