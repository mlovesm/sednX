package hanibal.ibs.interceptor;

import javax.servlet.http.HttpServletRequest;

class CorsData {
	private static final String ORIGIN = "Origin";
	private static final String AC_REQUEST_METHOD = "Access-Control-Request-Method";
	private static final String AC_REQUEST_HEADERS = "Access-Control-Request-Headers";
	private String origin;
	private String requestMethods;
	private String requestHeaders;

	CorsData(HttpServletRequest request) {
		this.origin = request.getHeader(ORIGIN);
		this.requestMethods= request.getHeader(AC_REQUEST_METHOD);
		this.requestHeaders = request.getHeader(AC_REQUEST_HEADERS);
	}

	public boolean hasOrigin(){
		return origin != null && !origin.isEmpty();
	}

	public boolean hasRequestMethods(){
		return requestMethods != null && !requestMethods.isEmpty();
	}

	public boolean hasRequestHeaders(){
		return requestHeaders != null && !requestHeaders.isEmpty();
	}

	public String getOrigin() {
		return origin;
	}

	public String getRequestMethods() {
		return requestMethods;
	}

	public String getRequestHeaders() {
		return requestHeaders;
	}

	public boolean isPreflighted() {
		return hasOrigin() && hasRequestHeaders() && hasRequestMethods();
	}

	public boolean isSimple() {
		return hasOrigin() && !hasRequestHeaders();
	}
}
