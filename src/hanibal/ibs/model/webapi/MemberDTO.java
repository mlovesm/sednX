package hanibal.ibs.model.webapi;

public class MemberDTO {
	private String auth_id;
	private String auth_pass;
	
	public String getAuth_id() {
		return auth_id;
	}
	public void setAuth_id(String auth_id) {
		this.auth_id = auth_id;
	}
	public String getAuth_pass() {
		return auth_pass;
	}
	public void setAuth_pass(String auth_pass) {
		this.auth_pass = auth_pass;
	}
}