<%--
  Created by IntelliJ IDEA.
  User: 83927
  Date: 2020/8/4
  Time: 12:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>

<html>
<head>
    <title>员工分页</title>
    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
<%--web路径 不以/开头的相对路径，找资源，以当前路径资源为基准，经常容易出问题
   以/开头的相对路径，以服务器的路径为标准(localhost:8080/)
--%>
        <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
        <%-- 引入juery--%>
        <script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.4.1/jquery-3.4.1.min.js"></script>
    <link href="css/list.css" rel="stylesheet"/>
</head>
<body>
   <div class="container">
           <%--标题行--%>
       <div class="row">
           <div class="col-md-12">
               <h1>SSM-CRUD</h1>
           </div>
       </div>
<%--按钮--%>
       <div class="row">
           <div class="col-md-4 col-md-offset-8">
               <button class="btn btn-success">新增</button>
               <button class="btn btn-danger">删除</button>
           </div>
       </div>
<%--显示表格数据--%>
       <div class="row">
           <div class="col-md-12">
               <table class="table table-bordered table-hover">

                   <thead>
                   <tr>
                       <th>编号</th>
                       <th>姓名</th>
                       <th>性别</th>
                       <th>电子邮件</th>
                       <th>部门</th>
                       <th>操作</th>
                   </tr>
                   </thead>
                   <tbody>
                   <c:forEach items="${pageInfo.list}" var="emp">
                   <tr>
                       <td>${emp.empId}</td>
                       <td>${emp.empName}</td>
                       <td>${emp.gender}</td>
                       <td>${emp.email}</td>
                       <td>${emp.department.deptName}</td>
                       <td>
                           <button class="btn btn-success">
                               <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                               编辑
                           </button>
                           <button class="btn btn-danger">
                               <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                               删除
                           </button>
                       </td>
                   </tr>
                   </c:forEach>
                   </tbody>

               </table>
           </div>
       </div>
<%--显示分页信息--%>
       <div class="row">
           <div class="col-md-6">
               当前第${pageInfo.pageNum}页,共有${pageInfo.pages}页,共有${pageInfo.total}条记录
           </div>
           <div class="col-md-6">
               <nav aria-label="Page navigation">
                   <ul class="pagination">
                       <li><a href="${APP_PATH}/emp?pn=1">首页</a></li>
                       <c:if test="${pageInfo.hasPreviousPage}">
                           <li>
                               <a href="${APP_PATH}/emp?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                   <span aria-hidden="true">&laquo;</span>
                               </a>
                           </li>
                       </c:if>
                       <c:forEach items="${pageInfo.navigatepageNums}" var="page_num">
                           <c:if test="${pageInfo.pageNum==page_num}">
                               <li class="active"><a href="#">${page_num}</a></li>
                           </c:if>
                           <c:if test="${pageInfo.pageNum!=page_num}">
                               <li><a href="${APP_PATH}/emp?pn=${page_num}">${page_num}</a></li>
                           </c:if>
                       </c:forEach>
                       <c:if test="${pageInfo.hasNextPage}">
                           <li>
                               <a href="${APP_PATH}/emp?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                   <span aria-hidden="true">&raquo;</span>
                               </a>
                           </li>
                       </c:if>
                       <li><a href="${APP_PATH}/emp?pn=${pageInfo.pages}">末页</a></li>
                   </ul>
               </nav>
           </div>
       </div>
   </div>
</body>
</html>
