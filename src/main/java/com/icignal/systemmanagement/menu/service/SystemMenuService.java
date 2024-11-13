
package com.icignal.systemmanagement.menu.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.request.MultiUploadReqDto;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.MultiUploadResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.base.service.CommonService;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.CommonUtil.IMAGE_UPLOAD_TYPE;
import com.icignal.common.util.LogUtil;
import com.icignal.systemmanagement.menu.dto.request.SystemMenuListReqDto;
import com.icignal.systemmanagement.menu.dto.response.SystemMenuListResDto;
import com.icignal.systemmanagement.menu.dto.response.SystemMenuListResDto2;
import com.icignal.systemmanagement.menu.mapper.SystemMenuMapper;



/*
 * 1. 클래스명	: SystemMenuService
 * 2. 파일명	: SystemMenuService.java
 * 3. 패키지명	: com.icignal.systemmanagement.menu.service
 * 4. 작성자명	: 표민종
 * 5. 작성일자	: 2017. 3. 9.
 */
/**
 * <PRE>
 * 1. 설명
 *		SystemManagement - Menu 관리 Service
 * </PRE>
 */ 
@Service("SystemMenuService")
public class SystemMenuService {

	@Autowired
	private SystemMenuMapper systemMenuMapper;
	
	@Autowired
	CommonService CommonService;

	 /*
	  * 1. 메소드명: getMenuList
	  * 2. 클래스명: SystemMenuService
	  * 3. 작성자명: 표민종 
	  * 4. 작성일자: 2017. 3. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		menuListNew.jsp의 메류트리 정보 불러오는 Method
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mlr
	 *   @return	
	 */
	public List<SystemMenuListResDto> getMenuList(SystemMenuListReqDto mlr) {
		LogUtil.param(SystemMenuService.class, mlr);
		mlr.setSVCAlias("mar");
		
		return systemMenuMapper.getMenuList(mlr);
		
	}

	 /*
	  * 1. 메소드명: getAuthMenuProgList
	  * 2. 클래스명: SystemMenuService
	  * 3. 작성자명: 표민종 
	  * 4. 작성일자: 2017. 3. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		메뉴에 등록된 프로그램 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mlr
	 *   @return	
	 */
	public GridPagingResDto<SystemMenuListResDto> getAuthMenuProgList(SystemMenuListReqDto mlr) {
		LogUtil.param(SystemMenuService.class, mlr);
		mlr.setSVCAlias("p");
		
		return new GridPagingResHelper<SystemMenuListResDto>().newGridPagingResDto(
				mlr.init(CommonUtil.getInstance().getDBType()), systemMenuMapper.getAuthMenuProgList(mlr)) ;
	}

	 /*
	  * 1. 메소드명: deleteMenuList
	  * 2. 클래스명: SystemMenuService
	  * 3. 작성자명: 표민종 
	  * 4. 작성일자: 2017. 3. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		메뉴 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bdmr
	 *   @return	
	 */
	public StatusResDto deleteMenuList(SystemMenuListReqDto bdmr) {
		LogUtil.param(SystemMenuService.class, bdmr);
		StatusResDto rtnValue = new StatusResDto();
		
		rtnValue.setSuccess(false);
		bdmr.setMenuId(bdmr.getArray().get(0).getMenuId());
		bdmr.setParentMenuId(bdmr.getArray().get(0).getParentMenuId());
		
		
		//메뉴마스터 삭제
		systemMenuMapper.deleteMenuList(bdmr);
		
		//메뉴 프로그램 관계 삭제
		systemMenuMapper.deleteMenuProgRel(bdmr);
		
		//메뉴 이미지 삭제
		bdmr.setSVCAlias("");
		systemMenuMapper.deleteMenuImage(bdmr);
		
		
		rtnValue.setSuccess(true);
		
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: addAuthMenuList
	  * 2. 클래스명: SystemMenuService
	  * 3. 작성자명: 표민종 
	  * 4. 작성일자: 2017. 3. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		메뉴 등록
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mlr
	 *   @param session
	 *   @return	
	 */
	public SystemMenuListResDto2 addAuthMenuList(SystemMenuListReqDto mlr, HttpSession session) {
		LogUtil.param(SystemMenuService.class, mlr);
		
		SystemMenuListResDto2 rtnValue = new SystemMenuListResDto2();
		String newMenuId = CommonUtil.newRid();
		
		rtnValue.setSuccess(false);
		rtnValue.setMenuId(newMenuId);
		mlr.setMemId(newMenuId);
		
		//메뉴 마스터 기본 메뉴명 셋팅(현재 로그인한 국가와 동일한 메뉴명으로 셋팅)
		for(int i=0; i<mlr.getMenuNames().size(); i++){
			
			if(mlr.getLang().equals(mlr.getMenuNames().get(i).getLangCode())){
				
				mlr.setMenuName(mlr.getMenuNames().get(i).getLangName());
			}
		}
		if(mlr.getMenuNames().size() > 0){
			if(!mlr.isUpdate()){
//				rtnValue = systemMenuMapper.addAuthMenuList(mlr);
				//메뉴마스터 등록
				systemMenuMapper.addAuthMenuList(mlr);
				rtnValue.setSuccess(true);
			}
			else{
//				rtnValue = systemMenuMapper.updateMenuList(mlr);
				//메뉴마스터 업데이트
				systemMenuMapper.updateMenuList(mlr);
				rtnValue.setSuccess(true);
			}
		}

		if(rtnValue.getSuccess() && mlr.getFileName() != null  && !mlr.getFileName().equals("null") && !mlr.getFileName().equals("")){
			MultiUploadReqDto muReq = new MultiUploadReqDto();
			if(mlr.getMenuId()==null){
				muReq.setParentId(rtnValue.getMenuId());
			}else{
				muReq.setParentId(mlr.getMenuId());
			}
			muReq.setCategory(IMAGE_UPLOAD_TYPE.MENU_ICON);
			muReq.setRotateAngle("0");
			muReq.setFileName(mlr.getTestFileName());
			muReq.setLang(mlr.getLang());
			
			//메뉴 이미지 세팅
			muReq.setFileName(mlr.getFileName());
			muReq.setOriName(mlr.getOriName());
			muReq.setFilePath(mlr.getFilePath());
			muReq.setSchemas("com");
			
			MultiUploadResDto mur = CommonService.multiUploadImage(session.getServletContext().getRealPath("/"), session.getId(), muReq);
		
			rtnValue.setSuccess(mur.getSuccess());

		}
		
		
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getAuthMenuListPop
	  * 2. 클래스명: SystemMenuService
	  * 3. 작성자명: 표민종 
	  * 4. 작성일자: 2017. 3. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		메뉴 프로그램 관계 등록 모달창
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mlr
	 *   @return	
	 */
	public GridPagingResDto<SystemMenuListResDto> getAuthMenuListPop(SystemMenuListReqDto mlr) {
		LogUtil.param(SystemMenuService.class, mlr);
		mlr.setSVCAlias("p");
		
		return new GridPagingResHelper<SystemMenuListResDto>().newGridPagingResDto(
				mlr.init(CommonUtil.getInstance().getDBType()), systemMenuMapper.getAuthMenuListPop(mlr));
	}

	 /*
	  * 1. 메소드명: addAuthMenuListProg
	  * 2. 클래스명: SystemMenuService
	  * 3. 작성자명: 표민종 
	  * 4. 작성일자: 2017. 3. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		메뉴 프로그램 관계 등록
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mlr
	 *   @return	
	 */
	public StatusResDto addAuthMenuListProg(SystemMenuListReqDto mlr) {
		LogUtil.param(SystemMenuService.class, mlr);
		StatusResDto rtnValue = new StatusResDto();

		mlr.setId(CommonUtil.newRid());
		systemMenuMapper.addAuthMenuListProg(mlr);

		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: delAuthMenuListProg
	  * 2. 클래스명: SystemMenuService
	  * 3. 작성자명: 표민종 
	  * 4. 작성일자: 2017. 3. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		메뉴 프로그램 관계 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mlr
	 *   @return	
	 */
	public StatusResDto delAuthMenuListProg(SystemMenuListReqDto mlr) {
		LogUtil.param(SystemMenuService.class, mlr);
		mlr.setSVCAlias("");
		StatusResDto rtnValue = new StatusResDto();
		systemMenuMapper.delAuthMenuListProg(mlr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: updateSortMenu
	  * 2. 클래스명: SystemMenuService
	  * 3. 작성자명: 표민종 
	  * 4. 작성일자: 2017. 3. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		메뉴 트리 순서 정렬
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mlr
	 *   @return	
	 */
	public StatusResDto updateSortMenu(SystemMenuListReqDto mlr) {
		LogUtil.param(SystemMenuService.class, mlr);
		StatusResDto rtnValue = new StatusResDto();
		systemMenuMapper.updateSortMenu(mlr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: updateMenuIcon
	  * 2. 클래스명: SystemMenuService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 25.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		메뉴 아이콘 변경
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mlr
	 *   @return	
	 */
	public StatusResDto updateMenuIcon(SystemMenuListReqDto mlr) {
		LogUtil.param(SystemMenuService.class, mlr);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		//aws 사용시
		String imageServerUrl = CommonUtil.getInstance().getImageServerUrl() + "/";
		mlr.setIconImg(imageServerUrl + mlr.getIconImg());
		//서버 사용시
		//String IMAGE_AP_URL = BeansUtil.getApplicationProperty("icignal.context.resource.menu-icon-path");
		//mlr.setIconImg(IMAGE_AP_URL + mlr.getIconImg());
		
		systemMenuMapper.updateMenuIcon(mlr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	public StatusResDto removeMenuIcon(SystemMenuListReqDto mlr) {
		LogUtil.param(SystemMenuService.class, mlr);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		systemMenuMapper.deleteMenuIcon(mlr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}
	
}