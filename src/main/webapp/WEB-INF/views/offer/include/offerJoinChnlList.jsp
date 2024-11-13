<%@page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<style>
	.tab-contents .page_btn_area .btn.disabled, .tab-contents .page_btn_area .btn[disabled] {
		display: inline;
	}
</style>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="O00003" /></span>
	</div>
	<div class="col-sm-5 searchbtn_r">
		<ifvm:inputNew type="button" btnType="plus" text="O00046" id="btnAddOfferJoinChnl" objCode="offerJoinChnlListNew_OBJ"/>
		<ifvm:inputNew type="button" btnType="minus" text="O00047" id="btnRemoveOfferJoinChnl" objCode="offerJoinChnlListRemove_OBJ"/>
		<ifvm:inputNew type="button" btnType="minus" text="O00082" id="btnRemoveOfferJoinAllChnl" objCode="offerJoinChnlListRemoveAll_OBJ"/>
        <ifvm:inputNew type="button" text="O00084" id="excelDownloadBtn" btnFunc="targetListDownload" objCode="offerJoinChnlListDownload_OBJ"/>
		<ifvm:inputNew type="button" text="O00083" id="btnUpload"  objCode="offerJoinChnlListUpload_OBJ"/>
        <ifvm:inputNew type="button" text="O00166" id="btnUploadSample" btnFunc="btnSampleDown" objCode="offerJoinChnlListUploadSample_OBJ"/>
	</div>
</div>
<div id="joinChnlGrid"></div>

<div id="chnlExcelUploadPop" class="popup_container"></div>
<script type="text/javascript">

	var joinChnlGrid = null;
	var OfferJoinChnlList = function () {
		var _rid = null;
	    //var _chnlRid = ifvGlobal["offerRid"];
	    this.setRid = function (rid) {
		    ifvGlobal["joinChnlRid"] = rid;
	        _rid = rid;
	    },
	    this.getRid = function () {
            return _rid;
        },
        this.getChnlRid = function () {
            return _chnlRid;
        },
        this.joinChnlGridOptions = null,
        this.setGridAndDataLoad = function (url) {
        	var _serializeGridData = function (data) {
        		data.ridOfr = ifvGlobal["offerRid"];
                return data;
            };
            var _rowSelected = function (args) {
                var _data = args.data;
                this.setRid(_data.rid);
            };
        	/* var _recordDoubleClick = function (args) {
                var _data = args.data;
                this.setRid(_data.rid);
                this.openPopup();
            }; */
            var ejGridOption = {
				serializeGridData: _serializeGridData,
				rowSelected: _rowSelected.bind(this),
				//recordDoubleClick: _recordDoubleClick.bind(this),
				dataUrl: '<ifvm:action name="getOfferJoinChnlList"/>',
				columns: [	// '채널번호', '채널명', '등록자', '등록일자''
					{
					    field: 'rid',
					    visible: false
					}, {
					    field: 'chnlNo',
					    headerText: '<spring:message code="O00076"/>',
					    width: '100px',
					    textAlign: 'center',
					    customAttributes: {
                            searchable: true
                        }
					}, {
					    field: 'chnlNm',
					    headerText: '<spring:message code="O00077"/>',
					    width: '200px',
					    textAlign: 'left',
					    customAttributes: {
                            searchable: true
                        }
	                }, {
					    field: 'createBy',
					    headerText: '<spring:message code="O00080"/>',
					    width: '80px',
					    textAlign: 'left'
	                }, {
	                    field: 'createDate',
	                    headerText: '<spring:message code="O00116"/>',
	                    width: '80px',
	                    textAlign: 'center'
					}],
				requestGridData: {
				    sidx: 'createDate'
				},
				radio: true
            };
            joinChnlGrid = $("#joinChnlGrid").ifvsfGrid({ ejGridOption : ejGridOption });
      	},
      	/* 팝업 오픈 */
        this.openPopup = function () {
            $.fn.ifvmPopupOpen('popupContainer', this.getRid(),
                '<ifvm:url name="offerLoyChnlListPopup"/>',
                '<spring:message code="O00081"/>', 860);
        },
        /* 버튼 클릭 시 액션 세팅 */
        this.setButtons = function () {
        	
        	//신규
            $("#btnAddOfferJoinChnl").click(function () {
                this.setRid(null);
                this.openPopup();
            }.bind(this));

        	//삭제
            $("#btnRemoveOfferJoinChnl").click(function (obj) {
            	if(joinChnlGrid.opt.gridControl.getSelectedRecords().length==0){
            		alert('<spring:message code="O00066"/>');
            	}else{
                	this.removeAction(obj);
            	}
            }.bind(this));

        	//전체삭제
            $("#btnRemoveOfferJoinAllChnl").click(function (obj) {
            	if(joinChnlGrid.opt.gridControl.model.currentViewData.length==0){
            		alert('<spring:message code="O00087"/>');
            	}else{
                    joinChnlGrid.opt.gridControl.selectRows(0);

                	this.removeAction(obj);
            	}
            }.bind(this));
            
        },
        /* 삭제 액션 */
        this.removeAction = function (obj) {
            var _success = function () {
                $.ifvProgressControl(false);
                alert('<spring:message code="O00055"/>');
                this.setGridAndDataLoad();
                checkReload();
                
            };

            var _fail = function (result) {
                alert(result.message);
                $.ifvProgressControl(false);
            };
            
            var _rid = this.getRid();
            var _ridOfr = ifvGlobal["offerRid"];
            
          	//선택된 삭제 버튼에 따른 actionTag 설정
        	var selectId = obj.target.id;
        	var _msg = '<spring:message code="O00056"/>';
        	var _url = '<ifvm:action name="removeOfferJoinChnl"/>';
        		
        	if (selectId == "btnRemoveOfferJoinChnl"){
        		_msg = '<spring:message code="O00056"/>';	/* 삭제 하시겠습니까? */
        		_url = '<ifvm:action name="removeOfferJoinChnl"/>';
        	}else if (selectId == "btnRemoveOfferJoinAllChnl"){
        		
        		_msg = '<spring:message code="O00086"/>'; /* 등록된 전체 항목을 삭제 하시겠습니까? */
        		_url = '<ifvm:action name="removeOfferJoinAllChnl"/>';
        	}
        	
            if ($.fn.ifvmIsNotEmpty(this.getRid())) {
                if (confirm(_msg)) {
                    $.ifvProgressControl(true);
                    $.ifvPostJSON(_url, { rid: _rid, ridOfr : _ridOfr }, _success.bind(this), _fail);
                }
            }
        },
        this.init = function () {
            this.setGridAndDataLoad();
            this.setButtons();
        }
	}
	
	function checkReload(){
		   $.ifvSyncPostJSON('<ifvm:action name="getOfferDetail"/>', {
				rid : ifvGlobal["offerRid"]
			},function(result){
				 if(result.useChnlLimitYn=="Y"){
					$("#useChnlLimitYn").prop("checked", true); 
				}else if(result.useChnlLimitYn=="N"){
					$("#useChnlLimitYn").prop("checked", false); 
				}
			}); 
	}
	//업로드 양식 다운로드
	function btnSampleDown(){
			var data = {
				fileName: "offerJoinChnl_sample_data.xls"
			};
			$.fn.ifvmExcelSampleDown(data);
	}
	
	// 엑셀 다운로드
	function targetListDownload(){
		if(joinChnlGrid.opt.gridControl.model.dataSource.length !=0) {
			$.ifvExcelDn('<ifvm:action name="exportExcelOfferJoinChnlTargetList"/>', 'joinChnlGrid');
		}else{
			alert("다운로드할 데이터가 없습니다.");
		}
	}
	
	//파일 업로드
	function excelDownChnlItem() {
	    $("#chnlExcelUploadPop").ifvsfPopup({
	        enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="offerJoinChnlExcelPop"/>',
	        contentType: "ajax",
	        title: '채널 업로드',
	        width: 600,
	        close : 'chnlExcelUploadClosePop'
	    });
	}
	
	function chnlExcelUploadClosePop() {
	    chnlExcelUploadPop._destroy();
	}




	$(document).ready(function () {
		var offerJoinChnlGrid = new OfferJoinChnlList();
		offerJoinChnlGrid.init();

		  $("#btnUpload").click(function() {
		        excelDownChnlItem();
		    });
		  
		  ofrStatSaveValid();
	});
</script>


