package hanibal.ibs.interceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author Keesun Baik
 */
public class CORSInterceptor extends HandlerInterceptorAdapter {

private static final String AC_ALLOW_ORIGIN = "Access-Control-Allow-Origin";
	private static final String AC_ALLOW_METHODS = "Access-Control-Allow-Methods";
	private static final String AC_ALLOW_HEADERS = "Access-Control-Allow-Headers";

	private CorsData corsData;

	private String origin;
	private String allowMethods;
	private String allowHeaders;

	public void setOrigin(String origin) {
		this.origin = origin;
	}

	public void setAllowMethods(String allowMethods) {
		this.allowMethods = allowMethods;
	}

	public void setAllowHeaders(String allowHeaders) {
		this.allowHeaders = allowHeaders;
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		this.corsData = new CorsData(request);

		if(this.corsData.isPreflighted()) {
			response.setHeader(AC_ALLOW_ORIGIN, origin);
			response.setHeader(AC_ALLOW_METHODS, allowMethods);
			response.setHeader(AC_ALLOW_HEADERS, allowHeaders);

			return false;
		}

		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		if(this.corsData.isSimple()) {
			response.setHeader(AC_ALLOW_ORIGIN, origin);
		}
	}

	 
}
