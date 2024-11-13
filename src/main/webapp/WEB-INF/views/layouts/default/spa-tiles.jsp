<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles"       prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script>

//Dynamic 검색영역에서 사용하는 공통변수 초기화 
requestitem = [];
var pgmObject = [];
<c:forEach items="${pgmChild}" var="info2">
var json = new Object();
json.pgmRid="${info2.pgmRid}";
json.url="${info2.url}";
json.labeNm="${info2.tabLabelNm}";
pgmObject.push(json);
</c:forEach>
if(pgmObject.length>0) {
	var items = [];
}
for(var i=0;i<pgmObject.length;i++) {
	var arr = "/"+pgmObject[i].url.replace(".jsp","");
	var rowData = {
			label : pgmObject[i].labeNm,
			href : arr,
			tabid : arr,
	};
	items.push(rowData);
}

function fnSpaAuth() {
	var nurl = '<tiles:getAsString name="content"/>';
	var uid = '<tiles:getAsString name="uid"/>';

	
	nurl = nurl.replace("/WEB-INF/views//", "");
	nurl = nurl.replace("/WEB-INF/views/", "");
	var authInfo = $.ifvmGetAuthInfo();
	
	$.each (authInfo.authObjList, function(index, obj) {
		//해당 페이지의 오브젝트의 표시 여부 설정
		if (nurl == obj.progPath) {
			//숨김
			if (obj.uiViewCd == "INVISIBLE") {
				$("#" + uid + " [objCode=" + obj.objCd + "]").hide();
			}
			//비활성
			else if (obj.uiViewCd == "DISABLE") {
				 if(obj.objCd == "SRCH" || obj.objCd == "ADRESS" || obj.objCd == "SRCH_APP" || obj.objCd == "SRCH_DEVICE" || obj.objCd == "SRCH_COUPON" || obj.objCd == "SRCH_IMAGE" || obj.objCd == "SRCH_TEMPLATE" || obj.objCd == "SRCH_MAP" || obj.objCd == "SRCH_ASSIGN" || obj.objCd == "SRCH_STAMP" || obj.objCd == "SRCH_PATH" || obj.objCd == "SRCH_APPLY_STORE"){
					if($("#" + uid + " [objCode=" + obj.objCd + "]>a") == undefined){
						$("#" + uid + " [objCode=" + obj.objCd + "]").attr('disabled','disabled');
					}
					else{
						$("#" + uid + " [objCode=" + obj.objCd + "]>a").attr('data-target','#');
						$("#" + uid + " [objCode=" + obj.objCd + "]>a").removeAttr('href');
						$("#" + uid + " [objCode=" + obj.objCd + "]").removeAttr('onCLick');

						 if(obj.objCd=="SRCH_IMAGE"){
								$("#" + uid + " [objCode=" + obj.objCd + "]").removeAttr('type','#');
						 }
					}
				}
				else{
					$("#" + uid + " [objCode=" + obj.objCd + "]").attr('disabled','disabled');
				}
			}
		}
	});
}

function fnSpaAuthObject() {
	var authObject = [];
	<c:forEach items="${pgmObject}" var="info">
		var json = new Object();
		json.progRid="${info.progRid}";
		json.progPath="${info.progPath}";
		json.objCd="${info.objCd}";
		authObject.push(json);
	</c:forEach>
	
	

	for(var i=0; i<$('.btn').length; i++) {
		for(var j=0; j<authObject.length; j++) {
			if($($('.btn')[i]).attr('data-objauth') != "true") {
				if($($('.btn')[i]).attr('objcode') == authObject[j].objCd) {
					$($('.btn')[i]).attr('data-objauth', 'true')
					break;
				} else {
					$($('.btn')[i]).attr('data-objauth', 'false') 
				}
			}
		}
	}
	
	for (var i=0; i<$('.tab-list li').length; i++) {
		for(var j=0; j<pgmObject.length; j++) {
			var arr = $($('.tab-list li')[i]).children('a').attr('href').split('/');
			var pageName = arr[arr.length-1]
			
			if(pgmObject[j].url.indexOf(pageName) > -1) {
				$($('.tab-list li')[i]).show();
			}
		}
	}
	
	tabcheck();
	
	
	
	$('[data-objauth=false]').remove();
	$('[data-objauth=true]').show();
}

function tabcheck(){
	$(".tab-list").attr("visible","false");
	$(".tab-list li").each(function(){
		if($(this).is(":visible")){
			$(this).parent(".tab-list").attr("visible","true");
		}
	})
	$(".tab-list").each(function(){
		if($(this).attr("visible")=="false"){
			$(this).hide();
			$(this).parent().parent().siblings(".tab-contents").hide();
		}
	})
}

</script>
<div id='<tiles:getAsString name="uid"/>'>
	<tiles:insertAttribute name="content" />
</div>

<script>
$(document).ready(function(){
	fnSpaAuth();
	fnSpaAuthObject();
});
</script>


