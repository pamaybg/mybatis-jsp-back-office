package com.icignal.kepler.targetGroup.targetGroup.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprSetTargetGroupColumnReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprSetTargetGroupReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprTargetGroupColumnListReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprTargetGroupDBInfoReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprTargetGroupListReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprTargetGroupReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprTargetGroupTargetListReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.response.KprTargetGroupColumnListResDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.response.KprTargetGroupDBInfoResDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.response.KprTargetGroupListResDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.response.KprTargetGroupResDto;

@Mapper
public interface KprTargetGroupMapper {

	public List<KprTargetGroupListResDto> selectTargetGroupList(KprTargetGroupListReqDto tglr);

	public List<KprTargetGroupListResDto> selectTargetGroupImportList(KprTargetGroupListReqDto tglr);

	public KprTargetGroupResDto selectTargetGroup(KprTargetGroupReqDto tgr);

	public void updateTagetGroupCount(KprTargetGroupReqDto tgr);

	public String selectTargetMemberNumListSql(KprTargetGroupTargetListReqDto tgtlr);

	public KprTargetGroupDBInfoResDto selectTargetGroupLcDBInfo(KprTargetGroupDBInfoReqDto tgdir);

	public int insertTargetGroup(KprSetTargetGroupReqDto stgr);

	public void updateTargetGroup(KprSetTargetGroupReqDto stgr);

	public List<KprTargetGroupColumnListResDto> selectTargetGroupColumnList(KprTargetGroupColumnListReqDto tgclr);

	public List<KprTargetGroupColumnListResDto> selectTargetGroupColumnAllList(KprTargetGroupColumnListReqDto tgclr);

	public void deleteTargetGroupColumn(KprSetTargetGroupColumnReqDto col);

	public int insertTargetGroupColumn(KprSetTargetGroupColumnReqDto col);

	public int selectConnectCampaignCheckCount(KprTargetGroupReqDto tgr);

	public void deleteTargetGroupByTargetGroupId(KprSetTargetGroupReqDto stgr);

	public void deleteTargetGroupColumnByTargetGroupId(KprSetTargetGroupColumnReqDto stgrc);
	
	public void deleteSimpleTargeting(KprSetTargetGroupReqDto stgr);

	public KprTargetGroupDBInfoResDto selectTargetGroupDBInfo(KprTargetGroupDBInfoReqDto tgdir);

	public KprTargetGroupResDto getMbrNoFromCust(KprTargetGroupReqDto tgr);

}
