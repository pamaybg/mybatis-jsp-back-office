/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: MenuController.java
 * 2. Package	: com.icignal.auth.controller
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 2. 24. 오후 8:03:13
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 2. 24.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.auth.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.auth.dto.response.AuthorityMenuListResDto;
import com.icignal.common.base.dto.request.MenuFrontReqDto;
import com.icignal.common.util.LogUtil;


/*
 * 1. 클래스명	: MenuController
 * 2. 파일명	: MenuController.java
 * 3. 패키지명	: com.icignal.auth.controller
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 2. 24.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Controller
@RequestMapping("/marketing/manage")
public class MenuController{

	/*@Autowired
    public IMKTControlService iMKTControlService;*/
	

	/*@RequestMapping(value = "/{name:.+}")
	public String view(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response) {
		LogUtil.param(this.getClass(),null);			
		
		String url = "";
		if(name.equals("ownerGroupUpdate")){
			request.setAttribute("authGroupDetail", true);	
			url = "marketing/sm/ownerGroupDetail.default-tiles";	
		}else if(name.equals("programUpdate")){
			request.setAttribute("programDetail", true);
			url = "marketing/sm/programDetail.default-tiles";				
						
		}else if(name.equals("ownerListUpdate")){
			request.setAttribute("ownerListUpdate", true);
			url = "marketing/sm/ownerList.default-tiles";				

		}else{
			url = "marketing/sm/"+name+".default-tiles";
		}
		
		return this.checkUserInfo(request, response, url);
	}	*/
	
	/*@RequestMapping(value = "/popup/{name:.+}", method = RequestMethod.GET)
	public String NavigatePopMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response) {
		return  this.checkUserInfoInclude(request, response, "marketing/sm/popup/"+ name);
	}*/
		
	/**
	 * @name : getMenuFront
	 * @date : 2015. 10.20
	 * @author : 안형욱
	 * @return : StatusResponseDTO
	 * @description : 메인 페이지 메뉴 출력  
	 */			
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/getMenuFront.do", method = RequestMethod.POST)
	public @ResponseBody
	List<AuthorityMenuListResDto> getMenuFront(HttpServletRequest request, HttpServletResponse response, @RequestBody MenuFrontReqDto dto, HttpSession session) {
		LogUtil.param(this.getClass(),dto);	
	  
		//MKTLoginResponseDTO loginInfo = this.checkLoginSession(request, response);
		
       /* dto.setMemId(loginInfo.getId());
        dto.setAppServiceType(loginInfo.getAppServiceId());
        dto.setAccountId(loginInfo.getAccountOrgId());
        if (dto.getApplyType() == null || dto.getApplyType().length() == 0 ) { 
        	dto.setApplyType(CommonUtil.PGM_APPLY_TYPE_MARKETING);
        }*/
 	  
	
		List<AuthorityMenuListResDto> menuDump = new ArrayList<AuthorityMenuListResDto>();
		
		if(dto.isLoginPage()){
		//	LogUtil.debug("already logged");

			menuDump = (List<AuthorityMenuListResDto>) session.getAttribute("menuDump");
			List<AuthorityMenuListResDto> initialDump = new ArrayList<AuthorityMenuListResDto>();
			int num =0;
			
			while(menuDump.size()>num){
				if(menuDump.get(num).getProgPath()!=null){								
					initialDump.add(menuDump.get(num));
					break;
				}
				num++;
			}
			
			menuDump = initialDump;
		} else {
			menuDump = (List<AuthorityMenuListResDto>) session.getAttribute("menuDump");	
		}
  
		return menuDump;		
	}	

	/**
	 * @name : updateSortMenu 
	 * @date : 2015. 10. 20.
	 * @author : 안형욱
	 * @return : StatusResponseDTO
	 * @description : 메뉴 - 순서 업데이트 
	 *//*			
	@RequestMapping(value="/updateSortMenu.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResponseDTO updateSortMenu(HttpServletRequest request, HttpServletResponse response, @RequestBody MenuListRequestDTO dto, HttpSession session) {
		LogUtil.param(MKTSMController.class,dto);	
		MKTLoginResponseDTO loginInfo = this.checkLoginSession(request, response);

		dto.setEmpId(loginInfo.getEmpId());
		dto.setAccountId(loginInfo.getAccountOrgId());
		
		return iMKTControlService.updateSortMenu(dto);
	}	
	
	*//**
	 * @name : delMenuListProg 
	 * @date : 2015. 10. 20.
	 * @author : 안형욱
	 * @return : StatusResponseDTO
	 * @description : 메뉴 - 프로그램 삭제
	 *//*			
	@RequestMapping(value="/delMenuListProg.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResponseDTO delMenuListProg(HttpServletRequest request, HttpServletResponse response, @RequestBody MenuListRequestDTO dto, HttpSession session) {
		LogUtil.param(MKTSMController.class,dto);	
		MKTLoginResponseDTO loginInfo = this.checkLoginSession(request, response);			
		dto.setEmpId(loginInfo.getEmpId());
		
		return iMKTControlService.delMenuListProg(dto);
	}	
	
	*//**
	 * @name : getMenuProgList 
	 * @date : 2015. 10. 20.
	 * @author : 안형욱
	 * @return : MenuListResponseDTO
	 * @description : 메뉴 - 추가된 프로그램 조회   
	 *//*			
	@RequestMapping(value="/getMenuProgList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResponseDTO getMenuProgList(HttpServletRequest request, HttpServletResponse response, @RequestBody MenuListRequestDTO dto, HttpSession session) {
		LogUtil.param(MKTSMController.class,dto);	
		MKTLoginResponseDTO loginInfo = this.checkLoginSession(request, response);			
		dto.setEmpId(loginInfo.getEmpId());
		dto.setAccountId(loginInfo.getAccountOrgId());
		session.setAttribute("systemId", dto.getAppServiceType());
		
		return iMKTControlService.getMenuProgList(dto);
	}	
	
	*//**
	 * @name : getMenuListPop 
	 * @date : 2015. 10. 20.
	 * @author : 안형욱
	 * @return : MenuListResponseDTO
	 * @description : 메뉴 - 프로그램 추가 조회   
	 *//*				
	@RequestMapping(value="/getMenuListPop.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResponseDTO getMenuListPop(HttpServletRequest request, HttpServletResponse response, @RequestBody MenuListRequestDTO dto, HttpSession session) {
		LogUtil.param(MKTSMController.class,dto);	
		MKTLoginResponseDTO loginInfo = this.checkLoginSession(request, response);			
		dto.setEmpId(loginInfo.getEmpId());
		//dto.setAccountId(loginInfo.getAccountOrgId());

		return iMKTControlService.getMenuListPop(dto);
	}	
	
	*//**
	 * @name : addMenuListProg 
	 * @date : 2015. 10. 20.
	 * @author : 안형욱
	 * @return : StatusResponseDTO
	 * @description : 메뉴 - 프로그램 추가 
	 *//*			
	@RequestMapping(value="/addMenuListProg.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResponseDTO addMenuListProg(HttpServletRequest request, HttpServletResponse response, @RequestBody MenuListRequestDTO dto, HttpSession session) {
		LogUtil.param(MKTSMController.class,dto);
		MKTLoginResponseDTO loginInfo = this.checkLoginSession(request, response);			
		dto.setEmpId(loginInfo.getEmpId());
		session.setAttribute("systemId", dto.getAppServiceType());

		return iMKTControlService.addMenuListProg(dto);
	}
	
	*//**
	 * @name : deleteMenuList 
	 * @date : 2015. 10. 20.
	 * @author : 안형욱
	 * @return : StatusResponseDTO
	 * @description : 메뉴 삭제   
	 *//*	
	@RequestMapping(value="/deleteMenuList.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResponseDTO deleteMenuList(HttpServletRequest request, HttpServletResponse response, @RequestBody MenuListRequestDTO dto) {
		LogUtil.param(MKTSMController.class,dto);
		MKTLoginResponseDTO loginInfo = this.checkLoginSession(request, response);			
		dto.setEmpId(loginInfo.getEmpId());
        
		return iMKTControlService.deleteMenuList(dto);
	}
	
	*//**
	 * @name : getMenuList 
	 * @date : 2015. 10. 20.
	 * @author : 안형욱
	 * @return : MenuListResponseDTO
	 * @description : 메뉴 리스트 조회     
	 *//*	
	@RequestMapping(value="/getMenuList.do", method = RequestMethod.POST)
	public @ResponseBody
	List<MenuListResponseDTO> getMenuList(HttpServletRequest request, HttpServletResponse response, @RequestBody MenuListRequestDTO dto, HttpSession session) {
		LogUtil.param(MKTSMController.class,dto);		
		MKTLoginResponseDTO loginInfo = this.checkLoginSession(request, response);			
		//dto.setAccountId(loginInfo.getAccountOrgId());
		
		session.setAttribute("systemId", dto.getAppServiceType());
		return iMKTControlService.getMenuList(dto); 
	}	
	
	*//**
	 * @name : addMenuList 
	 * @date : 2015. 10. 20.
	 * @author : 안형욱
	 * @return : StatusResponseDTO
	 * @description : 메뉴 추가    
	 *//*	
	@RequestMapping(value="/addMenuList.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResponseDTO addMenuList(HttpServletRequest request, HttpServletResponse response, @RequestBody MenuListRequestDTO dto, HttpSession session) {
		LogUtil.param(MKTSMController.class,dto);
		MKTLoginResponseDTO loginInfo = this.checkLoginSession(request, response);			
		dto.setEmpId(loginInfo.getEmpId());
		//dto.setAccountId(loginInfo.getAccountOrgId());
		session.setAttribute("systemId", dto.getAppServiceType());

		return iMKTControlService.addMenuList(request.getSession().getServletContext().getRealPath("/"),dto,session);
	}
	
	*//**
	 * @name : delOwnerList 
	 * @date : 2015. 10. 20.
	 * @author : 안형욱
	 * @return : StatusResponseDTO
	 * @description : 권한 관리 - 사용자 삭제 
	 *//*	
	@RequestMapping(value="/delOwnerList.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResponseDTO delOwnerList(HttpServletRequest request, HttpServletResponse response, @RequestBody OwnerListRequestDTO dto) {
		LogUtil.param(MKTSMController.class,dto);
		MKTLoginResponseDTO loginInfo = this.checkLoginSession(request, response);			
		dto.setEmpId(loginInfo.getEmpId());
		return iMKTControlService.delOwnerList(dto);
	}
	
	*//**
	 * @name : getCommCode 
	 * @date : 2015. 10. 20.
	 * @author : 안형욱
	 * @return : BaseResponseDTO
	 * @description : 운영 관리 - 프로그램 적용유형(MARKETING) 조회 
	 *//*	
	@RequestMapping(value="/getCommCode.do", method = RequestMethod.POST)
	public @ResponseBody List<MKTCommCodeResponseDTO> getCommCode(ProgramListRequestDTO dto){
		LogUtil.param(MKTSMController.class,dto);	
		return iMKTControlService.getCommCode(dto);
	}	
	
	*//**
	 * @name : getOwnerProgList 
	 * @date : 2015. 10. 20.
	 * @author : 안형욱
	 * @return : ownerListResponseDTO
	 * @description : 권한 관리 - 프로그램 조회 
	 *//*	
	@RequestMapping(value="/getOwnerProgList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResponseDTO getOwnerProgList(HttpServletRequest request, HttpServletResponse response, @RequestBody OwnerListRequestDTO dto, HttpSession session) {
		LogUtil.param(MKTSMController.class,dto);	
		MKTLoginResponseDTO loginInfo = this.checkLoginSession(request, response);			
		dto.setAccountId(loginInfo.getAccountOrgId());
		return iMKTControlService.getOwnerProgList(dto);
	}	
	
	*//**
	 * @name : addOwnerProgList 
	 * @date : 2015. 10. 20.
	 * @author : 안형욱
	 * @return : StatusResponseDTO
	 * @description : 권한 관리 - 프로그램 추가  
	 *//*	
	@RequestMapping(value="/addOwnerProgList.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResponseDTO addOwnerProgList(HttpServletRequest request, HttpServletResponse response, @RequestBody OwnerListRequestDTO dto) {
		LogUtil.param(MKTSMController.class,dto);
		MKTLoginResponseDTO loginInfo = this.checkLoginSession(request, response);			
		dto.setEmpId(loginInfo.getEmpId());
		return iMKTControlService.addOwnerProgList(dto);
	}
	
	*//**
	 * @name : getOwnerProgListPop 
	 * @date : 2015. 10. 20.
	 * @author : 안형욱
	 * @return : ownerListResponseDTO
	 * @description : 권한 관리 - 프로그램 조회 
	 *//*		
	@RequestMapping(value="/getOwnerProgListPop.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResponseDTO getOwnerProgListPop(HttpServletRequest request, HttpServletResponse response, @RequestBody OwnerListRequestDTO dto, HttpSession session) {
		LogUtil.param(MKTSMController.class,dto);	

		MKTLoginResponseDTO loginInfo = this.checkLoginSession(request, response);			
		//dto.setAccountId(loginInfo.getAccountOrgId());
		return iMKTControlService.getOwnerProgListPop(dto);
	}	
	
	*//**
	 * @name : getOwnerList 
	 * @date : 2015. 10. 20.
	 * @author : 안형욱
	 * @return : ownerListResponseDTO
	 * @description : 권한 관리 - 사용자 조회 
	 *//*		
	
	@RequestMapping(value="/getOwnerList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResponseDTO getOwnerList(HttpServletRequest request, HttpServletResponse response, @RequestBody OwnerListRequestDTO dto, HttpSession session) {
		LogUtil.param(MKTSMController.class,dto);	
	
		MKTLoginResponseDTO loginInfo = this.checkLoginSession(request, response);			
		dto.setAccountId(loginInfo.getAccountOrgId());
		return iMKTControlService.getOwnerList(dto);
	}	
	
	*//**
	 * @name : getOwnerGroup 
	 * @date : 2015. 10. 20.
	 * @author : 안형욱
	 * @return : StatusResponseDTO
	 * @description : 권한 관리 - 권한 그룹 조회 
	 *//*		
	@RequestMapping(value="/getOwnerGroup.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResponseDTO getOwnerMemberList(HttpServletRequest request, HttpServletResponse response, @RequestBody OwnerListRequestDTO dto, HttpSession session) {
		LogUtil.param(MKTSMController.class,dto);	
		
		MKTLoginResponseDTO loginInfo = this.checkLoginSession(request, response);			
		dto.setAccountId(loginInfo.getAccountOrgId());
		session.setAttribute("systemId", dto.getAppServiceType());
		return iMKTControlService.getOwnerGroup(dto);
	}	
		 
	
	*//**
	 * @name : getOwnerListPop 
	 * @date : 2015. 10. 20.
	 * @author : 안형욱
	 * @return : StatusResponseDTO
	 * @description : 권한 관리 사용자 등록 사용자 확인 
	 *//*		
	@RequestMapping(value="/getOwnerListPop.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResponseDTO getOwnerListPop(HttpServletRequest request, HttpServletResponse response, @RequestBody OwnerListRequestDTO dto) {
		LogUtil.param(MKTSMController.class,dto);	
		MKTLoginResponseDTO loginInfo = this.checkLoginSession(request, response);			
		dto.setAccountId(loginInfo.getAccountOrgId());
		return iMKTControlService.getOwnerListPop(dto);
	}	
		
	
	*//**
	 * @name : addOwnerList 
	 * @date : 2015. 10. 20.
	 * @author : 안형욱
	 * @return : StatusResponseDTO
	 * @description : 권한 관리 사용자 추가      
	 *//*	
	@RequestMapping(value="/addOwnerList.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResponseDTO addOwnerList(HttpServletRequest request, HttpServletResponse response, @RequestBody OwnerListRequestDTO dto) {
		LogUtil.param(MKTSMController.class,dto);
		MKTLoginResponseDTO loginInfo = this.checkLoginSession(request, response);			
		dto.setEmpId(loginInfo.getEmpId());
		
		return iMKTControlService.addOwnerList(dto);
	}
	
	*//**
	 * @name : addDataAuthOwnerList 
	 * @date : 2015. 10. 20.
	 * @author : 안형욱
	 * @return : StatusResponseDTO
	 * @description : Data권한 관리 사용자 추가      
	 *//*	
	@RequestMapping(value="/addDataAuthOwnerList.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResponseDTO addDataAuthOwnerList(HttpServletRequest request, HttpServletResponse response, @RequestBody MKTsetDataAuthOwnerRequestDTO sdaor) {
		LogUtil.param(MKTSMController.class,sdaor);
		MKTLoginResponseDTO loginInfo = this.checkLoginSession(request, response);
		
		sdaor.setCreateBy(loginInfo.getEmpId());
		
		return iMKTControlService.addDataAuthOwnerList(sdaor);
	}
	
		
	
	*//**
	 * @name : getProgramList 
	 * @date : 2015. 10. 20.
	 * @author : 안형욱
	 * @return : programListResponseDTO
	 * @description : 프로그램 조회 
	 *//*
	@RequestMapping(value="/getProgramList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResponseDTO getProgramList(HttpServletRequest request, HttpServletResponse response, @RequestBody ProgramListRequestDTO dto, HttpSession session) {
		LogUtil.param(MKTSMController.class,dto);	
		MKTLoginResponseDTO loginInfo = this.checkLoginSession(request, response);			
		dto.setEmpId(loginInfo.getEmpId());
		//dto.setAccountId(loginInfo.getAccountOrgId());
		session.setAttribute("systemId", dto.getAppServiceType());
		return iMKTControlService.getProgramList(dto);
	}	
	
	*//**
	 * @name : addProgramList
	 * @date : 2015. 10. 20.
	 * @author : 안형욱
	 * @return : StatusResponseDTO
	 * @description : 프로그램 추가 
	 *//*
	@RequestMapping(value="/addProgramList.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResponseDTO addProgramList(HttpServletRequest request, HttpServletResponse response, @RequestBody ProgramListRequestDTO dto) {
		LogUtil.param(MKTSMController.class,dto);
		MKTLoginResponseDTO loginInfo = this.checkLoginSession(request, response);			
		dto.setId(loginInfo.getId());
		//dto.setAccountId(loginInfo.getAccountOrgId());
		return iMKTControlService.addProgramList(dto);
	}
	
	*//**
	 * @name : getProgramDetail
	 * @date : 2015. 10. 20.
	 * @author : 안형욱
	 * @return : programListResponseDTO
	 * @description : 프로그램 상세 
	 *//*
	@RequestMapping(value="/getProgramDetail.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResponseDTO getProgramDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody ProgramListRequestDTO dto, HttpSession session) {
		LogUtil.param(MKTSMController.class,dto);	

		MKTLoginResponseDTO loginInfo = this.checkLoginSession(request, response);			
		dto.setAccountId(loginInfo.getAccountOrgId());
		return iMKTControlService.getProgramDetail(dto);
	}	
	
	*//**
	 * @name : updateProgramList
	 * @date : 2015. 11. 12.
	 * @author : 안형욱
	 * @return : StatusResponseDTO
	 * @description : 프로그램 수정  
	 *//*
	@RequestMapping(value="/updateProgramList.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResponseDTO updateProgramList(HttpServletRequest request, HttpServletResponse response, @RequestBody ProgramListRequestDTO dto) {
		LogUtil.param(MKTSMController.class,dto);
		MKTLoginResponseDTO loginInfo = this.checkLoginSession(request, response);			
		dto.setLoginInfo(loginInfo);
		
		return iMKTControlService.updateProgramList(dto);
	}
	
	*//**
	 * @name : delProgramList
	 * @date : 2015. 11. 12.
	 * @author : 안형욱
	 * @return : StatusResponseDTO
	 * @description : 프로그램 삭제 
	 *//*
	
	@RequestMapping(value="/delProgramList.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResponseDTO delProgramList(HttpServletRequest request, HttpServletResponse response, @RequestBody ProgramListRequestDTO dto) {
		LogUtil.param(MKTSMController.class,dto);
		MKTLoginResponseDTO loginInfo = this.checkLoginSession(request, response);			
		dto.setEmpId(loginInfo.getEmpId());
		dto.setAccountId(loginInfo.getAccountOrgId());
		StatusResponseDTO rtnVal = iMKTControlService.delProgramList(dto);
		//return iMKTControlService.delProgramList(dto);
		return rtnVal;
	}	
	
	
	
	*//**
	 * @name : getSystem
	 * @date : 2015. 10. 26.
	 * @author : 안형욱
	 * @return : MKTControlGridResponseDTO
	 * @description : 시스템명 조회 
	 *//*
	@RequestMapping(value="/getSystem.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResponseDTO getSystem(HttpServletRequest request, HttpServletResponse response, @RequestBody MKTControlDTO dto) {
		LogUtil.param(MKTSMController.class,dto);	
		this.checkLoginSession(request, response);		
		return iMKTControlService.getSystem(dto);
	}
	
	*//**
	 * @name : getAuthGroupType
	 * @date : 2015. 10.26.
	 * @author : 안형욱
	 * @return : MKTControlGridResponseDTO
	 * @description : 권한그룹 유형 조회 
	 *//*
	@RequestMapping(value="/getAuthGroupType.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResponseDTO getAuthGroupType(HttpServletRequest request, HttpServletResponse response, @RequestBody MKTControlDTO dto) {
		LogUtil.param(MKTSMController.class,dto);	
		this.checkLoginSession(request, response);		
		return iMKTControlService.getAuthGroupType(dto);
	}	
	
	*//**
	 * @name : getAuthGroup
	 * @date : 2015. 10. 20.
	 * @author : 안형욱
	 * @return : MKTControlGridResponseDTO
	 * @description : 화면 권한그룹 조회 
	 *//*
	@RequestMapping(value="/getAuthGroup.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResponseDTO getAuthGroup(HttpServletRequest request, HttpServletResponse response, @RequestBody MKTControlDTO dto, HttpSession session) {
		LogUtil.param(MKTSMController.class,dto);

		MKTLoginResponseDTO loginInfo = this.checkLoginSession(request, response);			
		dto.setAccountId(loginInfo.getAccountOrgId());
		session.setAttribute("systemId", dto.getAppServiceId());		
		return iMKTControlService.getAuthGroup(dto);
	}

	
	
	*//**
	 * @name : addAuthGroup
	 * @date : 2015. 10. 20.
	 * @author : 안형욱
	 * @return : StatusResponseDTO
	 * @description : 권한그룹 추가 
	 *//*
	@RequestMapping(value="/addAuthGroup.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResponseDTO addAuthGroup(HttpServletRequest request, HttpServletResponse response, @RequestBody MKTControlDTO dto) {
		LogUtil.param(MKTSMController.class,dto);
		MKTLoginResponseDTO loginInfo = this.checkLoginSession(request, response);			
		dto.setId(loginInfo.getId());
		dto.setAccountId(loginInfo.getAccountOrgId());
		return iMKTControlService.addAuthGroup(dto);
	}
	

	*//**
	 * @name : getAuthGroupDetail
	 * @date : 2015. 10.20
	 * @author : 안형욱
	 * @return : adminControlResponseDTO
	 * @description : 권한그룹 상세 페이지 이동  
	 *//*
	@RequestMapping(value="/getAuthGroupDetail.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResponseDTO getAuthGroupDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody MKTControlDTO dto) {
		LogUtil.param(MKTSMController.class,dto);	

		MKTLoginResponseDTO loginInfo = this.checkLoginSession(request, response);			
		dto.setAccountId(loginInfo.getAccountOrgId());
		return iMKTControlService.getAuthGroupDetail(dto);
	}
	
	*//**
	 * @name : updateAuthGroup
	 * @date : 2015. 10.20
	 * @author : 안형욱
	 * @return : StatusResponseDTO
	 * @description : 권한그룹 정보 수정   
	 *//*
	@RequestMapping(value="/updateAuthGroup.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResponseDTO updateAuthGroup(HttpServletRequest request, HttpServletResponse response, @RequestBody MKTControlDTO dto) {
		LogUtil.param(MKTSMController.class,dto);		
		MKTLoginResponseDTO loginInfo = this.checkLoginSession(request, response);	
		dto.setModifyBy(loginInfo.getAccountOrgId());
		dto.setAccountId(loginInfo.getAccountOrgId());
		return iMKTControlService.updateAuthGroup(dto);
	}
	
	*//**
	 * @name : delAuthGroup
	 * @date : 2015. 10.20
	 * @author : 안형욱
	 * @return : StatusResponseDTO
	 * @description : 권한그룹 삭제   
	 *//*	
	@RequestMapping(value="/delAuthGroup.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResponseDTO delAuthGroup(HttpServletRequest request, HttpServletResponse response, @RequestBody MKTControlDTO dto) {
		LogUtil.param(MKTSMController.class,dto);		
		MKTLoginResponseDTO loginInfo = this.checkLoginSession(request, response);			
		dto.setModifyBy(loginInfo.getId());		
		dto.setAccountId(loginInfo.getAccountOrgId());
		return iMKTControlService.delAuthGroup(dto);
	}
	
	*//**
	 * @name : getAuthMenuNeo 
	 * @date : 2015. 10.20
	 * @author : 안형욱
	 * @return : List<MenuListResponseDTO>
	 * @description : 운영관리 - 메뉴 조회
	 *//*	
	@RequestMapping(value="/getAuthMenuNeo.do", method = RequestMethod.POST)
	public @ResponseBody
	List<MenuListResponseDTO> getAuthMenuNeo(HttpServletRequest request, HttpServletResponse response, @RequestBody MenuListRequestDTO dto, HttpSession session) {
		LogUtil.param(MKTSMController.class,dto);	
		
		MKTLoginResponseDTO loginInfo = this.checkLoginSession(request, response);			
		dto.setAccountId(loginInfo.getAccountOrgId());
		session.setAttribute("systemId", dto.getAppServiceType());
		
		return iMKTControlService.getAuthMenuNeo(dto); 
	}	
	
	*//**
	 * @name : getCommCodeGridList 
	 * @date : 2015. 10.20
	 * @author : 안형욱
	 * @return : GridPagingResponseDTO
	 * @description : 공통코드 조회
	 *//*	
	@RequestMapping(value="/getCommCodeGridList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResponseDTO getCommCodeGridList(HttpServletRequest request, HttpServletResponse response, @RequestBody CommCodeGridListRequestDTO ccglr) {
		LogUtil.param(MKTSMController.class, ccglr);
		this.checkLoginSession(request, response);
		
		return iMKTControlService.getCommCodeGridList(ccglr);
	}
	
	*//**
	 * @name : editCommCodeFlag 
	 * @date : 2015. 10.20
	 * @author : 안형욱
	 * @return : StatusResponseDTO
	 * @description : 다중선택한 공통코드 삭제 처리(flag를 0으로 업데이트)
	 *//*	
	@RequestMapping(value="/editCommCodeFlag.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResponseDTO editCommCodeFlag(HttpServletRequest request, HttpServletResponse response, @RequestBody CommCodeUpdateFlagRequestDTO ccufr) {
		LogUtil.param(MKTSMController.class, ccufr);
		MKTLoginResponseDTO loginInfo = this.checkLoginSession(request, response);
		ccufr.setUserId(loginInfo.getEmpId());//수정자는 로그인한 계정의 ID 이므로 empId 선택한다.
		
		return iMKTControlService.editCommCodeFlag(ccufr);
	}
	
	*//**
	 * @name : getCommCodeLangByIdList 
	 * @date : 2015. 10.20
	 * @author : 안형욱
	 * @return : GridPagingResponseDTO
	 * @description : 해당 아이디로 등록 가능한 언어 목록 조회
	 *//*	
	@RequestMapping(value="/getCommCodeLangByIdList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResponseDTO getCommCodeLangByIdList(HttpServletRequest request, HttpServletResponse response, @RequestBody CommCodeLangListByIdRequestDto ccllbir) {
		LogUtil.param(MKTSMController.class, ccllbir);
		this.checkLoginSession(request, response);
		
		return iMKTControlService.getCommCodeLangByIdList(ccllbir);
	}
	
	*//**
	 * @name : addCommCode
	 * @date : 2015. 10.20
	 * @author : 안형욱
	 * @return : StatusResponseDTO
	 * @description : 공통코드 등록하기 
	 *//*
	@RequestMapping(value="/addCommCode.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResponseDTO addCommCode(HttpServletRequest request, HttpServletResponse response, @RequestBody CommCodeInsertRequestDTO ccir) {
		LogUtil.param(MKTSMController.class,ccir);	
		
		StatusResponseDTO rtnValue = new StatusResponseDTO();
		
		MKTLoginResponseDTO loginInfo = this.checkLoginSession(request, response);
		ccir.setUserId(loginInfo.getEmpId());
		
		rtnValue = iMKTControlService.addCommCode(ccir);
		return rtnValue;
	}
	
	*//**
	 * @name : getCommCodeCountry 
	 * @date : 2015. 10.20
	 * @author : 안형욱
	 * @return : GridPagingResponseDTO
	 * @description : 국가 목록 조회
	 *//*	
	@RequestMapping(value="/getCommCodeCountry.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResponseDTO getCommCodeCountry(HttpServletRequest request, HttpServletResponse response, @RequestBody MKTControlDTO dto) {
		LogUtil.param(MKTSMController.class,dto);	
		this.checkLoginSession(request, response);
		
		return iMKTControlService.getCommCodeCountry(dto);
	}
	
	
	*//**
	 * @name : getCommCodeDetail 
	 * @date : 2015. 10.20
	 * @author : 안형욱
	 * @return : CommCodeDetailResponseDTO
	 * @description : 공통코드 상세 조회
	 *//*	
	@RequestMapping(value="/getCommCodeDetail.do", method = RequestMethod.POST)
	public @ResponseBody
	CommCodeDetailResponseDTO getCommCodeDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody CommCodeDetailRequestDTO ccdr) {
		LogUtil.param(MKTSMController.class,ccdr);	
		this.checkLoginSession(request, response);

		return iMKTControlService.getCommCodeDetail(ccdr);
	}	
	
	*//**
	 * @name : editCommCode
	 * @date : 2015. 10.20
	 * @author : 안형욱
	 * @return : StatusResponseDTO
	 * @description : 공통코드 수정하기 
	 *//*
	@RequestMapping(value="/editCommCode.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResponseDTO editCommCode(HttpServletRequest request, HttpServletResponse response, @RequestBody CommCodeInsertRequestDTO ccir) {
		LogUtil.param(MKTSMController.class,ccir);	
		
		StatusResponseDTO rtnValue = new StatusResponseDTO();
		
		MKTLoginResponseDTO loginInfo = this.checkLoginSession(request, response);
		ccir.setUserId(loginInfo.getEmpId());
		
		rtnValue = iMKTControlService.editCommCode(ccir);
		return rtnValue;
	}
	
	*//**
	 * @name : getDataAuthGroup
	 * @date : 2015. 12. 21.
	 * @author : 안형욱
	 * @return : GridPaingResponseDTO
	 * @description : 데이터 권한 리스트 조회
	 *//*
	@RequestMapping(value="/getDataAuthGroup.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResponseDTO getDataAuthGroup(HttpServletRequest request, HttpServletResponse response, @RequestBody MKTDataAuthListRequestDTO dalr, HttpSession session) {
		LogUtil.param(MKTSMController.class,dalr);

		MKTLoginResponseDTO loginInfo = this.checkLoginSession(request, response);
		
		session.setAttribute("systemId", dalr.getAppServiceId());
		
		dalr.setAccountId(loginInfo.getAccountOrgId());
		
		return iMKTControlService.getDataAuthGroup(dalr);
	}
	
	*//**
	 * @name : getDataOwnerList
	 * @date : 2015. 12. 21.
	 * @author : 안형욱
	 * @return : GridPaingResponseDTO
	 * @description : 데이터 권한 사용자 조회
	 *//*
	@RequestMapping(value="/getDataOwnerList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResponseDTO getDataOwnerList(HttpServletRequest request, HttpServletResponse response, @RequestBody MKTDataOwnerListRequestDTO dto, HttpSession session) {
		LogUtil.param(MKTSMController.class,dto);
		
		MKTLoginResponseDTO loginInfo = this.checkLoginSession(request, response);
		
		dto.setAccountId(loginInfo.getAccountOrgId());
		
		
		session.setAttribute("systemId", dto.getAppServiceId());
		
		return iMKTControlService.getDataOwnerList(dto);
	}
	*//**
	 * @name : getEmpList
	 * @date : 2015. 12. 21.
	 * @author : 안형욱
	 * @return : GridPaingResponseDTO
	 * @description : 직원 조회
	 *//*
	@RequestMapping(value="/getEmpList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResponseDTO getEmpList(HttpServletRequest request, HttpServletResponse response, @RequestBody MKTEmpListRequestDTO elr, HttpSession session) {
		LogUtil.param(MKTSMController.class,elr);
	
		MKTLoginResponseDTO loginInfo = this.checkLoginSession(request, response);

		elr.setAccountId(loginInfo.getAccountOrgId());
		return iMKTControlService.getEmpList(elr);
	}
	
	*//**
	 * @name : delDataAuthOwnerList
	 * @date : 2015. 12. 21.
	 * @author : 안형욱
	 * @return : StatusResponseDTO
	 * @description : Data권한을 가진 직원 삭제
	 *//*
	@RequestMapping(value="/delDataAuthOwnerList.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResponseDTO delDataAuthOwnerList(HttpServletRequest request, HttpServletResponse response, @RequestBody MKTDelDataAuthOwnerRequestDTO dolr, HttpSession session) {
		LogUtil.param(MKTSMController.class,dolr);
				
		MKTLoginResponseDTO loginInfo = this.checkLoginSession(request, response);
		dolr.setModifyBy(loginInfo.getAccountOrgId());

		return iMKTControlService.delDataAuthOwnerList(dolr);
	}
	*//**
	 * @name : delDataAuthGroupList
	 * @date : 2015. 12. 21.
	 * @author : 안형욱
	 * @return : StatusResponseDTO
	 * @description : Data권한 그룹 삭제
	 *//*
	@RequestMapping(value="/delDataAuthGroupList.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResponseDTO delDataAuthGroupList(HttpServletRequest request, HttpServletResponse response, @RequestBody MKTDelDataAuthGroupRequestDTO ddagr, HttpSession session) {
		LogUtil.param(MKTSMController.class,ddagr);
		
		MKTLoginResponseDTO loginInfo = this.checkLoginSession(request, response);
		
		ddagr.setAccountId(loginInfo.getAccountOrgId());

		return iMKTControlService.delDataAuthGroupList(ddagr);
	}
	*//**
	 * @name : getDeptList
	 * @date : 2015. 12. 21.
	 * @author : 안형욱
	 * @return : GridPagingResponseDTO
	 * @description : 전체 부서조회
	 *//*
	@RequestMapping(value="/getDeptList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResponseDTO getDeptList(HttpServletRequest request, HttpServletResponse response, @RequestBody MKTGetDeptListRequestDTO gdlr, HttpSession session) {
		LogUtil.param(MKTSMController.class,gdlr);
		
		MKTLoginResponseDTO loginInfo = this.checkLoginSession(request, response);
		gdlr.setAccountId(loginInfo.getAccountOrgId());

		return iMKTControlService.getDeptList(gdlr);
	}
	*//**
	 * @name :getAccountId
	 * @date : 2016. 2. 23.
	 * @author : 박지열
	 * @return : MKTGetAccountResponseDTO
	 * @description : account Id 조회
	 *//*
	@RequestMapping(value="/getAccountId.do", method = RequestMethod.POST)
	public @ResponseBody List<MKTGetAccountResponseDTO> getAccountId(HttpServletRequest request, HttpServletResponse response, @RequestBody MKTGetAccountRequestDTO gdlr, HttpSession session) {
		LogUtil.param(MKTSMController.class,gdlr);
		
		MKTLoginResponseDTO loginInfo = this.checkLoginSession(request, response);
		gdlr.setAccountId(loginInfo.getAccountOrgId());

		return iMKTControlService.getAccountId(gdlr);
	}*/
}

