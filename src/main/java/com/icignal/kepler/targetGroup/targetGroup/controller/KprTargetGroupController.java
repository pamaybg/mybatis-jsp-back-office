package com.icignal.kepler.targetGroup.targetGroup.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.LogUtil;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprSetTargetGroupColumnReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprSetTargetGroupReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprTargetGroupColumnListReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprTargetGroupListReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprTargetGroupReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprTargetGroupTargetListReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.response.KprTargetGroupColumnListResDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.response.KprTargetGroupListResDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.response.KprTargetGroupResDto;
import com.icignal.kepler.targetGroup.targetGroup.service.KprTargetGroupService;


/**
 * @name : infavor.kepler.segment.controller
 * @date : 2016. 6. 9.
 * @author : 류동균
 * @description : 세그먼트 controller
 */
@Controller
@RequestMapping("/kepler/targetGroup")
public class KprTargetGroupController extends BaseController {

	@Autowired
	public KprTargetGroupService iKPRTargetGroupService;

    /**
     * @programId : ANL_TGT_001
     * @name : getTargetGroupList
     * @date : 2016. 7. 21.
     * @author : 류동균
     * @table : anl.anl_tgt_group, com.employee
     * @return :
     * @description : 타겟그룹 목록 조회
     */
    @RequestMapping(value="/getTargetGroupList.do", method = RequestMethod.POST)
    public @ResponseBody
    GridPagingResDto<KprTargetGroupListResDto> getTargetGroupList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprTargetGroupListReqDto tglr) {
        LogUtil.param(KprTargetGroupController.class, tglr);

        tglr.setLoginInfo(this.checkLoginSession(request, response));

        GridPagingResDto<KprTargetGroupListResDto> rtnValue = new GridPagingResDto<>();
        rtnValue = iKPRTargetGroupService.getTargetGroupList(tglr);

        return rtnValue;
    }

    /**
     * 타겟그룹 & Import 목록 조회
     *
     * @programId :
     * @name : getTargetGroupImportList
     * @date : 2018. 3. 5.
     * @author : jh.kim
     * @table :
     * @param request
     * @param response
     * @param tglr
     * @return
     * @description :
     */
    @RequestMapping(value="/getTargetGroupImportList.do", method = RequestMethod.POST)
    public @ResponseBody
    GridPagingResDto<KprTargetGroupListResDto> getTargetGroupImportList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprTargetGroupListReqDto tglr) {
        LogUtil.param(KprTargetGroupController.class, tglr);

        tglr.setLoginInfo(this.checkLoginSession(request, response));

        GridPagingResDto<KprTargetGroupListResDto> rtnValue = new GridPagingResDto<>();
        rtnValue = iKPRTargetGroupService.getTargetGroupImportList(tglr);

        return rtnValue;
    }

    /**
     * @name : getMktTgtHadFileUploadList
     * @date : 2018. 4. 26.
     * @author : jun.lee
     * @return : GridPagingResDto<>
     * @description : 타겟그룹 대조군 파일업로드 유형 목록 조회
    **/
	/*쿼리없음
	 * @RequestMapping(value="/getMktTgtHadFileUploadList.do", method =
	 * RequestMethod.POST) public @ResponseBody GridPagingResDto<>
	 * getMktTgtHadFileUploadList(HttpServletRequest request, HttpServletResponse
	 * response, @RequestBody KPRTargetGroupListRequestDTO tglr) {
	 * LogUtil.param(KPRTargetGroupController.class, tglr);
	 * 
	 * tglr.setLoginInfo(this.checkLoginSession(request, response));
	 * 
	 * GridPagingResDto<> rtnValue = new GridPagingResDto<>(); rtnValue =
	 * iKPRTargetGroupService.getMktTgtHadFileUploadList(tglr);
	 * 
	 * return rtnValue; }
	 */

    /**
     * @programId : ANL_TGT_002
     * @name : selectTargetGroup
     * @date : 2016. 7. 21.
     * @author : 류동균
     * @table : anl.anl_tgt_group, com.comm_code, com.employee
     * @return :
     * @description : 타겟그룹 상세 조회
     */
    @RequestMapping(value="/getTargetGroup.do", method = RequestMethod.POST)
    public @ResponseBody KprTargetGroupResDto getTargetGroup(HttpServletRequest request, HttpServletResponse response, @RequestBody KprTargetGroupReqDto tgr) {
        LogUtil.param(KprTargetGroupController.class, tgr);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        //tgr.setAccountId(loginInfo.getAccountOrgId());

        KprTargetGroupResDto rtnValue = new KprTargetGroupResDto();
        rtnValue = iKPRTargetGroupService.getTargetGroup(tgr);

       return rtnValue;
    }
    
    /**
     * @programId : ANL_TGT_002
     * @name : selectTargetGroup
     * @date : 2016. 7. 21.
     * @author : 류동균
     * @table : anl.anl_tgt_group, com.comm_code, com.employee
     * @return :
     * @description : 타겟그룹 대상자수 조회
     */
    @RequestMapping(value="/getTargetGroupCount.do", method = RequestMethod.POST)
    public @ResponseBody KprTargetGroupResDto getTargetGroupCount(HttpServletRequest request, HttpServletResponse response, @RequestBody KprTargetGroupReqDto tgr) {
        LogUtil.param(KprTargetGroupController.class, tgr);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        //tgr.setAccountId(loginInfo.getAccountOrgId());

        KprTargetGroupResDto rtnValue = new KprTargetGroupResDto();
        rtnValue = iKPRTargetGroupService.getTargetCount(tgr);

       return rtnValue;
    }

    /**
     * @programId : ANL_TGT_002
     * @name : getTargetList
     * @date : 2016. 7. 21.
     * @author : 류동균
     * @table :
     * @return :
     * @description : 대상 목록
     */
    @RequestMapping(value="/getTargetGroupTargetList.do", method = RequestMethod.POST)
    public @ResponseBody
    GridPagingResDto getTargetGroupTargetList(
            HttpServletRequest request, HttpServletResponse response, @RequestBody KprTargetGroupTargetListReqDto tgtlr) {
        LogUtil.param(KprTargetGroupController.class, tgtlr);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
       // tgtlr.setAccountId(loginInfo.getAccountOrgId());

        GridPagingResDto rtnValue = new GridPagingResDto<>();
        rtnValue = iKPRTargetGroupService.getTargetGroupTargetList(tgtlr);

        return rtnValue;
    }

    /**
     * @programId : ANL_SEG_P05
     * @name : addTargetGroup
     * @date : 2016. 7. 21.
     * @author : 류동균
     * @table : anl.anl_tgt_group
     * @return :
     * @description : 타겟그룹 등록
     */
    @RequestMapping(value="/addTargetGroup.do", method = RequestMethod.POST)
    public @ResponseBody
    StatusResDto addTargetGroup(HttpServletRequest request, HttpServletResponse response, @RequestBody KprSetTargetGroupReqDto stgr) {
        LogUtil.param(KprTargetGroupController.class,stgr);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        stgr.setCreateBy(loginInfo.getId());
        stgr.setModifyBy(loginInfo.getId());
        //stgr.setAccountId(loginInfo.getAccountOrgId());

        return iKPRTargetGroupService.addTargetGroup(stgr);
    }

    /**
     * @programId : ANL_TGT_002
     * @name : editTargetGroup
     * @date : 2016. 7. 21.
     * @author : 류동균
     * @table : anl.anl_tgt_group
     * @return :
     * @description : 타겟그룹 수정
     */
    @RequestMapping(value="/editTargetGroup.do", method = RequestMethod.POST)
    public @ResponseBody
    StatusResDto editTargetGroup(HttpServletRequest request, HttpServletResponse response, @RequestBody KprSetTargetGroupReqDto stgr) {
        LogUtil.param(KprTargetGroupController.class,stgr);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        stgr.setCreateBy(loginInfo.getId());
        stgr.setModifyBy(loginInfo.getId());
        //stgr.setAccountId(loginInfo.getAccountOrgId());

        return iKPRTargetGroupService.editTargetGroup(stgr);
    }

    /**
     * @programId : ANL_TGT_002, ANL_TGT_P01
     * @name : getTargetGroupColumnList
     * @date : 2016. 7. 25.
     * @author : 류동균
     * @table : anl.anl_tgt_group, anl.anl_tgt_group_column
     * @return :
     * @description : 타겟그룹 컬럼 목록 조회
     */
    @RequestMapping(value="/getTargetGroupColumnList.do", method = RequestMethod.POST)
    public @ResponseBody
    List<KprTargetGroupColumnListResDto>  getTargetGroupColumnList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprTargetGroupColumnListReqDto tgclr) {

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        //tgclr.setAccountId(loginInfo.getAccountOrgId());

        return iKPRTargetGroupService.getTargetGroupColumnList(tgclr);
    }

    /**
     * @programId : ANL_TGT_002, ANL_TGT_P01
     * @name : getTargetGroupColumnList
     * @date : 2016. 7. 25.
     * @author : 류동균
     * @table : anl.anl_tgt_group, anl.anl_tgt_group_column
     * @return :
     * @description : 타겟그룹 컬럼 목록 모두 조회
     */
    @RequestMapping(value="/getTargetGroupColumnAllList.do", method = RequestMethod.POST)
    public @ResponseBody
    List<KprTargetGroupColumnListResDto>  getTargetGroupColumnAllList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprTargetGroupColumnListReqDto tgclr) {

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        //tgclr.setAccountId(loginInfo.getAccountOrgId());

        return iKPRTargetGroupService.getTargetGroupColumnAllList(tgclr);
    }

    /**
     * @programId : ANL_TGT_P01
     * @name : saveTargetGroupColumn
     * @date : 2016. 7. 25.
     * @author : 류동균
     * @table : anl.anl_tgt_group_column
     * @return :
     * @description : 타겟그룹 컬럼 저장
     */
    @RequestMapping(value="/saveTargetGroupColumn.do", method = RequestMethod.POST)
    public @ResponseBody
    StatusResDto saveTargetGroupColumn(HttpServletRequest request, HttpServletResponse response, @RequestBody KprSetTargetGroupColumnReqDto stgcr) {
        LogUtil.param(KprTargetGroupController.class,stgcr);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        stgcr.setCreateBy(loginInfo.getId());
        stgcr.setModifyBy(loginInfo.getId());
        //stgcr.setAccountId(loginInfo.getAccountOrgId());

        return iKPRTargetGroupService.saveTargetGroupColumn(stgcr);
    }

    /**
     * @programId : ANL_TGT_002
     * @name : exportExcelTargetGroupTargetList
     * @date : 2016. 8. 10.
     * @author : 류동균
     * @table :
     * @return :
     * @description : export excel 타겟그룹 대상자 목록
     * @modify : 2020-07-21  LEE GYEONG YOUNG 
     */
    @RequestMapping(value="/exportExcelTargetGroupTargetList.do", method = RequestMethod.POST)
  	public  
  	String ChnlExecDown(HttpServletRequest request, HttpServletResponse response, @RequestBody KprTargetGroupTargetListReqDto reqDto, ModelMap model) {
  		
  		LogUtil.param(this.getClass(), reqDto);
  		reqDto.setLoginInfo(this.checkLoginSession(request, response));
  		
  		GridPagingResDto data = iKPRTargetGroupService.getAllTargetGroupTargetList(reqDto);

  		model.addAttribute("result", data);
  		model.addAttribute("excelHeader", reqDto.getExcelHeader());
  		model.addAttribute("fileName", "Target_Group");

  		return "ExcelView";
  	}

    /**
     * @programId :
     * @name : removeTargetGroup
     * @date : 2016. 9. 13.
     * @author : 류동균
     * @table : anl.anl_tgt_group, anl.anl_tgt_group_column, anl.anl_seg_mst, anl.anl_seg_filter, anl.anl_seg_filter_rel
     * @return :
     * @description : 타겟그룹 삭제
     */
    @RequestMapping(value="/removeTargetGroup.do", method = RequestMethod.POST)
    public @ResponseBody
    StatusResDto removeTargetGroup(HttpServletRequest request, HttpServletResponse response, @RequestBody KprSetTargetGroupReqDto stgr) {
        LogUtil.param(KprTargetGroupController.class,stgr);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        stgr.setCreateBy(loginInfo.getId());
        stgr.setModifyBy(loginInfo.getId());
        //stgr.setAccountId(loginInfo.getAccountOrgId());

        return iKPRTargetGroupService.removeTargetGroup(stgr);
    }

    /**
     * @programId : ANL_TGT_002
     * @name : getMbrNoFromCust
     * @date : 2022. 1. 24.
     * @author : 정수지
     * @table : anl.anl_tgt_group, com.comm_code, com.employee
     * @return :
     * @description : 멤버 rid 가져오기
     */
    @RequestMapping(value="/getMbrNoFromCust.do", method = RequestMethod.POST)
    public @ResponseBody KprTargetGroupResDto getMbrNoFromCust(HttpServletRequest request, HttpServletResponse response, @RequestBody KprTargetGroupReqDto tgr) {
        LogUtil.param(KprTargetGroupController.class, tgr);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        //tgr.setAccountId(loginInfo.getAccountOrgId());

        KprTargetGroupResDto rtnValue = new KprTargetGroupResDto();
        rtnValue = iKPRTargetGroupService.getMbrNoFromCust(tgr);

        return rtnValue;
    }
}
