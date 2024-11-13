<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="form-horizontal underline top_well underline" >
	<br>
	<div class="col-xs-9"></div>
	<div class="col-xs-3">
		<ifvm:inputNew type="text" id="totalScore" label="L02227" labelClass="4" className="text-center" conClass="7" disabled="true"/>
	</div>
</div>
<div id="dupRstDetail" style="padding: 30px 20px;" class="white_bg grid_bd0"></div>
<div class="page_btn_area">
	<div class="searchbtn_r" style="text-align : center;">
		<button class="btn btn-sm" id="closePopBtn" objCode="">
			<spring:message code="L00941" />
		</button>
	</div>
</div>
<style>
td {
     border: 1px black solid;
     width: 10%;
     padding: 10px;
     text-align : center;
}
#hCell{
	background-color : lightgray;
}
</style>

<script type="text/javascript">
var table =$('<table>');
var cellHeader = ["비교필드", "대상고객", "유사고객", "점수"];
var fieldValCd = [], fieldValNm=[];
var data = null;
var tgt ="", similr = "";

function makeForm(){
	//모든 식별값 가져오기
	getFieldVal();
	//종복결과에대한 체크 결과 가져오기
	getDupRstDetail();
	//결과 헤더
	header();
	//회원번호
	getCustNo(data);
	//식별값에대한 결과
	body(data);
	//테이블 만들기
	$('#dupRstDetail').append(table);
	//총점수
	sumTotalScore();
}

function getDupRstDetail(){
	$.ifvSyncPostJSON('<ifvm:action name="getDupRstDetail"/>', 
			{rid : dupResultRid,  ridCustDi : custDiRid, custCd : realCustCd}, 
			function(result){data = result.rows;});
	//$("#totalScore").val(data[0].totalScore);
}

function header(){
	table +='<tr>';
	for(var i = 0; i < cellHeader.length; i++){
		table+='<td id="hCell" >'+cellHeader[i]+'</td>';
	}
	table +='</tr>'
}

function getCustNo(data){
	table +='<tr>';
		table+='<td id="cnCell" ><spring:message code="L00690"/></td>';
		table+='<td id="cnCell" >'+data[0].tgtCustNo+'</td>';
		table+='<td id="cnCell" >'+data[0].similrCustNo+'</td>';
		table+='<td id="cnCell" > </td>';
	table +='</tr>'
}

function body(data){
	for(var i=0;i<data.length; i++){
		if(fieldValNm.includes(data[i].field)){
			table +='<tr>';
			table+='<td id="bCell" >'+data[i].field+'</td>';
			if(data[i].fieldCd == 'SNS' || data[i].fieldCd == 'CI' ){ tgt = data[i].tgtCertVal; similr = data[i].similrCertVal; }
			else if(data[i].fieldCd == 'NM_HAN')	{ tgt = data[i].tgtCustNm; similr = data[i].similrCustNm; }
			else if(data[i].fieldCd == 'NM_ENG')	{ tgt = data[i].tgtCustNmAdd; similr = data[i].similrCustNmAdd; }
			else if(data[i].fieldCd == 'BIRTHDT'){ tgt =data[i].tgtBirthday; similr = data[i].similrBirthday; }
			else if(data[i].fieldCd == 'GEN')	{ tgt = data[i].tgtGen;	similr	 = data[i].similrGen; }
			else if(data[i].fieldCd == 'HHP')		{ tgt = data[i].tgtHhp;	similr	 = data[i].similrHhp; }
			else if(data[i].fieldCd == 'EMAIL')	{ tgt = data[i].tgtEmail; similr = data[i].similrEmail; }
			else if(data[i].fieldCd == 'BIZR_NO'){ tgt = data[i].tgtBizrNo; similr	= data[i].similrBizrNo; }
			else if(data[i].fieldCd == 'JUR_NO') { tgt = data[i].tgtJurNo; similr = data[i].similrJurNo; }
			else if(data[i].fieldCd == 'GRP_NO'){ tgt = data[i].tgtTelNo; similr = data[i].similrTelNo; }
			setScore(tgt, similr, i);
			table +='</tr>'
		}
	}
}
function setScore(tgt, similr, i){
	if(tgt == null){ tgt =""}
	if(similr == null){ similr = ""}
	table+='<td id="bCell'+1+'" >'+tgt+'</td>';
	table+='<td id="bCell'+2+'" >'+similr+'</td>';
	if(tgt == similr && tgt != ""){
		table+='<td id="bCell'+3+'" class="score" >'+data[i].score+'</td>';
	}else{
		table+='<td id="bCell'+3+'" class="score"> 0 </td>';
	}
}

function getFieldVal(){
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{ groupCode : 'LOY_CUST_DI_TYPE_CD'}, function(result){
		var val = result.rows;
		//for(var i=0; i<val.length;i++){fieldValCd[i] = val[i].codeName;}
		for(var i=0; i<val.length;i++){fieldValNm[i] = val[i].markName;}
	});
}

function sumTotalScore(){
	var sum =0;
	for(var i=0;i<$("#dupRstDetail .score").length; i++){sum +=Number($("#dupRstDetail .score")[i].innerHTML)}
	$("#totalScore").val(sum);
}


$(document).ready(function(){
	
	makeForm();
	
	$("#closePopBtn").click(function(){
		getDupResultPopupClose();
	}); 
});
</script>