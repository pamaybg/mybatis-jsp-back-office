package com.icignal.common.excel.service;

import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.excel.reader.ExcelReader;
import com.icignal.common.excel.writer.ExcelSheetWriter;
import com.icignal.common.excel.writer.ExcelWriter;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.LogUtil;
import org.apache.commons.lang3.tuple.Pair;
import org.apache.commons.lang3.tuple.Triple;
import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.util.List;
import java.util.function.BiConsumer;
import java.util.function.BiFunction;

@Service
public class ExcelService {

    final private SqlSessionFactory factory;

    public ExcelService(SqlSessionFactory factory) {
        this.factory = factory;
    }

    @Transactional
    public <M, T> Triple<Integer, Integer, StatusResDto> executeExcelDataUpload(String excelFileFullPath, Class<M> mapperClass, Class<T> targetClass, BiConsumer<M, List<T>> consumer) throws IOException {
        ExcelReader<T> vo = null;
        try {
            SqlSession session = this.factory.openSession(ExecutorType.BATCH, false);
            M mapper = session.getMapper(mapperClass);

            vo = new ExcelReader<>(excelFileFullPath, targetClass);
            Pair<Integer, Integer> rowCounts = vo.proceed(itemList -> {
                consumer.accept(mapper, itemList);
                session.flushStatements();
                session.commit();
            });

            session.close();

            String message = String.format("총 업로드 갯수 : %s, 필수 값 누락 건수 : %s 가 업로드 되었습니다.", rowCounts.getLeft(), rowCounts.getRight());
            return Triple.of(rowCounts.getLeft(), rowCounts.getRight(), new StatusResDto(true, message));
        } catch (Exception e) {
            LogUtil.param(this.getClass(), e);
            return Triple.of(0, 0, new StatusResDto(false, "처리 중 오류가 발생하였습니다."));
        } finally {
            if (vo != null) {
                vo.uploadDone();
            }
        }
    }

    public ExcelWriter executeExcelDataDownload(String fileName, BiFunction<Integer, Integer, List<?>> function) {
        return this.executeExcelDataDownload(fileName, null, function);
    }

    public ExcelWriter executeExcelDataDownload(String fileName, Class<?> clazz, BiFunction<Integer, Integer, List<?>> function) {
        ExcelWriter excelWriter = new ExcelWriter(fileName);
        ExcelSheetWriter sheetWriter = excelWriter.createSheet(fileName);

        if (clazz != null) {
            sheetWriter.setupTargetClass(clazz);
        }

        this.executeExcelDataDownload(sheetWriter, function);

        return excelWriter;
    }

    public void executeExcelDataDownload(ExcelSheetWriter writerVo, BiFunction<Integer, Integer, List<?>> function) {
        int excelChunkSize = BeansUtil.getApplicationProperty("excel.chunk-size", Integer.class);

        int rowCount = 0;
        int offset = 0;
        do {
            List<?> selectedList = function.apply(offset, excelChunkSize);

            if (selectedList != null) {
                writerVo.addSheetDataList(selectedList);

                offset += excelChunkSize;
                rowCount = selectedList.size();
            }
        } while (rowCount == excelChunkSize);
    }
}