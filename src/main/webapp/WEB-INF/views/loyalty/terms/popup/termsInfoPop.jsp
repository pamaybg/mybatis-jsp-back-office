<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<jsp:include page="/WEB-INF/views/layouts/default/ifvFramework.jsp" />
<script src="${pageContext.request.contextPath}/resources/js/lib/util.js"></script>
<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/css/common/common.css" />
<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/css/marketing/style.css" />

<div class="form-horizontal underline top_well" id="termsContent" >
	<div class="form-horizontal top_well underline" id="termsDetail">
		<div class="row">
			<div class="page_btn_area">
				<div class="col-xs-2">
					<span><spring:message code="L02329"/></span>
				</div>
			</div>
			<ifvm:inputNew type="textarea" id="termsSumry" names="termsSumry" dto="termsSumry" readonly="true" labelClass="1" conClass="11" rows="9" />
		</div>
		<div class="row">
			<div class="page_btn_area">
				<div class="col-xs-2">
					<span><spring:message code="L02332"/></span>
				</div>
			</div>
			<ifvm:inputNew type="textarea" id="termsConts" names="termsConts" dto="termsConts" readonly="true"  labelClass="1" conClass="11" rows="26"/>
		</div>
	</div>
</div>

<style>
    .email_preview_wrap {
        float: left;
        width: 761px;
    }
    #termsSumry_tools{
           display: none;
    }
    #termsConts_tools{
              display: none;
    }
</style>

<script type="text/javascript">
var termsSumry;
var termsConts;

function htmlPopup(){
    
    $("#termsSumry").ejRTE({
        height : "240px",
        width : "100%",
        minWidth : "10px",
        showFooter : false,
        showHtmlSource : false,
        maxLength:90000000,
        allowEditing: false,
        tools : {
            formatStyle : [ ],
            font : [ ],
            style : [ ],
            indenting : [],
            images : [],
            tables : [],
            doAction : [],
            links : [],
            media : [],
            view : [ "fullScreen" ]
        }, 
        pasteCleanupSettings:{
            listConversion:true,
            cleanCSS:false,
            removeStyles:false,
            cleanElements:false
        },
        select : function () {
            termsSumryViewCHeck = 'termsSumry_Iframe'
        }
    });
    
    termsSumryViewObj = $("#termsSumry").data("ejRTE");
    
    
    $("#termsConts").ejRTE({
        height : "240px",
        width : "100%",
        minWidth : "10px",
        showFooter : false,
        showHtmlSource : false,
        maxLength:90000000,
        allowEditing: false,
        tools : {
            formatStyle : [  ],
            font : [ ],
            style : [ ],
            indenting : [],
            images : [],
            tables : [],
            doAction : [],
            links : [],
            media : [],
            view : [ "fullScreen" ]
        }, 
        pasteCleanupSettings:{
            listConversion:true,
            cleanCSS:false,
            removeStyles:false,
            cleanElements:false
        },
        select : function () {
            termsContsViewfocusCHeck = 'termsConts_Iframe'
        }
    });
    
    termsContsViewObj = $("#termsConts").data("ejRTE");
    
    setTimeout(function () {
        if ($("#termsSumry").length) {
            termsSumryViewObj.setHtml(termsSumry);
        }
        if ($("#termsConts").length) {
            termsContsViewObj.setHtml(termsConts);
        }
    }, 200);
}


var getTermsContent={
		init : function(){
			var rid = $.ifvGetParam('rid');
			$.ifvSyncPostJSON('<ifvm:action name="getTermsInfoDetail"/>', {
				rid : rid
			}, function(result) {
				if ($.fn.ifvmIsNotEmpty(result)) {
				    termsSumry = result.termsSumry;
				    termsConts = result.termsConts;
				    if(result.editMode == 'HTML'){
				        htmlPopup();       
				    } else {
	                    $("#termsContent").dataSetting(result);
				    }
				}
			}, function(result) {
				alert(result.message);
			});
		}
}
window.onload= function(){
	getTermsContent.init();
};
</script>