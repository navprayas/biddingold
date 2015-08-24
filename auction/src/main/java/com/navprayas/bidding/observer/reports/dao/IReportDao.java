package com.navprayas.bidding.observer.reports.dao;

import java.util.List;
import java.util.Set;

import com.navprayas.bidding.common.dto.ReportVO;
import com.navprayas.bidding.common.form.BidItem;
import com.navprayas.bidding.common.form.Bids;

public interface IReportDao {

	public List<Bids> getReportSummary1(String userName, ReportVO reportVO);
	public  List<Bids> getBidsForCategoryObserverReportSummary1(ReportVO reportVO, String userName);
	public  Set<String> getLotsList(String userName);
	public  List<BidItem> getBidsForLotsObserverReportSummary1(long lotid, String userName);
	public  List<Bids> getBidsForLotsObserverReportSummary1(ReportVO reportVO, String userName);
	
}
