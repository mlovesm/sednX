package hanibal.ibs.library;

import javax.servlet.http.HttpServletRequest;
public class IbsCmsPagingUtil {
	public static String memberPagingText(HttpServletRequest req, String searchWord, String authority,int totalRecordCount, 
			int pageSize, int blockPage, int nowPage,String page) {

		String pagingStr="<ul class=\"btn-group\" id=\"pagingDiv\">";
		int totalPage= (int)(Math.ceil(((double)totalRecordCount/pageSize)));
		int intTemp = ((nowPage - 1) / blockPage) * blockPage + 1;
		if(intTemp != 1){
			pagingStr+= " <li class=\"btn btn-sm btn-alt\"><a rel='"+page+"nowPage="+(intTemp -blockPage)+"&authority="+authority+"&searchWord="+searchWord+"'><i class=\"icon\">&#61903;</i></a></li>";	
		}
		int blockCount = 1;
		while(blockCount <=  blockPage && intTemp <= totalPage){  
			if(intTemp == nowPage){  
				pagingStr+=" <li class=\"btn btn-sm btn-alt active\"><a>"+intTemp+"</a></li>";
			}else
		    	pagingStr+="<li class=\"btn btn-sm btn-alt\"><a rel='"+page+"nowPage="+intTemp+"&authority="+authority+"&searchWord="+searchWord+"'>"+intTemp+"</a></li>";
		   intTemp = intTemp + 1;
		   blockCount = blockCount + 1;
		}
		if(intTemp<=totalPage) {
			pagingStr+="<li class=\"btn btn-sm btn-alt\"><a rel='"+page+"nowPage="+totalPage+"&authoritye="+authority+"&searchWord="+searchWord+"'><i class=\"icon\">&#61815;</i></a></li>"; 
		}
		pagingStr+="</ul>";
		return pagingStr;
	}

	public static String vodPagingText(HttpServletRequest req, String searchWord,String childIdx, int totalRecordCount, int pageSize,
			int blockPage, int nowPage, String page) {
		String pagingStr="<ul class=\"btn-group\" id=\"pagingDiv\">";
		int totalPage= (int)(Math.ceil(((double)totalRecordCount/pageSize)));
		int intTemp = ((nowPage - 1) / blockPage) * blockPage + 1;
		if(intTemp != 1){
			pagingStr+= " <li class=\"btn btn-sm btn-alt\"><a rel='"+page+"nowPage="+(intTemp -blockPage)+"&searchWord="+searchWord+"&childIdx="+childIdx+"'><i class=\"icon\">&#61903;</i></a></li>";	
		}
		int blockCount = 1;
		while(blockCount <=  blockPage && intTemp <= totalPage){  
			if(intTemp == nowPage){  
				pagingStr+=" <li class=\"btn btn-sm btn-alt active\">&nbsp;&nbsp;&nbsp;"+intTemp+"&nbsp;&nbsp;&nbsp;</li>";
			}else
		    	pagingStr+="<li class=\"btn btn-sm btn-alt\"><a rel='"+page+"nowPage="+intTemp+searchWord+"&childIdx="+childIdx+"'>"+intTemp+"</a></li>";
		   intTemp = intTemp + 1;
		   blockCount = blockCount + 1;
		}
		if(intTemp<=totalPage) {
			pagingStr+="<li class=\"btn btn-sm btn-alt\"><a rel='"+page+"nowPage="+totalPage+"&searchWord="+searchWord+"&childIdx="+childIdx+"'><i class=\"icon\">&#61815;</i></a></li>"; 
		}
		pagingStr+="</ul>";
		return pagingStr;
	}

	public static String livePagingText(HttpServletRequest req, String searchWord,String childIdx, int totalRecordCount, int pageSize,
			int blockPage, int nowPage, String page) {
		String pagingStr="<ul class=\"btn-group\" id=\"pagingDiv\">";
		int totalPage= (int)(Math.ceil(((double)totalRecordCount/pageSize)));
		int intTemp = ((nowPage - 1) / blockPage) * blockPage + 1;
		if(intTemp != 1){
			pagingStr+= " <li class=\"btn btn-sm btn-alt\"><a rel='"+page+"nowPage="+(intTemp -blockPage)+"&searchWord="+searchWord+"&childIdx="+childIdx+"'><i class=\"icon\">&#61903;</i></a></li>";	
		}
		int blockCount = 1;
		while(blockCount <=  blockPage && intTemp <= totalPage){  
			if(intTemp == nowPage){  
				pagingStr+=" <li class=\"btn btn-sm btn-alt active\">&nbsp;&nbsp;&nbsp;"+intTemp+"&nbsp;&nbsp;&nbsp;</li>";
			}else
		    	pagingStr+="<li class=\"btn btn-sm btn-alt\"><a rel='"+page+"nowPage="+intTemp+searchWord+"&childIdx="+childIdx+"'>"+intTemp+"</a></li>";
		   intTemp = intTemp + 1;
		   blockCount = blockCount + 1;
		}
		if(intTemp<=totalPage) {
			pagingStr+="<li class=\"btn btn-sm btn-alt\"><a rel='"+page+"nowPage="+totalPage+"&searchWord="+searchWord+"&childIdx="+childIdx+"'><i class=\"icon\">&#61815;</i></a></li>"; 
		}
		pagingStr+="</ul>";
		return pagingStr;
	}

	public static String filePagingText(HttpServletRequest req, String searchWord,String childIdx, int totalRecordCount, int pageSize,
			int blockPage, int nowPage, String page) {
		String pagingStr="<ul class=\"btn-group\" id=\"pagingDiv\">";
		int totalPage= (int)(Math.ceil(((double)totalRecordCount/pageSize)));
		int intTemp = ((nowPage - 1) / blockPage) * blockPage + 1;
		if(intTemp != 1){
			pagingStr+= " <li class=\"btn btn-sm btn-alt\"><a rel='"+page+"nowPage="+(intTemp -blockPage)+"&searchWord="+searchWord+"&childIdx="+childIdx+"'><i class=\"icon\">&#61903;</i></a></li>";	
		}
		int blockCount = 1;
		while(blockCount <=  blockPage && intTemp <= totalPage){  
			if(intTemp == nowPage){  
				pagingStr+=" <li class=\"btn btn-sm btn-alt active\">&nbsp;&nbsp;&nbsp;"+intTemp+"&nbsp;&nbsp;&nbsp;</li>";
			}else
		    	pagingStr+="<li class=\"btn btn-sm btn-alt\"><a rel='"+page+"nowPage="+intTemp+searchWord+"&childIdx="+childIdx+"'>"+intTemp+"</a></li>";
		   intTemp = intTemp + 1;
		   blockCount = blockCount + 1;
		}
		if(intTemp<=totalPage) {
			pagingStr+="<li class=\"btn btn-sm btn-alt\"><a rel='"+page+"nowPage="+totalPage+"&searchWord="+searchWord+"&childIdx="+childIdx+"'><i class=\"icon\">&#61815;</i></a></li>"; 
		}
		pagingStr+="</ul>";
		return pagingStr;
	}

	public static String photoPagingText(HttpServletRequest req, String searchWord,String childIdx, int totalRecordCount, int pageSize,
			int blockPage, int nowPage, String page) {
		String pagingStr="<ul class=\"btn-group\" id=\"pagingDiv\">";
		int totalPage= (int)(Math.ceil(((double)totalRecordCount/pageSize)));
		int intTemp = ((nowPage - 1) / blockPage) * blockPage + 1;
		if(intTemp != 1){
			pagingStr+= " <li class=\"btn btn-sm btn-alt\"><a rel='"+page+"nowPage="+(intTemp -blockPage)+"&searchWord="+searchWord+"&childIdx="+childIdx+"'><i class=\"icon\">&#61903;</i></a></li>";	
		}
		int blockCount = 1;
		while(blockCount <=  blockPage && intTemp <= totalPage){  
			if(intTemp == nowPage){  
				pagingStr+=" <li class=\"btn btn-sm btn-alt active\">&nbsp;&nbsp;&nbsp;"+intTemp+"&nbsp;&nbsp;&nbsp;</li>";
			}else
		    	pagingStr+="<li class=\"btn btn-sm btn-alt\"><a rel='"+page+"nowPage="+intTemp+searchWord+"&childIdx="+childIdx+"'>"+intTemp+"</a></li>";
		   intTemp = intTemp + 1;
		   blockCount = blockCount + 1;
		}
		if(intTemp<=totalPage) {
			pagingStr+="<li class=\"btn btn-sm btn-alt\"><a rel='"+page+"nowPage="+totalPage+"&searchWord="+searchWord+"&childIdx="+childIdx+"'><i class=\"icon\">&#61815;</i></a></li>"; 
		}
		pagingStr+="</ul>";
		return pagingStr;
	}

	public static String boardPagingText(HttpServletRequest req, String searchWord,String childIdx, int totalRecordCount, int pageSize,
			int blockPage, int nowPage, String page) {
		String pagingStr="<ul class=\"btn-group\" id=\"pagingDiv\">";
		int totalPage= (int)(Math.ceil(((double)totalRecordCount/pageSize)));
		int intTemp = ((nowPage - 1) / blockPage) * blockPage + 1;
		if(intTemp != 1){
			pagingStr+= " <li class=\"btn btn-sm btn-alt\"><a rel='"+page+"nowPage="+(intTemp -blockPage)+"&searchWord="+searchWord+"&childIdx="+childIdx+"'><i class=\"icon\">&#61903;</i></a></li>";	
		}
		int blockCount = 1;
		while(blockCount <=  blockPage && intTemp <= totalPage){  
			if(intTemp == nowPage){  
				pagingStr+=" <li class=\"btn btn-sm btn-alt active\">&nbsp;&nbsp;&nbsp;"+intTemp+"&nbsp;&nbsp;&nbsp;</li>";
			}else
		    	pagingStr+="<li class=\"btn btn-sm btn-alt\"><a rel='"+page+"nowPage="+intTemp+searchWord+"&childIdx="+childIdx+"'>"+intTemp+"</a></li>";
		   intTemp = intTemp + 1;
		   blockCount = blockCount + 1;
		}
		if(intTemp<=totalPage) {
			pagingStr+="<li class=\"btn btn-sm btn-alt\"><a rel='"+page+"nowPage="+totalPage+"&searchWord="+searchWord+"&childIdx="+childIdx+"'><i class=\"icon\">&#61815;</i></a></li>"; 
		}
		pagingStr+="</ul>";
		return pagingStr;
	}

	public static String stbPagingText(HttpServletRequest req, String searchWord,String childIdx, int totalRecordCount, int pageSize,
			int blockPage, int nowPage, String page) {
		String pagingStr="<ul class=\"btn-group\" id=\"pagingDiv\">";
		int totalPage= (int)(Math.ceil(((double)totalRecordCount/pageSize)));
		int intTemp = ((nowPage - 1) / blockPage) * blockPage + 1;
		if(intTemp != 1){
			pagingStr+= " <li class=\"btn btn-sm btn-alt\"><a rel='"+page+"nowPage="+(intTemp -blockPage)+"&searchWord="+searchWord+"&childIdx="+childIdx+"'><i class=\"icon\">&#61903;</i></a></li>";	
		}
		int blockCount = 1;
		while(blockCount <=  blockPage && intTemp <= totalPage){  
			if(intTemp == nowPage){  
				pagingStr+=" <li class=\"btn btn-sm btn-alt active\">&nbsp;&nbsp;&nbsp;"+intTemp+"&nbsp;&nbsp;&nbsp;</li>";
			}else
		    	pagingStr+="<li class=\"btn btn-sm btn-alt\"><a rel='"+page+"nowPage="+intTemp+searchWord+"&childIdx="+childIdx+"'>"+intTemp+"</a></li>";
		   intTemp = intTemp + 1;
		   blockCount = blockCount + 1;
		}
		if(intTemp<=totalPage) {
			pagingStr+="<li class=\"btn btn-sm btn-alt\"><a rel='"+page+"nowPage="+totalPage+"&searchWord="+searchWord+"&childIdx="+childIdx+"'><i class=\"icon\">&#61815;</i></a></li>"; 
		}
		pagingStr+="</ul>";
		return pagingStr;
	}

	public static String schedulePagingText(HttpServletRequest req, String searchWord,String childIdx, int totalRecordCount, int pageSize,
			int blockPage, int nowPage, String page) {
		String pagingStr="<ul class=\"btn-group\" id=\"pagingDiv\">";
		int totalPage= (int)(Math.ceil(((double)totalRecordCount/pageSize)));
		int intTemp = ((nowPage - 1) / blockPage) * blockPage + 1;
		if(intTemp != 1){
			pagingStr+= " <li class=\"btn btn-sm btn-alt\"><a rel='"+page+"nowPage="+(intTemp -blockPage)+"&searchWord="+searchWord+"&childIdx="+childIdx+"'><i class=\"icon\">&#61903;</i></a></li>";	
		}
		int blockCount = 1;
		while(blockCount <=  blockPage && intTemp <= totalPage){  
			if(intTemp == nowPage){  
				pagingStr+=" <li class=\"btn btn-sm btn-alt active\">&nbsp;&nbsp;&nbsp;"+intTemp+"&nbsp;&nbsp;&nbsp;</li>";
			}else
		    	pagingStr+="<li class=\"btn btn-sm btn-alt\"><a rel='"+page+"nowPage="+intTemp+searchWord+"&childIdx="+childIdx+"'>"+intTemp+"</a></li>";
		   intTemp = intTemp + 1;
		   blockCount = blockCount + 1;
		}
		if(intTemp<=totalPage) {
			pagingStr+="<li class=\"btn btn-sm btn-alt\"><a rel='"+page+"nowPage="+totalPage+"&searchWord="+searchWord+"&childIdx="+childIdx+"'><i class=\"icon\">&#61815;</i></a></li>"; 
		}
		pagingStr+="</ul>";
		return pagingStr;
	}
}
