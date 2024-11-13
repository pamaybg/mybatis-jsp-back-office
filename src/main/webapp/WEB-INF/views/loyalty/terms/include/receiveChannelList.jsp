<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="L02687"/></span>
	</div>
	<div class="col-sm-5 searchbtn_r">
        <ifvm:inputNew type="button" btnType="plus" id="addNewRcvChnl"  text="V00002" objCode="addNewRcvChnl_OBJ"/>
        <ifvm:inputNew type="button" btnType="minus" id="delRcvChnl"  text="L00029" objCode="delRcvChnl_OBJ"/>
	</div>
</div>
<div id="termsRcvChnlLisrGrid"></div>
<div id="termsRcvChnlPopupContainer" class="popup_container"></div>

<script type="text/javascript">
var rcvChnlList;
var parRid = $.ifvGetParam('rid');
var chnlRid;
function getRcvChnlList(){
	var ejGridOption ={
			recordDoubleClick : function(args){
				var data = args.data;
				chnlRid = data.rid;
				getRcvChnlPop(chnlRid);
			},serializeGridData : function(data) {
				data.rid = parRid;
				return data;
			},rowSelected : function (args) {
				var data = args.data;
				chnlRid = data.rid;
        	},
			dataUrl : '<ifvm:action name="getTermsRcvChnl"/>',
			columns : [
				 { 
					 field : 'rid', headerText : 'rid', visible : false
				}, {
					field : 'seqNo', headerText : '<spring:message code="M00240"/>',textAlign : 'center',  customAttributes :{searchable : true}
				},{
					field : 'mktRcvChnlCdNm', headerText : '<spring:message code="L02600"/>',  textAlign : 'center', customAttributes : { index : 'mktRcvChnlCd'}
				},	{
					field : 'startDate', headerText : '<spring:message code="L00153"/>', textAlign : 'center'
				},	{
					field : 'useYn', headerText : '<spring:message code="M02513"/>',  textAlign : 'center', customAttributes : { index : 'useYnCd'}
				}, {
					field : 'createBy', headerText : '<spring:message code="M00221"/>', textAlign : 'center'
				},{
					field : 'createDate', headerText : '<spring:message code="M00222"/>', textAlign : 'center'
				}],
				requestGridData : {
					nd : new Date().getTime(),
					rows : 10,
					sidx : '2',
					sord : 'asc',
					_search : false
				},
				rowList : [10, 25, 50, 100],
				radio : true,
	};
	
	rcvChnlList = $("#termsRcvChnlLisrGrid").ifvsfGrid({ejGridOption : ejGridOption});
}

function getRcvChnlPop(chnlRid){
	$("#termsRcvChnlPopupContainer").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="termsRcvChnlPop"/>'+ '?chnlRid=' + chnlRid, 
        contentType: "ajax",
        title: '<spring:message code="L02691"/>',
        width: 700,
        close : 'termsRcvChnlPopupClose',
    	open : function(){
    		new ifvm.PopupCenter({
        		popupDivId : 'popupContainer'
        	})
        }
    });
}

function termsRcvChnlPopupClose() {
	termsRcvChnlPopupContainer._destroy();
} 

function removeRcvChnl(){
    // 삭제하시겠습니까?
    if (confirm('<spring:message code="M01053"/>')) {
        
        $.ifvSyncPostJSON('<ifvm:action name="removeTermsRcvChnl"/>',{
            parRid : parRid,
            rid : chnlRid,
        },
        function(result) {
            alert('<spring:message code="M00003"/>');
            chnlRid = null;
            rcvChnlList._doAjax();
        });
    }

}

$(document).ready(function(){
	getRcvChnlList();
	//신규
	$("#addNewRcvChnl").click(function(){
		if(parRid == null){
			alert('<spring:message code="C00171"/>');
		}else{
			chnlRid = null;
			getRcvChnlPop();
		}
	});
	//삭제
	$("#delRcvChnl").click(function(){
		if(chnlRid == null){
			alert('<spring:message code="M00499"/>');
		}else{
			if(realStatCd == 'W'){
				removeRcvChnl();
			}else{
				alert('<spring:message code="M02941"/>');
			}
		}
	});

});
</script>