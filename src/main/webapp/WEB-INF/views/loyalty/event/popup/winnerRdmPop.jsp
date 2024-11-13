<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div id="winningRdmForm">
	<div class="form-horizontal underline top_well">
		<div class="row qt_border">
			<div class="col-xs-3">
			<ifvm:inputNew type="text" id="voteCnt" labelClass="5" conClass="7" label="응모 건수" nuc="true" disabled="true"/>
			</div>
			<%-- <ifvm:inputNew type="text" id="voteCnt" labelClass="1" conClass="2" label="응모 건수" nuc="true" disabled="true"/> --%>
			<ifvm:inputNew type="text" id="voteMbrCnt" labelClass="2" conClass="2" label="응모자 수" nuc="true" disabled="true"/>
			<ifvm:inputNew type="number" id="winningCnt" labelClass="2" conClass="2" label="당첨 인원" nuc="true" required="true"/>
		</div>
		<div class="row qt_border"></div>
		<div class="pop_btn_area">
	    	<button class="btn btn-sm btn_gray" id="selectBtn">
	       		<i class="glyphicon glyphicon-check"></i>당첨자 추출
	    	</button> 
	    	<button class="btn btn-sm btn_lightGray2" id="cancelBtn">취소   
	   	 	</button> 
		</div>
	</div>
</div>

<script>

	//응모자수 추출
	function getApplicantCnt(){
		$.ifvSyncPostJSON('<ifvm:action name="getApplicantCnt"/>',{
			eventRid : eventRid
	    },function(result){
	    	$('#voteCnt').val(result.voteCnt);
	    	$('#voteMbrCnt').val(result.voteMbrCnt);
		});
	}
	
	//당첨자 추출
	function getRdmWinner(){
		var voteCnt = $('#voteCnt').val();
		var voteMbrCnt = $('#voteMbrCnt').val();
		var winCnt = $('#winningCnt').val();
		
		if(winCnt * 1 > voteMbrCnt * 1){
			alert('당첨 인원은 응모자 수를 넘을수 없습니다.')
		}else{
			if(confirm('기존 당첨자를 초기화 후 당첨자가 추출됩니다.\n당첨자를 추출 하시겠습니까?') === false) return;
			$.ifvSyncPostJSON('<ifvm:action name="getRdmWinner"/>',{
				eventRid : eventRid,
				winCnt : winCnt
		    },function(result){
		    		winnerRdmPopClose();
		    		alert(result.message);
		    		/*winCmpltYn='Y';
		    		$("#winnerRdm").prop('disabled',true);
		    		$("#winnerTransfer").prop('disabled',true);
		    		$("#deleteEventWinnerBtn").prop('disabled',true);*/
			    	getEventApplicantList();
			},function(result){
				alert(result.message);
			});
		}
	}
	
	$(document).ready(function() {
		getApplicantCnt();
		
		$('#selectBtn').on('click',function(){
			getRdmWinner();
		});
		
		$('#cancelBtn').on('click',function(){
			winnerRdmPopClose();
		});
	});
</script>