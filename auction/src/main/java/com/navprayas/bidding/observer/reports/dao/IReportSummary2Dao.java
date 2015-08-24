package com.navprayas.bidding.observer.reports.dao;

import java.util.List;
import java.util.Map;

import com.navprayas.bidding.common.dto.ReportSummary2;
import com.navprayas.bidding.common.dto.ReportVO;
import com.navprayas.bidding.common.form.Bids;

public interface IReportSummary2Dao {

	public Map<Long,ReportSummary2> getReportSummary2(String userName, ReportVO reportVO);
	
}
