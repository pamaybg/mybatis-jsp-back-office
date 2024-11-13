
StoreManage = function( obj ){
	
	$.extend( this, obj );
	
	this.init();
};

StoreManage.prototype = {
		
	commcodeUrl : null,
	isSnbShow : true,
	departmentsInfoUrl : '',
	departmentsEmployeeUrl : '',
	deleteStoreUrl : '',
	selectNodeData : {},
	getSubAccountList : '',
	getRootAccountList : '',
	getSelectedAccount : '',
	isMoveCancel : false,
	storeType : null,
	currentPageType : null,
	treeDataArr : null,
	defaultInfo : {},
	isRefresh : 0,
	
	ACCOUNT_ICON : PAGE_CONTEXT_PATH + '/resources/images/marketing/tree/ico_account.png',
    GROUP_ICON : PAGE_CONTEXT_PATH +'/resources/images/marketing/tree/ico_group.png',
    STORE_ICON : PAGE_CONTEXT_PATH +'/resources/images/marketing/tree/ico_store.png',
    FOLDER_ICON : PAGE_CONTEXT_PATH +'/resources/images/marketing/tree/ico_store.png',
	
	init : function(){
		$("#storeManageNavTab").find('a').attr('disabled', true );
		//if (ifvYMADMAccountInfo.accountId) {
			//this.treeInit();
		//}
		this.treeInit();		
		this.eventSetting();
		this.getCommonCode();
		this.showHideEventSetting();
	},
	
	updateOriginStoreType : function( type ){
		var id = this.selectNodeData.id;
		for( var i = 0; i < this.treeDataArr.length; i++ ){
			if( this.treeDataArr[i].id == id ){
				this.treeDataArr[i].type = type;
			}
		}
	},
	
	eventSetting : function(){
		
		var _this = this;
		$("#storeManageStoreType").change(function(){
			
			if( confirm( MESSAGE.storeManage.storeTypeChangeConfirm ) === true){
				
				_this.storeType = $("#storeManageStoreType option:selected").val();
				_this.updateOriginStoreType( _this.storeType );

				var iconArea = $("#"+_this.selectNodeData.id).find('a > [role=presentation]');
				if( _this.storeType == 'STORE'){
					iconArea.css('background', "url(" + _this.STORE_ICON + ")  50% 50% no-repeat" );
				}else{
					iconArea.css('background', "url(" + _this.GROUP_ICON + ")  50% 50% no-repeat" );
				}
				
				_this.changePlaceHolder();
				_this.resetPage();
			}else{
				$("#storeManageStoreType").val(storeTypeTemp);
			}
		});
		
	},
	
	changePlaceHolder : function(){
		var str = '';
		switch( this.storeType ){
			
			case 'STORE' :
				str = MESSAGE.storeManage.store;
				break;
		}
		$("#storeManage_name").attr('placeholder', str );
	},
	
	uniqCheck : function(result){
		if( result.message == 'MSG_5007' ){
			$("#addrVali").show();
			$("#storeManage_name").addClass('valieTxt_border');
		}else if( result.message == 'MSG_5008' ){
			
		}
		
		var str = '';
		
		switch( result.message ){
			case 'MSG_1004' :
				str = MESSAGE.storeManage.error_MSG_1004;
				break;
				
			case 'MSG_1005' :
				str = MESSAGE.storeManage.error_MSG_1005;
				break;
				
			case 'MSG_1006' :
				str = MESSAGE.storeManage.error_MSG_1006;
				break;
				
			case 'MSG_1008' :
				str = MESSAGE.storeManage.error_MSG_1008;
				break;
				
			case 'MSG_5001' :
				str = MESSAGE.storeManage.error_MSG_5001;
				break;
				
			case 'MSG_5009' :
				str = MESSAGE.storeManage.error_MSG_5009;
				break;
				
				
			case 'MSG_5008' :
				str = MESSAGE.storeManage.error_MSG_5008;
				break;
				
			case 'MSG_5007' :
				str = MESSAGE.storeManage.error_MSG_5007;
				break;
			case 'MSG_3001' :
				str = MESSAGE.departments.error_MSG_3001;
				break
			case 'MSG_3003' :
				str = MESSAGE.departments.error_MSG_3003;
				break
			case 'MSG_1050' :
				str = MESSAGE.departments.error_MSG_1050;
				break
		}
		
		alert(str);

	},
	
	resetPage : function(){
		this.tabSetting();
		
		var type = null; 
		
//		if( this.currentPageType == null || this.currentPageType == 'departmentsInfo' )
			type = 'departmentsInfo';
//		else
//			type = 'departmentsEmployee';
		
		this.changeContent(type);
		
	},
	
	tabSetting : function(){
/*
		if( this.currentPageType == null || this.currentPageType == 'departmentsInfo') {
			$("#storeManageNavTab").find('a').removeClass('active');
			$("#storeManageNavTab").find('a').eq(0).addClass('active');
		}
		
		$("#storeManageNavTab").find('a').attr('disabled', false );
*/
		if( this.selectNodeData.original.isNew != null ){
			//신규
			$("#storeManageNavTab").find('a').attr('disabled', true );
			$("#storeManageNavTab").find('a').eq(0).attr('disabled', false );

		}
		//else if( this.currentPageType == null || this.currentPageType == 'departmentsInfo') {
		//	$("#storeManageNavTab").find('a').removeClass('active');
		//	$("#storeManageNavTab").find('a').eq(0).addClass('active');
		//}
		else {
			$("#storeManageNavTab").find('a').attr('disabled', false );
		}
	},
	
	tabClick : function(type, tab ){
		
		/*if( type == 'default' && this.storeType != 'GROUP' ){
			type = 'defaultStore';
		}*/
		this.saveDefaultInfo();
		this.changeContent( type, tab );
		
	},
	
	saveDefaultInfo : function(){
		if( this.currentPageType == 'departmentsInfo' ){
			this.defaultInfo.address = $("#address").val();
			this.defaultInfo.phone1= $("#phone1").val();
			this.defaultInfo.phone2= $("#phone2").val();
			this.defaultInfo.phone3= $("#phone3").val();
		}
	},
	
	changeContent : function( type, tab ){
		
		this.currentPageType = type;
		
		if( typeof storeManageSaveData != "undefined" ){
			storeManageSaveData(); //remove처리등
			
		}
		var url = '';
//		$("#manageCon").height(900);
//		$("#storeManage_name").attr('disabled', true );
//		$("#storeManageNameValue").hide();
		
		switch( type ){
		
			case 'departmentsInfo' :
				url = this.departmentsInfoUrl;
				break;

			case 'departmentsEmployee' :
				url = this.departmentsEmployeeUrl;
				break;

			case 'employeeDetail' :
				url = this.employeeDetailUrl;
				break;

				
			default :
				
				break;
		};
		hideProgressBar();
		
		var _this = this;
		var fileName = url.split('/').pop();
		$.ifvCachedHtml( url ).done( function(script, textStatus){
			if( tab != null ){
				$("#storeManageNavTab").find('a').removeClass('active');
				$(tab).addClass('active');
			} else {
				$("#storeManageNavTab").find('a').removeClass('active');
				$("#storeManageNavTab").find('a').eq(0).addClass('active');
			}
			$("#storeManageContent").empty();
			$("#storeManageContent").html('');
			$("#storeManageContent").append( script );
			_this.removeLoadUI( type );
			//$.ifvbLnbSetting('beaconMain');
			
			if( window[fileName + '_init'] != null ) window[fileName + '_init']();
			
		});
	},
	
	removeLoadUI : function( type ){
		$("#storeManageContent").find(".page-title").remove();
		$(".manageHideItem").remove();
		$(".manageSize").removeClass("col-sm-3").addClass("col-sm-5");
		$(".storeManageSearchPeriodSize").removeClass("col-sm-4").addClass("col-sm-5");
		$(".manageSize2").removeClass("").addClass("");
		if( type == 'departmentsInfo' || type == 'departmentsEmployee'){
			//$("#storeManageContent").find(".well").css("border-top","1px solid #c6c6c6");
		}
		$('.btn.btn-sm').addClass('btn_gray');
	},
	
	treeInit : function(){
		this.getTreeDataSetting();
	},
	
	getOrigindata : function( id ){
		for( var i = 0; i < this.treeDataArr.length; i++ ){
			if( this.treeDataArr[i].id == id ){
				return this.treeDataArr[i];
			}
		}
	},
	
	getTreeDataSetting : function(){
		
		this.treeDataArr = [];
		//this.treeDataArr = [ { "id" : "ajson1", "parent" : "ajson11", "text" : "Simple root node" }, { "id" : "ajson2", "parent" : "ajson11", "text" : "Root node 2" }, { "id" : "ajson3", "parent" : "ajson2", "text" : "Child 1" }, { "id" : "ajson4", "parent" : "ajson2", "text" : "Child 2" } ];
		var _this = this;
		$('#tree').jstree({
			"core" : {
				'data' : {
					type : 'POST',
                    dataType : 'json',
                    contentType :"application/json; charset=UTF-8",
					url : function (node){
						return node.id === '#' ? _this.getRootAccountList : _this.getSubAccountList;
					},
			        data : function (node){
			        	$.ifvLoading('body');
			        	
			        	// 최인한 language 파라메터 추가 20150512 
			        	var tempData = {};
			        	//var tempData =  null; //[{id : "#", text : "aaatxt", type : "account", parent : "#", orgId : "#", child : true}];			        	
			        	//tempData.accountId		= {id : "#", text : "aaatxt", type : "account", parent : "#", orgId : "#", child : true};			        	
			        	tempData.accountId		= node.id  === '#' ? $.ifvmStoreInfo().accountId : node.id;
			        	tempData.appServiceId	= window.appServiceId;
			        	tempData.country 		= window.country;
			        	tempData.lang			= window.lang;
			        	return $.toJSON(tempData);
			        	//console.log(tempData);
			        	//return tempData;
			        },
			        complete : function(data){
			        	
			        	var nodeJson = $.parseJSON(data.responseText);
			        	if( nodeJson.success == false && nodeJson.errorType == '200410' ){	//세션없을때 로그인화면으로
			        		$.ifvErrorPop( ifv.errorMessage.e_200410 );
			        		sessionEndFunc();
			        		return;
			        	}
			        	
			        	if( nodeJson.length == null ){	//데이타가 json객체일때
			        		_this.treeDataArr.push( nodeJson );
			        	}else{							//데잍가 배열일때
			        		for( var i = 0; i<nodeJson.length; i++ ){
			        			_this.treeDataArr.push( nodeJson[i] );
			        		}
			        	}
			        	
			        	$.ifvRemoveRequestBtn('body');
			        }
				},
			    "multiple" : false,
			    "animation" : 200,
			    "check_callback" : function (operation, node, node_parent, node_position, more) {
			    	if( operation === 'move_node' ){
			    		if( more.ref != null ){
			    			return node.original.orgId === more.ref.original.orgId ? true : false;
			    		}
			    	};
		            // operation can be 'create_node', 'rename_node', 'delete_node', 'move_node' or 'copy_node'
		            // in case of 'rename_node' node_position is filled with the new node name
		            //return operation === 'rename_node' ? true : false;
		        }
			},
			'types': {
	            'ACCOUNT': {
	                'icon': _this.ACCOUNT_ICON
	            },
	            'COR': {
	                'icon': _this.GROUP_ICON
	            },
	            'SEC': {
	                'icon': _this.GROUP_ICON
	            },
	            'HQ': {
	                'icon': _this.GROUP_ICON
	            },
	            'PART': {
	                'icon': _this.GROUP_ICON
	            },
	            'TEAM': {
	                'icon': _this.GROUP_ICON
	            },
	            'STORE': {
	                'icon': _this.STORE_ICON
	            },
	            'folder' : {
	            	'icon': _this.FOLDER_ICON
	            }
	        },
			"plugins" : [ "dnd",  "context", "types" ]
			
		
			})
		.bind("select_node.jstree", function( event, data ){
			
			$("[btnId=btnArea]").remove();
			var id = data.node.id;
			var originData = _this.getOrigindata( id );
			if( originData != null  ){
				if( originData.children == true ){
					var tree = $('#tree').jstree(true);
					tree.open_node( id );
				}
				data.node.original.type = originData.type;
				_this.selectNode(data);
			}else{
				this.selectNodeData = {};
			}
			if( data.node.original != null && data.node.original.isNew != true && data.node.original.type != 'STORE' ){
				_this.makePlusMinusBtn( id );
			}
			
		})
		.bind("create_node.jstree", function( event, data ){
						
			var tree = $('#tree').jstree(true);
			tree.open_node( data.node.parent );
			_this.focusChange( data, 'new' );
		})
		.bind("rename_node.jstree", function( event, data ){
			_this.reName(data.node.text);
		})
		.bind("loaded.jstree", function( event, data ){
			var tree = $('#tree').jstree(true);
			var accountId = $.ifvmStoreInfo().accountId;
			//var accountId = {'id' : "#", 'text' : "aaatxt", 'type' : "account", 'parent' : "#", 'orgId' : "#", 'children' : true};
			tree.open_node(accountId);
			tree.select_node(accountId);
		})
		.bind("refresh.jstree", function (e,data) {
			_this.isRefresh = 2;
	    })
	    .bind("open_node.jstree", function (e,data){
	    	if( _this.isRefresh == 0 ){//일반적으로 폴더 열릴때
	    		_this.clickedItemChange(data.node.id);
	    	}else if( _this.isRefresh == 2 ){
	    		
	    		//새로고침 됐을때 마지막 폴더 열리고 기존선택했던 노드 클릭되게 
	    		var newNode = $("#" + _this.selectNodeData.id + " > a ");
	    		newNode.trigger("click");
	    		_this.isRefresh = 0;
	    	}
	    })
		.bind("move_node.jstree", function (e, data) {
			
			// 20150528 udpate. IH. 신규등록시 이동 금지.
			if ( data.node.original.isNew == true ) {
				if ( data.node.original.isMove !== true ) {
					data.node.original.isMove = true;
					var tree = $('#tree').jstree(true);
					tree.move_node( data.node.id , data.old_parent, 'last' );
				}
				data.node.original.isMove = false;
				return;
			};
			
			if( _this.isMoveCancel == false )	//이동시
			{
				
				if( confirm( MESSAGE.storeManage.moveConfirm ) === false){
					
					//취소시 이전으로
					_this.isMoveCancel = true;
					var tree = $('#tree').jstree(true);
					tree.move_node( $("#" + data.node.id) , data.old_parent );
					
				}else{
					
					var children = data.node.children;
					if( children.length > 0 && confirm( MESSAGE.storeManage.moveChildren ) === false ){
						//자식노드는 부모의 기존 부모id
						for( var i = 0; i<children.length; i++ ){
							_this.isMoveCancel = true;
							_this.moveNode( children[i], data.old_parent );
							
							var tree = $('#tree').jstree(true);
							tree.move_node( $("#" + children[i]) , data.old_parent );
						}
					}
					
					//현재 노드 이동
					_this.moveNode( data.node.id, data.parent );
					_this.isRefresh = 1;
					$("#tree").jstree(true).refresh( $( "#"+ data.node.id ) );
					
				}
			}
			else								//이동취소해서 돌아왔을때
			{
				_this.isMoveCancel = false;
			}
			
		});
		
	},
	
	moveNode : function( id, parent ){
		var moveNodeArr = [{ accountId : id, parentId : parent }];
		$.ifvSyncPostJSON( this.setAccountLevel, { updateItems : moveNodeArr }, function(result){
		},null,'body');
	},
	
	focusChange : function(data, isNew ){
		this.selectNode(data);
		this.clickedItemChange(data.node.id);
	},
	
	clickedItemChange : function(id){
		var newNode = $("#" + id + " > a ");
		newNode.trigger("click");
	},
	
	scrollTopChange : function(data){
		var top = $("#" + data.node.id ).offset().top;
		var halfHeight = $("#tree").outerHeight()/2;
		var tarTop = top - halfHeight;
		$("#treeMenu").scrollTop( top );
	},
	
	makePlusMinusBtn : function(id){
		
		var item = $("#"+ id);
		var btns = '';
		btns += '<div style="position:absolute; top:0px;" btnId="btnArea"><button class="plus_minus_btn" btnId="plus">+'+MESSAGE.storeManage.add+'</button></div>';

		var jbtns = $(btns);
		var tL = item.find('a').width() + 35;
		jbtns.css({'left' : tL });
		item.css('position', 'relative');
		item.append(jbtns);
		
		var _this = this;
		var plusBtn = $("[btnId=plus]"); 
		plusBtn.click(function(){
			_this.createFolder();
		});
	},
	
	//동적 folder추가
	deleteStore : function(){
		if( this.selectNodeData == null ) return;
		
		if( confirm( MESSAGE.storeManage.deleteStore ) === true ){
			
			var children = this.selectNodeData.children;
			var storeId = this.selectNodeData.id;
			var obj = { storeId : storeId, parentId : this.selectNodeData.parent };
			if( children.length > 0 && confirm( MESSAGE.storeManage.deleteChildren ) === true ){
				obj.deleteAll = true;
			}else{
				obj.deleteAll = false;
			}
			$.ifvPostJSON( this.deleteStoreUrl, obj, function( result ){
				$("#tree").jstree(true).refresh( $( "#"+ storeId ) );
			}, function( result ){
				$("#tree").jstree(true).refresh( $( "#"+ storeId ) );
			});
		}
		
	},
	
	selectNode : function(data){
		
		this.selectNodeData = data.node;
		var parentData = this.getParentData(data.node.parent);
		if( parentData != null ){
			this.selectNodeData.orgId = parentData.orgId;
			this.selectNodeData.original.orgId = parentData.orgId;
		}
		//kj.kang 2015.10.28 수정
		if( this.selectNodeData.original.isNew != true){
			ifvmStoreInfo.storeId = this.selectNodeData.id;
			
			$.ifvSyncPostJSON( this.setStoreUrl ,{storeId : this.selectNodeData.id, storeName : this.selectNodeData.original.text, storeType : this.selectNodeData.original.type, storeMarkType : this.selectNodeData.original.markType /*, storeDesc : data.storeDesc, memId : data.memId*/ }
			,function(result) {
			});
			ifvmStoreInfo.storeId = this.selectNodeData.id;
			ifvmStoreInfo.storeName = this.selectNodeData.original.text;
			ifvmStoreInfo.storeType = this.selectNodeData.original.type;
			ifvmStoreInfo.storeMarkType = this.selectNodeData.original.markType;
		}		
		
		this.reName(data.node.text);
		
		var ttype = '';
		ttype = data.node.original.type;
		
		$("#storeManageStoreType").val( ttype );
		this.storeType = ttype;
		this.changePlaceHolder();
		$("#storeManage_name").removeClass('valieTxt_border');
		$("#addrVali").hide();
		
		if( data.node.original.isNew != null ){
			$("#storeManageStoreType").attr('disabled', false );
		}else{
			$("#storeManageStoreType").attr('disabled', true );
		}
		
		this.resetPage();
	},
	
	reName : function(text){
		if( text != MESSAGE.storeManage.newStoreText ){
			$("#storeManage_name").val( text );
		}else{
			$("#storeManage_name").val( '' );
		}
	},
	
	//동적 folder추가
	createFolder : function(){
		
		if( this.selectNodeData != null && this.selectNodeData.original != null && this.selectNodeData.original.isNew == true ) return;
		//kj.kang 매장 하위 추가 생성 못함
		var new_store_type;
		var type_message;
		switch(this.selectNodeData.original.type) {
			case 'ACCOUNT' :
				new_store_type = 'COR';
				type_message = MESSAGE.storeManage.newCOR;
				break;
			case 'COR' :
				new_store_type = 'SEC';
				type_message = MESSAGE.storeManage.newSEC;
				break;
			case 'SEC' :
				new_store_type = 'HQ';
				type_message = MESSAGE.storeManage.newHQ;
				break;
			case 'HQ' :
				new_store_type = 'PART';
				type_message = MESSAGE.storeManage.newPart;
				break;
			case 'PART' :
				new_store_type = 'TEAM';
				type_message = MESSAGE.storeManage.newTeam;
				break;
			case 'TEAM' :
				new_store_type = 'STORE';
				type_message = MESSAGE.storeManage.newStore;
				break;
			default :
				return;
		}
		var ref = $('#tree').jstree(true),
			sel = ref.get_selected();
		if( !sel.length ){ return false; }
		var saveId = null;
		if( this.selectNodeData != null ) saveId = this.selectNodeData.id;
		sel = sel[0];
		sel = ref.create_node( sel, { type : new_store_type, isNew : true, text : type_message });
		var dataObj = ref.get_json(sel);
		this.treeDataArr.push( dataObj );
		
		//중간에 없고 제일 밑에 있는 노드일때
		if( saveId != null ){
			if( $("#" + saveId ).parent().children().length - 1 == $("#" + saveId ).index() ){
				$("#" + saveId ).addClass('jstree-last'); //부모필드 선 지우기
			}
		}
		
	},
	
	saveTreeData : function(){
		
	},
	
	getTreeData : function(){
		var ref = $('#tree').jstree(true);
		var jsonData = ref.get_json();
	},
	
	getParentData : function( id ){
		var item = null;
		for( var i = 0; i<this.treeDataArr.length; i++ ){
			if( this.treeDataArr[i].id == id ){
				item = this.treeDataArr[i];
				break;
			}
		}
		return item;
	},
	
	//신규등록후 수정으로 변경
	updateNodeData : function( id ){
		var selectId = null;
		var ref = $('#tree').jstree(true);
		var sel = ref.get_selected();
		ref.rename_node( sel, $("#storeManage_name").val() );
		
		if( this.selectNodeData.original.isNew == true ){
			var saveId = this.selectNodeData.id; 
			this.selectNodeData.id = id;
			this.selectNodeData.original.isNew = null;
			
			ref.set_id( sel, id );
			$( "#" + saveId ).attr({ 'id' : id });
			
			$( "#"+ id ).find('a').attr({ 'id' : id + "_anchor" });
			
			var obj = ref.get_json(saveId);
			obj.type = $("#storeManageStoreType").val();
			this.updateOrigindata( saveId, obj );
			
			selectId = id;
		}else{
			selectId = this.selectNodeData.id;
		}
		
		var focusLink = $( "#"+ selectId ).find('a').eq(0);
		var html = focusLink.html();
		if( html != null ){
			var newHtml = html.split('</i>')[0] + '</i>' + $("#storeManage_name").val();
			focusLink.html(newHtml);
		}
		
		$("[btnId=btnArea]").remove();
		this.makePlusMinusBtn( selectId );
		
	},
	
	updateOrigindata : function( id, data ){
		for( var i = 0; i < this.treeDataArr.length; i++ ){
			if( this.treeDataArr[i].id == id ){
				this.treeDataArr[i] = data;
			}
		}
	},
	
	refresh : function(){
		this.isRefresh = 1;
		$("#tree").jstree(true).refresh();
	},
	
	setTreeData : function(){
		var ref = $('#tree').jstree(true),
		sel = ref.get_selected();
		
		ref.rename_node( sel, $("#storeManage_name").val() );
	},
	
	getCommonCode : function(){
		var _this = this;
		$.ifvSyncPostJSON( this.commcodeUrl, {
			groupCode : 'ACCOUNT_DATA_TYPE'
		}, function(result) {
			var temp = $("#storeManageCommCodeTemplate").tmpl(result.rows);
			$("#storeManageStoreType").append(temp);
			
			_this.storeType = $("#storeManageStoreType").val();
		});
	},
	
	showHideEventSetting : function(){
		var duration = 250;
		var _this = this;
		$("#btnMinitree").click(function(){
			if( _this.isSnbShow == true ){
				_this.isSnbShow = false;
				$("#treeMenu").stop().animate({left:-140}, duration );
				$("#manageContent").stop().animate({marginLeft:10}, duration);
				$("#btnMinitree").rotate(180);
				$("#btnMinitree").css('right','-10px');
			}else{
				_this.isSnbShow = true;
				$("#treeMenu").stop().animate({left:0}, duration);
				$("#manageContent").stop().animate({marginLeft:150}, duration);
				$("#btnMinitree").rotate(0);
				$("#btnMinitree").css('right','0px');
			}
		});
	}
	
	
};

function setGoogleMapLang() {
	//document.write('<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=places&language=' + lang + '&region=' + country + '"></script>');
	var s = document.createElement("script");
	s.type = "text/javascript";
	s.src = 'https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=places&language=' + lang + '&region=' + country;
	$("head").append(s);
}