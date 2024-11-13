<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>

<!-- (2) LoginWithNaverId Javscript 설정 정보 및 초기화 -->
<script>
	
		
var naver_id_login = new naver_id_login("ZoWJrfxYsQvtvjcgrY_L", "http://localhost:9090/callback/naverAuthCallback");
naver_id_login.get_naver_userprofile("naverSignInCallback()");
		
function naverSignInCallback() {
alert(naver_id_login.getProfileData('id'));
		    
top.window.open('about:blank','_self').close();
}
		
</script>