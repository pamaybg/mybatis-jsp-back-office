<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="apiSpecGrid"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="btnApiSpecSelect" objCode="">
		<spring:message code="L00072" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="btnApiSpecCancle" objCode="">
		<spring:message code="M00441" />
	</button>
</div>

<script type="text/javascript">
var apiSpecListPop = function (ASrid) {
		var _apiSpecRid = ASrid;
		var _rid = null;
	
        this.setApiSpecRid = function (ASrid) {
        	_apiSpecRid = ASrid;
        },
	    this.getApiSpecRid = function () {
	        return _apiSpecRid;
	    },
        this.setRid = function (rid) {
            _rid = rid;
        },
	    this.getRid = function () {
	        return _rid;
	    },
        /* 그리드 생성 */
        this.setGridAndDataLoad = function () {
            var _rowSelected = function (args) {
                var data = args.data;
                this.setRid(data.rid);
            };
            var _serializeGridData = function(data){
            	data.rid = this.getApiSpecRid();
                return data;
            };
            var ejGridOption = {
                rowSelected: _rowSelected.bind(this),
                serializeGridData: _serializeGridData.bind(this),
                dataUrl : '<ifvm:action name="getApiSpecListPop"/>',
    	        columns:[ 
  	        	  {
  		      		  field : 'apiGrpCdNm', headerText : '분류', headerTextAlign : 'center', textAlign : 'center', customAttributes : { index : 'apiGrpCd'}
  		      	  },{
  		      		  field : 'apiNo', headerText : 'API No', headerTextAlign : 'center', textAlign : 'center', customAttributes : {searchable : true}
  		      	  },{
  		      		  field : 'apiNm', headerText : 'API명 ', headerTextAlign : 'center', textAlign : 'left', customAttributes : {searchable : true}
  		      	  },{
  		      		  field : 'reqUrl', headerText : 'URL', headerTextAlign : 'center', textAlign : 'left', customAttributes : {searchable : true, index : 'apiUrl'}
  		      	  },{
  		      		  field : 'statCdNm', headerText : '상태', headerTextAlign : 'center', textAlign : 'center', customAttributes : { index : 'statCd'}
  		      	  },/* {  
  		      		  field : 'createDate', headerText : '등록일', headerTextAlign : 'center', textAlign : 'center'
  		      	  },{  
  		      		  field : 'createBy', headerText : '등록자', headerTextAlign : 'center', textAlign : 'center'
  		      	  }, */{
  		      		  field : 'rid', headerText : 'rid', visible : false /* rid */
  		      	  },
  	        	],
                requestGridData: {
                    sidx: 'createDate',
                },
                rowList : [10,25,50,100],
                radio: true
            };
            $("#apiSpecGrid").ifvsfGrid({
                ejGridOption: ejGridOption
            });
        },
        this.save = function(){
        	
        	var _callBack = function(result){
        		if(result.success){
        			if(result.message) alert(result.message)
        			else alert("복사되었습니다.")
        			$.fn.ifvmPopupClose();
        			var apiChnlListNew = new apiChnlGrid();
        			apiChnlListNew.setGridDataLoad();
        		}else{
        			if(result.message) alert(result.message)
        			else alert('<spring:message code="I00742"/>');
        		}
        	}
        	
        	if(confirm("채널 복사를 하시겠습니까?")){
        		$.ifvSyncPostJSON('<ifvm:action name="copyApiChnl"/>',{rid : this.getApiSpecRid() , copyRid : this.getRid()}, _callBack.bind(this), _callBack.bind(this))
        	}
        },
        /* 버튼 세팅 */
        this.setButtons = function () {
            $("#btnApiSpecSelect").on('click', function () {
            	this.save()
            }.bind(this));

            $("#btnApiSpecCancle").on('click', function () {
    			$.fn.ifvmPopupClose();
            }.bind(this));
        },
        /* 페이지 초기화 */
        this.init = function () {
            this.setGridAndDataLoad();
            this.setButtons();
        }
};
	
$(document).ready(function () {
    var urlParams = $.ifvGetParams();
    var rid = urlParams.rid;

	ifvGlobal["apiSpecRid"] = rid;
	
    var apiSpecListPopNew = new apiSpecListPop(rid);
	apiSpecListPopNew.init();
});
</script>
