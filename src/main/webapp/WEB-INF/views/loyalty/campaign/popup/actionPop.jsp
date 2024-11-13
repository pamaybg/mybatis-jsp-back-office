<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div id='promotionActionInfoForm'>




	<div class="form-horizontal top_well underline">
		<div class="page_btn_area">
				<div class="col-xs-2">
					<span style="font-size: 10pt">오퍼 제공</span>
				</div>
			</div>
			

            <div class="col-xs-6 control_content">
            	<label class="col-xs-2 control-label">
            	<spring:message code="등급제한"/>
            	&nbsp;
                    <ifvm:input type="radio" id="tierBnftYn" names="tierBnftYn" values="R" checked="true"/>
                </label>
        		<label class="col-xs-3 control-label" >
        		<spring:message code="기본"/>&nbsp;
        		&nbsp;
                    <ifvm:input type="radio" id="allYn" names="tierBnftYn" values="R"/>
                </label>
            </div>
        </div>
			
	<div id="tierList">
	
	<div class="row qt_border tiersGridList" seqNo="1" id="tiersGridList1">
	
	<br>
	<div class="flex_btn_area">
        <button class="btn_searchitem_add_remove actionItemPlusBtn" onClick="addPlusBtn()">Plus</button>
        <button class="btn_searchitem_add_remove actionItemMinusBtn" onClick="removeMinusBtn(1)" id="itemMinusfirst">Minus</button>
    </div>

        <label class="col-xs-1 control-label"><spring:message code="등급"/></label>
	    <div class="col-xs-2 control_content">
        		<ifvm:input type="text" id="tierGroup1" className = "searchTextVal" disabled="true" />
  		</div>
  		<ifvm:input type="hidden" id="tierGroupRid1" names="tierGroupRid" />
  		<ifvm:input type="hidden" id="tierRid1" names="tierGroupRid" />
  		<ifvm:input type="hidden" id="promActTierRid1" names="promActTierRid" />
  		<ifvm:input type="hidden" id="promActionTierRid1" names="tierGroupRid" />
  		<ifvm:input type="hidden" id="promStatCd" names="promStatCd" />	
 
		<div class="col-xs-2 control_content">
			<div class="input-group">
        		<ifvm:input type="text" id="tierTypeCd1"  className = "searchTextVal" disabled="true" />
        		<span class="input-group-addon" id="tierGroupPopBtn1" onClick="tierGroupPopup(1)">
					<a><i class="fa fa-search"></i></a>
				</span>
			</div>
   		</div>
   		
   		<div class="col-xs-2 control_content">
    	<ifvm:input type="select" id="ofrAmtType1"  names="ofrAmtType1" className="searchCondition" />
		</div>
		
        <label class="col-xs-1 control-label"><spring:message code="수량/적립금"/></label>
        <div class="col-xs-1 control_content">
        <ifvm:input type="number" id="ofrAmt1" className="text-right"/>
        </div><lebel id="info21"></lebel>
       
    </div>
	</div>
	

	<br>
	<div class="form-horizontal top_well underline">
	    <div class="row qt_border">
    
	        <label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="한도"/></label>
	        <div class="col-xs-1 control_content">
	            <ifvm:input type="text" dto="maxAmt" names="maxAmt" id="maxAmt" required="true"  className="text-right" values="0"/>
	        </div>
	    </div>
	</div>
	    
	    <div class="row qt_border">
	    	<label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="유효시작일"/></label>
	        <div class="col-xs-1 control_content">
	            <ifvm:input type="radio" names="eff"  id="effStrtDirectYn"/>즉시
	        </div>
	        
	        <div class="col-xs-2 control_content">
  				<div class="col-xs-1 control_content">
    				<ifvm:input type="radio" id="effStrtDateCntYn" names="eff"/>
		  		</div>
			  <div class="col-xs-11 control_content">
			    <div class="col-xs-5 control_content">
			      <ifvm:input type="number" id="effStrtDateCnt" names="effStrtDateCnt" />
			    </div>
			    <label class="col-xs-4 control_label">일 이후</label>
			  </div>    
			</div>
	        
	        <%-- <div class="col-xs-2 control_content">
  				<div class="col-xs-6 control_content">
    				<ifvm:input type="radio" id="effStrtDateYn" names="eff"/>특정일
		  		</div>
			  <div class="col-xs-11 control_content">
			    <div class="col-xs-11 control_content">
			      <ifvm:input type="date" id="effStrtDate" names="effStrtDate"/>
			    </div>
			  </div>    
			</div> --%>
			
			<div class="col-xs-3 control_content">
  				<div class="col-xs-1 control_content">
    				<ifvm:input type="radio" id="effStrtDateYn" names="eff"/>
		  		</div>
			  <div class="col-xs-11 control_content">
			    <div class="col-xs-7 control_content">
			      <ifvm:input type="date" id="effStrtDate" names="effStrtDate"/>
			    </div>
			    <label class="col-xs-4 control_label">특정일 지정</label>
			  </div>    
			</div>
			
		</div>
	    
	    <%-- <div class="row qt_border">
	        <label class="col-xs-1 control-label"><spring:message code="스탬프 적용"/></label>
	        <div class="col-xs-2 control_content">
	            <ifvm:input type="checkBox" dto="stmpYn" names="stmpYn" id="stmpYn"  maxLength="24"/>
	        </div>
	    </div> --%>
	   	<br>
	    
	    	<div class="page_btn_area">
				<div class="col-xs-2">
					<span style="font-size: 10pt">반응수집고객군</span>
				</div>
			</div>
			<div class="form-horizontal top_well underline">
			
			<div class="row">
				<label class="col-xs-1 control-label"><spring:message code="대상고객군"/></label>
                <div class="col-xs-2 control_content">
                    <ifvm:input type="text" id="tgtGrpNo" dto="tgtGrpNo" names="tgtGrpNo" disabled="true"  />
                </div>
                 <div class="col-xs-3 control_content">
                 	<div class="input-group">
                    <ifvm:input type="text" id="tgtGrpNm" names="tgtGrpNm" dto="tgtGrpNm" disabled="true"  />
                	<span class="input-group-addon" id="tgtGrpActionPopBtn">
							<a><i class="fa fa-search"></i></a>
					</span>
					</div>
                </div>
	    	</div>
			
			<br>
			
			<!-- <div class="page_btn_area">
				<div class="col-xs-2">
					<span  style="font-size: 10pt">Qualifying Point산출</span>
				</div>
			</div> -->
			
			<%-- <div class="row">
				<label class="col-xs-1 control-label"><spring:message code="자격포인트 유형"/></label>
                <div class="col-xs-2 control_content">
                    <ifvm:input type="select" id="qpntTypeCd" dto="qpntTypeCd" names="qpntTypeCd"   />
                </div>
                 <div class="col-xs-1 control_content">
                    <ifvm:input type="number" id="qpntAmt" names="qpntAmt" dto="qpntAmt"  className="text-right" />
                </div>
	    	</div> --%>
			
	        
	    
	</div>

</div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="promotionActionSaveBtn" objCode="actionPopSave_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="M00280"/>
	</button>
	<button class="btn btn-sm btn_gray btn_lightGray2" id="promotionActionCancle" objCode="actionPopCancle_OBJ">
		<spring:message code="닫기"/>
	</button>
</div>

<div id="tgtGrpIncPop" class="popup_container"></div>
<div id="tierGroupPop" class="popup_container"></div>
<div id="tierTypePop" class="popup_container"></div>

<script id="ActionAllDefaultTemp" type="text/x-jquery-tmpl">
<div class="row qt_border tiersGridList" seqNo="1" id="tiersGridListAllList">
	
	<br>

  		<ifvm:input type="hidden" id="promActTierRid1" names="promActTierRid" />
  		<ifvm:input type="hidden" id="promActionTierRid1" names="tierGroupRid" />	
   		
        <label class="col-xs-1 control-label"><spring:message code="제공혜택유형"/></label>
   		<div class="col-xs-2 control_content">
    	<ifvm:input type="select" id="ofrAmtType1"  names="ofrAmtType1" className="searchConditionOfrAmtTpye" />
		</div>
		
        <label class="col-xs-1 control-label"><spring:message code="수량/적립금"/></label>
        <div class="col-xs-1 control_content">
        <ifvm:input type="number" id="ofrAmt1" className="text-right"/>
        </div><lebel id="info21"></lebel>
       
    </div>
</script>

<script id="ActionDefaultTemp" type="text/x-jquery-tmpl">
<div class="row qt_border tiersGridList" seqNo="1" id="tiersGridList1">
	
	<br>
	<div class="flex_btn_area">
        <button class="btn_searchitem_add_remove actionItemPlusBtn" onClick="addPlusBtn()">Plus</button>
        <button class="btn_searchitem_add_remove actionItemMinusBtn" onClick="removeMinusBtn(1)" id="itemMinusfirst">Minus</button>
    </div>

	    <label class="col-xs-1 control-label"><spring:message code="등급"/></label>
	    <div class="col-xs-2 control_content">
        		<ifvm:input type="text" id="tierGroup1" className = "searchTextVal" disabled="true" />
  		</div>
  		<ifvm:input type="hidden" id="tierGroupRid1" names="tierGroupRid" />
  		<ifvm:input type="hidden" id="tierRid1" names="tierGroupRid" />
  		<ifvm:input type="hidden" id="promActTierRid1" names="promActTierRid" />
  		<ifvm:input type="hidden" id="promActionTierRid1" names="tierGroupRid" />	
 
		<div class="col-xs-2 control_content">
			<div class="input-group">
        		<ifvm:input type="text" id="tierTypeCd1"  className = "searchTextVal" disabled="true" />
        		<span class="input-group-addon" id="tierGroupPopBtn1" onClick="tierGroupPopup(1)">
					<a><i class="fa fa-search"></i></a>
				</span>
			</div>
   		</div>
   		
   		<div class="col-xs-2 control_content">
    	<ifvm:input type="select" id="ofrAmtType1"  names="ofrAmtType1" className="searchConditionOfrAmtTpye" />
		</div>
		
        <label class="col-xs-1 control-label"><spring:message code="수량/적립금"/></label>
        <div class="col-xs-1 control_content">
        <ifvm:input type="number" id="ofrAmt1" className="text-right"/>
        </div><lebel id="info21"></lebel>
       
    </div>
</script>

<script id="ActionOfferTemp" type="text/x-jquery-tmpl">
<div class="row qt_border tiersGridList" seqNo=${'${'}seqNo} id="tiersGridList${'${'}seqNo}">
    <div class="flex_btn_area">
        <button class="btn_searchitem_add_remove actionItemPlusBtn" onclick="addPlusBtn()">Plus</button>
        <button class="btn_searchitem_add_remove actionItemMinusBtn" onClick="removeMinusBtn(${'${'}seqNo})">Minus</button>
    </div>

	    <label class="col-xs-1 control-label"><spring:message code="등급"/></label>
	    <div class="col-xs-2 control_content">
        		<ifvm:input type="text" id="tierGroup${'${'}seqNo}" className = "searchTextVal" disabled="true" />
  		</div>

		<ifvm:input type="hidden" id="tierGroupRid${'${'}seqNo}" names="tierGroupRid" />  
		<ifvm:input type="hidden" id="tierRid${'${'}seqNo}" names="tierGroupRid" />
		<ifvm:input type="hidden" id="promActTierRid${'${'}seqNo}" names="tierGroupRid" />
		<ifvm:input type="hidden" id="promActionTierRid${'${'}seqNo}" names="tierGroupRid" />	

		<div class="col-xs-2 control_content">
			<div class="input-group" >
        		<ifvm:input type="text" id="tierTypeCd${'${'}seqNo}"  className = "searchTextVal" disabled="true" />
        		<span class="input-group-addon" id="tierTypePopBtn${'${'}seqNo}" onClick="tierGroupPopup('\${seqNo}')">
					<a><i class="fa fa-search"></i></a>
				</span>
			</div>
   		</div>
   		
   		<div class="col-xs-2 control_content" seqNo=${'${'}seqNo}>
    	<ifvm:input type="select" id="ofrAmtType${'${'}seqNo}"  names="ofrAmtType${'${'}seqNo}" className="searchConditionOfrAmtTpye" />
		</div>
        <label class="col-xs-1 control-label"><spring:message code="수량/적립금"/></label>
        <div class="col-xs-1 control_content">
        <ifvm:input type="text" id="ofrAmt${'${'}seqNo}" className="text-right"/>
        </div><lebel id="info2${'${'}seqNo}"></lebel>

    </div>
</div>
</script>


<script>
var promActRid=null;
var tgtGrpActionRid=null;
var effStrtDayCnt;
var effDateType;
var index;
var seqNo=1;
var rtnDatas = [];
var removeRtnDatas = [];
var effStrtDate=null;;
var cpnYn='N';
var tierBnftYn=null;
function ActionMinusBtn(){
	if( $('.SearchCondition[defcon=1]').length == 1){
        $('.itemMinusBtn').hide();
    }else{
        $('.itemMinusBtn').show();
    }
}

$(document).on("change", '.searchConditionOfrAmtTpye', function() {
	ofrValTypeChange($(this).attr("id"));
});

function tierGroupPopup(index) {
	seqNo = index;
	$("#tierGroupPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="tierGroupPop"/>',
        contentType: "ajax",
        title: '등급그룹 조회',
        width: 800,
        close : 'tierGroupClosePop'
    });
}

function tierGroupClosePop() {
	tierGroupPop._destroy();
}

function removeMinusBtn(seq) {
		if($("#promStatCd").val()!='W') {
			alert('작성중이 아닌 프로모션은 삭제할수없습니다.');
			return;
		}
		else {
        if(seq!=1) {
        	if($("#promActionTierRid"+seq).val() != '') {
        		if( confirm('<spring:message code="I01500"/>') == true ){
        	        $.ifvSyncPostJSON('<ifvm:action name="removeActionTier"/>', {
        	            rid: $("#promActionTierRid"+seq).val()
        	        },
        	        function(result) {
        				alert('<spring:message code="I00726"/>');
        				$("#tiersGridList"+seq).remove();
               		 	ActionMinusBtn();
               	     	seqNo = seqNo - 1;
        	        });
        	    }
        	}
        	else {
        		$("#tiersGridList"+seq).remove();
        		 ActionMinusBtn();
        	     seqNo = seqNo - 1;
        	}

        }
		}
}

function addPlusBtn() {
	
	$("#itemMinusfirst").show();
	seqNo = Number(seqNo) + 1;
	var temp = $("#ActionOfferTemp").tmpl(seqNo);
    $("#tierList").append(temp);
    $("#promActionTierRid"+seqNo).val('');
	$.fn.ifvmSetSelectOptionCommCode("ofrAmtType"+seqNo, "PROM_ACT_AMT_TYPE", null, null, false);
	/* document.getElementById("ofrAmtType"+seqNo).onchange = ofrValTypeChange(seqNo); */
	if(cpnYn=='Y') {	
		$("#info2"+seqNo).text("개");
 	 }
}

function ofrValTypeChange(temp) {
	var btnSeqNo = temp.charAt(temp.length-1);
	$("#"+temp).parents("seqNo");
	if(cpnYn=='Y') {	
		$("#info2"+btnSeqNo).text("개");
 	 } else {
 		 if($("#"+temp).val()=='RATE') $("#info2"+btnSeqNo).text("%");
 		 else if($("#"+temp).val()=='AMT') $("#info2"+btnSeqNo).text("P");
 		 else if($("#"+temp).val()=='RULE') $("#info2"+btnSeqNo).text("%");
 		 else $("#info2"+btnSeqNo).text("");
 	 } 
}


function actionPopupInit() {
	$("#itemMinusfirst").hide();
    $.fn.ifvmSetSelectOptionCommCode("ofrAmtType1", "PROM_ACT_AMT_TYPE", null, null, false);
    $.fn.ifvmSetSelectOptionCommCode("qpntTypeCd", "PROM_ACT_QPNT_TYPE", null, null, false);
	
	cDialog.model.title = 'Action 상세 정보';
    $("#dialog_title").append('Action 상세 정보');
    cDialog.model.width = "1200";
    cDialog.model.close = "closeActionPop";
}



//dialog close
function closeActionPop(args) {
	$(".tiersGridList").each(function(i,item) {
            $(this).remove();
		
});
    //campaignDefaultInfo = {};
    //konckout bindings stop
    ko.virtualElements.allowedBindings.stopBinding = true;

    //dialog 파괴
    cDialog._destroy();
}

function tgtGrpActionPopup() {
	$("#tgtGrpIncPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="tgtGrpIncPop"/>',
        contentType: "ajax",
        title: '대조고객군 등록',
        width: 680,
        close : 'tgtGrpIncClosePop'
	});
}

function tgtGrpIncClosePop() {
	tgtGrpIncPop._destroy();
}

function promotionActionSave() {
	rtnDatas = [];
	if($('input:radio[id="tierBnftYn"]').is(":checked") == true){
		tierBnftYn = 'Y'
	}else{
		tierBnftYn = 'N'
	}
	if(tierBnftYn=='N') {
		i=1;
		var ofrAmtType = $("#ofrAmtType"+i).val();
		var ofrAmt = $("#ofrAmt"+i).val();
		var rid = $("#promActTierRid"+i).val();
		
		var rowData = {
				ofrAmtType : ofrAmtType,
				ofrAmt : ofrAmt,
				seqNum : i,
				rid : rid
		};
		rtnDatas.push(rowData);
	}
	else {
	
	 $(".tiersGridList").each(function(i,item) {	
		 i=i+1;
			var tierGroupRid = $("#tierGroupRid"+i).val();
			var tierRid = $("#tierRid"+i).val();
			var ofrAmtType = $("#ofrAmtType"+i).val();
			var ofrAmt = $("#ofrAmt"+i).val();
			var rid = $("#promActTierRid"+i).val();
			
			var rowData = {
					tierGroupRid : tierGroupRid,
					tierRid : tierRid,
					ofrAmtType : ofrAmtType,
					ofrAmt : ofrAmt,
					seqNum : i,
					rid : rid
			};
			rtnDatas.push(rowData);
			
	});
	}
	
	if($('input:checkbox[id="stmpYn"]').is(":checked") == true){
		stmpYn = 'Y'
	}else{
		stmpYn = 'N'
	}
	
	/* if($('input:checkbox[id="tierBnftYn"]').is(":checked") == true){
		tierBnftYn = 'Y'
	}else{
		tierBnftYn = 'N'
	} */
	
	if($('input:radio[id="effStrtDirectYn"]').is(":checked") == true){
		effDateType = "D";
	} else if($('input:radio[id="effStrtDateCntYn"]').is(":checked") == true) {
		effStrtDayCnt = $("#effStrtDateCnt").val();
		effStrtDate = null;
		effDateType = "A";
	} else if($('input:radio[id="effStrtDateYn"]').is(":checked") == true) {
		effStrtDate = $("#effStrtDate").val();
		effStrtDayCnt = null;
		effDateType = "P";
	}

	
	var varData = null;
	varData = $("#promotionActionInfoForm").getSubmitData();
	varData.promRid = campaign.id;
	var requestData = {
			promotionTierAction : rtnDatas,
			promRid 	: campaign.id,
			tgtGrpActionRid : tgtGrpActionRid,
			effStrtDayCnt : effStrtDayCnt,
			effStrtDate : effStrtDate,
			effDateType : effDateType,
			maxAmt : $("#maxAmt").val(),
			stmpYn : stmpYn,
			qpntTypeCd : $("#qpntTypeCd").val(),
			qpntAmt : $("#qpntAmt").val(),
			tiersYn : tierBnftYn, 
			rid   : promActRid
			
	};
	
	var promotionActionInfo = $("#promotionActionInfoForm").ifvValidation();
	requestData.effStrtDate=$("#effStrtDate").val();
	if(promotionActionInfo.confirm()) {
	
	//varData.tgtGrpCntrlRid = tgtGrpCntrlRid;
	$.ifvSyncPostJSON('<ifvm:action name="savePromotionAction"/>', requestData
			, function(result) {
				if ($.fn.ifvmIsNotEmpty(result)) {
					
					/* promKpiRid = result.message; */
					alert("<spring:message code="C00094" />");
					closeActionPop();
				}
			}, function(result) {
				alert("<spring:message code="M02248" />");
			});
	}
}

function actionFlexMinusBtn() {
	if( $('.tiersGridList').length == 1){
        $('.itemMinusfirst').hide();
    }else{
        $('.itemMinusfirst').show();
    }
}

function actionPromInfoData() {
	
	$.ifvSyncPostJSON('<ifvm:action name="getPromInfo"/>', {
    	promRid: campaign.id
    },
    function(result) {
    	if ($.fn.ifvmIsNotEmpty(result)){
        	cpnYn = result.cpnYn;
        }
    });
}

function actionPopupData() {
	$.ifvSyncPostJSON('<ifvm:action name="getPromActionInfo"/>', {
    	promRid: campaign.id
    },
    function(result) {
    	if ($.fn.ifvmIsNotEmpty(result)){
        	 promActRid = result.rid;
        	 //cpnYn = result.cpnYn;
        	 $("#effStrtDate").val(result.effStrtDate);
        	 tgtGrpActionRid = result.tgtGrpActionRid;
        	 if(result.tiersYn=='Y'){
         		$("input:radio[id='tierBnftYn']").attr("checked", true);
         	} else {
         		$("input:radio[id='allYn']").attr("checked", true);
         	}
        	 
        	 
        	if(result.tiersYn=='N') {
        		 seqNo = 1;
        		 $("#tierList").empty();
        		 var temp = $("#ActionAllDefaultTemp").tmpl(seqNo);
        		 $("#tierList").append(temp);
        		 $.fn.ifvmSetSelectOptionCommCode("ofrAmtType"+seqNo, "PROM_ACT_AMT_TYPE", null, null, false);
        		 $("#ofrAmt"+seqNo).val(result.promotionTierAction[0].ofrAmt);
        		 $("#ofrAmtType"+seqNo).val(result.promotionTierAction[0].ofrAmtType);
        		 $("#promActTierRid"+seqNo).val(result.promotionTierAction[0].rid);
        		 $("#promActionTierRid"+seqNo).val(result.promotionTierAction[0].rid);
        		 if(result.cpnYn=='Y') {
              		 $("#info21").text("개");
              	 } else {
              		 if(result.promotionTierAction[0].ofrAmtType=='RATE') $("#info21").text("%");
              		 else if(result.promotionTierAction[0].ofrAmtType=='AMT') $("#info21").text("P");
              		 else if(result.promotionTierAction[0].ofrAmtType=='RULE') $("#info21").text("%");
              	 } 
        	}
        	
        	else {
        	$("#tiersGridListAllList").remove();	
        	if(result.promotionTierAction.length>0) {
        	for(var i=0;i<result.promotionTierAction.length;i++) {
    			
        		if(result.promotionTierAction[i].seqNo>=2) {
        			seqNo = result.promotionTierAction[i].seqNo;
        			var temp = $("#ActionOfferTemp").tmpl(seqNo);
                    $("#tierList").append(temp);
             	    $.fn.ifvmSetSelectOptionCommCode("ofrAmtType"+seqNo, "PROM_ACT_AMT_TYPE", null, null, false);
        		}
        		
        		$("#promActTierRid"+result.promotionTierAction[i].seqNo).val(result.promotionTierAction[i].rid);
                $("#tierGroupRid"+result.promotionTierAction[i].seqNo).val(result.promotionTierAction[i].tierGroupRid);
                $("#tierRid"+result.promotionTierAction[i].seqNo).val(result.promotionTierAction[i].tierRid);
                $("#tierGroup"+result.promotionTierAction[i].seqNo).val(result.promotionTierAction[i].tierGrpNm);
                $("#tierTypeCd"+result.promotionTierAction[i].seqNo).val(result.promotionTierAction[i].tierNm); //result.promotionTierAction[i].tierTypeCd -> result.promotionTierAction[i].tierNm
                $("#ofrAmtType"+result.promotionTierAction[i].seqNo).val(result.promotionTierAction[i].ofrAmtType);
                $("#ofrAmt"+result.promotionTierAction[i].seqNo).val(result.promotionTierAction[i].ofrAmt);
                $("#ofrAmt"+result.promotionTierAction[i].seqNo).val(result.promotionTierAction[i].ofrAmt);
                $("#promActionTierRid"+result.promotionTierAction[i].seqNo).val(result.promotionTierAction[i].rid); 
                
                if(result.cpnYn=='Y') {
             		 $("#info2"+result.promotionTierAction[i].seqNo).text("개");
             	 } else {
             		 if(result.promotionTierAction[i].ofrAmtType=='RATE') $("#info2"+result.promotionTierAction[i].seqNo).text("%");
             		 else if(result.promotionTierAction[i].ofrAmtType=='AMT') $("#info2"+result.promotionTierAction[i].seqNo).text("P");
             		 else if(result.promotionTierAction[i].ofrAmtType=='RULE') $("#info2"+result.promotionTierAction[i].seqNo).text("%");
             	 } 
        		}
        	  }
        	}
        	if(result.stmpYn=='Y'){
        		$("input:checkbox[id='stmpYn']").attr("checked", true);
        	}
        	
        	if(result.effDateType == 'D'){
        		$("input:radio[id='effStrtDirectYn']").attr("checked", true);
        	} else if(result.effDateType == 'A') {
        		$("input:radio[id='effStrtDateCntYn']").attr("checked", true);
        		$("#effStrtDateCnt").val(result.effStrtDayCnt);
        	} else if(result.effDateType == 'P') {
        		$("input:radio[id='effStrtDateYn']").attr("checked", true);
        		$("#effStrtDate").val(result.effStrtDate);
        	}
        	
        	$("#promotionActionInfoForm").dataSetting(result);
        	$("#maxAmt").val(result.maxAmt);
        	promKpiRid = result.rid;
        	tgtGrpCntrlRid = result.tgtGrpCntrlRid;

        }
    	if(cpnYn=='Y') {
     		 $("#info21").text("개");
     	 } 
    });
	

}


function ActionMinusBtn() {
	if( $('.tiersGridList').length == 1){
        $('#itemMinusfirst').hide();
    }else{
        $('#itemMinusfirst').show();
    }
}

$("#ofrAmtType").click(function(){
	  
	});

//달력
function setChannelCalendar() {
    var effStrtDate = $("#effStrtDate");

    effStrtDate.ifvDateChecker({});
}

function actionTierRemove() {
	if( confirm('<spring:message code="유형 변경시 기존 ACTION 등급데이터는 삭제됩니다. 변경하시겠습니까?"/>') == true ){
		
		$.ifvSyncPostJSON('<ifvm:action name="removeActionTierItem"/>', {
            promRid		     : campaign.id
        },
        function(result) {
        	tierBnftYn='Y';
			seqNo =  1;
			$("#tierList").empty();
			var temp = $("#ActionDefaultTemp").tmpl(seqNo);
		    $("#tierList").append(temp);
		    $("#promActionTierRid"+seqNo).val('');
			$.fn.ifvmSetSelectOptionCommCode("ofrAmtType"+seqNo, "PROM_ACT_AMT_TYPE", null, null, false);
			if(cpnYn=='Y') {	
				$("#info2"+seqNo).text("개");
		 	 }
        });
	} else {
		$("input:radio[id='allYn']").attr("checked", true);
	}
}

function actionTierBnftRemove() {
	if( confirm('<spring:message code="유형 변경시 기존 ACTION 등급데이터는 삭제됩니다. 변경하시겠습니까?"/>') == true ){
		
		$.ifvSyncPostJSON('<ifvm:action name="removeActionTierItem"/>', {
            promRid		     : campaign.id
        },
        function(result) {
        	tierBnftYn='N';
			seqNo =  1;
			$("#tierList").empty();
			var temp = $("#ActionAllDefaultTemp").tmpl(seqNo);
			$("#tierList").append(temp);
		    $("#promActionTierRid"+seqNo).val('');
			$.fn.ifvmSetSelectOptionCommCode("ofrAmtType"+seqNo, "PROM_ACT_AMT_TYPE", null, null, false);
			if(cpnYn=='Y') {	
				$("#info2"+seqNo).text("개");
		 	 }
        });
	} else {
		$("input:radio[id='tierBnftYn']").attr("checked", true);
	}
}



$(document).ready(function () {	
	
	setChannelCalendar();
	
	actionPopupInit();	
	
	actionPromInfoData();
	
	actionPopupData();
	
	ActionMinusBtn();
	
	$("#tierBnftYn").change(function(){
		if($("#tierBnftYn").is(":checked")){
			actionTierRemove();		
        }
    }); 
	
	$("#allYn").change(function(){
		if($("#allYn").is(":checked")){
			actionTierBnftRemove();
        }
    }); 
	
	 //저장 클릭시
    $('#promotionActionSaveBtn').on('click', function(){
    	promotionActionSave();
    });
	 
  //취소 클릭시
    $('#promotionActionCancle').on('click', function(){
        closeActionPop();
    });
  
    $("#tgtGrpActionPopBtn").click(function(){
    	tgtGrpActionPopup();
	});
    
    $("#ofrAmtType1").change(function(){
    	ofrValTypeChange("ofrAmtType1");
	});
    
    promStatCheck();
});

</script>