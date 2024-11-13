<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var storeDefulatInfoValidation;

var isModify = false;
var geocoder;
var map;
var geometryData = {};

function storeDefaultInfo_init(){
	if( storeManage.selectNodeData.original.isNew == null ){ //수정인경우
		isModify = true;
		$.ifvSyncPostJSON( '<ifvm:action name="getDeptInfo"/>', 
				{ storeId : storeManage.selectNodeData.id, type : storeManage.selectNodeData.original.type },
				function(result){

			if ( result == null || result == 'undefined') {
				return;
			}

			$("#address").val( result.addressDetail );
			
			if (result.phoneNumber != null) {
				var phoneArr = result.phoneNumber.split('-');
				if(phoneArr[2] == null){
					$("#phone2").val( phoneArr[0] );
					$("#phone3").val( phoneArr[1] );
				} else {
					$("#phone1").val( phoneArr[0] );
					$("#phone2").val( phoneArr[1] );
					$("#phone3").val( phoneArr[2] );
				}
			}

			if (result.faxNumber != null) {
				var faxArr = result.faxNumber.split('-');
				$("#fax1").val( faxArr[0] );
				$("#fax2").val( faxArr[1] );
				$("#fax3").val( faxArr[2] );
			}
			
			$("#accountStatus").val( result.accountStatus );
			$("#description").val( result.description );
			$("#partnerType").val( result.partnerType);
			$("#storeManage_name").val( result.storeName );
			$("#accountNumber").val( result.accountNumber );
		}, 'body', 'bigsize_progressRoll' );
	};
	//매장일 경우에만 파트너 타입을 보여줌
	if($("#storeManageStoreType").val() == "STORE") {
		$("#partnerTypeVisible").show();
	} else {
		$("#partnerTypeVisible").hide();
	}
	
};

function saveData(){
	
	storeDefulatInfoValidation = $("#departmentsDefaultForm").ifvValidation();
	if( storeDefulatInfoValidation.confirm() == false ) return;
	
	var obj = {};
	obj.useInfavor = enabledInfavor;
	obj.parentId = storeManage.selectNodeData.parent;
	obj.phoneNumber = $("#phone1").val() + '-' + $("#phone2").val() + '-' + $("#phone3").val();
	obj.faxNumber = $("#fax1").val() + '-' + $("#fax2").val() + '-' + $("#fax3").val();
	obj.accountStatus = $("#accountStatus").val();
	obj.description = $("#description").val();
	obj.storeName = $("#storeManage_name").val();
	obj.accountStatus = $("#accountStatus").val();
	obj.storeType =  $("#storeManageStoreType").val();
	//가맹/직영 구분 : STORE일 때만 DB에 partner_type 입력
	if(obj.storeType == "STORE") {
		obj.partnerType = $("#partnerType").val();
	} else {
		obj.partnerType = '';
	}
	obj.accountId = $.ifvmGetUserInfo().accountId;
	obj.accountNumber = $("#accountNumber").val();
	
	if( obj.storeName.trim() == '' ){
		storeDefulatInfoValidation.valiShowAPI( $("#storeManage_name"), $("#storeManageNameVali") );
		return;
	}

	if( geometryData.addr1 != null ){
		obj.addressDetail = geometryData.addr1;	
	}else{
		obj.addressDetail = $("#address").val();
	}
	
	if ( geometryData.addr2 != null ) {
		obj.addressDetail += " " + geometryData.addr2;
	}
	
	
	
	var url = '';
	if( storeManage.selectNodeData.original.isNew != null ){
		url = '<ifvm:action name="setDeptInfo"/>';
	}else{
		url = '<ifvm:action name="updateDeptInfo"/>';
		obj.storeId = storeManage.selectNodeData.id;
	}
	obj.orgId = storeManage.selectNodeData.orgId;
	
	showProgressBar();
	$.ifvPostJSON( url, obj, function(result){
		alert('<spring:message code="M00015" />');
		hideProgressBar();
		storeManage.updateNodeData( result.message );
		storeManage.tabSetting();
		
		$.ifvSyncPostJSON( '<ifvm:action name="setCurrentdivision"/>' ,{storeId : storeManage.selectNodeData.id, storeName : storeManage.selectNodeData.text, storeType : storeManage.selectNodeData.type, storeMarkType : storeManage.selectNodeData.markType /*, storeDesc : data.storeDesc, memId : data.memId*/ }
		,function(result) {
		});
		//스토어 타입  저장
		ifvmDivisionInfo.storeId = storeManage.selectNodeData.id;
		ifvmDivisionInfo.storeName = storeManage.selectNodeData.text;
		ifvmDivisionInfo.storeType = storeManage.selectNodeData.type;
		
		// 스토어 타입 disabled
		$("#storeManageStoreType").prop("disabled", "disabled");
	},
	function(result){
		hideProgressBar();
		storeManage.uniqCheck(result);
		storeDefaultInfo_init();
	}, "body", 'bigsize_progressRoll' );
};


function getPhoneCorrectNum(str){
	var arr = str.split(' ');
	if( arr.length < 2 ){
		arr = str.split('-');
	}
	var newArr = [];
	for( var i = 0; i<arr.length; i++ ){
		var arr2 = arr[i].split('-');
		newArr = newArr.concat(arr2);
	}
	
	for( var i = 0; i<newArr.length; i++ ){
		var exp = /[\(\)]/g;
		newArr[i] = newArr[i].replace(exp, '' );
	}
	
	return newArr;
}

function getCommonCode(){
	$.ifvSyncPostJSON( '<ifvm:action name="getCommCodeList"/>', {
		groupCode : 'ACCOUNT_STATUS'
	}, function(result) {
		
		var temp = $("#storeManageCommCodeTemplate").tmpl(result.rows);
		$("#accountStatus").append(temp);
	});
	
	$.ifvSyncPostJSON( '<ifvm:action name="getCommCodeList"/>', {
		groupCode : 'ACCOUNT_PARTNER_TYPE'
	}, function(result) {
		
		var temp = $("#storeManageCommCodeTemplate").tmpl(result.rows);
		$("#partnerType").append(temp);
	});
};

//지도 ////////////////////////////////

function initialize() {
	
	var latLngPos = {x : 60, y : 105};
	if(navigator.geolocation) {
	    navigator.geolocation.getCurrentPosition( function(position){
	    	
	    	latLngPos.x = position.coords.latitude;
	    	latLngPos.y = position.coords.longitude;
	    	
	    	geocoder = new google.maps.Geocoder();
	    	var latlng = new google.maps.LatLng( latLngPos.x, latLngPos.y );
	    	var mapOptions = {
	    		zoom: 15,
	    		center: latlng
	    		//language : 'kr'	//설정에 따라 place.address_components의 값의 언어가 바뀐다.
	    	};
	    	map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
	    	
	    	var autocomplete = new google.maps.places.Autocomplete(document.getElementById('address'),{
	            
	    	});
	    	autocomplete.bindTo('bounds', map);
	    	
	    	$("#address").keydown( function(e) { 
	    	    if (e.keyCode == 13) { 
	    	        e.preventDefault();
	    	        codeAddress();
	    	    }
	    	}); 
	    	
	    	$("#address").keyup( function(e) {
	    		if( e.keyCode < 36 && e.keyCode > 40 ){
	    			var str = $("#address").val();
		    		$("#address").val( str.replace('<spring:message code="M00128" />' , '') );
	    		}
	    	});
	    	
	    	google.maps.event.addListener(autocomplete, 'place_changed', function() {
	    		changePlace();
	    	});
	    	
	    	function changePlace(){
	    		
	    		if( isModify == false  ){
	    	    	for( var i = 0; i<3; i++ ){	//전화번호 필드 초기화
	    	    		$("#phone" + (i + 1)).val( '' );	
	    	    	};
    	    	}
	    		
	    	    var place = autocomplete.getPlace();
	    	    geometryData = {};
	    	    if( !place.geometry ){
	    	    	//return;
	    	    }else{
	    	    	//geometryData = place.geometry;
	    	    	if( isModify == false && place.formatted_phone_number != null ){
	    	    		//전화번호 맵핑
	    	    		//var phoneArr = place.formatted_phone_number.split('-');
	    	    		var phoneArr = getPhoneCorrectNum( place.formatted_phone_number );
		    	    	for( var i = 0; i<phoneArr.length; i++ ){
		    	    		if( i < 3 ){
		    	    			$("#phone" + (i + 1)).val( phoneArr[i] );	
		    	    		};
		    	    	};
	    	    	}
	    	    	
	    	    	function getAddress(type) {
	    	    		var arr = place.address_components;
	    	    		for( var i = 0; i<arr.length; i++ ){
	    	    			var types = arr[i].types;
	    	    			for( var j = 0; j < types.length; j++ ){
	    	    				if( types[j] == type ){
									return arr[i].long_name;    	    					
	    	    				};
	    	    			};
	    	    		}
	    	    		return '';
	    	    	};
	    	    	
	    	    	function getSublocality(){
	    	    		var arr = place.address_components;
	    	    		var localityArr = [];
	    	    		for( var i = 0; i<arr.length; i++ ){
	    	    			var types = arr[i].types;
	    	    			for( var j = 0; j < types.length; j++ ){
	    	    				if( types[j] == 'sublocality' ){
	    	    					localityArr.push( arr[i] );
	    	    					break;
	    	    				};
	    	    			};
	    	    		}
	    	    		var arr2 = localityArr.reverse();
	    	    		var sublocality = '';
	    	    		for( var i = 0; i<arr2.length; i++ ){
	    	    			sublocality += ' ' + arr2[i].long_name;
	    	    		}
	    	    		return sublocality;
	    	    	};
	    	    	var sublocality = getSublocality();
	    	    	if( sublocality != '' || getAddress('locality') != '' ){		//시정보나 동정보까지 있는경우는 geo데이타에서
	    	    		var zipCode = getAddress('postal_code');
		    	    	geometryData.zipCode1 = zipCode.split('-')[0];
		    			geometryData.zipCode2 = zipCode.split('-')[1];
		    			geometryData.addr1 = getAddress('locality') + sublocality;
		    			if( sublocality != '' && geometryData.addr1.indexOf( place.name ) < 0 ){
		    				geometryData.addr2 = place.name;
		    			}else{
		    				geometryData.addr2 = '';
		    			}
		    			
		    			var urlStr = geometryData.addr1 + ' ' + geometryData.addr2;
		    			
	    	    	};
	    	    }
	    	    codeAddress();	//주소 변경될때마다 지도 이동
	    	}
	    	codeAddress();	//수정데이타 보여준후에 지도 이동
			
	    	//입력폼 내 유효성 검사
			storeDefulatInfoValidation = $("#departmentsDefaultForm").ifvValidation();
	    });
	}
}
var marker;
function codeAddress( urlCheck ) {
	
	var address = document.getElementById('address').value;
	
	geocoder.geocode( { 'address': address }, function(results, status){
		if(status == google.maps.GeocoderStatus.OK){
		    map.setCenter(results[0].geometry.location);

			if( marker != null ) marker.setMap(null);
		    
		    marker = new google.maps.Marker({
		        map: map,
		        position: results[0].geometry.location
		    });
		}else{
		}
	});
	$("#address").val( $("#address").val().replace('<spring:message code="M00128" />' , '') );
}

$(document).ready( function(){
	getCommonCode();
	storeDefaultInfo_init();
	initialize();
});

</script>

<div id="departmentsDefaultForm" class="form-horizontal">
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="M00556"/></span>
		</div>
		<div class="col-sm-5 searchbtn_r">
			<button class="btn btn-sm" id="btnSaveData" onclick="saveData()"> <i class="glyphicon glyphicon-check"></i> 
				<spring:message code="M00573"/>
			</button>
		</div>
	</div>
	<div class="well underline form-horizontal">
		<div class="row qt_border store_content_top">
			<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00574"/></label>
			<div class="col-xs-9 control_content">
				<div class="input-group">
					<ifvm:input type="text" className="form-control" id="address" required="true"/>
					<span style="cursor:pointer" class="input-group-addon"><a  href="javascript:codeAddress();"><i class="fa fa-search"></i></a></span>
				</div>
			</div>
		</div>
		<div class="row qt_border">
			<label class="col-xs-2 control-label"><spring:message code="M00575"/></label>
			<div class="col-xs-9 control_content">
				<div id="map-canvas" style="height:350px; width:100%;"></div>
			</div>
		</div>
		
		<div class="row qt_border">
			<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00555"/></label>
			<div class="col-xs-3 control_content">
				<ifvm:input type="text" id="storeManage_name" className="form-control" maxLength="50" required="true"/>
			</div>
			<label class="col-xs-2 col-lg-3 control-label"><span class="asterisk">*</span><spring:message code="M00336"/></label>
			<div class="col-xs-3 control_content">
				<ifvm:input type="text" id="accountNumber" className="form-control" maxLength="12" required="true"/>
			</div>
		</div>
		
		<div class="row qt_border">
			<label class="col-xs-2 control-label"><spring:message code="M00576"/></label>
			<div class="col-xs-4 col-lg-4 control_content">
				<ifvm:input type="text" className="style_type1 phone_size3" id="phone1" valiItem="number" maxLength="3"/>
				-
				<ifvm:input type="text" className="style_type1 phone_size4" id="phone2" valiItem="number" maxLength="4"/>
				-
				<ifvm:input type="text" className="style_type1 phone_size4" id="phone3" valiItem="number" maxLength="4"/>
			</div>
			
			<label class="col-xs-2 col-lg-2 control-label">
				<spring:message code="M00578"/>
			</label>
			<div class="col-xs-4 control_content">
				<ifvm:input type="text" className="style_type1 phone_size3" id="fax1" valiItem="number" maxLength="3"/>
				-
				<ifvm:input type="text" className="style_type1 phone_size4" id="fax2" valiItem="number" maxLength="4"/>
				-
				<ifvm:input type="text" className="style_type1 phone_size4" id="fax3" valiItem="number" maxLength="4"/>
			</div>
		</div>
	
		<div class="row qt_border">
			<label class="col-xs-2 control-label"><spring:message code="M00579"/></label>
			<div class="col-xs-3 control_content">
				<ifvm:input type="select" id="accountStatus" />		
			</div>
			
			<!-- 매장정보일경우에만 show -->
			<div id="partnerTypeVisible" style="display: none;">
				<label class="col-xs-3 control-label"><spring:message code="M00580"/></label>
				<div class="col-xs-3 control_content">
					<ifvm:input type="select" id="partnerType" />
				</div>
			</div>
		</div>
		
		<div class="row">
			<label class="col-xs-2 control-label"><spring:message code="M00560"/></label>
			<div class="col-xs-9 control_content">
				<ifvm:input type="textarea" className="form-control" maxLength="1500" id="description"/>		
			</div>
		</div>
	</div>

</div>
