<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="page_btn_area">
    <div class="col-xs-5">
        <span><spring:message code="D00035" /></span>
    </div>
    <div class="col-xs-7 searchbtn_r">
		<ifvm:inputNew type="button" id="btnNew" className="btn_gray" btnFunc="btnSaveClick" btnType="save" text="L00074" />
    </div>
</div>
<div class="well form-horizontal" id="announceForm">
	<div class="row qt_border">
		<ifvm:inputNew type="radio" id="winnerLang" names="winnerLang" dto="winnerLang" required="true" label="M00237" labelClass="2" conClass="9" text="D00083|D00084|D00085" values="ko|en|zh" checkIndex="1"/>
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="radio" id="announceStatus" names="announceStatus" dto="announceStatus" required="true" label="L00090" labelClass="2" conClass="9" text="D00005|D00006" values="true|false" checkIndex="2"/>
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="text" id="announceTitle" names="announceTitle" dto="announceTitle" required="true" label="D00007" labelClass="2" conClass="9" />
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="textarea" id="announceDesc" names="announceDesc" dto="announceDesc" required="true" label="D00009" labelClass="2" conClass="9" rows="5"/>
	</div>
</div>

<script>

$(document).ready(function(){
	eventPrizewinner_init(null);
});

function eventPrizewinner_init(params) {
	$("input:radio[name='winnerLang']").attr('disabled', 'disabled');
	detailPrizewinner();	
	$('input[dtoparam=winnerLang]').on('change', function() {
		detailPrizewinner();	
	});
}

function detailPrizewinner(){
	$.ifvSyncPostJSON('<ifvm:action name="getAnnounceDetail"/>', {
		eventId : eventId,
		eventLang : $(':radio[name="winnerLang"]:checked').val() 
	}, function(result) {
		
		if( $.fn.ifvmIsNotEmpty(result.langList) ){
			if(result.langList.length > 0 ){
				for(var i=0; i<result.langList.length; i++){
					if(result.langList[i] == 'ko'){
						$('#winnerLang1').attr('disabled', false);
					}
					else if(result.langList[i] == 'en'){
						$('#winnerLang2').attr('disabled', false);
					}
					else{
						$('#winnerLang3').attr('disabled', false);
					}
				}
			}
		}
		
		if(result.announceTitle != null){
			if(result.announceLang == 'ko'){
				$("input:radio[name='winnerLang']:radio[value='ko']").attr("checked",true);
			}
			else if(result.announceLang == 'en'){
				$("input:radio[name='winnerLang']:radio[value='en']").attr("checked",true);
			}
			else if(result.announceLang == 'zh'){
				$("input:radio[name='winnerLang']:radio[value='zh']").attr("checked",true);
			}
			
			if(result.exposure_yn == "Y"){
				$("input:radio[name='announceStatus']:radio[value='true']").attr("checked",true);
			}
			else{
				$("input:radio[name='announceStatus']:radio[value='false']").attr("checked",true);
			}
			$('#announceTitle').val(result.announceTitle);
			$('#announceDesc').val(result.announceDesc);
		}
		else{
			$('#announceTitle').val("");
			$('#announceDesc').val("");
		}
		
		
	})
}


function btnSaveClick() {
	var validation = $('#announceForm').ifvValidation();
	if(validation.confirm() === false) return;
	else{
		
		$.ifvSyncPostJSON( '<ifvm:action name="updateAnnounce"/>',
				{
					eventId	: eventId,
					winnerLang : $(':radio[name="winnerLang"]:checked').val(),
					announceStatus : $(':radio[name="announceStatus"]:checked').val(),
					announceTitle : $("#announceTitle").val(),
					announceDesc : $("#announceDesc").val()
					
				},
				function(result) {
					 if(result.success == true){
						alert('<spring:message code="M00005"/>');
						}
					else{
						alert(result.message);
						}
				}
			);	
	}
}
</script>