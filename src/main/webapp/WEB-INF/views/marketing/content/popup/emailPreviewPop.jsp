<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<style>
.editor_contents {border-bottom: 1px solid #cccccc}
#emailPreviewPopupArea .input_email {min-height: 28px} 
</style>

<script>
var PhoneArray = [];
var memName = [];
var functionCheck = 0;
var sndNm;
var sndEmail; 
var titleVal;
var htmlVal;

function createPhoneArray() {
	PhoneArray = [];
	for(var i=1;i<6;i++){
		if($("#email" +i).val().length > 0 && $("#memName" +i).val().length > 0) { 
			var temp = {} 
			temp.phone = $("#email" +i).val();
			temp.memName = $("#memName" +i).val();
			
			PhoneArray.push(temp)
			functionCheck++;
		}
	}
}

//상세페이지 체크
function getEmailData() {

    if (conid != "null") {
        $.ifvSyncPostJSON('<ifvm:action name="getDetailContent"/>', {
            id : conid
        }, function(result) {
            titleVal = result.title;
            htmlVal = result.html;
            if (result.fileName != null) {
                filePath = result.filepath;
            }
        });
    }
}

$(document).ready(function(){
    
	getEmailData();
	
	$("#pretitle").text(ctitle);
	$("#prehtmlContentsArea").html(chtmlContentsArea);
	$("#fileNameCon").text($(fileNameText).text());
	
	//발신자 정보 세팅
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
		groupCode : 'MAIL_SENDER_INFO'
		, enableNA : true
	},function(result) {
		sndNm = result.rows[0].attrib01
		sndEmail = result.rows[0].markName
	});
	
	$("#sendChannelTest").on('click', function(){
	    
	    createPhoneArray();
	    
	    if(functionCheck > 0){
	        //조회 호출
	        $.ifvSyncPostJSON('<ifvm:action name="sendChannelTest"/>', {
	                  title            : titleVal
	                , contents         : htmlVal
	                , id               : conid
	                , contentsType     : chnlCode
	                , phoneArr         : PhoneArray
	                , typeCode         : typeCodeId
	                , senderNm         : sndNm
	                , senderEmail      : sndEmail
	                , filePath         : filePath
	                , emailType        : $("#emailType").val()
	        }, function(result) {
	            var Text;
	            
	            if(result.message.indexOf('Fail') == -1){
	                Text = result.message;
	            }
	            else {
	                Text = result.message + '\n<spring:message code="M00455"/>';
	            }
	            
	            alert(Text);
	        }, function(result){
	            if(result.errorType == 800100){ 
	                alert('<spring:message code="M00455"/>'); 
	            }
	        });
	    }
	    else {
	        alert('<spring:message code="M00447"/>');
	    }
	});

	$("#prehtmlContentsArea").html(htmlStore)
});
</script>

<div class="content_pop_wrap" style="padding: 12px" id="emailPreviewPopupArea">
	<div class="email_preview_wrap">
		<div class="email_header" id="pretitle">
			<p></p>
		</div>
		<div class="editor_contents" id="prehtmlContentsArea"><!-- 이메일 내용 들어갈 부분 --></div>
		
		<div class="file_box row" style="display: none;">
			<span class="file_tit"><spring:message code="M00420"/></span>
			<p class="file_link"><a href="javascript:;" id="fileNameCon"><!-- 파일 첨부된 이름 --></a></p>
		</div>
		
	</div>
	<div class="send_desc_wrap" style="float: right; width: 192px; padding : 0px 0px 10px 20px">
		<div>
			<header class="temp_title">
				<p><spring:message code="M00424"/></p>
			</header>
			<ul class="description_guide">
				<li><spring:message code="M00425"/></li>
				<li><spring:message code="M00426"/></li>
				<li class="last"><spring:message code="M00427"/></li>
			</ul>
		</div>
		<div>
			<header class="temp_title">
				<p><spring:message code="M00391"/></p>
			</header>
			
			<div class="form-horizontal row">
    			<div class="col-xs-7">
    			     <ifvm:input type="email" placeholder="M00428" id="email1" className="form-control input_email" valiItem="email" />
    			</div>
    			<div class="col-xs-1"></div>
    			<div class="col-xs-4">
    			     <ifvm:input type="text" placeholder="M01385" id="memName1" className="form-control input_email" valiItem="memName" />
    			</div>
			</div>
			
			<div class="form-horizontal row">
    			<div class="col-xs-7">
    			     <ifvm:input type="email" placeholder="M00428" id="email2" className="form-control input_email" valiItem="email" />
    			</div>
    			<div class="col-xs-1"></div>
    			<div class="col-xs-4">
    			     <ifvm:input type="text" placeholder="M01385" id="memName2" className="form-control input_email" valiItem="memName" />
    			</div>
			</div>
			
			<div class="form-horizontal row">
    			<div class="col-xs-7">
    			     <ifvm:input type="email" placeholder="M00428" id="email3" className="form-control input_email" valiItem="email" />
    			</div>
    			<div class="col-xs-1"></div>
    			<div class="col-xs-4">
    			     <ifvm:input type="text" placeholder="M01385" id="memName3" className="form-control input_email" valiItem="memName" />
    			</div>
			</div>
			
			<div class="form-horizontal row">
    			<div class="col-xs-7">
    			    <ifvm:input type="email" placeholder="M00428" id="email4" className="form-control input_email" valiItem="email" />
    			</div>
    			<div class="col-xs-1"></div>
    			<div class="col-xs-4">
    			    <ifvm:input type="text" placeholder="M01385" id="memName4" className="form-control input_email" valiItem="memName" />
    			</div>
			</div>
			
			<div class="form-horizontal row">
    			<div class="col-xs-7">
    			     <ifvm:input type="email" placeholder="M00428" id="email5" className="form-control input_email" valiItem="email" />
    			</div>
    			<div class="col-xs-1"></div>
    			<div class="col-xs-4">
    			     <ifvm:input type="text" placeholder="M01385" id="memName5" className="form-control input_email" valiItem="memName" />
    			</div>
			</div>
			
			<div class="text-center send_preview_btn_area">
				<button class="btn btn-sm btn_gray" id="sendChannelTest" objCode="emailPreviewTest_OBJ">         
					<spring:message code="M00391"/>
				</button>
			</div>
		</div>
	</div>
</div>