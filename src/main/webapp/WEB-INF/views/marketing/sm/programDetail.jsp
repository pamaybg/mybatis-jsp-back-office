<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>

<script type="text/javascript">
var chid = '<%= cleanXss(request.getParameter("acid")) %>';
var validation;

/* kj.kang 추가사항 :: 케플러 대시보드에서 해당 페이지를 호출할 수 있다.
 * 대시보드를 프로그램에 쉽게 등록하기 위해, 해당 페이지로 1)대시보드 ID 2)대시보드명 3)대시보드 경로 를 보낸다. 
 */
var dashboardId = $.ifvGetParam( "dashboardId" );
var dashboardNm = decodeURI($.ifvGetParam( "dashboardNm" ));
var dashboardPath = "<ifvm:url name='dashboardView' />" + "?dashboardId=" + dashboardId + ".jsp";
dashboardPath = dashboardPath.substr( 1 );

var analysisId = $.ifvGetParam( "analysisId" );
var analysisNm = decodeURI($.ifvGetParam( "analysisNm" ));
var analysisEmbedType = $.ifvGetParam( "analysisEmbedType" );
var analysisPath = "<ifvm:url name='analysisView' />" + "?analysisId=" + analysisId + "&analysisEmbedType=" + analysisEmbedType + ".jsp";
analysisPath = analysisPath.substr( 1 );

function init(){
    validation = $("#programDetailForm").ifvValidation();
   	
   	$('#createBy').val($.ifvmGetUserInfo().empName);
   	var date = new Date();
   	var month ='00',  dateD = '00';
   	var dateMonth = String(date.getMonth()+1);	
   	var monthlength = month.length-dateMonth.length;   
   	var dateDate = String(date.getDate());
   	var datelength = dateD.length-dateDate.length;
       	
	$('#createDate').val(date.getFullYear()+'-'+month.substring(0,monthlength)+dateMonth+'-'+dateD.substring(0,datelength)+dateDate);
		
	$('#progUrl').keyup(function(event){		
		 $('#progUrl').css('border-style','').css('border-color','');
		 $('#progUrlDiv').find('span').remove();
		
		 var urlData = $(this).val();	
		 		 
		 if(urlData.search('.jsp')==-1){
			$(this).attr('noJSP',true);
		 }else if(urlData.split('.jsp')[1].length>0)
				$(this).attr('noJSP',true);
		 else{			
			   $(this).removeAttr('noJSP');
		 }	 
	});	
	
	/* kj.kang 추가 :: 대시보드에서 해당 페이지 호출 시, 대시보드 관련 정보를 INPUT BOX에 세팅해줌. */
	if( $.fn.ifvmIsNotEmpty( dashboardId ) ) {
		$("#progId").val(dashboardId);
		
		if( $.fn.ifvmIsNotEmpty(dashboardNm) ) {
			$("#progName").val(dashboardNm);
		}
		
		if( $.fn.ifvmIsNotEmpty(dashboardPath) ) {
			$("#progUrl").val(dashboardPath);
		}
	}
	
	if( $.fn.ifvmIsNotEmpty( analysisId ) ) {
		$("#progId").val(analysisId);

		if( $.fn.ifvmIsNotEmpty(analysisNm) ) {
			$("#progName").val(analysisNm);
		}
		
		if( $.fn.ifvmIsNotEmpty(analysisPath) ) {
			$("#progUrl").val(analysisPath);
		}
	}
};

function progTypeSelect(select){
	var progType = ['<spring:message code="M00205"/>', 'POPUP', 'TAB'];
	var progValue = ['LIST', 'POPUP', 'TAB'];
    $(progType).each(function(index, item){
    	select.append($('<option/>').text(item).val(progValue[index]));
    });    
    
    

  }

function systemSelect(select){
	 $.ifvSyncPostJSON('<ifvm:action name="getSystem"/>',
	 {id:'program'}, 
	 function(result){
	      	 //
	    	 $(result.rows).each(function(index, item){	 
	    		 //console.log(item);
	    		 select.append($('<option/>').text(item.and_app_name)
	    				  .val(item.id));	 
	    	 });	 
	    
	    	 var myParam = location.search.split('id=')[1];
	    	 select.val(myParam);	
	 });
	 $.ifvSyncPostJSON('${pageContext.request.contextPath}/marketing/manage/getCommCode.do',null, 
				function(result){		 
				 $(result).each(function(index, item){
				        $('#applyType').append($('<option/>').val(item.id).text(item.markName));
				  });
			    });
}

function checkforDetail(flag){	
	//console.log(flag);
		if(flag!='null'){
     	 var myParam = location.search.split('id=')[1];
     	$('#subTitle').text( '<spring:message code="M00259"/>');
     	 $.ifvSyncPostJSON('<ifvm:action name="getProgramDetail"/>',
    			 {id:myParam}, 
    			 function(result){
    			      //
  			      	  var detailObject = $(result.rows)[0];
  			      	  chid = detailObject.accountId
    			      $('#systemName').val(detailObject.appServiceType);
    			      $('#progId').val(detailObject.progNum);
    			      $('#progName').val(detailObject.progName);
    			      $('#progType').val(detailObject.type);
    			      $('#progUrl').val(detailObject.progPath);
    			      $('#createBy').val(detailObject.createBy);
    			      $('#applyType').val(detailObject.applyType);	
    			      var crDate = detailObject.createDate;    			      
    			      $('#createDate').val(crDate.substring(0,10));    		
    			      
    			      if(detailObject.useFlag){
    			    	  $('#flagUse1').attr('checked',true);
    			      }
    			      
    			 }); 
    	saveBtnEvent('programUpdate');
	}else{
		saveBtnEvent('programAdd');
  	   $('#flagUse1').attr('checked',true);
	}
	
}

function saveBtnEvent(action){
	
	$('#btnSave').click(function(){
	
    if(validation.confirm()){
    		 
		 if($('#progUrl').attr('noJSP')){
			     $('#progUrl').css('border-style','solid').css('border-color','red');
			     $('#progUrlDiv').append(
			    		 $('<span/>')
	  		             .text('<spring:message code="M00225"/>')
			             .css('color','red')
			             .css('font-weight','bold')
			             .css('margin-left','10px')
			     );
		 }else{
				var data = new Object;
				data.id = location.search.split('id=')[1];
				data.progId = $('#progId').val();
				data.progUrl = $('#progUrl').val();
				/* data.progType=$('#progType').val(); */
				data.progType=$('#progType').val();
				data.progName = $('#progName').val();
				data.applyType = $('#applyType').val();
				data.accountId = chid;
	
				if($('#flagUse1').attr('checked')){
					data.flagUse = true;
				}else{
					data.flagUse = false;
				}			 
				
				
		    if(action=='programAdd'){
    			$('#progId').css('border-style','').css('border-color',''); 
		    	$('#progNumSpan').find('span').remove();
		    	
		    	$.ifvSyncPostJSON('<ifvm:action name="addProgramList"/>',
						 data, 
						 function(result){
				            if(result.message=='Exist'){
				    			$('#progId').css('border-style','solid').css('border-color','red'); 
				    			$('#progNumSpan').append(
				    					$('<span/>')
				    		             .text('<spring:message code="M00591"/>')
				    		             .css('color','red')
							             .css('font-weight','bold')
							             .css('margin-left','12px')
							             .css('width','154px')
							             .css('position','absolute')
							             .css('margin-top','6px')
							             );
				    			
				            }else if(result.message=='Success'){
				            	alert('<spring:message code="M00295"/>');
				 
				            	qtjs.href('<ifvm:url name="programList"/>');
				            }				         		    		        
				         });
		    	 	
			}else if(action=='programUpdate'){
			 	   if(confirm('<spring:message code="M00209"/>')){	
			  	$.ifvSyncPostJSON('${pageContext.request.contextPath}/marketing/manage/updateProgramList.do',
						 data, 
						 function(result){
			  				 alert('<spring:message code="M00295"/>');
						     qtjs.reload();				         
				         });	 			    
			 	 }
			}
		}	   
	}	 
	});
	
}





$(document).ready(function(){
	$.ifvmLnbSetting('programList');
	init();
	systemSelect($('#systemName'));
	progTypeSelect($('#progType'));
	checkforDetail('<%=request.getAttribute("programDetail")%>');
});

</script>
<div class="page-title">
	<h1>
		<spring:message code="M00156" /> 
		<span> &gt; <spring:message code="M00157" /></span>
		<span> &gt; <label id="subTitle"><spring:message code="M00163" /></label> </span>
	</h1>
</div>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="M00178" /></span>
	</div>
	<div class="col-sm-5 searchbtn_r">
		<button id="btnSave" class="btn btn-sm">
			<i class="glyphicon glyphicon-check"></i>
			<spring:message code="M00137" />
		</button>
	</div>
</div>

<div class="well underline">
	<form class="form-horizontal" id='programDetailForm'>
		<div class="row qt_border" style="display:none ">
			<label class="col-sm-2 span control-label"><span class="asterisk">*</span><spring:message code="M00174" /></label>
			<div class="col-sm-3">
				<div class="input-group" style="width:100%; display:none">
					<ifvm:input type="select" id='systemName' disabled='true'/>	
				</div>
			</div>	
		</div>
		<!-- <label class="col-sm-2 span control-label"><span class="asterisk">*</span>적용 타입</label> -->
			<div class="col-sm-2" style="display:none">
				<div class="input-group" style="width:100%;">
		    		<ifvm:input type="select" id='applyType' disabled = 'true'/>	
		    	</div>
		   	</div>
	
		<div class="row qt_border">
			<label class="col-xs-2 span control-label"><span class="asterisk">*</span><spring:message code="M00179" /></label>
			<div class="col-xs-3 control_content">
				<div class="input-group" id='progNumSpan'>
					<ifvm:input type="text" id='progId' maxLength='24' required='true'/>	
				</div>
			</div>
			<label class="col-xs-2 span control-label"><span class="asterisk">*</span><spring:message code="M00175" /></label>
			<div class="col-xs-3 control_content">
				<div class="input-group">
					<ifvm:input type="text" id='progName' maxLength='100' required='true'/>	
				</div>
			</div>
		</div>
		<div class="row qt_border">
			<label class="col-xs-2 span control-label"><span class="asterisk">*</span><spring:message code="M00180" /></label>
			<div class="col-xs-3 control_content">
				<div class="input-group">
					<ifvm:input type="select" id='progType'/>	
				</div>
			</div>
			<label class="col-xs-2 span control-label"><span class="asterisk">*</span><spring:message code="M00181" /></label>
			<div class="col-xs-3 control_content">
				<div class="input-group">
					<ifvm:input type="checkboxType" text="M00164" id='flagUse'/>	
				</div>
			</div>
		</div>
		
		<div class="row qt_border">
			<label class="col-xs-2 span control-label"><span class="asterisk">*</span><spring:message code="M00183" /></label>
			<div class="col-xs-8 control_content">
				<div class="input-group" id='progUrlDiv'>
					<ifvm:input type="text" id='progUrl' maxLength='250' required='true'/>	
				</div>
			</div>
		</div>
		<div class="row">
			<label class="col-xs-2 span control-label"><spring:message code="M00184" /></label>
			<div class="col-xs-3 control_content">
				<div class="input-group">
					<ifvm:input type="text" disabled="true" id='createBy' />	
				</div>
			</div>
			<label class="col-xs-2 span control-label"><spring:message code="M00185" /></label>
			<div class="col-xs-3 control_content">
				<div class="input-group">
					<ifvm:input type="text" disabled="true" id='createDate' />	
				</div>
			</div>
		</div>
	</form>
</div>

