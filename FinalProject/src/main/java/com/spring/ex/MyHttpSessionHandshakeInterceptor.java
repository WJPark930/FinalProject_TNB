package com.spring.ex;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

public class MyHttpSessionHandshakeInterceptor extends HttpSessionHandshakeInterceptor {
    
    @Autowired
    private HttpSession httpSession;
    
    @Override
    public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response,
            WebSocketHandler wsHandler, Map<String, Object> attributes) throws Exception {
        
        if (request instanceof ServletServerHttpRequest) {
            ServletServerHttpRequest servletRequest = (ServletServerHttpRequest) request;
            attributes.put("loginInfo", httpSession.getAttribute("loginInfo"));
        }
        return super.beforeHandshake(request, response, wsHandler, attributes);
    }
}
