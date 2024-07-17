<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<%!
		public class Member {
			int user_id;
			String user_email;
			String user_name;
			
			Member(int user_id,String user_email,String user_name){
				this.user_id = user_id;
				this.user_email = user_email;
				this.user_name = user_name;
			}
			public int getUser_id(){
				return user_id;
			}			
			public String getUser_email(){
				return user_email;
			}
			public String getUser_name(){
				return user_name;
			}
		}
	%>
	<%
		Member member = new Member(1,"user@naver.com","admin");
		//System.out.println(member.user_email);
		session.setAttribute("loginInfo", member);
		response.sendRedirect(request.getContextPath()+"/main.jsp");
	%>