<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.icignal.common.util.BeansUtil" %>

<%
    response.setHeader("Cache-Control", "100000");
    response.setHeader("Pragma", "cache");
    response.setDateHeader("Expires", 0);
%>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common/login.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/t10/common/login.css">

<script src='${pageContext.request.contextPath}/resources/js/lib/placeholders.min.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/jquery.json-2.3.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/jquery.json-2.3.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/cryptoJS/aes.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/cryptoJS/pbkdf2.js' type="text/javascript"></script>

<script src='${pageContext.request.contextPath}/resources/js/jquery.blockUI.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/1.4/ifvValidation/js/ifvValidation.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/1.4/ifvsfPopup/js/ifvsfPopup.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/1.4/ifvDefault/js/ifvDefault.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/1.4/syncfusion/scripts/ej.widget.dialog.min.js' type="text/javascript"></script>


<!--[if lt IE 9]>
<style>
#login #main{
background: #000;
border-top:1px solid #fff;
border-bottom:1px solid #fff;
filter: alpha(opacity=40);
}
</style>
<![endif]-->

<script>


    //중복로그인 시 기존 세션 종료 여부 (true:기존세션종료)
    var preSessionAbortYn = false;
    var tokenId = '';
    var globalUrl; // SMS 인증팝업에서 사용하는 URL
    //loginType = email,sms
    var loginType = "<%= BeansUtil.getApplicationProperty("icignal.login.double.auth-mehtod")%>";
    //loginMethod = single: pwd 검증만, double : pwd and 본인인증
    var loginMethod = "<%=BeansUtil.getApplicationProperty("icignal.login.auth-type")%>";

    var langType = "<%=BeansUtil.getApplicationProperty("icignal.context.server.lang")%>"
    var countryType = "<%=BeansUtil.getApplicationProperty("icignal.context.server.country")%>"
    var selectLangYn = "<%=BeansUtil.getApplicationProperty("icignal.login.view.selectLang")%>"

    function selLangType(obj) {
        langType = obj.attr("data-val");
        if (langType == "en") {
            $("#defaultLangBtn").addClass("active");
        }
    }

    function selCountryType(obj) {
        countryType = obj.attr("data-val");
    }

    function getEncryptedPassword() {
        var today = $.ifvGetTodayDate().replace("-", "").replace("-", "");
        var iv = today + window.appServiceId;
        var salt = today + window.appServiceId;
        var plainText = $("#password").val();
        var keySize = 128;
        var iterationCount = 1000;
        var passPhrase = (today + window.appServiceId).substring(0, 16);


        var key128Bits100Iterations =
            CryptoJS.PBKDF2(passPhrase, CryptoJS.enc.Hex.parse(salt),
                {keySize: keySize / 32, iterations: iterationCount});

        var encrypted = CryptoJS.AES.encrypt(
            plainText,
            key128Bits100Iterations,
            {iv: CryptoJS.enc.Hex.parse(iv)});

        return encrypted.toString();
    };

    /* 이메일 인증  */
    function emailAuthCheckFn() {
        $("#emailAuthCheckBtn").attr("disabled", true);		//emailAuthCheck(기존)

        //sendMailSmtp2 사용시 id,pw 지정 필요
        $.ifvSyncPostJSON('<ifvm:action name="sendMailSmtp2"/>', {
            email: $("#id").val()
        }, function (result) {
            alert("해당 이메일로 메일 발송 하였습니다. 인증 후 로그인 해주세요.");
            tokenId = result.message;
        }, function (result) {
            alert(result.message);
            $("#emailAuthCheckBtn").attr("disabled", false);
        });
    }

    //BAT KOREA 이중인증으로인하여 ready절에있던 submitHandler를 function으로 만들었습니다
    //기존로직으로변경시 이함수를 주석처리한후 ready절에있는 부분을 주석해제해주세요
    function realLoginFn() {
        $.ifvPostHeaderJSON('<ifvm:action name="MKTLogin"/>', {}, {
                email: $("#id").val(),
                password: getEncryptedPassword(),
                preSessionAbortYn: preSessionAbortYn,
                tokenId: tokenId,
                loginMethod: loginMethod,
                sendchnl: loginType,
                lang: langType
                //password : $.ifvmEncryptAES($("#password").val())
            },
            function (result) {	//sucess
                loginConfirmSuccess(result);
            },
            function (result) {	//error
                loginConfirmError(result);
            });
    }

    //로그인 성공
    function loginConfirmSuccess(result) {

        var obj = JSON.parse(result.message);
        var pwChangeExp = obj.pwChangeExp;
        var pwChangeFirst = obj.pwChangeFirst;
        var duplicatedLogin = obj.duplicatedLogin;
        var authSmsYn = obj.authSmsYn;
        var url = obj.url;
        globalUrl = url;

        if (authSmsYn == "true" && loginType == "sms") {
            //SMS 인증 [BAT 전용]
            $.ifvLoadPop({
                url: '<ifvm:url name="smsCertiPopup"/>', params: {}, close: function () {
                }
            });
        }

        //패스워드 만료
        else if (pwChangeExp == "true") {
            location.href = '${pageContext.request.contextPath}/' + url + '?pwChangeExp=true';
        }
        //최초 로그인
        else if (pwChangeFirst == "true") {
            if (confirm('<spring:message code="M02794"/>')) {
                $.ifvLoadPop({
                    url: '<ifvm:url name="modifyFirstLoginPwdPop"/>', params: {}, close: function () {
                    }
                });
            } else {
                $.ifvmMarketingLogOut();
            }
        }
        //중복 로그인
        else if (duplicatedLogin == "true") {

            var ip;
            var ipDate;
            $.ifvSyncPostJSON('/login/getCrmUserIp.do', {
                userId: $("#id").val()
            }, function (result) {
                ip = result.ip;
                ipDate = result.ipDate;
            });

            if (confirm('현재 접속 중인 아이디 입니다.\n(기존접속 IP:' + ip + ')\n(로그인 시간:' + ipDate + ')\n기존 접속을 끊고 접속하시겠습니까?')) {
                setTimeout(function () {
                    //기존 세션 종료
                    preSessionAbortYn = true;
                    $("#login-form").submit();

                    //기존 세션 종료 여부 초기화
                    preSessionAbortYn = false;

                }, 1000)
            }
        } else {
            //SMS 인증 [BAT 전용]
            //$.ifvLoadPop({url :'<ifvm:url name="smsCertiPopup"/>', params : {}, close: function(){}});

            //기존방식
            location.href = '${pageContext.request.contextPath}/' + url;
        }
    }

    //로그인 오류
    function loginConfirmError(result) {
        if (result.message == null) {
            alert('<spring:message code="V00175"/>');
        } else if (result.message == 'idPwd') {
            alert('<spring:message code="M00298"/>');
        } else if (result.message == 'overUserPwCnt') {
            alert('<spring:message code="V00172"/>'); //사용자 비밀번호 입력에 5번 이상 실패하여 30분간 로그인 시도가 제한됩니다.
        } else if (result.message == 'overdueUserPw') {
            alert('<spring:message code="V00173"/>');
        } else if (result.message == 'notIpAuth') {
            alert('<spring:message code="V00174"/>');
        } else if (result.message.indexOf("remainingTime") > -1) {
            var remainingTime = result.message.split('/')[1];
            if (remainingTime == null || remainingTime === 'null') {
                alert('<spring:message code="C00157"/>');
            } else {
                alert('<spring:message code="C00155" arguments="'+remainingTime+'"/>');
            }
        } else if (result.message == 'overEmailAuth') {
            alert("이메일 인증 시간이 초과 하였습니다. 다시 인증해주세요.");
            $("#emailAuthCheckBtn").attr("disabled", false);
        } else if (result.message == 'notEmailAuth') {
            alert("이메일 인증후 로그인 해주세요.");
        } else if (result.message == 'notEmailAuthId') {
            alert("로그인 하려는 email과 인증 email이 다릅니다.");
        } else if (result.message == null || result.message != '') {
            alert(result.message);
        } else if (result.message == 'lastLoginDateOver') {
            alert('<spring:message code="C00175"/>');
        } else if (result.message == 'userStatInactive') {
            alert('<spring:message code="C00176"/>');
        } else if (result.message == 'acesStartDateOver') {
            alert('<spring:message code="C00185"/>');
        } else if (result.message == 'acesEndDateOver') {
            alert('<spring:message code="C00186"/>');
        } else {
            alert('<spring:message code="V00175"/>');
        }
    }

    function naverLoginPop() {
        $.ifvSyncPostJSON('<ifvm:action name="naverLogin"/>', {},
            function (result) {
                //window.open(result.naverAuthUrl,"","width=600,height=600,left=600");
                location.href = result.naverAuthUrl;
            });
    }

    function facebookLoginPop() {
        $.ifvSyncPostJSON('<ifvm:action name="facebookLogin"/>', {},
            function (result) {
                location.href = result.facebookAuthUrl;
                //window.open(result.facebookAuthUrl,"","width=600,height=600,left=600");
            }, function (result) {
                alert("서비스 준비중입니다.");
            });
    }

    function kakaoLoginPop() {
        $.ifvSyncPostJSON('<ifvm:action name="kakaoLogin"/>', {},
            function (result) {
                //window.open(result.gogleAuthUrl,"","width=600,height=600,left=600");
                location.href = result.kakaoAuthUrl;
            });
    }

    function gogleLoginPop() {
        $.ifvSyncPostJSON('<ifvm:action name="googleLogin"/>', {},
            function (result) {
                //window.open(result.gogleAuthUrl,"","width=600,height=600,left=600");
                location.href = result.gogleAuthUrl;
            }, function (result) {
                alert("서비스 준비중입니다.");
            });
    }

    /* 비밀번호 초기화 가능 여부 확인 */
    function checkOperationPolicyFn() {

        $.ifvSyncPostJSON('<ifvm:action name="checkOperationPolicyInitPw"/>', {
            plcyCd: 'A33'
        }, function (result) {
            $("#passwordInitBtn").css("display", "inline-block");
        }, function (result) {
            $("#passwordInitBtn").css("display", "none");
        });
    }

    $(document).ready(function () {

        checkOperationPolicyFn();
        /* //$("#emailAuthCheckBtn").addClass("hidden");
        $("#naverLgoinPopBtn").click(function(){
            naverLoginPop();
         });
         $("#kakaoLgoinPopBtn").click(function(){
            kakaoLoginPop();
         });
         $("#facebookLoginPop").click(function(){
            facebookLoginPop();
         });
         $("#gogleLoginPop").click(function(){
            gogleLoginPop();
         });  */

        if (selectLangYn == "Y") {
            $("#langWrap").show(); //다국어 설정
        } else {
            $("#langWrap").hide(); //다국어 설정
        }

        //default Lang 지정
        if (lang == "ko") {
            $("#defaultLangBtn").addClass("active");
        }

        /* 이중인증로그인 본인인증 발송채널이 email일 경우 */
        if (loginMethod == "double" && loginType == "email") {
            /* email일 경우 이메일 인증 버튼 show */
            $("#emailAuthCheckBtn").show();

        } else {
            /* email일 경우 이메일 인증 버튼 hide */
            $("#emailAuthCheckBtn").hide();

        }


        if ($("#login").length == 0) {
            $.ifvErrorPop(ifv.errorMessage.e_200410);
            sessionEndFunc();
        }


        $("#login-form").validate({
            rules: {
                id: {
                    required: true,
                    minlength: 1
                },
                password: {
                    required: true,
                    minlength: 3,
                    maxlength: 20
                }
            },

            // Messages for form validation
            messages: {
                id: {
                    required: 'Please enter your id'
                },
                password: {
                    required: 'Please enter your password'
                }
            },

            // Do not change code below
            errorPlacement: function (error, element) {
                error.insertAfter(element.parent());
            },
            //BAT KOREA 이메일,패스워드 여부판단
            submitHandler: function () {

                /* 로그인 인증 방식 double : pwd and 본인인증 이고 본인인증 발송채널이 sms인 경우 */
                if (loginMethod == "double") {
                    realLoginFn();

                } else if (loginMethod == "single") {
                    $.ifvPostHeaderJSON('<ifvm:action name="MKTLogin"/>', {}, {
                            email: $("#id").val(),
                            password: getEncryptedPassword(),
                            preSessionAbortYn: preSessionAbortYn,
                            tokenId: tokenId,
                            loginMethod: loginMethod,
                            sendchnl: loginType,
                            lang: langType
                            //password : $.ifvmEncryptAES($("#password").val())
                        },
                        function (result) {	//sucess
                            var obj = JSON.parse(result.message);
                            var pwChangeExp = obj.pwChangeExp;
                            var pwChangeFirst = obj.pwChangeFirst;
                            var duplicatedLogin = obj.duplicatedLogin;
                            var url = obj.url;
                            var authSmsYn = obj.authSmsYn;
                            globalUrl = url;

                            //패스워드 만료
                            if (pwChangeExp == "true") {
                                location.href = '${pageContext.request.contextPath}/' + url + '?pwChangeExp=true';
                            }
                            //최초 로그인
                            else if (pwChangeFirst == "true") {
                                if (confirm('<spring:message code="M02794"/>')) {
                                    $.ifvLoadPop({
                                        url: '<ifvm:url name="modifyFirstLoginPwdPop"/>', params: {}, close: function () {
                                        }
                                    });
                                } else {
                                    $.ifvmMarketingLogOut();
                                }
                            }
                            //중복 로그인
                            else if (duplicatedLogin == "true") {
                                var ip;
                                var ipDate;
                                $.ifvSyncPostJSON('/login/getCrmUserIp.do', {
                                    userId: $("#id").val()
                                }, function (result) {
                                    ip = result.ip;
                                    ipDate = result.ipDate;

                                });
                                if (confirm('현재 접속 중인 아이디 입니다.\n(기존접속 IP:' + ip + ')\n(로그인 시간:' + ipDate + ')\n기존 접속을 끊고 접속하시겠습니까?')) {
                                    //기존 세션 종료
                                    preSessionAbortYn = true;
                                    $("#login-form").submit();

                                    //기존 세션 종료 여부 초기화
                                    preSessionAbortYn = false;
                                }
                            } else {
                                //SMS 인증 [BAT 전용]
                                //$.ifvLoadPop({url :'<ifvm:url name="smsCertiPopup"/>', params : {}, close: function(){}});
                                //기존방식
                                location.href = '${pageContext.request.contextPath}/' + url;
                            }

                        },
                        function (result) {	//error
                            if (result.message == null) {
                                alert('<spring:message code="V00175"/>');
                            } else if (result.message == 'idPwd') {
                                alert('<spring:message code="M00298"/>');
                            } else if (result.message == 'overUserPwCnt') {
                                alert('<spring:message code="V00172"/>'); //사용자 비밀번호 입력에 5번 이상 실패하여 30분간 로그인 시도가 제한됩니다.
                            } else if (result.message == 'overdueUserPw') {
                                alert('<spring:message code="V00173"/>');
                            } else if (result.message.indexOf('.') != -1) {
                                var empName = result.message.split(",")[0];
                                var host = result.message.split(",")[1];

                                alert(empName + ', ' + host + ', <spring:message code="V00174"/>');
                            } else if (result.message.indexOf("remainingTime") > -1) {
                                var remainingTime = result.message.split('/')[1];
                                if (remainingTime == null || remainingTime === 'null') {
                                    alert('<spring:message code="C00157"/>');
                                } else {
                                    alert('<spring:message code="C00155" arguments="'+remainingTime+'"/>');
                                }
                            } else if (result.message == 'overEmailAuth') {
                                alert("이메일 인증 시간이 초과 하였습니다. 다시 인증해주세요.");
                                $("#emailAuthCheckBtn").attr("disabled", false);
                            } else if (result.message == 'notEmailAuth') {
                                alert("이메일 인증후 로그인 해주세요.");
                            } else if (result.message == 'notEmailAuthId') {
                                alert("로그인 하려는 email과 인증 email이 다릅니다.");
                            } else if (result.message == 'lastLoginDateOver') {
                                alert('<spring:message code="C00175"/>');
                            } else if (result.message == 'userStatInactive') {
                                alert('<spring:message code="C00176"/>');
                            } else if (result.message == 'acesStartDateOver') {
                                alert('<spring:message code="C00185"/>');
                            } else if (result.message == 'acesEndDateOver') {
                                alert('<spring:message code="C00186"/>');
                            } else if (result.message == 'checkAuth') {
                                alert('<spring:message code="V00302"/>');
                            } else {
                                alert('<spring:message code="V00175"/>');
                            }
                        }
                    );
                }
            }
        });
        //BAT KOREA 이중인증으로인한 주석처리
        /*
            submitHandler: function (frm) {
              $.ifvPostHeaderJSON('

        <ifvm:action name="MKTLogin"/>', {}, {
				email : $("#id").val(),
				password : getEncryptedPassword(),
				preSessionAbortYn : preSessionAbortYn,
				tokenId : tokenId
	        	//password : $.ifvmEncryptAES($("#password").val())
			},
			function(result) {	//sucess
				var obj = JSON.parse(result.message);
				var pwChangeExp = obj.pwChangeExp;
				var pwChangeFirst = obj.pwChangeFirst;
				var duplicatedLogin = obj.duplicatedLogin;
				var url = obj.url;
				globalUrl = url;
				//패스워드 만료
				if(pwChangeExp == "true"){
		    		location.href = '

        ${pageContext.request.contextPath}/'+url+'?pwChangeExp=true';
				}
				//최초 로그인
				else if(pwChangeFirst == "true") {
					if(confirm('

        <spring:message code="M02794"/>')) {
						$.ifvLoadPop({url :'

        <ifvm:url name="modifyFirstLoginPwdPop"/>', params : {}, close: function(){}});
					} else {
						$.ifvmMarketingLogOut();
					}
		    	}
				//중복 로그인
				else if(duplicatedLogin == "true") {
					if(confirm('

        <spring:message code="C00154"/>')) {
						//기존 세션 종료
						preSessionAbortYn = true;
						$("#login-form").submit();

						//기존 세션 종료 여부 초기화
						preSessionAbortYn = false;
					}
		    	}
		    	else {
		    		//SMS 인증 [BAT 전용]
		    		//$.ifvLoadPop({url :'

        <ifvm:url name="smsCertiPopup"/>', params : {}, close: function(){}});
		    		
		    		//기존방식
		    		location.href = '

        ${pageContext.request.contextPath}/'+url;
		    	}

			},
			function(result){	//error
				if(result.message == 'idPwd'){
					alert('

        <spring:message code="M00298"/>');
				}else if(result.message == 'overUserPwCnt'){
					alert('

        <spring:message code="V00172"/>'); //사용자 비밀번호 입력에 5번 이상 실패하여 30분간 로그인 시도가 제한됩니다.
				}else if(result.message == 'overdueUserPw'){
					alert('

        <spring:message code="V00173"/>');
				}else if(result.message.indexOf('.') != -1){
					var empName = result.message.split(",")[0];
					var host = result.message.split(",")[1];

					alert(empName+', '+host+',

        <spring:message code="V00174"/>');
				}else if(result.message.indexOf("remainingTime") > -1){
					var remainingTime = result.message.split('/')[1];
					if(remainingTime == null || remainingTime === 'null') {
						alert('

        <spring:message code="C00157"/>');
					} else {
						alert('

        <spring:message code="C00155" arguments="'+remainingTime+'"/>');
					}
				}else if(result.message == 'overEmailAuth'){
					alert("이메일 인증 시간이 초과 하였습니다. 다시 인증해주세요.");
					$("#emailAuthCheckBtn").attr("disabled",false);
				}else if(result.message == 'notEmailAuth'){
					alert("이메일 인증후 로그인 해주세요.");
				}else if(result.message == 'notEmailAuthId'){
					alert("로그인 하려는 email과 인증 email이 다릅니다.");
				}else{
					alert('

        <spring:message code="V00175"/>');
				}
			}
			);
		}
		}); */


        /* 언어 설정을 테스트를 위해 임시 등록 */
        var paramObj = function () {
            var query_string = {};
            var query = window.location.search.substring(1);
            var vars = query.split("&");
            for (var i = 0; i < vars.length; i++) {
                var pair = vars[i].split("=");
                if (typeof query_string[pair[0]] === "undefined") {
                    query_string[pair[0]] = pair[1];
                } else if (typeof query_string[pair[0]] === "string") {
                    var arr = [query_string[pair[0]], pair[1]];
                    query_string[pair[0]] = arr;
                } else {
                    query_string[pair[0]].push(pair[1]);
                }
            }
            return query_string;
        }();

        $("#langWrap a").on("click", function () {

            var $this = $(this);
            var varName = $this.data("name");
            window[varName] = $this.data("val");

            $this.siblings().removeClass("active");
            $this.addClass("active");
        });

        (function () {

            var oSelectCountry;
            var oSelectLang;
            if (paramObj.country != null) {
                $("#langWrap").show();
                oSelectCountry = $("#langWrap a[data-val=" + paramObj.country + "]");
                oSelectCountry.trigger("click");
            }
            if (paramObj.lang != null) {
                $("#langWrap").show();
                oSelectLang = $("#langWrap a[data-val=" + paramObj.lang + "]");
                oSelectLang.trigger("click");
            }
        })();


        //비밀번호 초기화 요청
        $('#passwordInitBtn').on('click', function () {
            $.ifvLoadPop({
                url: '<ifvm:url name="passwordInitRequestPop"/>', params: {}, close: function () {
                }
            });
        });
    });
</script>
<style type="text/css">
    #langWrap {
        display: none;
        position: absolute;
        top: 20px;
        right: 50px
    }

    #langWrap span {
        display: inline-block;
        width: 60px;
        vertical-align: text-bottom;
    }

    #langWrap .btn {
        width: 50px;
        padding-left: 0;
        padding-right: 0;
        color: #fffefe;
        background-color: gray;
        border: 0 none;
        -webkit-border-radius: 4px;
        border-radius: 4px
    }

    #langWrap .btn.active {
        background-color: skyblue;
    }

    #passwordInitBtn {
        position: relative;
        background-color: #7486A4;
        font-weight: 300;
        border-radius: 2px;
        border: 0 none;
        min-width: 70px;
        min-height: 25px;
        line-height: unset;
    }

    #pw-init-label {
        color: #000000;
        font-weight: 400;
        position: relative;
        top: 82%;
        text-align: right;
    }

    #form-label {
        color: #000000;
        font-weight: 400;
        text-align: center;
        font-size: 17px;
        margin-bottom: 5px;
    }

    .client-form header {
        margin: 0px auto 0px
    }

    #init-container {
        position: relative;
        top: 82%;
    }
</style>

<body id="login" class="animated fadeInDown">
<!-- possible classes: minified, no-right-panel, fixed-ribbon, fixed-header, fixed-width-->
<div class="content_area">

    <!-- 언어 설정을 위해 임시 등록 -->
    <!-- 		<div id="langWrap"> -->
    <%-- 	<p>
                <span>Country : </span>
                <a href='javascript:void(0);' onclick="selCountryType($(this))" class="btn" data-val="US" data-name="country"><spring:message code="M00299"/></a>
                <a href='javascript:void(0);' onclick="selCountryType($(this))" class="btn" data-val="KR" data-name="country"><spring:message code="M00300"/></a>
            </p>  --%>
    <%-- 			<p>
                    <span>Lang : </span>
                    <a href='javascript:void(0);' onclick="selLangType($(this))" class="btn" data-val="en" data-name="lang"><spring:message code="M00301"/></a>
                    <a href='javascript:void(0);' onclick="selLangType($(this))" class="btn" data-val="ko" data-name="lang" id="defaultLangBtn"><spring:message code="M00302"/></a>
                </p> --%>
    <!-- 		</div> -->
    <!-- //언어 설정을 위해 임시 등록 -->


    <!-- 		<header class="header">
 			<div class="container">
				<img src='<ifvm:image name="login_logo"/>' alt="iCignal marketing logo" /> 
			</div>

 			<!-- END AJAX-DROPDOWN  -->
    </header>

    <div id="main" role="main">

        <!-- MAIN CONTENT -->
        <div id="content" class="container">

            <div class="row">
                <div class="loginForm">
                    <form action="index.html" method="POST" id="login-form" class="smart-form client-form" novalidate="novalidate">
                        <header></header>
                        <div id="form-label"><spring:message code="C00197"/></div>
                        <fieldset>

                            <section style="margin-bottom:10px;" class="row-wrap">
                                <label class="label">ID</label>
                                <label class="input">
                                    <%--<input type="email" name="id" id="id" placeholder="Id">--%>
                                    <input type="text" name="id" id="id" placeholder="Id">
                                    <b class="tooltip tooltip-top-right"><i class="fa fa-user txt-color-teal"></i> Please enter id</b></label>
                                <button type="button" id="emailAuthCheckBtn" class="btn btn-primary" onclick="emailAuthCheckFn();">이메일인증</button>
                                <%-- <ifvm:inputNew type="button" btnType="save" text="L00074" id="emailAuthCheckBtn" btnFunc="emailAuthCheckFn"  /> --%>
                            </section>
                            <section>
                                <label class="label">Password</label>
                                <label class="input">
                                    <input type="password" name="password" id="password" placeholder="Password">
                                    <b class="tooltip tooltip-top-right"><i class="fa fa-lock txt-color-teal"></i> Enter your password</b> </label>
                            </section>

                            <!--  								<section> -->
                            <!--  									<div class="rememberArea"> -->
                            <!-- 										<label class="checkbox"> -->
                            <!-- 											<input type="checkbox" name="remember"> -->
                            <!-- 											<i></i>Remember me -->
                            <!-- 										</label> -->
                            <!-- 									</div> -->
                            <!-- 								</section>  -->
                        </fieldset>
                        <footer>
                            <button type="submit" class="btn btn-primary" id="submitLogin" style="background-color : black;">
                                Login
                            </button>
                        </footer>
                    </form>

                    <%-- <div class="snsArea">
                        <img src="<ifvm:image name='sns_naver'/>" onclick="naverLoginPop();" />
                        <img src="<ifvm:image name='sns_kakao'/>" onclick="kakaoLoginPop();" />
                        <img src="<ifvm:image name='sns_gogle'/>" onclick="gogleLoginPop();" />
                        <img src="<ifvm:image name='sns_facebook'/>" onclick="facebookLoginPop();" />
                    </div> --%>
                </div>
            </div>

            <div class="row" id="init-container">
                <div class="col-xs-15 searchbtn_r">
                    <button class="btn btn-sm" id='passwordInitBtn'>
                        <spring:message code="C00187"/>
                    </button>
                </div>
            </div>
            <%--<div class="row" id="pw-init-label"><spring:message code="C00196"/></div>--%>


        </div>
    </div>

</div>
<!-- 	<footer>
		&copy; 2020 Quintet Systems
	</footer> -->
</body>
<div id="searchMbrPop" class="popup_container"></div>
<!-- SNS 인증키 등록 팝업 -->
<div id="snsAuthKeyPop"></div>