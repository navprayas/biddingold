package com.navprayas.bidding.observer.service;

import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.navprayas.bidding.common.dto.CommonVO;
import com.navprayas.bidding.common.dto.ObserverVO;
import com.navprayas.bidding.common.form.BidItem;
import com.navprayas.bidding.common.form.Bids;
import com.navprayas.bidding.observer.dao.IObserverDao;

@Configurable
@Service("observerService")

public class ObserverServiceImpl implements IObserverService{

	@Autowired
	@Qualifier("observerRepository")
	private IObserverDao observerDao;
	@Transactional
	public BidItem getBidItem (long bidItemId) {
		return observerDao.getBidItem(bidItemId);
	}
	@Transactional
	public List<BidItem> getBidItems(String userName) {
		
		return observerDao.getBidItems(userName);	
	}
	@Transactional
	public List<BidItem> getBidItemsForCategoryForActiveMarketForObserver(
			String userName) {
		
		return observerDao.getBidItemsForCategoryForActiveMarketForObserver(userName);
	}
	@Transactional
	public List<BidItem> getBidItemsForCategoryForActiveMarketForObserver(
			long categoryId, String userName) {
		return observerDao.getBidItemsForCategoryForActiveMarketForObserver(categoryId, userName);
	}
	@Transactional
	public List<Bids> getBidItemsForCategoryForClosedMarketForObserver(CommonVO commonVO) {
		
		return observerDao.getBidItemsForCategoryForClosedMarketForObserver(commonVO);
	}
	@Transactional
	public List<Bids> getBidItemsForCategoryForClosedMarketForObserver(long categoryId, CommonVO commonVO) {
		
		return observerDao.getBidItemsForCategoryForClosedMarketForObserver(categoryId, commonVO);
		
	}
	@Transactional
	public List<BidItem> getBidItemsForCategoryForMarketListForObserver(
			String userName) {
		return observerDao.getBidItemsForCategoryForMarketListForObserver(userName);
	}
	@Transactional
	public List<BidItem> getBidItemsForCategoryForMarketListForObserver(
			long categoryId, String userName) {
		return observerDao.getBidItemsForCategoryForMarketListForObserver(categoryId, userName);
	}
	@Transactional
	public Set<Long> getBidItemsIDListForActiveMarket(String userName) {
		return observerDao.getBidItemsIDListForActiveMarket(userName);
	}
	
	@Transactional
	public boolean getH1Approved(ObserverVO observerVO, String userName) {
		
		return observerDao.getH1Approved(observerVO, userName);
	}

}
