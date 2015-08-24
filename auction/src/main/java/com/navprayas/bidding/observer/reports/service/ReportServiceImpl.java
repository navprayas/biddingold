package com.navprayas.bidding.observer.reports.service;

import java.util.List;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.navprayas.bidding.common.dto.ReportVO;
import com.navprayas.bidding.common.form.BidItem;
import com.navprayas.bidding.common.form.Bids;
import com.navprayas.bidding.observer.reports.dao.IReportDao;

@Configurable
@Service("reportService")

public class ReportServiceImpl  implements IReportService{

private final static Logger logger = LoggerFactory.getLogger(ReportServiceImpl.class);
	
	@Autowired
	@Qualifier("reportRepository")
	private IReportDao reportDao;

	
	@Transactional
	public List<Bids> getReportSummary1(String userName, ReportVO reportVO) {		
		List<Bids> bidsList = reportDao.getReportSummary1(userName, reportVO);
		return bidsList;
	}

	@Transactional
	public List<Bids> getBidsForCategoryObserverReportSummary1(ReportVO reportVO, String userName) {
		return reportDao.getBidsForCategoryObserverReportSummary1(reportVO, userName);
	}

	@Transactional
	public List<BidItem> getBidsForLotsObserverReportSummary1(long lotid,
			String userName) {
		// TODO Auto-generated method stub
		return null;
	}

	@Transactional
	public Set<String> getLotsList(String userName) {
		return reportDao.getLotsList(userName);
	}
	@Transactional
	public List<Bids> getBidsForLotsObserverReportSummary1(ReportVO reportVO, String userName) {
		return reportDao.getBidsForLotsObserverReportSummary1(reportVO, userName);
	}
}
