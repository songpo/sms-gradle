<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <script type="text/javascript"src="<%=path%>/js/jquery/jquery-2.0.3.min.js"></script>
    <script type="text/javascript"src="<%=path%>/js/jquery/jquery-2.0.3.min.map"></script>
    <script type="text/javascript"src="<%=path%>/js/bootstrap/bootstrap.min.js"></script>
    <script type="text/javascript"src="<%=path%>/js/common/dateutil.js"></script>

    <link rel="stylesheet" type="text/css" href="<%=path%>/css/bootstrap/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/flat-ui/flat-ui.css">
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/font-awesome/font-awesome.min.css">

</head>
<body>
<security:authentication property="principal" var="authentication"/>
${authentication.username}

<div class="navbar navbar-inverse">
    <div class="navbar-collapse collapse navbar-collapse-01">
        <ul class="nav navbar-nav navbar-left">
            <li class="active">
                <a href="<%=path%>/user/worker/manage"><span class="fa fa-lg fa-users"></span>员工管理</a>
            </li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li>
                <a class="fa fa-lg fa-user" href="javascript:void(0);">${loginUser.nickname}</a>
                <ul style="width: auto;">
                    <li>
                        <a href="javascript:void(0);" onclick="edit('${loginUser.id}');"><span class="fa fa-lg fa fa-edit"></span>我的信息</a>
                    </li>
                    <li>
                        <a href="javascript:void(0);" onclick="changePassword('${loginUser.id}');"><span class="fa fa-lg fa-lock"></span>更改密码</a>
                    </li>
                    <li>
                        <a href="<%=path%>/logout"><span class="fa fa-lg fa-sign-out"></span>退&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;出</a>
                    </li>
                </ul>
            </li>
        </ul>
    </div>
</div>

<div class="col-md-6">
    <div class="input-group">
        <span class="input-group-btn">
            <button class="btn btn-primary" type="button" onclick="add();"><span class="fa fa-plus"></span>添加</button>
        </span>
        <input type="text" class="form-control" placeholder="搜索" id="queryParam" onchange="queryParam = $(this).val();" />
        <div class="input-group-btn">
            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" id="queryType">全部</button>
            <ul id="queryTypeList" class="dropdown-menu">
                <li><a href="javascript:void(0);" onclick="$('#queryType').text('全部');queryType = 'all';$('#queryParam').val('');">全部</a></li>
                <li><a href="javascript:void(0);" onclick="$('#queryType').text('账号');queryType = 'username';">账号</a></li>
                <li><a href="javascript:void(0);" onclick="$('#queryType').text('昵称');queryType = 'nickname';">昵称</a></li>
                <li><a href="javascript:void(0);" onclick="$('#queryType').text('手机');queryType = 'mobilePhone';">手机</a></li>
                <li><a href="javascript:void(0);" onclick="$('#queryType').text('邮箱');queryType = 'email';">邮箱</a></li>
            </ul>
        </div>
        <span class="input-group-btn">
            <button class="btn btn-info" onclick="query();"><span class="fa fa-plus"></span>查询</button>
        </span>
    </div>
</div>

<div class="table">
    <table class="table table-striped">
        <thead>
        <tr>
            <th>账户</th>
            <th>昵称</th>
            <th>手机</th>
            <th>邮箱</th>
            <th>状态</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
</div>

<div id="pageContent" style="margin-left: 40%;">
    <button class="btn btn-success" onclick="first();"><span class="fa fa-fast-backward"></span></button>
    <button class="btn btn-success" onclick="prev();"><span class="fa fa-backward"></span></button>
    <button class="btn btn-success" onclick="next();"><span class="fa fa-forward"></span></button>
    <button class="btn btn-success" onclick="last();"><span class="fa fa-fast-forward"></span></button>
</div>

<!-- Modal -->
<div class="modal fade" id="form" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel"><span class="fui-user"></span>用户信息</h4>
            </div>
            <div class="modal-body" style="height: 600px;">
                <form class="form-horizontal">
                    <input type="hidden" id="userInfoId" name="id">
                    <div class="input-group input-group-lg">
                        <span class="input-group-addon">账号</span>
                        <input type="text" class="form-control" placeholder="账号" id="username" name="username" onblur="checkUsername($(this));">
                    </div>
                    <div id="pwd" class="input-group input-group-lg">
                        <span class="input-group-addon">密码</span>
                        <input type="text" class="form-control" placeholder="密码" id="password" name="password">
                    </div>
                    <div id="rePwd" class="input-group input-group-lg">
                        <span class="input-group-addon">重复</span>
                        <input type="text" class="form-control" placeholder="重复密码" id="rePassword" name="rePassword">
                    </div>
                    <div class="input-group input-group-lg">
                        <span class="input-group-addon">昵称</span>
                        <input type="text" class="form-control" placeholder="昵称" id="nickname" name="nickname">
                    </div>
                    <div class="input-group input-group-lg">
                        <span class="input-group-addon">年龄</span>
                        <input type="text" class="form-control" placeholder="年龄" id="age" name="age">
                    </div>
                    <div class="input-group input-group-lg">
                        <span class="input-group-addon">性别</span>
                        <select class="form-control" id="sex" name="sex">
                            <option value=""></option>
                            <option value="0">女</option>
                            <option value="1">男</option>
                        </select>
                    </div>
                    <div class="input-group input-group-lg">
                        <span class="input-group-addon">生日</span>
                        <input type="text" class="form-control" placeholder="1970-01-01" id="birthday" name="birthday">
                    </div>
                    <div class="input-group input-group-lg">
                        <span class="input-group-addon">手机</span>
                        <input type="text" class="form-control" placeholder="手机" id="mobilePhone" name="mobilePhone">
                    </div>
                    <div class="input-group input-group-lg">
                        <span class="input-group-addon">邮箱</span>
                        <input type="text" class="form-control" placeholder="邮箱" id="email" name="email">
                    </div>
                    <div class="input-group input-group-lg">
                        <span class="input-group-addon">星座</span>
                        <select class="form-control" id="constellation" name="constellation">
                            <option value=""></option>
                            <option value="1">水瓶座</option>
                            <option value="2">双鱼座</option>
                            <option value="3">白羊座</option>
                            <option value="4">金牛座</option>
                            <option value="5">双子座</option>
                            <option value="6">狮子座</option>
                            <option value="7">巨蟹座</option>
                            <option value="8">处女座</option>
                            <option value="9">天秤座</option>
                            <option value="10">天蝎座</option>
                            <option value="11">射手座</option>
                            <option value="12">魔蝎座</option>
                        </select>
                    </div>
                    <div class="input-group input-group-lg">
                        <span class="input-group-addon">爱好</span>
                        <input type="text" class="form-control" placeholder="爱好" id="hobbiesAndInterests" name="hobbiesAndInterests">
                    </div>
                    <div class="input-group input-group-lg">
                        <span class="input-group-addon">签名</span>
                        <input type="text" class="form-control" placeholder="签名" id="individualitySignature" name="individualitySignature">
                    </div>
                    <div class="input-group input-group-lg">
                        <span class="input-group-addon">日期</span>
                        <input type="text" class="form-control" laceholder="创建日期" id="createTime" name="createTime">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" onclick="update();">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="changePasswordForm" tabindex="-1" role="dialog" aria-labelledby="changePasswordModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="resetPasswordModalLabel"><span class="fui-lock"></span>重置密码</h4>
            </div>
            <div class="modal-body" style="height: auto;">
                <form id="passwordForm" class="form-horizontal" action="<%=path%>/user/resetPassword" method="post">
                    <input type="hidden" id="resetId" name="resetId">
                    <div class="input-group input-group-lg">
                        <span class="input-group-addon">原始密码</span>
                        <input type="text" class="form-control" placeholder="原始密码" id="oldPassword" name="oldPassword">
                    </div>
                    <div class="input-group input-group-lg">
                        <span class="input-group-addon">新的密码</span>
                        <input type="text" class="form-control" placeholder="新的密码" id="newPassword" name="newPassword">
                    </div>
                    <div class="input-group input-group-lg">
                        <span class="input-group-addon">重复密码</span>
                        <input type="text" class="form-control" placeholder="重复密码" id="repeatPassword" name="repeatPassword">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><span class="fui-cross"></span>取消</button>
                <button type="button" class="btn btn-primary" onclick="savePassword();"><span class="fui-check"></span>保存</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>
