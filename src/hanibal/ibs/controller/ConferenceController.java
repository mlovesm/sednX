package hanibal.ibs.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import hanibal.ibs.dao.ConferenceDAO;

@Controller
public class ConferenceController {
	Logger log = Logger.getLogger(this.getClass());
	ConferenceDAO conferenceDAO;
	public Logger getLog() {
		return log;
	}
	public void setLog(Logger log) {
		this.log = log;
	}
	
	
	public ConferenceDAO getConferenceDAO() {
		return conferenceDAO;
	}
	public void setConferenceDAO(ConferenceDAO conferenceDAO) {
		this.conferenceDAO = conferenceDAO;
	}
	@RequestMapping("/conference")
	public String confMain() {
		return "/conference/main.ibs";
	}
}
