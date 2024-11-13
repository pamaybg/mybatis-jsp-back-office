<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="pop_inner_wrap">
	<div class="form-horizontal underline" id="mbrGroupUserPopWrap">
		<div class="form-horizontal top_well">
			<div class="row">
				<ifvm:inputNew type="search" id="mbrNo|mbrNoBtn"   dto="mbrNo"	btnFunc="mbrSearchHelpPop.pop"	required="true"
							label="L00835" labelClass="2" conClass="2" /><!-- 회원명-->
				<ifvm:inputNew type="text" id="custNm" dto="custNm"    labelClass="2" conClass="4" disabled="true"/>
				<ifvm:inputNew type="hidden" id="ridMbr"   dto="ridMbr" /><!-- 회원 rid -->
			</div>
			<script>
				mbrSearchHelpPop = {
					id : "searchMbrPop",
					pop : function(){
						$("#"+this.id).ifvsfPopup({
				            enableModal : true,
				            enableResize : false,
				            contentUrl : '<ifvm:url name="mbrSearchHelp"/>',
				            contentType : "ajax",
				            title : '<spring:message code="L00988"/>', // 회원 찾기
				            width : '700px'
				        });
					},
					beforeClose : function(obj){
						console.log(obj);
						$("#mbrGroupUserPopWrap #mbrNo").val(obj.mbrNo);
						$("#mbrGroupUserPopWrap #custNm").val(obj.custNm);
						$("#mbrGroupUserPopWrap #ridMbr").val(obj.rid);

					},
					close: function(obj){
						if(obj){
							this.beforeClose(obj)
						}
						var _popObj = eval(this.id)
						_popObj._destroy();
					}
				}
			</script>
			<div class="row">
				<ifvm:inputNew type="text" id="regDt"   dto="regDt"	disabled="true"
					label="L01507" labelClass="2" conClass="2" /><!-- 가입일시-->
				<ifvm:inputNew type="text" id="delDt"   dto="delDt"	disabled="true"
					label="L01508" labelClass="2" conClass="2" /><!-- 탈퇴일시-->
				<ifvm:inputNew type="select" id="activeFlg"   dto="activeFlg"	disabled="true"
					label="L01509" labelClass="2" conClass="2" /><!-- 탈퇴여부-->
			</div>

		</div>
	</div>
</div>
<div class="pop_btn_area">
    <ifvm:inputNew type="button" text="L00817" btnFunc="addMbrGroupUser" className="btn_lightGray2" objCode="addMbrGroupaddMbrGroupUser_OBJ"/>
    <ifvm:inputNew type="button" text="L00073" btnFunc="addMbrGroupUserPopup.close" className="btn_lightGray2" objCode="MbrGroupUserPopup_OBJ"/>
</div>
<div id="searchMbrPop" class="popup_container"></div><!--검색-->
<script>
$.ifvGetCommCodeList('select', 'activeFlg', '<ifvm:action name="getCommCodeList2"/>', 'YES_NO_FLAG', 'loy', false, false, true);
$("#mbrGroupUserPopWrap #activeFlg").val("N");
$("#mbrGroupUserPopWrap #regDt").val($.ifvGetTodayDate('-'));
function addMbrGroupUser(){
	var vali = $("#mbrGroupUserPopWrap").ifvValidation();
	if(vali.confirm() == true){
		var dataObj = $("#mbrGroupUserPopWrap").getSubmitData();
		dataObj.ridChnl = gGroupDetail.data.chnlRid
		console.log(dataObj);
		var action = '<ifvm:action name="addMbrGroupUser"/>';
		$.ifvSyncPostJSON(action, dataObj, function(result) {

			if(result.success){
				msg ='<spring:message code="L01257"/>'
				alert(msg);
				addMbrGroupUserPopup.close(result);
			}

		}, function(result){
			alert(result.message);
		})
	}
}

</script>