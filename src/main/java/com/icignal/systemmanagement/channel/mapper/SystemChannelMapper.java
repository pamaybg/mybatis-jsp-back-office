 /*
  * Copyright 2016-2020 by Quintet Systems Corp.,
  * All rights reserved.
  *
  * This software is the confidential and proprietary information
  * of Quintet Systems Corp.
  */

package com.icignal.systemmanagement.channel.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.systemmanagement.channel.dto.request.SystemChannelDetailReqDto;
import com.icignal.systemmanagement.channel.dto.request.SystemChannelInsertReqDto;
import com.icignal.systemmanagement.channel.dto.request.SystemChannelReqDto;
import com.icignal.systemmanagement.channel.dto.request.SystemChannelcapaDeleteReqDto;
import com.icignal.systemmanagement.channel.dto.request.SystemChannelcapaReqDto;
import com.icignal.systemmanagement.channel.dto.request.SystemDeleteSnsAdtnInfoReqDto;
import com.icignal.systemmanagement.channel.dto.request.SystemImgOptionDeleteReqDto;
import com.icignal.systemmanagement.channel.dto.request.SystemImgOptionListReqDto;
import com.icignal.systemmanagement.channel.dto.request.SystemImgOptionReqDto;
import com.icignal.systemmanagement.channel.dto.request.SystemImgOptionlInsertReqDto;
import com.icignal.systemmanagement.channel.dto.request.SystemImgOptionlUpdateReqDto;
import com.icignal.systemmanagement.channel.dto.request.SystemInsertSnsAdtnInfoReqDto;
import com.icignal.systemmanagement.channel.dto.request.SystemSnsAdtnInfoReqDto;
import com.icignal.systemmanagement.channel.dto.response.SystemAccountResDto;
import com.icignal.systemmanagement.channel.dto.response.SystemChannelDetailResDto;
import com.icignal.systemmanagement.channel.dto.response.SystemChannelResDto;
import com.icignal.systemmanagement.channel.dto.response.SystemChannelcapaResDto;
import com.icignal.systemmanagement.channel.dto.response.SystemGetDetailSnsAdtnInfoResDto;
import com.icignal.systemmanagement.channel.dto.response.SystemImgOptionListResDto;
import com.icignal.systemmanagement.channel.dto.response.SystemImgOptionResDto;
import com.icignal.systemmanagement.channel.dto.response.SystemSnsAdtnInfoResDto;
import com.icignal.systemmanagement.commcode.dto.request.MKTCommonCodeRequestDTO;

@Mapper
public interface SystemChannelMapper {

	public void deleteImgOption(SystemImgOptionDeleteReqDto midr);

	public SystemChannelDetailResDto selectDetailChannel(SystemChannelDetailReqDto mcr);

	public void updateResponseChannel(SystemChannelReqDto _mcr);

	public SystemChannelResDto selectChannelCheck(SystemChannelReqDto mcr);

	public void insertChannel(SystemChannelInsertReqDto mcr);

	public void deleteSnsAdtnInfo(SystemDeleteSnsAdtnInfoReqDto mcdr);

	public List<SystemChannelResDto> selectChannel(SystemChannelReqDto mcr);

	public void deleteCapa(SystemChannelcapaDeleteReqDto mcdr);

	public List<SystemAccountResDto> selectChannelOrg(SystemChannelReqDto mcr);

	public List<SystemSnsAdtnInfoResDto> getSnsAdtnInfoList(SystemSnsAdtnInfoReqDto mcr);

	public List<SystemChannelcapaResDto> selectChannelStore(SystemChannelcapaReqDto mcr);

	public String getDateInfo(MKTCommonCodeRequestDTO slir);

	public List<SystemImgOptionListResDto> selectImgOption(SystemImgOptionListReqDto mior);

	public void updateImgOption(SystemImgOptionlUpdateReqDto miou);

	public SystemImgOptionResDto selectContypeId(SystemChannelReqDto mcdr);

	public List<SystemImgOptionResDto> selectImageOptionList(SystemImgOptionReqDto mior);

	public String selectSeq(SystemChannelcapaReqDto mor);

	public void insertImgOption(SystemImgOptionlInsertReqDto mcr);

	public SystemImgOptionResDto selectImgDetailOption(SystemImgOptionReqDto mior);

	public SystemChannelcapaResDto selectDetailCapa(SystemChannelcapaReqDto mcr);

	public String selectperiodType(SystemChannelcapaReqDto mcr);

	public void updateCapaChannel(SystemChannelcapaReqDto mcr);

	public void insertChannelStore(SystemChannelcapaReqDto mcr);

	public int insertSnsAdtnInfo(SystemInsertSnsAdtnInfoReqDto mcr);

	public SystemGetDetailSnsAdtnInfoResDto getDetailSnsAdtnInfo(SystemSnsAdtnInfoReqDto mcr);

	public int updateSnsAdtnInfo(SystemInsertSnsAdtnInfoReqDto mcr);

}

