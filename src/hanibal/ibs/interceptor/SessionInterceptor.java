package hanibal.ibs.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class SessionInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		Object member_authority=request.getSession().getAttribute("member_authority");
		String  contextPath=request.getContextPath();
		if(request.getRequestURI().equals(contextPath+"/cms/login")
				||request.getRequestURI().equals(contextPath+"/cms/join")
				||request.getRequestURI().equals(contextPath+"/cms/forgetpass")
				||request.getRequestURI().equals(contextPath+"/cms/loginProcess")
				||request.getRequestURI().equals(contextPath+"/cms/memberJoin")
				||request.getRequestURI().equals(contextPath+"/cms/lostpass")
				||request.getRequestURI().equals(contextPath+"/")
				||request.getRequestURI().indexOf("/sedn/download/")>-1
				||request.getRequestURI().indexOf("/api/")>-1
				||request.getRequestURI().indexOf("/error/")>-1
				||request.getRequestURI().indexOf("/SEQ/")>-1
				||request.getRequestURI().indexOf("/svc/")>-1
				||request.getRequestURI().indexOf("/user/")>-1
			){
			if(member_authority !=null&&Integer.parseInt((String) member_authority)<0){
				return true;
			}else{
				return true;
			}
		}
		if(member_authority==null){
			response.sendRedirect(contextPath+"/cms/login");
			return false;
		}else{
			return true;
		}
	}
	
}
