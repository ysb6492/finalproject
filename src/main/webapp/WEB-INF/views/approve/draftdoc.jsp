<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
<style>
section {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 20px;
}
.container {
    width: 90%;
    
    margin: 0 auto;
    background: #fff;
    padding: 20px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    border-radius: 5px;
}
h1 {
    text-align: left;
}
.status-search{
    display: flex; 
    justify-content: space-between;
}
.tabs {
    display: flex;
    gap: 10px;
    margin-bottom: 20px;
}
.tabs button {
    padding: 10px 20px;
    border: none;
    background-color: #f0f0f0;
    cursor: pointer;
}
.tabs button.active {
    background-color: #9269d4;
    color: white;
}
table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
}
table, th, td {
    border: 1px solid #ddd;
    padding: 8px;
}
th {
    background-color: #f2f2f2;
}
.status-button {
    padding: 5px 10px;
    border: none;
    border-radius: 3px;
    cursor: pointer;
}
.status-pending {
    background-color: #9269d4;
    color: white;
}
.status-inprogress {
    background-color: #FFA500;
    color: white;
}
.status-completed {
    background-color: #9E9E9E;
    color: white;
}
.pagination {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 10px;
    margin-bottom: 20px;
}
.pagination button {
    padding: 10px 15px;
    border: 1px solid #ddd;
    background-color: #fff;
    cursor: pointer;
}
.pagination button.active {
    background-color: #9269d4;
    color: white;
    border: none;
}
.filter-section {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 15px;
}
.filter-section select,
.filter-section input {
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 3px;
    
}
</style>
<body>
    <section>
        <div class="container">
            <h1>기안 문서함</h1>
            <div class="status-search">
                <div class="tabs">
                    <button class="active">전체</button>
                    <button>진행</button>
                    <button>반려</button>
                    <button>완료</button>
                </div>
                <div class="filter-section" style="margin-bottom: 20px;">
                    <select>
                        <option>전체기간</option>
                        <option>1</option>
                        <option>2</option>
                    </select>
                    <input type="text" placeholder="제목">
                    <button>검색</button>
                </div>
            </div>
            
            <table>
                <thead>
                    <tr>
                        <th>기안일</th>
                        <th>결재방식</th>
                        <th>제목</th>
                        <th>사유</th>
                        <th>첨부파일</th>
                        <th>문서번호</th>
                        <th>결재상태</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>2022-09-26</td>
                        <td>휴가신청</td>
                        <td>휴가신청</td>
                        <td></td>
                        <td></td>
                        <td>123123-4545</td>
                        <td><button class="status-button status-pending">대기</button></td>
                    </tr>
                    <tr>
                        <td>2022-09-26</td>
                        <td>연장근무신청</td>
                        <td>연장근무신청</td>
                        <td></td>
                        <td></td>
                        <td>1231-45465</td>
                        <td><button class="status-button status-inprogress">진행</button></td>
                    </tr>
                </tbody>
            </table>
            <div class="pagination">
                <button class="active">1</button>
                
            </div>
            
        </div>
     </section>
</body>
</html>