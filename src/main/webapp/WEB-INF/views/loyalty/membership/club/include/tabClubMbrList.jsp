<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var ridClubMbr;
var clubMbrGridList;

$(document).ready(function(){
	getTabMemberList();
	$("#addClubMbrBtn").on("click",function(){
		addClubMbrFn();
	});


	$("#trmnteClubMbrBtn").on("click",function(){
		if($.fn.ifvmIsNotEmpty(clubMbrGridList.getCheckedGridData()[0])){
			trmntClubMbrFn();
		}else{
			alert("<spring:message code='L01820'/>");
		}

	});
});

function addClubMbrFn(){
	var url = '<ifvm:url name="clubMbrPop"/>' + '?rid=' + clubTypeRid;
	var obj = {
			url : url,
			width : 600,
			title : '클럽 가입'
	}
	clubMbrPopupOpen(obj);
}

function trmntClubMbrFn(){
	var url = '<ifvm:url name="clubMbrTrmntPop"/>' + '?ridClubMbr=' + ridClubMbr;
	var obj = {
			url : url,
			width : 600,
			title : '클럽 탈퇴'
	}
	clubMbrPopupOpen(obj);
}

function clubMbrPopupOpen(obj){
	$("#clubMbrPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: obj.url,
        contentType: "ajax",
        width: obj.width,
        title: obj.title,
        close : 'clubMbrPopClose'
    });
}

function clubMbrPopClose(){
	clubMbrPop._destroy();
}

function getTabMemberList(){

	var jqGridOption = {
			serializeGridData : function( data ){
	        	data.ridClub			=  clubTypeRid;
	            return data;
	       	},
	        onSelectRow : function (data) {
	        	ridClubMbr = data.rid;
	       	},
			url: '<ifvm:action name="getTabMemberList"/>',
		    colNames:[
					  '회원번호',
					  '회원명',
					  '등급명',
					  '상태',
		              '가입일',
		              '해지일',
		              '변경자',
		              '변경일시',
		              'rid',
		              'ridTier',
	        ],
		    colModel:[
				{ name:'mbrNo', 			index:'lm.mbr_no', 		width:'100px', 	align: 'center', 	resizable : true ,sortable:false},
				{ name:'custNm', 			index:'lm.MBR_HID_NM', 		width:'100px', 	align: 'center', 	resizable : true ,sortable:false},
				{ name:'tierNm', 			index:'lct.TIER_NM', 		width:'100px', 	align: 'center', 	resizable : true ,sortable:false},
				{ name:'clubStatNm', 		index:'cc1.MAR_NAME', 		width:'100px', 	align: 'center', 	resizable : true ,sortable:false},
	            { name:'clubJoinDate', 		index:'lcm.CLUB_JOIN_DATE', 	width:'100px', 	align: 'center',   	resizable : true  ,sortable:false,formatter:'date', formatoptions:{newformat:"Y-m-d"}  },
	            { name:'clubCnclDate',		index:'lcm.CLUB_CNCL_DATE',	width:'100px', 	align: 'center', 		resizable : true  ,sortable:false ,formatter:'date', formatoptions:{newformat:"Y-m-d"}  },
	            { name:'modifyBy', 			index:'lcm.modify_by', 		width:'100px', 	align: 'center', 	resizable : true  ,sortable:false},
	            { name:'modifyDate',    	index:'lcm.modify_date',  width:'100px', 	align: 'center', 		resizable : true  ,sortable:false},
	            { name:'rid',    			index:'lcm.rid', hidden:true},
	            { name:'ridTier',    		index:'lcm.RID_TIER', hidden:true}
		    ],
		    sortname: 'lcm.modify_date',
		    sortorder: "desc",
		    radio: true,

		   /*  tempId : 'ifvGridSimpleTemplete'	//각 페이지 별로 다른 템플릿을 쓰고 싶을 때 */
		};
		clubMbrGridList = $("#chnlMemberListGrid").ifvGrid({ jqGridOption : jqGridOption });
}

</script>

<div class="page_btn_area" >
       <div class="col-xs-7">
       </div>
       <div class="col-xs-5 searchbtn_r">
           <button class="btn btn-sm" id="addClubMbrBtn"><i class="fa fa-plus"></i>
           		<spring:message code="L00078"/></button>
           <button class="btn btn-sm" id="trmnteClubMbrBtn"> <i class="fa fa-minus"></i>
               	탈퇴
           </button>
       </div>
</div>
<div id="chnlMemberListGrid" class="content grid_container"></div>

<div id="clubMbrPop" class="popup_container content_container"></div>
