<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
var MenuId = null;

function chageSideMenu() {
    var sideMenus = $("ul.leftMenu>li");
    var sideMenuBtns = $(">a", sideMenus);
    sideMenuBtns.on("click", function(event) {
        if ( $(this).next("ul").length ) {
           var idx = sideMenus.index(this);
           sideMenus.each(function(i) {
               if ( i == idx) {
                   $(this).toggleClass("active open");
               } else {
                   $(this).removeClass();
               }
           });
           event.preventDefault ? event.preventDefault() : (event.returnValue = false);
        } else {
        	$(this).parent().siblings().removeClass('active open');
        	$(this).parent().parent().find("ul:visible").slideUp(235, function(){
        		$(this).parent("li").find("b:first").html('<em class="fa fa-plus-square-o"></em>');
        	});
        	$(this).parent().addClass('active');
        }
    });
};

function setLeftMenu(obj) {
	for(var key in obj) {
		var buf = '';
		$(obj[key]).each(function(index, item){
			var data = '';
			if(key == 'levelFirst') {
				if(item.imgURL){
					$(item.imgURL.split('\\')).each(function(index, item){
						data+=item+'/';
					});
				}

				data = data.substring(0,data.length-1);
			}

			var itemId;
			if(item.progPath){
				itemId = item.progPath.substring(item.progPath.lastIndexOf('/')+1);
				itemId = itemId.substring(0,itemId.lastIndexOf('.'));
			}

			if(buf!=item.menuId){
				var childItem =$('<li/>').attr('id',itemId).attr('data-menuId', item.menuId);
				var childA = $('<a/>');

				if(key != 'levelFirst') {
					if($('[data-menuId=' + item.parentMenuId +']').children('ul').length == 0) {
						var classString = 'sub';
						if(key == 'levelThird') {
							classString += ' sub2';
							$('[data-menuId=' + item.parentMenuId +']').addClass('hasSub')
						}
						$('[data-menuId=' + item.parentMenuId +']').append('<ul class="' + classString + '"></ul>');
					}
				}

				if(item.progPath) {
					childA.click(function(){
						var object = item;
						var path = object.progPath;
						path = path.substring(0,path.lastIndexOf("."));
						localStorage.clear(); // 로컬스트로지 초기화
						qtjs.href('${pageContext.request.contextPath}/'+path);
						//location.href = '${pageContext.request.contextPath}/'+path;
					});
				}
				//메뉴 아이콘 넣어주기 (수정중)
				<%-- var serverPath = "<%=BeansUtil.getApplicationProperty("icignal.context.resource.menu-icon-path")%>";--%>
				var iconImgPath = item.iconImg;
				var a ="";
				if(iconImgPath != null){
					a = childA.attr('href','javascript:;').attr('class',itemId)
					.attr('title',item.menuName).css({"background":"url("+iconImgPath+")"}).css({"background-repeat":"no-repeat"}).css({"background-position":"9% 55%"})
					.append($('<span/>').attr('class','menu-item-parent').text(item.menuName))
				}else{
					a = childA.attr('href','javascript:;').attr('class',itemId)
					.attr('title',item.menuName)
					.append($('<span/>').attr('class','menu-item-parent').text(item.menuName))
				}
				var parentItem = childItem.append( a );
				if(key == 'levelFirst')
					$('#infavorMenu').append(parentItem);
				else
					$('[data-menuId=' + item.parentMenuId +']').children('ul').append(parentItem);
			}
			buf = item.menuId;
		});
	}
}

$(function() {
	//var sideMenuHeight;
	/* 20150602 update. 왼쪽메뉴 높이 조절 */
	/*$(window).on("resize load", function() {
	if ( !sideMenuHeight ) { sideMenuHeight = $('#sideMenu').outerHeight(); };
	var maxHeight = Math.max( sideMenuHeight, $("body").outerHeight(), $(window).outerHeight() );
	$('#sideMenu').outerHeight( maxHeight );
	}); */

	/*
	* Request for MenuList
	*/
	$.ifvSyncPostJSON('<ifvm:action name="getMenuFront"/>',null,
	function(result){
		$('#infavorMenu').empty();

		var lnbObj = {
			levelFirst : []
			, levelSecond : []
			, levelThird : []
		};
		/*
		* Allow proper Programs only
		*/

		$(result).each(function(index, item){
			if(item.menuLevel == 1) {
				lnbObj.levelFirst.push(item);
			} else if(item.menuLevel == 2) {
				lnbObj.levelSecond.push(item);
			} else if(item.menuLevel == 3) {
				lnbObj.levelThird.push(item);
			}
		});

		setLeftMenu(lnbObj);

		chageSideMenu();

		$('#navTag').css('display','');

		var pathName = window.location.pathname;
		var pathId = pathName.substring(pathName.lastIndexOf('/')+1);

		$.ifvmLnbSetting(pathId);
	});
});
</script>


<aside id="sideMenu">
    <div class="side-logo">
        <h1 class="ymAdminLogo" id='hiddenBtn'>Marketing</h1>
    </div>
    <nav id='navTag' style='display : none'>
        <ul class="leftMenu" id='infavorMenu' style='overflow:hidden;'></ul>
    </nav>
    <span class="minifyme"><a href="#"><i class="fa fa-arrow-circle-left hit"></i></a></span>
</aside>