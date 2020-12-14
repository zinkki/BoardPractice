<%@ page import = "model.BoardDAO" %>
<%@ page import = "java.util.Vector" %>
<%@ page import = "model.BoardBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<!-- 게시글보기에 카운터링을 설정하기 위한 변수들을 선언!! -->
	<%
		//화면에 보여질 게시글의 개수를 지정
		int pageSize = 10;
		//현재 카운터를 클릭한 번호값을 읽어옴
		String pageNum = request.getParameter("pageNum");
		//만약 처음 boardList.jsp를 클릭하거나 수정삭제 등 다른 게시글에서 이전페이지로 넘어오면 pageNum값이 없기때문에 null처리를 해준다?
		if(pageNum == null) {
			pageNum="1";
		}
		int count = 0; //전체글의 갯수를 저장하는 변수
		int number = 0; //페이지 넘버링 변수
		
		//현재 보고자 하는 페이지 숫자를 저장
		int currentPage = Integer.parseInt(pageNum);
		
		//전체 게시글의 내용을 jsp쪽으로 가져와야함.
		BoardDAO bdao = new BoardDAO();
		//전체 게시글의 갯수를 읽어드리는 메소드 생성후  호출...!
		count = bdao.getAllCount();  
		//현재 페이지에 보여줄 시작 번호를 설정! = 데이터 베이스에서 불러올 시작번호
		int startRow = (currentPage-1)*pageSize+1;
		int endRow = currentPage * pageSize;
		
		
		//전체 게시글을 리턴 받아주는 소스 (페이지 카운팅하기 전에는 전체게시글을 리턴받아왔지...)
		//Vector<BoardBean> vec = bdao.getAllBoard();
		
		//(페이지 카운팅을 넣고)최신글10개씩 게시글을 리턴받아주는 메소드생성후 호출
		Vector<BoardBean> vec = bdao.getAllBoard(startRow , endRow); 
		//테이블에 표시할 번호를 저장
		number = count - (currentPage - 1)*pageSize;
	%>
	
	<h2 align="center">! ALL LIST !</h2>
	<table align="center" width="700" border="1">
		<tr height="50">
			<td align="right" colspan="5">
			<input type="button" value="WRITE" onclick="location.href='boardWriteForm.jsp'">
			</td>
		</tr>
		<tr height="50">
			<td width="50" align="center">NUM</td>
			<td width="350" align="center">TITLE</td>
			<td width="150" align="center">WRITER</td>
			<td width="100" align="center">DATE</td>
			<td width="50" align="center">VIEW</td>
		</tr>
		
	<%
		for(int i=0; i < vec.size(); i++) {
			BoardBean bean = vec.get(i);  //벡터에 저장되어있는 빈클래스를 하나씩 추출해라는 뜻
			
	%>
		<tr height="40">
			<td width="50" align="center"><%=number-- %></td>
			<td width="350" align="left">
				<a href="boardInfo.jsp?board_num=<%=bean.getBoard_num()%>"> 
					<%=bean.getSubject()%></a>
			</td>
			<td width="150" align="center"><%=bean.getWriter() %></td>
			<td width="100" align="center"><%=bean.getReg_date() %></td>
			<td width="50" align="center"><%=bean.getReadcount() %></td>
		</tr>
	<% 
	}
	%>
		
	</table>
	<!-- 페이지 카운터링 소스를 작성 이거 개어려웡 이해도안가고 ㅋ-->
	<p align="center">
	<%
		if(count > 0) {
			int pageCount = count / pageSize + (count%pageSize == 0 ? 0 : 1);
			
			//시작 페이지 숫자를 설정
			int startPage = 1;
			if(currentPage %10 != 0){
				startPage=(int)(currentPage/10)*10+1;
			}else {
				startPage =((int)(currentPage/10)-1)*10+1;
			}
			
			int pageBlock=10; //카운터링 처리 숫자
			int endPage = startPage+pageBlock-1; //화면에 보여질 페이지의 마지막숫자
			
			if(endPage > pageCount) endPage = pageCount;
			
			//이전이라는 링크를 만들건지 파악
			if(startPage > 10) {
	 %>
	 	<a href="boardList.jsp?pageNum=<%=startPage-10 %>">[before]</a>
	 <%	
			}
			//페이징처리
			for(int i = startPage; i <= endPage; i++) {
	  %>
	  	<a href="boardList.jsp?pageNum=<%=i %>">[<%=i %>]</a>
	  
	<% }
			//다음이라는 링크를 만들건지 파악...기빨려....ㅅㅂ
			if(endPage < pageCount) {
	 %>
		<a href="boardList.jsp?pageNum=<%=startPage+10 %>">[next]</a>
		
	<%
			}
	
		}
	%>
	
</body>
</html>