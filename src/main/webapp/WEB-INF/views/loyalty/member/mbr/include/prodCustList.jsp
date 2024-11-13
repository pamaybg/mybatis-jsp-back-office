<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/x-jsrender" id="ynTemplate">
	{{if uploadImgPath != null }}
		Y
	{{else}}
		N
	{{/if}}
</script>
<script type="text/javascript">
function prodCustListDetailFun(data){
    $.ifvSyncPostJSON('<ifvm:action name="prodCustListDetail"/>', {
        rid: data
    },
    function(result) {
        $('#buyChnl').val(result.purChnl); 		 // 구입채널
        //$('#itemCode').val(result.srcProdId);    // 아이템코드[살펴볼것**]
        $('#prodCode').val(result.prodNo);       // 자재코드
        $('#desc').val(result.content);
        $('#goodsCode').val(result.goodsCode);       // 자재코드
        
    });
}




function prodCustListFun(){
    var ejGridOption = {
        serializeGridData : function( data ){
                data.rid = mbr_rid;
                data.intRidMbr = mbr_rid;
                data.mbrStatCd = $("#mbrStatCd").val();
                 return data;
        },
        recordDoubleClick : function(args){
          var data = args.data.rid;
          prodCustListDetailFun(data);
        },
        rowSelected : function (args) {
            var data = args.data.rid;
            prodCustListDetailFun(data);
            $("#buyChnl").focus();

        },
        dataUrl : '<ifvm:action name="getProdCustList"/>',
        columns:[
        	  {
            	  field : 'reviewTypeCdName', headerText : '상품구분',width:'60px', headerTextAlign : 'center', textAlign: 'center', customAttributes : {index : 'reviewTypeCd', searchable : true}
              },
        	  {
            	  field : 'prodNo', headerText : '자재코드',width:'60px', headerTextAlign : 'center', textAlign: 'center', customAttributes : {index : 'T2.PROD_ID',searchable : true}
              },
          	  {
            	  field : 'goodsCode', headerText : '상품코드',width:'60px', headerTextAlign : 'center', textAlign: 'center', customAttributes : {index : 'lpx.GOODS_CODE',searchable : true}
              }
              ,{
                  field : 'prodNm', headerText : '상품명',width:'200px',textAlign : 'left', headerTextAlign : 'center',customAttributes : {index : 'T2.DESC1',searchable : true}
              }
              ,{
                  field : 'subject', headerText : '제목',width:'230px',textAlign : 'left', headerTextAlign : 'center',customAttributes : {index : 'T1.SUBJECT',searchable : true}
              }
              ,{
                  field : 'score', headerText : '점수',width:'20px',textAlign : 'center', headerTextAlign : 'center',customAttributes : {index : 'T1.SCORE'}
              }
              ,{
                  field : 'uploadImgPath', headerText : '포토여부',width:'40px',textAlign : 'center', headerTextAlign : 'center',customAttributes : {index : 'T1.SCORE'}, template:"#ynTemplate"
              }
              ,{
                  field : 'regDate', headerText : '등록일',width:'70px',textAlign : 'center', headerTextAlign : 'center',customAttributes : {index : 'T1.REG_DATE'}
              }
              ,{
                  field : 'modifyDate', headerText : '수정일', width:'70px', textAlign : 'center', headerTextAlign : 'center', customAttributes : {index : 'T1.MODIFY_DATE'}
              }
              ,{
                  field : 'rid', headerText : 'rid' ,visible : false,
              }
                
            ],
            requestGridData : {
                  nd   : new Date().getTime(),
                  rows : 10,
                  sidx : '1',
                  sord : 'desc',
                  _search : false
              },
              rowList : [10,25,50,100],
              radio: true
    };

    prodCustList = $("#prodCustList").ifvsfGrid({ ejGridOption  : ejGridOption });
}

$(document).ready(function() {
    prodCustListFun();

});

</script>

<style>
    .heightForm{
        height:230px;
    }
    .middle {
        vertical-align: middle;
        text-align: left;
    }
    #buyChnl{
	cursor: not-allowed;
    background-color: #eee !important;
    opacity: 1;
    }
</style>
</style>

<div class="page_btn_area">
    <div class="col-xs-7">
        <span><spring:message code="상품평 이력" /></span>
    </div>
</div>
<div id="prodCustList" class="white_bg grid_bd0"></div>

<div class="page_btn_area">
    <div class="col-xs-7">
        <span><spring:message code="상품평 상세" /></span> <lable style="color:#191970;font-size:15px">&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; 1.오프라인구매상품, 온라인구매상품 상품평 : 자재코드  2.체험단 상품평: 상품코드</lable>
    </div>
</div>
<div class="form-horizontal top_well underline" id="prodCustDetialInfo">
	<div class="row">
	      <div class="col-xs-12">
	       <ifvm:inputNew type="text" id="buyChnl" label="구입채널"  labelClass="1" conClass="2"  readonly ="true"/>
	       <ifvm:inputNew type="text" id="prodCode" label="자재코드"  labelClass="2" conClass="2"  disabled="true"/>
	       <ifvm:inputNew type="text" id="goodsCode" label="상품코드"  labelClass="2" conClass="2"  disabled="true"/>
	       <%-- <ifvm:inputNew type="text" id="itemCode" label="아이템코드"  labelClass="2" conClass="2"  disabled="true"/> --%>
	    </div>
	</div>
	</br>
	<div class="row">
	    <div class="col-xs-12">
	       <ifvm:inputNew type="textarea" id="desc" label="내용"  labelClass="1" conClass="10"  disabled="true" rows="5" maxLength="5000"/>
        </div>
	</div>
</div>

