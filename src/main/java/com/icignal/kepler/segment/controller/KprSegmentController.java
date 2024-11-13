package com.icignal.kepler.segment.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.icignal.kepler.segment.dto.request.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.controller.CommonController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.LogUtil;
import com.icignal.kepler.segment.dto.response.KprLogicalComponentColumnListResDto;
import com.icignal.kepler.segment.dto.response.KprLogicalComponentListResDto;
import com.icignal.kepler.segment.dto.response.KprSegmentDetailResDto;
import com.icignal.kepler.segment.dto.response.KprSegmentListResDto;
import com.icignal.kepler.segment.service.KprSegmentService;


/**
 * @name : infavor.kepler.segment.controller
 * @date : 2016. 6. 9.
 * @author : 류동균
 * @description : 세그먼트 controller
 */
@Controller
@RequestMapping("/kepler/segment")
public class KprSegmentController extends CommonController {
	
	@Autowired
	public KprSegmentService iKPRSegmentService;
	
	@Autowired
	public AuthHelper authHelper;
   
    
    /**
     * @programId : ANL_SEG_001
     * @name : getSegmentList
     * @date : 2016. 7. 1.
     * @author : 류동균
     * @table : anl.anl_seg_mst, anl.anl_lgc_comp_mst, com.employee
     * @return : 
     * @description : 세그먼트 목록 조회
     */
    @RequestMapping(value="/getSegmentList.do", method = RequestMethod.POST)
    public @ResponseBody
    GridPagingResDto<KprSegmentListResDto> getSegmentList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprSegmentListReqDto slr) {
        LogUtil.param(KprSegmentController.class, slr);
         
        LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
      //  slr.setAccountId(loginInfo.getAccountOrgId());
        
        GridPagingResDto<KprSegmentListResDto> rtnValue = new GridPagingResDto<>();
        rtnValue = iKPRSegmentService.getSegmentList(slr);
        
        return rtnValue;
    }
    
    /**
     * @programId : ANL_SEG_P01
     * @name : getLogicalComponentList
     * @date : 2016. 7. 1.
     * @author : 류동균
     * @table : anl.anl_lgc_comp_mst, com.employee
     * @return : 
     * @description : 로지컬 컴포넌트 목록
     */
    @RequestMapping(value="/getLogicalComponentList.do", method = RequestMethod.POST)
    public @ResponseBody
    GridPagingResDto<KprLogicalComponentListResDto> getLogicalComponentList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprLogicalComponentListReqDto lclr) {
        LogUtil.param(KprSegmentController.class, lclr);
         
        LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
        //lclr.setAccountId(loginInfo.getAccountOrgId());
        
        GridPagingResDto<KprLogicalComponentListResDto> rtnValue = new GridPagingResDto<>();
        rtnValue = iKPRSegmentService.getLogicalComponentList(lclr);
        
        return rtnValue;
    }
    
    /**
     * @programId : ANL_SEG_P01 
     * @name : addSegment
     * @date : 2016. 7. 7.
     * @author : 류동균
     * @table : anl.anl_seg_mst
     * @return : 
     * @description : 세그먼트 등록
     */
    @RequestMapping(value="/addSegment.do", method = RequestMethod.POST)
    public @ResponseBody
    StatusResDto addSegment(HttpServletRequest request, HttpServletResponse response, @RequestBody KprSetSegmentReqDto ssr) {
        LogUtil.param(KprSegmentController.class, ssr);
         
        LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
        ssr.setCreateBy(loginInfo.getId());
        ssr.setModifyBy(loginInfo.getId());
       // ssr.setAccountId(loginInfo.getAccountOrgId());
        
        return iKPRSegmentService.addSegment(ssr);
    }
    
    /**
     * @programId : ANL_SEG_P03
     * @name : getAttributeGroupColumnValueList
     * @date : 2016. 7. 11.
     * @author : 류동균
     * @table : 
     * @return : 
     * @description : 어트리뷰트 속성 그룹 값 목록 조회 
     */
    @RequestMapping(value="/getAttributeGroupColumnValueList.do", method = RequestMethod.POST)
    public @ResponseBody
    GridPagingResDto<Object> getAttributeGroupColumnValueList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAttributeGroupColumnInfoReqDto agcir) {
        LogUtil.param(KprSegmentController.class, agcir);
         
        LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
       // agcir.setAccountId(loginInfo.getAccountOrgId());
        
        GridPagingResDto<Object> rtnValue = new GridPagingResDto<>();
        rtnValue = iKPRSegmentService.getAttributeGroupColumnValueList(agcir);
        
        return rtnValue;
    }
    
    /**
     * @programId : ANL_SEG_002
     * @name : getSegmentFilterKeyColumn
     * @date : 2016. 7. 11.
     * @author : 류동균
     * @table : anl.anl_lgc_comp_mst, anl.anl_atrib_group, anl.anl_atrib_group_column
     * @return : 
     * @description : 세그먼트 전체 건수
     */
    @RequestMapping(value="/getSegmentAllCount.do", method = RequestMethod.POST)
    public @ResponseBody String getSegmentAllCount(HttpServletRequest request, HttpServletResponse response, @RequestBody KprSegmentCountReqDto scr) {
        LogUtil.param(KprSegmentController.class, scr);
        
        LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
     //   scr.setAccountId(loginInfo.getAccountOrgId());
             
        String rtnValue = iKPRSegmentService.getSegmentAllCount(scr);
        
       return rtnValue;
    }
    
    /**
     * @programId : ANL_SEG_002
     * @name : getSegmentDetail
     * @date : 2016. 7. 12.
     * @author : 류동균
     * @table :
     * @return : 
     * @description : 세그먼트 상세 조회
     */
    @RequestMapping(value="/getSegmentDetail.do", method = RequestMethod.POST)
    public @ResponseBody KprSegmentDetailResDto getSegmentDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody KprSegmentDetailReqDto sdr) {
        LogUtil.param(KprSegmentController.class, sdr);
        
        LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
        //sdr.setAccountId(loginInfo.getAccountOrgId());
        
        KprSegmentDetailResDto rtnValue = new KprSegmentDetailResDto();
        rtnValue = iKPRSegmentService.getSegmentDetail(sdr);
        
       return rtnValue;
    }
    
    /**
     * @programId : ANL_SEG_P03
     * @name : saveSegmentFilter
     * @date : 2016. 7. 13.
     * @author : 류동균
     * @table : 
     * @return : anl.anl_seg_filter
     * @description : 세그먼트 필터 저장
     */
    @RequestMapping(value="/saveSegmentFilter.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto saveSegmentFilter(HttpServletRequest request, HttpServletResponse response, @RequestBody KprSetSegmentFilterReqDto ssfr) {
        LogUtil.param(KprSegmentController.class, ssfr);
        
        LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
      //  ssfr.setAccountId(loginInfo.getAccountOrgId());
        ssfr.setCreateBy(loginInfo.getId());
        ssfr.setModifyBy(loginInfo.getId());
        
        StatusResDto rtnValue = new StatusResDto();
        rtnValue = iKPRSegmentService.saveSegmentFilter(ssfr);
        
       return rtnValue;
    }
    /**
     * @programId : ANL_SEG_002
     * @name : saveAsDifferentSegment
     * @date : 2021. 08. 13.~
     * @author : 이경영
     * @table :
     * @return :
     * @description : 세그먼트 다른이름으로 저장
     */
    @RequestMapping(value="/saveAsDifferentSegment.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto saveAsDifferentSegment(HttpServletRequest request, HttpServletResponse response, @RequestBody KprSetSegmentReqDto reqDto) {
        LogUtil.param(KprSegmentController.class, reqDto);

        LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
        reqDto.setLoginInfo(loginInfo);

        return iKPRSegmentService.saveAsDifferentSegment(reqDto);
    }
    /**
     * @programId : ANL_SEG_002
     * @name : saveSegment
     * @date : 2016. 7. 13.
     * @author : 류동균
     * @table : 
     * @return : 
     * @description : 세그먼트 저장
     */
    @RequestMapping(value="/saveSegment.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto saveSegment(HttpServletRequest request, HttpServletResponse response, @RequestBody KprSetSegmentReqDto ssr) {
        LogUtil.param(KprSegmentController.class, ssr);
        
        LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
     //   ssr.setAccountId(loginInfo.getAccountOrgId());
        ssr.setCreateBy(loginInfo.getId());
        ssr.setModifyBy(loginInfo.getId());

        StatusResDto rtnValue = new StatusResDto();
        rtnValue = iKPRSegmentService.saveSegment(ssr);

       return rtnValue;
    }
    
    /**
     * @programId : ANL_SEG_002
     * @name : editSegmentLogicalComponentId
     * @date : 2016. 7. 13.
     * @author : 류동균
     * @table : 
     * @return : anl.anl_seg_filter
     * @description : 세그먼트 로지컬 컴포넌트 id 수정
     */
    @RequestMapping(value="/editSegmentLogicalComponentId.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto editSegmentLogicalComponentId(HttpServletRequest request, HttpServletResponse response, @RequestBody KprSetSegmentReqDto ssr) {
        LogUtil.param(KprSegmentController.class, ssr);
        
        LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
       // ssr.setAccountId(loginInfo.getAccountOrgId());
        ssr.setCreateBy(loginInfo.getId());
        ssr.setModifyBy(loginInfo.getId());
        
        StatusResDto rtnValue = new StatusResDto();
        rtnValue = iKPRSegmentService.editSegmentLogicalComponentId(ssr);
        
       return rtnValue;
    }
    
    /**
     * @programId : ANL_SEG_P03
     * @name : getLogicalComponentColumnList
     * @date : 2016. 7. 26.
     * @author : 류동균
     * @table : anl.anl_atrib_group_column
     * @return : 
     * @description : 로지컬컴포넌트 컬럼 목록
     */
    @RequestMapping(value="/getLogicalComponentColumnList.do", method = RequestMethod.POST)
    public @ResponseBody List<KprLogicalComponentColumnListResDto> getLogicalComponentColumnList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprLogicalComponentColumnListReqDto lcclr) {
        LogUtil.param(KprSegmentController.class, lcclr);
        
        LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
    //    lcclr.setAccountId(loginInfo.getAccountOrgId());
        
       return iKPRSegmentService.getLogicalComponentColumnList(lcclr);
    }
    
    /**
     * @programId : ANL_SEG_002
     * @name : resetAllSegmentFilterCount
     * @date : 2016. 7. 26.
     * @author : 류동균
     * @table : anl.anl_seg_filter
     * @return : 
     * @description : 전체 세그먼트 필터 건수 재설정 
     */
    @RequestMapping(value="/resetAllSegmentFilterCount.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto resetAllSegmentFilterCount(HttpServletRequest request, HttpServletResponse response, @RequestBody KprSegmentFilterReqDto sfr) {
        LogUtil.param(KprSegmentController.class, sfr);
        
        LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
      //  sfr.setAccountId(loginInfo.getAccountOrgId());
        sfr.setModifyBy(loginInfo.getId());
        
        StatusResDto rtnValue = new StatusResDto();
        rtnValue = iKPRSegmentService.resetAllSegmentFilterCount(sfr);
        
       return rtnValue;
    }
    
    /**
     * @programId : ANL_SEG_002
     * @name : resetSegmentFilterCount
     * @date : 2018. 12. 07.
     * @author : 류동균
     * @table : anl.anl_seg_filter
     * @return : 
     * @description : 세그먼트 필터 건수 재설정 
     */
    @RequestMapping(value="/resetSegmentFilterCount.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto resetSegmentFilterCount(HttpServletRequest request, HttpServletResponse response, @RequestBody KprSegmentFilterReqDto sfr) {
        LogUtil.param(KprSegmentController.class, sfr);
        
        LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
     //   sfr.setAccountId(loginInfo.getAccountOrgId());
        sfr.setModifyBy(loginInfo.getId());
        
        StatusResDto rtnValue = new StatusResDto();
        rtnValue = iKPRSegmentService.resetSegmentFilterCount(sfr);
        
       return rtnValue;
    }
    
    /**
     * @programId : ANL_SEG_002
     * @name : removeSegment
     * @date : 2016. 9. 13.
     * @author : 류동균
     * @table : anl.anl_seg_mst, anl.anl_seg_filter, anl.anl_seg_filter_rel
     * @return : 
     * @description : 세그먼트 삭제
     */
    @RequestMapping(value="/removeSegment.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto removeSegment(HttpServletRequest request, HttpServletResponse response, @RequestBody KprSetSegmentReqDto ssr) {
        LogUtil.param(KprSegmentController.class, ssr);
        
        LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
     //  ssr.setAccountId(loginInfo.getAccountOrgId());
        ssr.setModifyBy(loginInfo.getId());
        
        StatusResDto rtnValue = new StatusResDto();
        rtnValue = iKPRSegmentService.removeSegment(ssr);
        
       return rtnValue;
    }
    
}
