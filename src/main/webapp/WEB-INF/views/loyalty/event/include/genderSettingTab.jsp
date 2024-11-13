<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="genderSetForm">
	<div class="page_btn_area" id=''>
    	<div class="col-sm-7">
			<span>조회 결과</span>    
    	</div>
    </div>
    <div class="col-sm-3 searchbtn_r">
    	<button class="btn btn-sm" id="genderAddBtn">
         	추가
        </button>
        <button class="btn btn-sm" id="genderModifyBtn">
         	수정
        </button>
    </div>
</div>
<div id="genderSettingGrid" class="white_bg grid_bd0"></div>

<script>

var genderSettingGrid;

function getGenderSettingList(){
	var ejGridOption = {
	      	serializeGridData : function( data ){
	      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
	      			data.item = requestitem;
	            }
	            return data;
	       	},
	       	rowSelected : function(args){
	       	},
	       	//dataUrl : '',
	        columns:[ 
	        	  {
		      		  field : 'rid', headerText : '', visible : false,
		      		  customAttributes : {
		      			  index : 'rid' }/* */
		      	  },{
		      		  field : 'gender', headerText : '성별',
		      		  customAttributes : {
		      			  index : 'gender'} /* 성별 */
		      	  },{
		      		  field : 'voteCnt', headerText : '회원번호', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {
		      			  index : 'voteCnt'} /* 회원번호 */
		      	  },{
		      		  field : 'value', headerText : '연령', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {
		      			  index : 'value'} /* 연령 */
		      	  }
	        ],
	        requestGridData : {
		      	  nd   : new Date().getTime(),
		      	  rows : 10,
		      	  sidx : '',
		      	  sord : '',
		      	  _search : false
		    },
		    rowList : [10,25,50,100],
	        autowidth : true ,
	        radio : true
	    };
	genderSettingGrid = $("#genderSettingGrid").ifvsfGrid({ ejGridOption : ejGridOption });
	
}

$(document).ready(function(){
	getGenderSettingList();
});
</script>