<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="form-horizontal top_well underline" id="clubMbrDetail">
<br>
	<div class="row">
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="V00005"/></label>
		<div class="col-xs-8">
			<div class="input-group">
				<ifvm:inputNew type="search" id="custNm" names="custNm" required="true"  btnFunc="getMbrListPop"/>
				<input type="hidden" id="mbrRid" name="mbrRid" disabled="true" required="true"/>
			</div>
		</div>
		<!-- <span class="input-group-addon" style="padding : 4px;"  id="mbrList">
			<a><i class="fa fa-search"></i></a>
		</span> -->
	</div>
	<br>
	<div id="tmpPanel" class="tmpPanel"></div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="saveMbrBtn" objCode="clubMbrDetailSave_OBJ">
		<spring:message code="M01855" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="cancelMbrBtn" objCode="clubMbrDetailCancel_OBJ">
		<spring:message code="I00404" />
	</button>
</div>
<div id="mbrPopContainer" class="popup_container"></div>

<style>
   .helpBtn {
      background-image: url("/resources/images/icons/btn_help.png");
      background-repeat:no-repeat;
       background-position:center center;
       padding-left: 30px;
       vertical-align: middle;
       width: 17px;
       height: 17px;
       line-height: 17px;
   }
</style>

<!-- checkbox and radio -->
<script id="createInputCR" type="text/x-jquery-tmpl">
<label class="control-label col-xs-2">\${val} <input id="\${rid}" type="\${fieldTypeCdNm}" value="" name="\${code}"/></label>
</script>

<!-- text, date, etc... -->
<script id="createInputNomal" type="text/x-jquery-tmpl">
{{if fieldTypeCdNm == 'DATE' }}
<div class="smart-form">
	<div class="input">
		<input id="\${rid}" class="text-right " type="\${fieldTypeCdNm}" style="width : 100%;"  required="\${reqYn}" />
	</div>
</div>	
{{else [fieldTypeCdNm == 'TEXT']}}
	<input id="\${rid}" type="\${fieldTypeCdNm}"  style="width : 100%;"  required="\${reqYn}"/>
{{else}}
	<input id="\${rid}" type="\${fieldTypeCdNm}" val=""  required="\${reqYn}"/>
{{/if}}
</script>

<!-- file template -->
<script id="createInputFile" type="text/x-jquery-tmpl">
	<input id="\${rid}" type="\${fieldTypeCdNm}"  onchange="fileUpload(this)" name="fileName"/>
	<input id="fileNameText" type="text" class="text-right" style="width : 85%;" required="\${reqYn}" disabled="true"/>
		<button class="ifv_search_box_search_btn" id="btnSearch" >
			<spring:message code="M00203"/>     
       	</button>
</script>

<!-- base template -->
<script id="createInputTemplate" type="text/x-jquery-tmpl">
<div class="row" id="\${uniqCode}">
	<label class="col-xs-2 control-label"><span class="mainLabel"></span>\${uniqCodeNm}</label>
	<div class="col-xs-8 control_content">
		<div class="input-group select">
		</div>
	</div>
</div>
</script>

<script id="asterTmpl" type="text/x-jquery-tmpl">
<span class="asterisk">*</span>
</script>

<script type="text/javascript">
var arrCode = new Array(), realData = new Array(), arrCodeNm = new Array();
var attrMeta, dataList;
var attMbrList ={};
var fnT = "";
var ridClubMbr;
function createInputBox(){
	if (typeof clubMbrRid === 'undefined' || clubMbrRid == null) {
		isNew = true;	
		$("#custNm").val("");
		$("#mbrRid").val("");
	}

	else
		isNew = false;

		$.ifvSyncPostJSON('<ifvm:action name="getClubAttrInMbr"/>',{
			rid : clubRid
		},function(result){
			if(result.rows.length>0){
				var data = result.rows;
				attrMeta = data;
				var Obj = {};
				//속성코드를 가져오기위한 for문
				for(var i=0; i<data.length; i++){
					arrCode.push(data[i].code); // IN, MA, DC, RE ....
					arrCodeNm.push(data[i].codeNm); // 관심분야, 결혼예정일, 증빙서류명, 거주형태 ....
				}
				//속성코드를 가져와 중복을 제거(1개의 속성에 1개의 타입만 올 수 있다)
				var uniqCode = arrCode.reduce(function(a,b){if(a.indexOf(b)<0)a.push(b);return a;},[]);
				var uniqCodeNm = arrCodeNm.reduce(function(a,b){if(a.indexOf(b)<0)a.push(b);return a;},[]);
				//중복 제거한 속성을 object 로 바꿔준다.
				for(var i=0; i<uniqCode.length; i++){
					Obj = {	'uniqCode' : uniqCode[i], 
								'uniqCodeNm' : uniqCodeNm[i]};
					realData.push(Obj);
				}
				//속성의 수에 따라 기본template을 그려준다.
				for(var i=0; i<uniqCode.length; i++){
					$("#createInputTemplate").tmpl(realData[i]).appendTo(".tmpPanel");				
				}
				for(var i=0; i<data.length; i++){
					if(data[i].fieldTypeCdNm ==="RADIO" || data[i].fieldTypeCdNm ==="CHECKBOX"){
						$("#createInputCR").tmpl(data[i]).appendTo("#"+data[i].code+" .input-group");
					}else if(data[i].fieldTypeCdNm ==="FILE"){
						if(data[i].reqYn == "Y"){
							$("#asterTmpl").tmpl(data[i]).appendTo("#"+data[i].code+" .mainLabel");
						}
						$("#createInputFile").tmpl(data[i]).appendTo("#"+data[i].code+" .input-group");
					}else{
						if(data[i].reqYn == "Y"){
							$("#asterTmpl").tmpl(data[i]).appendTo("#"+data[i].code+" .mainLabel");
						}
						$("#createInputNomal").tmpl(data[i]).appendTo("#"+data[i].code+" .input-group");
					}
				}
			}
		});
		
	 	if(!isNew){
			$.ifvSyncPostJSON('<ifvm:action name="getClubMbrDetail"/>',{
				rid : clubMbrRid,
				ridClub : clubRid
			},function(result){
				var data = result.rows;
				$("#mbrRid").val(data[0].ridMbr);
				$("#custNm").val(data[0].custNm);
				
				for(var i=0; i<data.length; i++){
					if(data[i].fieldTypeCd == 'F' || data[i].fieldTypeCd == 'I'){
						//추후개발
						//$("#"+data[i].ridAttr).val(data[i].fileName);
						$("#fileNameText").val(data[i].fileName);
					}else if (data[i].fieldTypeCd == 'C' || data[i].fieldTypeCd == 'R'){
						if(data[i].val == 'Y') $("#"+data[i].ridAttr).attr("checked",true);
						else $("#"+data[i].ridAttr).attr("checked",false);
					}else {
						$("#"+data[i].ridAttr).val(data[i].val);
					}
				}
			});
		} 
}

function getMbrListPop(){
	$("#mbrPopContainer").ifvsfPopup({
		enableModal : true,
		enableResize: false,
		contentUrl: '<ifvm:url name="mbrListPop"/>',
		contentType: "ajax",
        title: '<spring:message code="L01673"/>',
        width: 900,
        close : 'mbrPopupClose',
    	open : function(){
    		new ifvm.PopupCenter({
        		popupDivId : 'popupContainer'
        	});
        }		
	});
}

function mbrPopupClose() {
	mbrPopContainer._destroy();
} 

var getClubMbrDetail={
		init : function(){	
			//초기 inputbox 만들기
			createInputBox();
			
		}, 
		save : function(){
			var validation = $("#clubMbrDetail").ifvValidation();
			if( validation.confirm() == false ) return;
			var checkVaild = validCkInputbox();
			if(checkVaild) {
				var tUrl = isNew? '<ifvm:action name="saveClubMbrDetail"/>' : '<ifvm:action name="modifyClubMbrDetail"/>';
				var tData = null;
				var stayFile = false;
				if($("input[type='file']")[0] == null || $("input[type='file']")[0].files[0] == undefined) stayFile = true;
				
				tData = {
					rid : clubMbrRid,
					ridClub : clubRid,
					ridMbr : $("#mbrRid").val(),
					mbrAttrList : dataList,
					/* array : dataList, */
					fileNameText : fnT,
					stayFile : stayFile
				};
				$.ifvSyncPostJSON(tUrl, tData
					, function(result) {
						if($("input[type='file']")[0] == null || $("input[type='file']")[0].files[0] == undefined){
							alert("<spring:message code="C00094"/>");
							clubMbrDetailPopupClose();
							getClubMbrList();
						}else{
							if(clubMbrRid  == null) clubMbrRid = result.rid;
							saveFile();
						}
					}, function(result) {
						if(result.message) alert(result.message);
						else alert('<spring:message code="M02248"/>');
				});
			}
		}
}

function saveFile(){
	var formData = new FormData();
	formData.append("clubMbrRid", clubMbrRid); 
	formData.append("ridAttr", $("input[type='file']")[0].id); 
	formData.append("file", $("input[type='file']")[0].files[0]); 
	$.ajax({
		url : '<ifvm:action name="clubMbrFileupload"/>',
		data :  formData,
		processData : false,
		contentType : false,
		type : 'POST',
		success : function(data) {
			if (!data.success) {
				if(data.message) alert(data.message);
				else alert('<spring:message code="M02248"/>');
			} else{
				alert("<spring:message code="C00094"/>");
				clubMbrDetailPopupClose();
				getClubMbrList();
			}
		}
	});
}

function validCkInputbox(){
	var inputCheck = true;
	//회원 여부 체크
	var mbrCheck = true;
	mbrCheck = mbrValidChk();
	
	if($("#fileNameText").val() != null){
		fnT = ($("#fileNameText").val()).toLowerCase();
	}
	
	if(mbrCheck){
		//속성 여부 체크
		if(attrMeta != null){
			dataList = new Array();
			for(var i = 0; i<attrMeta.length; i++){
				if(attrMeta[i].fieldTypeCd == 'C' || attrMeta[i].fieldTypeCd == 'R'){
					attMbrList = {
							ridAttr : attrMeta[i].rid,
							val : $("#"+attrMeta[i].rid+"").is(":checked") ? 'Y' :'N'
							/* rid : clubMbrRid,
							ridClub : clubRid,
							ridMbr : $("#mbrRid").val(),
							fileNameText : fnT */
					};
				}else if(attrMeta[i].fieldTypeCd == 'F'){
					var htmlFileName = $("#fileNameText").val();
					const fileEx = htmlFileName.slice(htmlFileName.indexOf(".") + 1).toLowerCase();
					
					if(fileEx != "jpg" && fileEx != "png" && fileEx != "jpeg" && fileEx != "gif"){
		                alert('<spring:message code="D10296"/>');
		                $("#"+attrMeta[i].rid).val("");
		                inputCheck = false;
		            }else{
		            	attMbrList = {
		    					ridAttr : attrMeta[i].rid,
		    					filePName : $("#fileNameText").val()
		    					/* rid : clubMbrRid,
								ridClub : clubRid,
								ridMbr : $("#mbrRid").val(),
								fileNameText : fnT */
		    			};
		            }
				}else{
					attMbrList = {
							ridAttr : attrMeta[i].rid,
							val : $("#"+attrMeta[i].rid+"").val()
							/* rid : clubMbrRid,
							ridClub : clubRid,
							ridMbr : $("#mbrRid").val(),
							fileNameText : fnT */
					};
				}

				
				dataList.push(attMbrList);
			}
		}
	}else{
		inputCheck = false;
	}
	return inputCheck;
}

function mbrValidChk(){
	var val = false;
	//기존 등록된 회원과 동일 회원 check
	$.ifvSyncPostJSON('<ifvm:action name="getClubMbrValidCheck"/>',{
			rid : clubMbrRid,
			ridClub : clubRid,
			ridMbr : $("#mbrRid").val()
	},function(result){
		val =  result.success;
	},function(result){
		val =  result.success;
		if(result.message) alert(result.message);
		else alert("<spring:message code="L02744"/>");
	});
	return val;
}

function fileUpload(file){
	var str = file.value;
	var fileValue = str.split("\\");
	var realFileName =  fileValue[fileValue.length-1];
	$("#fileNameText").val(realFileName.toLowerCase());
}

$(document).ready(function(){
	
	getClubMbrDetail.init();
	/* if(realStatCd == "C" || realStatCd == "W"){
		$("#saveMbrBtn").attr("disabled", true);
	} */
	//회원 팝업
	/* $("#mbrList").click(function(){
		getMbrListPop();
	}); */
	
	//클럽 회원 상세 저장
	$("#saveMbrBtn").click(function(){
		if(realStatCd == "C" || realStatCd == "W"){
			alert("반려 또는 탈퇴시 내용을 수정할수 없습니다.")
		}else{
			getClubMbrDetail.save();
		}
	});
	
	//클럽 회원 상세 닫기
	$("#cancelMbrBtn").click(function(){
		realStatCd = null;
		clubMbrDetailPopupClose();
	});
	
	//input file 여부 체크 
	if($("input[type='file']").length>0){
		var fileId = $("input[type='file']")[0].id;
		$("#"+fileId).hide();
	}
	
	//file button trigger
	$("#btnSearch").click(function(){
		$("#"+fileId).trigger("click");
	});

	//물음표 아이콘
	$('.helpBtn').setupHelpMessage();
	
});
</script>