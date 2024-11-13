package com.icignal.external.ftpservice.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.core.database.dto.request.MKTDBInfoDTO;

@Mapper
public interface FtpServiceMapper {

	MKTDBInfoDTO selectFTPInfo(MKTDBInfoDTO dataBaseInfo);

}
