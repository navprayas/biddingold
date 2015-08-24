package com.navprayas.bidding.observer.reports.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.navprayas.bidding.common.dto.ReportSummary2;
import com.navprayas.bidding.common.dto.ReportVO;
import com.navprayas.bidding.common.form.Bids;
import com.navprayas.bidding.observer.reports.dao.IReportSummary2Dao;


@Configurable
@Service("reportService2")

public class ReportSummary2ServiceImpl implements IReportSummary2Service{

	@Autowired
	@Qualifier("reportRepository2")
	private IReportSummary2Dao reportSummary2Dao;
	
	@Transactional
	public Map<Long,ReportSummary2> getReportSummary2(String userName, ReportVO reportVO) {
		return reportSummary2Dao.getReportSummary2(userName, reportVO);
	}

}
