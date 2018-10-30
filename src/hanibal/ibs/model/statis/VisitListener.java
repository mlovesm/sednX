package hanibal.ibs.model.statis;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import hanibal.ibs.dao.VisitCountDAO;

public class VisitListener implements HttpSessionListener {
	
    @Override
    public void sessionCreated(HttpSessionEvent sessionEvent){
        HttpSession session = sessionEvent.getSession();
        System.out.println("session= "+ session);
//        WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(session.getServletContext());
   
        //등록되어있는 빈을 사용할수 있도록 설정해준다
//        ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext()); 

        HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
        //request를 파라미터에 넣지 않고도 사용할수 있도록 설정
//        VisitCountDAO visitCountDAO = (VisitCountDAO) wac.getBean("visitCountDAO");
        VisitCountDAO visitCountDAO = new VisitCountDAO();
        VisitCountVO vo = new VisitCountVO();
        
        String ip = req.getHeader("X-FORWARDED-FOR");
        if (ip == null) ip = req.getRemoteAddr();
        vo.setVisit_ip(ip);
        vo.setVisit_agent(req.getHeader("User-Agent"));//브라우저 정보
        vo.setVisit_refer(req.getHeader("referer"));//접속 전 사이트 정보
        
        try {
			visitCountDAO.insertVisitor(vo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
    }
    @Override
    public void sessionDestroyed(HttpSessionEvent arg0){
        //TODO Auto-generated method stub
    }	

}
