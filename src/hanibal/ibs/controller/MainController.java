package hanibal.ibs.controller;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.context.MessageSource;
import org.springframework.context.MessageSourceAware;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MainController implements MessageSourceAware {
	Logger log=Logger.getLogger(this.getClass());
	MessageSource messageSource;
	String returnView;
	
	
	public void setLog(Logger log) {
		this.log = log;
	}
	public void setMessageSource(MessageSource messageSource) { 
		this.messageSource = messageSource;
	}
	public void setReturnView(String returnView) {
		this.returnView = returnView;
	}
	
	
    @RequestMapping("/svc/login")
	public String mainIndex() {
		returnView="/ibsUserViews/main.ibs";
		return returnView;
	}
	
	@RequestMapping("/sednmanager")
	public String oneDept() {
		//returnView="/ibsCmsViews/WEB_Dashboard.cms";
		return "redirect:"+"/sedn/web/media";
	}
	@RequestMapping("/error/{section}")
	public String error(@PathVariable String section,Model model,HttpServletRequest req) {
		String messageIndex="error."+section;
		Object [] args=new String[] {section};
		model.addAttribute("errorTitle","ERROR "+section);
		model.addAttribute("description",messageSource.getMessage(messageIndex,args, Locale.getDefault()));
		returnView="/ibsError/main.inc";
		return returnView;
	}
	@RequestMapping("/inc/{section}")
	public String incMsg(@PathVariable String section,@RequestParam(required=false) String permission,Model model) {
		if(section.equals("incMsg")) returnView="/ibsInclude/messages.inc";
		if(section.equals("incNoti")) returnView="/ibsInclude/notifications.inc";
		if(section.equals("incPermission")) {
			model.addAttribute("permission",permission);
			returnView="/ibsInclude/permitssion.inc";
		}
		return returnView;
	}
	
	
	
}
