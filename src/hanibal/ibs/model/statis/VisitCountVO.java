package hanibal.ibs.model.statis;

public class VisitCountVO {
    private int visit_id;
    private String visit_ip;
    private int visit_time;
    private String visit_refer;
    private String visit_agent;
    
	public int getVisit_id() {
		return visit_id;
	}
	public void setVisit_id(int visit_id) {
		this.visit_id = visit_id;
	}
	public String getVisit_ip() {
		return visit_ip;
	}
	public void setVisit_ip(String ip) {
		this.visit_ip = ip;
	}
	public int getVisit_time() {
		return visit_time;
	}
	public void setVisit_time(int visit_time) {
		this.visit_time = visit_time;
	}
	public String getVisit_refer() {
		return visit_refer;
	}
	public void setVisit_refer(String string) {
		this.visit_refer = string;
	}
	public String getVisit_agent() {
		return visit_agent;
	}
	public void setVisit_agent(String string) {
		this.visit_agent = string;
	}
    
    
}
