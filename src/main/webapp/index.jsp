<%--
  Created by IntelliJ IDEA.
  User: 83927
  Date: 2020/8/4
  Time: 12:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>员工分页</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <%--web路径 不以/开头的相对路径，找资源，以当前路径资源为基准，经常容易出问题
       以/开头的相对路径，以服务器的路径为标准(localhost:8080/)
    --%>
    <%-- 引入juery--%>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.4.1/jquery-3.4.1.min.js"></script>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

    <link href="css/index.css" rel="stylesheet"/>
</head>
<body>
<div class="container">


    <!-- Modal 新增员工模态框-->
    <div class="modal fade" id="empAdd" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">新增员工</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal Add_emp">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">姓名</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="empName" id="empName_input"
                                       placeholder="姓名">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">邮箱</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="email" id="email_input"
                                       placeholder="xxx.@xxx.com">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">性别</label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="inlineRadio1" value="男" checked> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="inlineRadio2" value="女"> 女
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">部门</label>
                            <div class="col-sm-10">
                                <select class="form-control" name="dId" id="dept_sel">

                                </select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="save_emp">保存</button>
                </div>
            </div>
        </div>
    </div>
    <%--编辑员工模态框--%>
    <div class="modal fade" id="emp_edit" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">编辑员工</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal form-edit">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">姓名</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="empName" id="empName_input_edit">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">邮箱</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="email" id="email_input_edit">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">性别</label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="male" value="男" checked> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="female" value="女"> 女
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">部门</label>
                            <div class="col-sm-10">
                                <select class="form-control" name="dId" id="edit_sel">

                                </select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="update_btn">更新</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 模态框   信息删除确认 -->
    <div class="modal fade" id="del_emp">
        <div class="modal-dialog">
            <div class="modal-content message_align">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                    <h4 class="modal-title">提示</h4>
                </div>
                <div class="modal-body confirm_text">
                    <!-- 隐藏需要删除的id -->
                    <%--                    <input type="hidden" id="deleteHaulId" />--%>
                    <p>您确认要删除该条信息吗？</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal">取消
                    </button>
                    <button type="button" class="btn btn-primary confirm_del "
                            id="confirm_del">确认
                    </button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
    </div>
    <!-- /.modal-dialog -->

    <%--标题行--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-success" id="add_emp">新增</button>
            <button class="btn btn-danger" id="del_select">删除所选</button>
        </div>
    </div>
    <%--显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-bordered table-hover ">
                <thead class="t_head">
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
                    <th>编号</th>
                    <th>姓名</th>
                    <th>性别</th>
                    <th>电子邮件</th>
                    <th>部门</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody class="emp_table">
                </tbody>
            </table>
        </div>
    </div>
    <%--显示分页信息--%>
    <div class="row">
        <div class="col-md-6" id="page_info">
        </div>
        <div class="col-md-6" id="page_nav">

        </div>
    </div>
</div>
<script type="text/javascript">
    <%--校验表单的字段是否出错--%>
    var flag = false;
    var emp_ids = "";
    var totalRecord, currenPage;
    <%--页面加载完成之后，发送一个ajax请求--%>

    $(function () {
        //  直接加载第一页
        to_page(1)
    });

    function to_page(pageNum) {
        $.ajax({
            url: "${APP_PATH}/emp",
            data: "pn=" + pageNum,
            type: "GET",
            success: function (res) {
                //    解析并显示
                build_emp_table(res)
                build_page_info(res)
                build_page_nav(res)
            }
        });
    }

    function build_emp_table(res) {
        $(".emp_table").empty()

        var emps = res.extend.pageInfo.list
        $.each(emps, function (index, item) {
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            empNameTd.attr("emp_name", item.empName)
            var genderTd = $("<td></td>").append(item.gender);
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            editBtn.attr("emp_edit_id", item.empId)
            editBtn.attr("emp_edit_name", item.empName)
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            delBtn.attr("emp_del_id", item.empId)
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            //var delBtn =


            //append方法执行完成以后还是返回原来的元素
            $("<tr></tr>")
                .append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo(".emp_table");
        })
    }

    function build_page_info(res) {
        $("#page_info").empty()
        $("#page_info").append(" 当前第" + res.extend.pageInfo.pageNum + "页,共有" + res.extend.pageInfo.pages + "页,共有" + res.extend.pageInfo.total + "条记录")
        totalRecord = res.extend.pageInfo.total;
        currenPage = res.extend.pageInfo.pageNum
    }

    function build_page_nav(res) {
        $("#page_nav").empty();
        var ul = $("<ul></ul>").addClass("pagination");

        //构建元素
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));

        if (res.extend.pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {
            firstPageLi.click(function () {
                to_page(1)
            });
            prePageLi.click(function () {
                to_page(res.extend.pageInfo.pageNum - 1)
            });
        }

        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));

        if (res.extend.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {
            lastPageLi.click(function () {
                to_page(res.extend.pageInfo.pages)
            });
            nextPageLi.click(function () {
                to_page(res.extend.pageInfo.pageNum + 1)
            });
        }


        ul.append(firstPageLi).append(prePageLi)
        $.each(res.extend.pageInfo.navigatepageNums, (index, item) => {
            var numLi = $("<li></li>").append($("<a></a>").append(item));

            if (item == res.extend.pageInfo.pageNum) {
                numLi.addClass("active")
            }

            numLi.click(function () {
                to_page(item)
            });

            ul.append(numLi)
        })
        ul.append(nextPageLi).append(lastPageLi)
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav");
    }

    $("#add_emp").click(function () {
        //清除上一次表单的内容以及样式
        reset_form(".Add_emp");

        get_depts("#dept_sel");

        $("#empAdd").modal({
            backdrop: "static"
        });
    })

    function get_depts(el) {
        $(el).empty();
        $.ajax({
            url: "${APP_PATH}/dept",
            type: "get",
            success: function (res) {
                put_dept_to_sel(res, el)
            }
        })
    }

    function put_dept_to_sel(res, el) {
        $.each(res.extend.depts, (index, item) => {
            $("<option></option>").append(item.deptName).attr("value", item.deptId).appendTo(el);
        })
    }

    function show_validate_msg(el, status, msg) {
        //清除上一次的样式以及内容
        $(el).parent().removeClass("has-success has-error");
        $(el).next("span").text("");

        if (status == "success") {
            $(el).parent().addClass("has-success");
            $(el).next("span").text(msg);
        } else if ("error" == status) {
            $(el).parent().addClass("has-error");
            $(el).next("span").text(msg);
        }
    }

    //前端验证姓名和邮箱的合法性
    $("#empName_input").blur(function () {
        //检验姓名的合法性
        check_S_EmpName("#empName_input")
    });

    //前端通过后，检查后端是否重复
    function check_S_EmpName(el) {
        var isRepeat = true;
        if (check_B_EmpName(el)) {
            $.ajax({
                url: "${APP_PATH}/checkUser",
                data: "empName=" + $(el).val(),
                type: "post",
                //改为同步处理
                async: false,
                success: function (res) {
                    if (res.code == 100) {
                        show_validate_msg(el, "success", "")
                        isRepeat = true;
                    } else {
                        show_validate_msg(el, "error", "用户名重复")
                        isRepeat = false;
                    }
                }
            });
        }
        if (isRepeat == true) {
            return true;
        }
        return false;
    }

    $("#email_input").blur(function () {
        //2、校验邮箱合法性
        checkEmail("#email_input");
    });

    //检查前端的输入框内容
    function check_B_EmpName(el) {
        var empName = $(el).val()
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (regName.test(empName)) {
            // show_validate_msg("#empName_input", "success", "用户名合法")
            return true;
        } else {
            show_validate_msg(el, "error", "用户名可以是2-5位中文或者6-16位英文和数字的组合")
            return false;
        }

    }

    function checkEmail(el) {
        var email = $(el).val();
        var regEmail = /^[A-Za-z0-9]+([_\.][A-Za-z0-9]+)*@([A-Za-z0-9\-]+\.)+[A-Za-z]{2,6}$/;
        if (regEmail.test(email)) {
            show_validate_msg(el, "success", "")
            return true;
        } else {
            show_validate_msg(el, "error", "邮箱不合法")
            return false;
        }
    }

    function reset_form(el) {
        $(el)[0].reset();
        $(el).find("*").removeClass("has-error has-success")
        $(el).find(".help-block").text("")
    }

    $("#save_emp").click(() => {
        if (flag) {
            $.ajax({
                url: "${APP_PATH}/saveEmp",
                type: "POST",
                data: $(".Add_emp").serialize(),
                success: function (res) {
                    if (res.code == 100) {
                        $("#empAdd").modal("hide")
                        to_page(totalRecord)
                    } else {
                        //有哪个字段的错误信息就显示哪个字段的；
                        if (undefined != res.extend.errors.email) {
                            //显示邮箱错误信息
                            show_validate_msg("#email_input", "error", res.extend.errors.email);
                        }
                        if (undefined != res.extend.errors.empName) {
                            //显示员工名字的错误信息
                            show_validate_msg("#empName_input", "error", res.extend.errors.empName);
                        }
                    }
                }
            });
        } else {
            return false;
        }

    });

    //将编辑按钮绑定点击事件
    $(document).on("click", ".edit_btn", function () {
        //清空表单样式
        $(".form-edit").find("*").removeClass("has-error has-success")
        $(".form-edit").find(".help-block").text("")

        //唤起模态框
        $("#emp_edit").modal({
            backdrop: "static",
        });

        //将员工的id传到更新按钮
        $("#update_btn").attr("edit_id", $(this).attr("emp_edit_id"))
        //将员工的姓名传到更新按钮
        $("#update_btn").attr("edit_name", $(this).attr("emp_edit_name"))
        //将部门写入到下拉列表
        get_depts("#edit_sel")
        //发起请求

        getEmp($(this).attr("emp_edit_id"))
    })

    //获取单个员工的信息
    function getEmp(id) {
        $.ajax({
            url: "${APP_PATH}/getEmp/" + id,
            type: "get",
            success: function (res) {
                var emp = res.extend.emp
                $("#empName_input_edit").val(emp.empName)
                $("#email_input_edit").val(emp.email)
                $(".form-edit input[name=gender]").val([emp.gender])
                $(".form-edit select").val([emp.dId])
            }
        });
    }

    $("#update_btn").click(function () {
        checkEmail("#email_input_edit")
        var empName = $("#empName_input_edit").val();
        //判断修改后的名字和原先是否一样
        if (empName == $(this).attr("edit_name")) {
            setTimeout(function () {
                //关闭模态框
                $("#emp_edit").modal("hide")
                //回到本页
                to_page(currenPage)
            }, 2000)
        } else {
            if (check_S_EmpName("#empName_input_edit")) {
                $.ajax({
                    url: "${APP_PATH}/updateEmp/" + $(this).attr("edit_id"),
                    data: $(".form-edit").serialize(),
                    type: "put",
                    success: function (res) {
                        if (res.code == 100) {
                            setTimeout(function () {
                                //关闭模态框
                                $("#emp_edit").modal("hide")
                                //回到本页
                                to_page(currenPage)
                            }, 2000)

                        } else {
                            return false;
                        }
                    }
                });
            }
        }
    });

    //将删除按钮绑定点击事件
    $(document).on("click", ".delete_btn", function () {

        //修改确认删除的名字
        var empName = $(this).parents("tr").find("td:eq(2)").text()
        $(".confirm_text p").text("你确定删除" + empName + "吗?")

        $("#del_emp").modal({
            backdrop: "static"
        })

        //将要删除的员工的id传到确认按钮按钮
        $("#confirm_del").attr("del_id", $(this).attr("emp_del_id"))
    });

    //确认删除按钮点击事件
    $("#confirm_del").click(function () {
        var del_id = $(this).attr("del_id")
        del_emp(del_id);
    });

    //删除员工
    function del_emp(empId) {
        $.ajax({
            url: "${APP_PATH}/delEmp/" + empId,
            type: "DELETE",
            success: function (res) {
                if (res.code == 100) {
                    $(".confirm_text p").text("删除成功")
                    setTimeout(() => {
                        $("#del_emp").modal("hide")
                        to_page(currenPage)
                    }, 2000)
                } else {
                    $(".confirm_text p").text("删除失败！")
                }
            }
        });
    }

    $("#check_all").click(function () {
        //prop修改和读取dom原生属性的值
        $(".check_item").prop("checked", $(this).prop("checked"));
    });

    $(document).on("click", ".check_item", () => {
        //判断是否全选，全选状态下check_all才属于激活状态下
        var fg = $(".check_item:checked").length == $(".check_item").length
        $("#check_all").prop("checked", fg);
    })

    $("#del_select").click(() => {
        var empName = "";
        var empId = "";

        $.each($(".check_item:checked"), function () {
            empName += $(this).parents("tr").find("td:eq(2)").text() + ",";
            empId += $(this).parents("tr").find("td:eq(1)").text() + "-";
        })
        empName = empName.substring(0, empName.length - 1)
        //去除删除的id多余的并将只赋予emp_ids
        emp_ids = empId.substring(0, empId.length - 1);
        //改变模态框内容
        $(".confirm_text p").text("确定要删除" + empName + "吗?")
        //唤起模态框
        $("#del_emp").modal({
            backdrop: "static"
        })

    });

    //确定一个或多个按钮点击事件
    $(".confirm_del").click(() => {
        delEmps(emp_ids);
    })

    //删除一个或多个员工
    function delEmps(delIds) {
        $.ajax({
            url: "${APP_PATH}/delEmps/" + delIds,
            type: "DELETE",
            success: function (res) {
                if (res.code == 100) {
                    $(".confirm_text p").text("")
                    $(".confirm_text p").text("删除成功!")

                    setTimeout(() => {
                        $("#del_emp").modal("hide")
                        $("#check_all").prop("checked",false);
                        to_page(currenPage)
                    }, 1500)
                } else {
                    $(".confirm_text p").text("删除失败!")
                }
            }
        });
    }
</script>
</body>
</html>
