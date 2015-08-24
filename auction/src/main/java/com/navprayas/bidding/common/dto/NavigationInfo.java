package com.navprayas.bidding.common.dto;

import java.util.List;

import org.displaytag.pagination.PaginatedList;
import org.displaytag.properties.SortOrderEnum;

/**
 * Class to show navigation bar for paging.
 * 
 * @author 30074382
 */
public class NavigationInfo implements PaginatedList {
	
	/**
	 *  Used to set subList of NavigationInfo
	 */
	private List subList;
	
	/**
	 *  Used to set currentPage of NavigationInfo
	 */
	private int currentPage;
	/**
	 *  Used to set pageSize of NavigationInfo
	 */
	private int pageSize;
	/**
	 *  Used to set rowCount of NavigationInfo
	 */
	private int rowCount;
	/**
	 *  Used to set maxIndices of NavigationInfo
	 */
	private int maxIndices;
	/**
	 *  Used to set sortCriterion of NavigationInfo
	 */
	private String sortCriterion;
	
	/**
	 *  Used to set sortOrderEnum of NavigationInfo
	 */
	private SortOrderEnum sortOrderEnum;

	/**
	 * Default constructor
	 */
	public NavigationInfo() {
		currentPage = 1;
		rowCount = 0;
		maxIndices= 10;
		pageSize = 10;
	}

	/**
	 * @return current page number
	 */
	public int getCurrentPage() {
		return currentPage;
	}

	/**
	 * @param currentPage
	 * 			current page number
	 */
	public void setCurrentPage(int currentPage) {
		if (currentPage <= 0) {
			this.currentPage = 1;
		}
		else if (currentPage > getPageCount()) {
			this.currentPage = getPageCount();
		}
		else {
			this.currentPage = currentPage;
		}
		if (this.currentPage <= 0) {
			this.currentPage = 1;
		}
	}

	/**
	 * @return number of records in a page
	 */
	public int getPageSize() {
		return pageSize;
	}

	/**
	 * @param pageSize
	 * 			number of records in a page 
	 */
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	/**
	 * @return number of records to be displayed
	 */
	public int getRowCount() {
		return rowCount;
	}

	/**
	 * @param rowCount 
	 * 			number of records to be displayed
	 */
	public void setRowCount(int rowCount) {
		this.rowCount = rowCount;
	}

	/**
	 * @return max indices
	 * 		maximum number of links to be displayed in the navigation bar
	 */ 
	public int getMaxIndices() {
		return maxIndices;
	}

	/**
	 * @param maxIndices
	 * 		maximum number of links to be displayed in the navigation bar
	 */
	public void setMaxIndices(int maxIndices) {
		this.maxIndices = maxIndices;
	}

	/**
	 * @return total number of pages
	 * 			
	 */
	public int getPageCount() {
		return (int) Math.ceil((double) rowCount / pageSize);
	}

	/**
	 * @return prev index
	 */
	public int getPrevIndex() {
		int prev = currentPage - 1;
		return prev <= 0 ? 1 : prev;
	}

	/**
	 * @return prev index
	 */
	public int getNextIndex() {
		int lastIndex = getPageCount();
		int next = currentPage + 1;
		return next > lastIndex ? lastIndex : next;
	}
	
	/**
	 * @return true if Page number is 0
	 */
	public boolean isFirstPage() {
		return 1 == currentPage;
	}
	
	/**
	 * @return true if Page count -1 is current page number
	 */
	public boolean isLastPage() {
		return (getPageCount()) == currentPage;
	}

	/**
	 * Method used for generating the entire list of 
	 * navigation indices from the range calculated 
	 * by getIndexRange().
	 * 
	 * @return Indexed list
	 */
	public int[] getIndexList() {
		int[] range = getIndexRange();
		int[] ilist = new int[range[1] - range[0] + 1];
		for (int i = 0; i < ilist.length; i++) {
			ilist[i] = range[0] + i;
		}
		return ilist;
	}
	
	/**
	 * @return index range
	 */
	public int[] getIndexRange() {
		// determine the standard window
		int start = currentPage - maxIndices / 2;
		int end = start + maxIndices - 1;
		// shift to right if start underflows 0
		if (start < 0) {
			end -= start; // end - -start = end + start = shift right
			start = 0;
		}
		// now maybe the window overflows pageCount - so shift to left again
		int lastIndex = getPageCount() - 1;
		if (end > (lastIndex)) {
			start -= (end - lastIndex);
			end = lastIndex;
		}
		// we have finalized end, now if start < 0 then truncate it
		if (start < 0)
			start = 0;
		
		return new int[] {start, end};
	}

	/* (non-Javadoc)
	 * @see org.displaytag.pagination.PaginatedList#getFullListSize()
	 */
	public int getFullListSize() {
		return rowCount;
	}

	/* (non-Javadoc)
	 * @see org.displaytag.pagination.PaginatedList#getList()
	 */
	public List getList() {
		return subList;
	}

	/* (non-Javadoc)
	 * @see org.displaytag.pagination.PaginatedList#getObjectsPerPage()
	 */
	public int getObjectsPerPage() {
		return pageSize;
	}

	/* (non-Javadoc)
	 * @see org.displaytag.pagination.PaginatedList#getPageNumber()
	 */
	public int getPageNumber() {
		return currentPage;
	}

	/* (non-Javadoc)
	 * @see org.displaytag.pagination.PaginatedList#getSearchId()
	 */
	public String getSearchId() {
		return null;
	}

	/* (non-Javadoc)
	 * @see org.displaytag.pagination.PaginatedList#getSortCriterion()
	 */
	public String getSortCriterion() {
		return sortCriterion;
	}

	/* (non-Javadoc)
	 * @see org.displaytag.pagination.PaginatedList#getSortDirection()
	 */
	public SortOrderEnum getSortDirection() {
		return this.sortOrderEnum;
	}
	
	/**
	 * @return the subList
	 */
	public List getSubList() {
		return subList;
	}

	/**
	 * @param subList the subList to set
	 */
	public void setSubList(List subList) {
		this.subList = subList;
	}

	/**
	 * @param sortCriterion the sortCriterion to set
	 */
	public void setSortCriterion(String sortCriterion) {
		this.sortCriterion = sortCriterion;
	}

	/**
	 * @param sortOrderEnum the sortOrderEnum to set
	 */
	public void setSortOrderEnum(SortOrderEnum sortOrderEnum) {
		this.sortOrderEnum = sortOrderEnum;
	}


}
