<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<style>
	.email_preview_wrap {
	    float: left;
        width: 761px;
	}
	#cContsSumryView_tools{
	       display: none;
	}
	#cContentView_tools{
	          display: none;
	}
</style>
<script type="text/javascript">
var ctitle;
var chtmlContentsArea;
var type = $("input[name=textTypeCode]:checked").val();
var previewObj
var cContsSumryViewCHeck;
var cContentViewfocusCHeck;
var cContsSumryViewObj;
var cContentViewObj;

function htmlPopup(){
    
    $("#cContsSumryView").ejRTE({
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
            cContsSumryViewCHeck = 'cContsSumryView_Iframe'
        }
    });
    
    cContsSumryViewObj = $("#cContsSumryView").data("ejRTE");
    
    
	$("#cContentView").ejRTE({
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
	        cContentViewfocusCHeck = 'cContentView_Iframe'
	    }
	});
	
	cContentViewObj = $("#cContentView").data("ejRTE");
	
    setTimeout(function () {
        if ($("#cContsSumryView").length) {
            cContsSumryViewObj.setHtml($("#contsSumry").val());
        }
        if ($("#cContentView").length) {
            cContentViewObj.setHtml($("#Contents").val());
        }
    }, 200);
}

$(document).ready(function () {
    $("#pretitle").text(ctitle);
    if(type == 'HTML'){
        htmlPopup();       
    } else {
        $("#cContsSumryView").html(cContsSumry);
        $("#cContentView").html(cContent);
    }
});

</script>
<div class="content_pop_wrap" style="padding: 12px" id="emailPreviewPopupArea">
	<div class="email_preview_wrap">
		<div class="email_header" id="pretitle">
			<p></p>
		</div>
	</div>
    <div class="form-horizontal underline top_well" id="termsVersionDetail">
        <div class="row qt_border">
            <ifvm:inputNew type="textarea" id="cContsSumryView"  required="false" label="L02688" labelClass="1"
                conClass="11" rows="5" maxLength="2000" readonly="true"/>
        </div>
        <div class="row qt_border">
            <ifvm:inputNew type="textarea" id="cContentView" required="false" label="L02332" labelClass="1"
            conClass="11" rows="20" readonly="true" />
        </div>
	</div>
</div>