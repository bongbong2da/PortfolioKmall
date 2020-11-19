package com.kmall.interceptor;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileWriter;
import java.lang.reflect.Method;
import java.util.Date;

public class CommonInterceptor extends HandlerInterceptorAdapter {

	private static final Logger log = LoggerFactory.getLogger(CommonInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
			//log.info(request.getRemoteAddr() + "으로부터 요청됨.");
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		if(request.getRemoteAddr().equals(request.getLocalAddr())) return;

		File file = new File("D:/dev/log/connectionLog.txt");
		file.canWrite();
		FileWriter writer = new FileWriter(file, true);

		Date date = new Date();
		String log = " Time : " + date + " | IP : " + request.getRemoteAddr() + " | Port : " + request.getRemotePort() + " | URI : " + request.getRequestURI() + "\n";
		System.out.println(log);
		writer.write(log);
		writer.flush();
		writer.close();
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		
	}

}
