package com.navprayas.bidding.common.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.navprayas.bidding.common.dao.ICommonDao;
import com.navprayas.bidding.common.dto.UserVO;
import com.navprayas.bidding.common.form.Auction;
import com.navprayas.bidding.common.form.Authorities;
import com.navprayas.bidding.common.form.BidSequence;
import com.navprayas.bidding.common.form.BidderCategory;
import com.navprayas.bidding.common.form.Category;
import com.navprayas.bidding.common.form.FirmDetails;
import com.navprayas.bidding.common.form.ItemLot;
import com.navprayas.bidding.common.form.UserActivity;
import com.navprayas.bidding.common.form.UserDetails;
import com.navprayas.bidding.common.form.Users;
import com.navprayas.bidding.utility.RedisCacheService;

@Configurable
@Service("commonService")
public class CommonServiceImpl implements ICommonService {

	private final static Logger logger = LoggerFactory
			.getLogger(CommonServiceImpl.class);
	@Autowired
	@Qualifier("commonRepository")
	private ICommonDao commonDao;

	@Transactional
	public List<Category> getCategoryList() {
		return commonDao.getCategoryList();
	}

	@Transactional
	public int saveVendor(FirmDetails firmDetails) {
		return commonDao.saveVendor(firmDetails);

	}

	@Transactional
	public void saveUserActivity(UserActivity userActivity) {
		commonDao.saveUserActivity(userActivity);
	}

	@Transactional
	public void updateUserActivity(String sessionId, Long auctionId) {
		commonDao.updateUserActivity(sessionId, auctionId);
	}

	@Transactional
	public List<UserActivity> getOnlineUserList(Long auctionid) {
		return commonDao.getOnlineUserList(auctionid);
	}

	@Transactional
	public List<BidderCategory> getCategoryList(String userName) {
		String auctionId = RedisCacheService.getAuctionId();

		/*
		 * if (auctionId == null) { Long auctionId1 =
		 * commonDao.getAuctionIdIfAny(); if (auctionId1 == null) { return new
		 * ArrayList<BidderCategory>(); } else { return
		 * commonDao.getCategoryList(userName, auctionId1); } }
		 */
		if (auctionId == null) {
			return new ArrayList<BidderCategory>();
		}
		return commonDao.getCategoryList(userName, Long.parseLong(auctionId));
	}

	@Transactional
	public List<BidSequence> getCurrentBidSequence(long auctionId) {
		return commonDao.getCurrentBidSequence(auctionId);
	}

	@Transactional
	public List<ItemLot> getItemLots(long bidItemId) {
		return commonDao.getItemLots(bidItemId);
	}

	/*
	 * @Transactional public Long getAuctionIdIfAny() { return
	 * commonDao.getAuctionIdIfAny(); }
	 */
	@Transactional
	public Date getActualAuctionStartTime(long auctionId) {
		return commonDao.getActualAuctionStartTime(auctionId);

	}

	@Transactional
	public Long getTimeExtension() {
		return commonDao.getTimeExtension();
	}

	@Transactional
	public void cleanPreviousAuction() {
		commonDao.cleanAuction();
	}

	@Transactional
	public void setActualAuctionStartTime(long auctionId,
			Date actualAuctionStartTime) {
		commonDao.setActualAuctionStartTime(auctionId, actualAuctionStartTime);
	}

	@Transactional
	public void insertAuctionDetail() {

		commonDao.insertAuctionDetail();

	}

	// ***********************Password Change**********************/
	@Transactional
	public String ChangePassword(String LoggerName, String Oldpass,
			String Newpass) {
		logger.debug("************PassWord Service**************");
		return commonDao.ChangePassword(LoggerName, Oldpass, Newpass);
	}

	@Transactional
	public void updateUserPassword(String LoggerName, String Newpass) {
		logger.debug("************Update Password************");
		commonDao.updateUserPassword(LoggerName, Newpass);
	}

	@Transactional
	public boolean checkIfUserExists(String userName) {
		logger.debug("checkIfUserExists Method Of Service::");
		return commonDao.checkIfUserExists(userName);
	}

	@Transactional
	public String checkUserExistsAndSendPasswordMail(String LoggerName,
			String secretAnswer) {
		logger.debug("************Checking user existence in forgot password.**************");
		return commonDao.checkUserExistsAndSendPasswordMail(LoggerName,
				secretAnswer);

	}

	public List<BidSequence> getCurrentBidSequence() {
		// TODO Auto-generated method stub
		return null;
	}

	@Transactional
	public String saveUser(Users users, Authorities authorities,
			UserDetails userDetails) {
		return commonDao.saveUser(users, authorities, userDetails);

	}

	// ***********************Password Change**********************/

	@Transactional
	public Users getUserForUsername(String userName) {
		return commonDao.getUserForUsername(userName);
	}

	@Transactional
	public void closeAuction(Long auctionId) {
		commonDao.closeAuction(auctionId);
	}

	@Transactional
	public boolean isValidAuction(Long auctionId) {
		return commonDao.isValidAuction(auctionId);
	}

	@Transactional
	public List<Auction> getAuctionListForAction() {
		return commonDao.getAuctionListForAction();
	}

	@Transactional
	public List<UserVO> getActiveBidders() {
		List<UserVO> userVOs = new ArrayList<UserVO>();
		for (Users user : commonDao.getActiveBidders()) {
			UserVO userVO = new UserVO();
			userVO.setFirstName(user.getUserDetails().getFirstName());
			userVO.setLastName(user.getUserDetails().getLastName());
			userVO.setMiddleName(user.getUserDetails().getMiddleName());
			userVO.setEmail(user.getEmail());
			userVO.setUsername(user.getUsername());
			userVO.setUserId(user.getUserId());
			userVOs.add(userVO);
		}
		return userVOs;
	}

	@Transactional
	public void setUserAuctionMap(Long selectedAuctionId,
			String selectedCategoryIdList, String selectedUserIdList) {
		commonDao.setUserAuctionMap(selectedAuctionId, selectedCategoryIdList,
				selectedUserIdList);
	}

	public ICommonDao getCommonDao() {
		return commonDao;
	}

	public void setCommonDao(ICommonDao commonDao) {
		this.commonDao = commonDao;
	}
}
